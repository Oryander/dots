module jwm

const(
	tab = '    '
)

pub type XMLTag = SimpleTag | Tag | ComplexTag

fn (mut tag XMLTag) str() string {
	return if tag is SimpleTag {
		(tag as SimpleTag).str()
	} else if tag is ComplexTag { 
		mut c := tag.as_complex()
		c.str() 
	} else if tag is Tag { 
		(tag as Tag).str() 
	} else {
		panic('Impossible situation!')
	}
}

fn (mut tag XMLTag) as_complex() ComplexTag {
	return tag as ComplexTag
}

pub struct SimpleTag {
	name string [required]
	properties map[string]string
mut:
	indent u8
}

fn (tag SimpleTag) indent(str string) string {
	mut result := ''
	for i := 0; i < tag.indent; i++ {
		result += tab
	}
	return result + str
}

fn (tag SimpleTag) properties() string {
	mut result := tag.name
	for k, v in tag.properties {
		result += ' $k=$v'
	}
	return result
}

fn (tag SimpleTag) str() string {
	return tag.indent('<$tag.properties()/>')
}

pub struct Tag {
	SimpleTag
	value string
}

fn (tag Tag) str() string {
	return tag.indent('<$tag.properties()>$tag.value</$tag.name>')
}

pub struct ComplexTag {
	SimpleTag
mut:
	children []XMLTag
}

fn (mut tag ComplexTag) str() string {
	line1 := tag.indent('<$tag.properties()>')
	mut lines := ''
	for mut x in tag.children {
		lines += '\n' + tag.indent(x.str())
	}
	last_line := '\n' + tag.indent('</$tag.name>')
	return line1 + lines + last_line
}

pub fn simple_tag(name string, properties map[string]string) XMLTag {
	return SimpleTag{name, properties, 1}
}

pub fn tag(name string, value string, properties map[string]string) XMLTag {
	return Tag{SimpleTag{name, properties, 1}, value}
}

pub fn complex_tag(name string, properties map[string]string, children ...XMLTag) XMLTag {
	return ComplexTag{SimpleTag{name, properties, 1}, children}
}

pub fn jwm(tags ...XMLTag) {
	println('<?xml version="1.0"?>')
	mut wm := ComplexTag{SimpleTag{'JWM', {}, 0}, tags}
	println(wm.str())
}