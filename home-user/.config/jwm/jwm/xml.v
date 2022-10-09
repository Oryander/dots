module jwm

const(
	//Standard spacing for XML.
	tab = '    '
)

//General type representing any XML tag.
pub type XMLTag = SimpleTag | Tag | ComplexTag

//Function returing a string representation for a given XML tag. Simply calls the .str() function on the correct subtype.
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

//A simple XML tag in the format 
//```XML
//	**<Name prop=value/>**
//```
//**name**: Name of the tag.
//**properties**: Properties to be placed inside the <> of the tag.
//**indent**: How far to indent the tag. Configured automatically.
pub struct SimpleTag {
	name string [required]
	properties map[string]string
mut:
	indent u8
}

fn (tag SimpleTag) indent(str string, add int) string {
	mut result := ''
	for i := 0; i < tag.indent + add; i++ {
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
	return tag.indent('<$tag.properties()/>', 0)
}

//An XML tag in the format 
//```XML
//	**<Name prop=val>value</Name>**
//```
//**SimpleTag**: Embeded SimpleTag struct to handle name and properties.
//**value**: Value to be placed between the opening and close of the tag.
pub struct Tag {
	SimpleTag
	value string
}

fn (tag Tag) str() string {
	return tag.indent('<$tag.properties()>$tag.value</$tag.name>', 0)
}

//A complex XML tag in the form
//```XML
//	<Name prop=val>
//	...
//	</Name>
//```
//**SimpleTag**: Embeded SimpleTag struct to handle name and properties.
//**children**: Array of sub-tags.
pub struct ComplexTag {
	SimpleTag
mut:
	children []XMLTag
}

fn (mut tag ComplexTag) str() string {
	line1 := tag.indent('<$tag.properties()>', 0)
	mut lines := ''
	for mut x in tag.children {
		lines += '\n' + tag.indent(x.str(), x.indent)
	}
	last_line := '\n' + tag.indent('</$tag.name>', 0)
	return line1 + lines + last_line
}

//**name**: string representing the name of the tag.
//**properties**: map[string]string representing the properties of the tag.
//Returns a SimpleTag with the given name and properties as an instance of the XMLTag data type.
pub fn simple_tag(name string, properties map[string]string) XMLTag {
	return SimpleTag{name, properties, 1}
}

//**name**: string representing the name of the tag.
//**value**: string representing the value of the tag.
//**properties**: map[string]string representing the properties of the tag.
//Returns a Tag with the given name, value, and properties as an instance of the XMLTag data type.
pub fn tag(name string, value string, properties map[string]string) XMLTag {
	return Tag{SimpleTag{name, properties, 1}, value}
}

//**name**: string representing the name of the tag.
//**properties**: map[string]string representing the properties of the tag.
//**children**: varargs string representing the children of the tag.
//Returns a ComplexTag with the given name, properties, and children as an instance of the XMLTag data type.
pub fn complex_tag(name string, properties map[string]string, children ...XMLTag) XMLTag {
	return ComplexTag{SimpleTag{name, properties, 1}, children}
}

//**tags**: varargs XMLTag representing the tags in this JWM config file.
//Prints the necessary boilerplate to be a valid JWM config file, along with all of the given tags.
pub fn jwm(tags ...XMLTag) {
	println('<?xml version="1.0"?>')
	mut wm := ComplexTag{SimpleTag{'JWM', {}, 0}, tags}
	println(wm.str())
}