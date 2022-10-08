import os

match os.args[1] {
	'Shutdown' { os.execute('shutdown now') }
	'Restart' { os.execute('reboot') }
	'Suspend' { os.execute('systemctl suspend') }
	'Hibernate' { os.execute('systemctl hibernate') }
	'Logout' { os.execute('jwm -exit') }
	'Cancel' { exit(0) }
	else { 
		println('Shutdown')
		println('Restart')
		println('Suspend')
		println('Hibernate')
		println('Logout')
		println('Cancel')
	}
}
