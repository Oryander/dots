import jwm { XMLTag, jwm }

const(
	mouse = 'Mouse'
	context = 'context'
	button = 'button'
	//builtin actions
	ldesktop = 'ldesktop'
	rdesktop = 'rdesktop'
	move = 'move'
	window = 'window'
	shade = 'shade'
	maximize = 'maximize'
	resize = 'resize'
	close = 'close'
	maxv = 'maxv'
	maxh = 'maxh'
	minimize = 'minimize'
)

fn mouse(ctxt string, b u8, action string) XMLTag {
	return jwm.tag(mouse, action, { context: ctxt, button: b.str() })
}
fn mousefn(ctxt string) fn (u8, string) XMLTag { 
	return fn [ctxt] (button u8, action string) XMLTag { 
		return mouse(ctxt, button, action) 
	}
}

root := mousefn('root')
title := mousefn('title')
icon := mousefn('icon')
border := mousefn('border')
closefn := mousefn('close')
maximizefn := mousefn('maximize')
minimizefn := mousefn('minimize')

jwm(
	root(4, ldesktop),
	root(5, rdesktop),

	title(1, move),
	title(2, move),
	title(3, window),
	title(4, shade),
	title(5, shade),
	title(11, maximize),

	icon(1, window),
	icon(2, move),
	icon(3, window),
	icon(4, shade),
	icon(5, shade),

	border(1, resize),
	border(2, move),
	border(3, window),

	closefn(-1, close),
	closefn(2, move),
	closefn(-3, close),

	maximizefn(-1, maximize),
	maximizefn(-2, maxv),
	maximizefn(-3, maxh),

	minimizefn(-1, minimize),
	minimizefn(2, move),
	minimizefn(-3, shade),

	jwm.tag('DoubleClickSpeed', '400', {}),
	jwm.tag('DoubleClickDelta', '2', {})
)