//import benchmark
import jwm
//
//NOTE: Compiled file in Config-backups may not be synced
//

const(
	up = 'up'
	down = 'down'
	left = 'left'
	right = 'right'
	@select = 'select'
	escape = 'escape'
	next_stacked = 'nextstacked'
	close = 'close'
	root_1 = 'root:1'
	root_2 = 'root:2'
	window = 'window'
	minimize = 'minimize'
	maximize = 'maximize'
	rdesktop = 'rdesktop'
	ldesktop = 'ldesktop'
	udesktop = 'udesktop'
	ddesktop = 'ddesktop'
	sendr = 'sendr'
	sendl = 'sendl'
	sendu = 'sendu'
	sendd = 'sendd'
	restart = 'restart'
	//common execs
	rofi = 'rofi -show'
	exec_drun = exec(rofi('drun'))
	term = 'alacritty'
)

fn exec(str string) string { return 'exec:$str' }
//execs
fn rofi(run string) string { return '$rofi $run' }
fn term(cmd string) string { return '$term -e $cmd' }

//mut b := benchmark.start()
keys := {
	'Up': up
	'Down': down
	'Left': left
	'Right': right
	'h': left
	'j':down
	'k': up
	'l': right
	'Return': @select
	'Escape': escape
	//Alt keys
	'A-Tab': next_stacked
	'A-F1': root_1
	'A-F2': window
	'A-F4': close
	'A-#': 'desktop#' //# is a special case that can represent any number, so it is not in const
	'A-x': close
	'A-m': minimize
	'A-v': maximize
	'A-Right': rdesktop
	'A-Left': ldesktop
	'A-Up': udesktop
	'A-Down': ddesktop
	//Alt + Super
	'-A-133': exec_drun
	//Super
	'4-d': exec_drun
	'4-r': exec(rofi('run'))
	'4-e': exec(term('lf'))
	'4-c': exec(term)
	'4-b': exec(term('btop'))
	'4-f': exec('firefox')
	//Super + Alt
	'4A-Right': sendr
	'4A-Left': sendl
	'4A-Up': sendu
	'4A-Down': sendd
	//Ctrl
	'C-Tab': exec(rofi('window'))
	'-C-133': root_2
	//Ctrl + alt
	'CA-a': exec('pulseaudio --kill')
	'CA-r': restart
	//Ctrl + shift
	'CS-q': exec(rofi('power'))
}
//b.measure('mapping')

println('<?xml version="1.0"?>')
println('<JWM>')
for k, v in keys {
	print('    <Key')
	split := k.split('-')
	key := match split.len {
		1 { split[0] }
		2 {  
			mask := split[0]
			print(' mask="$mask"')
			split[1]
		}
		3 { //keycode
			mask := split[1]
			keycode := split[2]
			print(' mask="$mask" keycode="$keycode">$v</Key>')
			println('')
			continue
			''
		}
		else { '' }
	}
	print(' key="$key">$v</Key>')
	println('')
}
println('</JWM>')