import jwm { XMLTag, jwm }

const(
	tab = '    '
	group_name = 'Group'
	option_name = 'Option'
	class_name = 'Class'
	name_name = 'Name'
)

fn group(children []XMLTag) XMLTag {
	return jwm.complex_tag(group_name, {}, ...children)
}

fn child(name string, value string) XMLTag {
	return jwm.tag(name, value, {})
}

fn option(value string) XMLTag { return child(option_name, value) }
fn class(value string) XMLTag { return child(class_name, value) }
fn name(value string) XMLTag { return child(name_name, value) }

jwm(
	group([ option('tiled') ]),
	group([ name('Navigator'), option('noborder'), option('aerosnap') ]),
	group([ name('pix'), option('icon:pix-jwm.png') ]),
	group([ class('librewolf-default'), option('icon:amarok-icon-jwm.png') ]),
	group([ class('firefox'), option('icon:firefox-4.0-jwm.png') ]),
	group([ name('Alacritty'), option('icon:alacritty-jwm.png') ]),
	group([ name('MultiMC'), option('icon:multimc-jwm.png') ]),
	group([ name('obsidian'), option('icon:/home/oryander/Pictures/obsidian-jwm.png') ])
)
