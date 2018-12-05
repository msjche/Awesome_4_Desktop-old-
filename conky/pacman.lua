-----------------------------------------------------------------------------
--                               conkyrc_seamod
-- Date    : 04/23/2016
-- Author  : SeaJey and Maxiwell
-- Conky   : >= 1.10 
-- License : Distributed under the terms of GNU GPL version 2 or later
-----------------------------------------------------------------------------

conky.config = {

	background = true,
	update_interval = 1,
	time_in_seconds = true,

	cpu_avg_samples = 2,
	net_avg_samples = 2,
	temperature_unit = 'farenheight',

	double_buffer = true,
	no_buffers = true,
	text_buffer_size = 2048,

	gap_x = 0,
	gap_y = 31,
	minimum_width = 440, 
	maximum_width = 440,
	minimum_height = 380,
	maximum_height = 380,

	own_window = true,
	own_window_type = 'desktop',
--	own_window_transparent = true,
	own_window_argb_visual = true,
	own_window_class = 'conky-semi',
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

	border_inner_margin = 0,
	border_outer_margin = 0,
	alignment = 'top_left',

	own_window_transparent = false,
	own_window_argb_value = 100,
	own_window_color = '000000', 

	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,

	override_utf8_locale = true,
	use_xft = true,
	font = 'caviar dreams:size=11',
	xftalpha = 0.5,
	uppercase = false,

-- Defining colors
	default_color = '#FFFFFF',
-- Shades of Gray
	color1 = '#DDDDDD',
	color2 = '#AAAAAA',
	color3 = '#888888',
-- Gentoo Purple
--	color4 = '#7A5ADA',
-- Arch blue
	color4 = '#1793D0',
-- Green
	color5 = '#FF5722',
-- Red
	color6 = '#F45F45',
};

conky.text = [[

${image /home/msjche/.config/awesome/conky/arch.png -p 0,0 -s 440x140 }
${voffset 55}${alignr 35}${font Play:size=14:style=bold}${color4}$kernel
${voffset -10}${goto 200}${font Play:size=10:style=normal}${color2}Uptime: ${alignr 35}${font Play:size=11:style=bold}${color1}$uptime
${voffset 20}${goto 50}${font Michroma:size=12:style=normal}${color2}System Updates
${goto 10}${font Play Mono:size=10}${color2}Pacman:	${alignr 150}${color4}${font Play Mono:size=10:bold}${execpi 3600 checkupdates | awk 'END { print (NR == 0 ? "System up to date" : NR " package" (NR > 1 ? "s" : "")); }'}
${goto 10}${font Play Mono:size=10}${color2}AUR:	${alignr 150}${color4}${font Play Mono:size=10:bold}${execp cat /tmp/aur.updates | wc -l}$color
${goto 10}${font Play Mono:size=10}${color2}Updated:	${alignr 150}${color2}${font Play Mono:size=8:normal}${execp date --date=$(expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 1 | awk '{print $1 "T" $2}')}$color
# NVIDIA
${image /home/msjche/.config/awesome/conky/NVIDIA.png -p 350,135 -s 73x73 }
${voffset -48}${goto 340}${font Play Mono:size=8}${color2}GPU: ${alignr 10}${color3}${nvidia gpuutil}%
${goto 340}${font Play Mono:size=8}${color2}RAM: ${alignr 10}${color3}${nvidia membwutil}%
${goto 340}${font Play Mono:size=8}${color2}VIDEO: ${alignr 10}${color3}${nvidia videoutil}%
${goto 340}${font Play Mono:size=8}${color2}PCIe: ${alignr 10}${color3}${nvidia pcieutil}%
${image /home/msjche/.config/awesome/conky/play.png -p 5,310 -s 70x70 }
${voffset -10}${goto 10}${font Michroma:size=14:style=normal}${color5}Google Music Player
${voffset -5}${goto 70}${font Play Mono:size=10}${color2}${execp cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.song.artist, .song.title' | sed ':a;N;$!ba;s/\n/ \- /'}
${image /tmp/gpmcover -p 310,275 -s 125x125 }
#]];
