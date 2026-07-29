hl.on("hyprland.start", function()
    local startup = {
        "waybar",
        "mako",
        "hyprctl setcursor default 24 && sleep 0.6 && hyprlock",
        "systemctl --user start hypridle.service",
        "sh -c 'wl-paste --watch cliphist store >/dev/null 2>&1 &'",
        "playerctld daemon",
    }

    for _, cmd in ipairs(startup) do
        hl.exec_cmd(cmd)
    end
end)



-- OLD HIDPI.CONF
hl.env("XFT_DPI", 140)
hl.env("GDK_SCALE", 1)
hl.env("GDK_DPI_SCALE", 1.5)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("QT_SCALE_FACTOR", 1.5)
hl.env("QT_FONT_DPI", 140)



-- MONITOR
hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@120",
	position = "0x0",
    scale = 1
})



-- BINDINGS
-- hl.bind(keys, dispatcher, { flag1 = ... , flag2 = ... })
hl.bind("SUPER + ESCAPE", hl.dsp.exit())
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SPACE" , hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + L"	  , hl.dsp.exec_cmd("hyprlock"))

for key, dir in pairs({ Left = "l", Right = "r", Up = "u", Down = "d", }) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }))
end

hl.bind("ALT + CTRL + Left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("ALT + CTRL + Right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind("ALT + CTRL + Up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind("ALT + CTRL + Down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

hl.bind("SUPER + V", hl.dsp.exec_cmd('cliphist list | fuzzel --dmenu --width 60 | cliphist decode | wl-copy'))

hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

hl.bind("F1", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("F2", hl.dsp.exec_cmd("pamixer -d 2"))
hl.bind("F3", hl.dsp.exec_cmd("pamixer -i 2"))

hl.bind("F4", hl.dsp.exec_cmd("pamixer --default-source -t"))

hl.bind("F5", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("F6", hl.dsp.exec_cmd("brightnessctl set 5%+"))

hl.bind("F9", hl.dsp.exec_cmd("pgrep -x waybar >/dev/null && pkill -x waybar || waybar >/dev/null 2>&1 &"))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
hl.bind("F11", hl.dsp.window.fullscreen())
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.bind("SUPER + SHIFT + code:201", hl.dsp.exec_cmd("zen-browser"))

hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd("kitty -e btop"))

for key,dir in pairs({ Left = "-1", Right = "+1" }) do
	hl.bind("CTRL + SUPER + " .. key, hl.dsp.focus({ workspace = dir }))
	hl.bind("CTRL + SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = dir }))
end

hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.resize())
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())


-- VARS
hl.config({
	general = {
		border_size = 2,
		col = {
			active_border = { colors = {"rgba(3a4750ff)", "rgba(2e3940ff)", angle = 45}}
		}
	},

	decoration = {
		active_opacity = 0.87,
		inactive_opacity = 0.87,

		shadow = {
			enabled = false,
		},

		rounding = 20,

		blur = {
			brightness = 1,
			enabled = true,
			size = 13,
			passes = 2,
			contrast = 1.15,
			noise = 0.1,

			new_optimizations = true,
			ignore_opacity = false,
			xray = true
		},
	},

	animations = {
		enabled = true
	},

	input = {
		natural_scroll = 1,
		touchpad = {
			natural_scroll = 1
		},

		kb_file = "~/.config/hypr/gb.xkb"
	},
})



-- ANIMATIONS
hl.curve("default", { type = "spring", mass = 1, stiffness = 300, dampening = 27 })
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "default", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 3, spring = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, spring = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, spring = "default", style = "slide" })
