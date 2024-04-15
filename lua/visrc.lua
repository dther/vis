-- load standard vis module, providing parts of the Lua API
require('vis')
mouse = require('vis-mouse') -- See this file, as well as README.mouse.md

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	-- vis:command('set number')
end)

-- Displays the mouse's current state on the status bar.
function getmousestr()
	local pressed = mouse.state.pressed
	local mousestr = "["
	for i=1, 3 do
		if pressed[i] then
			if (i == mouse.state.current.dragging) then
				mousestr = mousestr.."D"
			elseif (i == mouse.state.current.chordbase) then
				mousestr = mousestr.."O"
			else
				mousestr = mousestr.."o"
			end
		else
			mousestr = mousestr.." "
		end
	end
	mousestr = mousestr.."]"
	if (mouse.state.last.button == mouse.BUTTON.WHEELUP) then
		mousestr = mousestr.."^"
	elseif (mouse.state.last.button == mouse.BUTTON.WHEELDOWN) then
		mousestr = mousestr.."v"
	end
	return mousestr
end
