import os

[noreturn]
fn fatal(msg string) {
	println(msg)
	exit(0)
}

[noreturn]
fn do(cmd string, f string) {
	os.execvp(cmd, [ f ]) or { panic('Could not start child process: $err') }
	fatal('Reached end of do - should be impossible')
}

match os.args.len {
	0, 1 { fatal('Too few args!') }
	2 {}
	else { fatal('Too many args!') }
}

f := os.args[1]

ext := file_ext(f)

//Extension matching
//with snap VSCodium, no easy way to open to a specific file
match ext {
	'.yaml', '.yml' { do('subl', f) }
	else {/* continue to next match expression */}
}

println(ext)

mime_cmd := os.execute('file --mime-type -Lb $f')
mime_type := mime_cmd.output

app := 'application'

//direct type matching
match mime_type {
	'$app/x-yaml' { do('subl', f) }
	else {/* continue to next match expression */}
}

mime_cat := mime_type.all_before('/')

match mime_cat {
	'text' { do('micro', f) }
	'audio' { do('rhythmbox', f) }
	else { do('xdg-open', f) }
}
