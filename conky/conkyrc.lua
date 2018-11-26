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
	gap_y = 140,
	minimum_width = 175, 
	maximum_width = 175,
	minimum_height = 900,

	own_window = true,
	own_window_type = 'desktop',
	own_window_transparent = true,
	own_window_argb_visual = true,
	own_window_class = 'conky-semi',
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

	border_inner_margin = 0,
	border_outer_margin = 0,
	alignment = 'top_left',


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
	color5 = '#8FEB8F',
-- Red
	color6 = '#F45F45',
-- Loading lua script for drawning rings
	lua_load = '~/.config/awesome/conky/seamod_rings.lua',
	lua_draw_hook_pre = 'main',

};

conky.text = [[

${font Droid Sans:size=9:style=normal}${color4}$kernel
${font Droid Sans:size=9:style=normal}${color1}Uptime: $alignr${color3}${color3}$uptime
${image /home/msjche/.config/awesome/conky/pacman.png -p 10,60 -s 60x60 }
$alignr${font Droid Sans Mono:size=8}${color2}Pacman: 	$color1${font Droid Sans Mono:size=8:bold}${execp cat /tmp/off.updates | wc -l}
$alignr${font Droid Sans Mono:size=8}${color2}AUR:    	$color1${font Droid Sans Mono:size=8:bold}${execp cat /tmp/aur.updates | wc -l}$color
# NVIDIA
${image /home/msjche/.config/awesome/conky/NVIDIA.png -p 1,115 -s 73x73 }
$alignr${font Droid Sans Mono:size=8}${color2}GPU: $color ${nvidia gpuutil}%
$alignr${font Droid Sans Mono:size=8}${color2}RAM: $color ${nvidia membwutil}%
$alignr${font Droid Sans Mono:size=8}${color2}VIDEO: $color ${nvidia videoutil}%
$alignr${font Droid Sans Mono:size=8}${color2}PCIe: $color ${nvidia pcieutil}%

# Showing CPU Graph
#${voffset 65}
#${offset 90}${font Droid Sans:size=19:style=bold}${color5}CPU
${voffset 75}
$alignr${cpugraph cpu1 90,80 666666 666666}
${font Droid Sans:size=9:style=normal}${color1}CPU Freq:  ${font Droid Sans:size=9:bold:style=normal}${alignr}${color4}${freq} ${color2}MHz

# Showing TOP 5 CPU-consumers
${font Droid Sans:bold:size=8:style=normal}${color4}${top name 1}${alignr}${top cpu 1}%
${font Droid Sans:size=8:style=normal}${color1}${top name 2}${alignr}${top cpu 2}%
${font Droid Sans:size=8:style=normal}${color2}${top name 3}${alignr}${top cpu 3}%
${font Droid Sans:size=8:style=normal}${color3}${top name 4}${alignr}${top cpu 4}%
${font Droid Sans:size=8:style=normal}${color3}${top name 5}${alignr}${top cpu 5}%

#Showing memory part with TOP 5
${voffset 28}
${offset 65}${font Droid Sans:size=14:style=bold}${color5}MEM
${voffset 1}
${font Droid Sans:bold:size=8:style=normal}${color4}${top_mem name 1}${alignr}${top_mem mem_res 1}
${font Droid Sans:size=8:style=normal}${color1}${top_mem name 2}${alignr}${top_mem mem_res 2}
${font Droid Sans:size=8:style=normal}${color2}${top_mem name 3}${alignr}${top_mem mem_res 3}
${font Droid Sans:size=8:style=normal}${color3}${top_mem name 4}${alignr}${top_mem mem_res 4}
${font Droid Sans:size=8:style=normal}${color3}${top_mem name 4}${alignr}${top_mem mem_res 5}

# Showing disk partitions: boot, root, home
${voffset 57}
${offset 95}${font Droid Sans:size=12:style=bold}${color5}DISKS
${voffset 40}
${diskiograph 20,170 666666 666666}${voffset -20}
${voffset 2}
${font Droid Sans:size=8:}${color1}Boot Free: ${alignr}$color3${font Droid Sans:size=8:style=normal}${fs_free /boot}
${font Droid Sans:size=8:}${color1}Root Free: ${alignr}$color3${font Droid Sans:size=8:style=normal}${fs_free /}
${font Droid Sans:size=8:}${color1}Home Free: ${alignr}$color3${font Droid Sans:size=8:style=normal}${fs_free /home}
${font Droid Sans:size=8:}${color1}Media Free: ${alignr}$color3${font Droid Sans:size=8:style=normal}${fs_free /media/Data}

# Network 
${voffset 43}
${offset 70}${font Droid Sans:size=14:style=bold}${color5}Ethernet
${voffset 15}
${font Droid Sans:size=8:style=bold}${color1}VPN: $alignr${font Droid Sans:size=9:style=bold}${color5}${if_up tun0}UP${else}${color6}Down$endif$color
${font Droid Sans:size=8}${color2}Int:$alignr${color1}$gw_iface
#${color2}VPN:$alignr${if_up tun0}${color1}Up${else}${color red}Down$endif$color
${font Droid Sans:size=8}${color2}${color2}UFW: $alignr$color1${execi 30 systemctl is-active ufw}$color
${color2}${font Droid Sans:size=8}Lan IP: ${alignr}$color1${addr eno1} 
${color2}Packets
${color2}In: $color1${tcp_portmon 1 32767 count} $alignr$color2${alignr}Out: $color1${tcp_portmon 32768 61000 count}$color

${color2}Up: ${alignr}${color green}${upspeed eno1}/s$color
${color2}Total: ${alignr}${color green}${totalup eno1}$color
$color6${upspeedgraph eno1 45,170 00ff00 00ff00}$color
${color2}Down: ${alignr}${color red}${downspeed eno1}/s$color
${color2}Total: ${alignr}${color red}${totaldown eno1}$color
$color6${downspeedgraph eno1 45,170 ff0000 ff0000}
]];
