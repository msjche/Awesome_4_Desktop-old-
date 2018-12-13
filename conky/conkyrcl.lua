
conky.config = {

	background = true,
	update_interval = 1,
--	time_in_seconds = true,

	cpu_avg_samples = 2,
	net_avg_samples = 2,
	temperature_unit = 'celsius',

	double_buffer = true,
	no_buffers = true,
	text_buffer_size = 2048,

	gap_x = 0,
	gap_y = 31,
	minimum_width = 440, 
	maximum_width = 440,
	minimum_height = 480,
--	maximum_height = 480,

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
--	own_window_color = '#000000', 

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
-- Arch blue
	color4 = '#1793D0',
-- Green
	color5 = '#8FEB8F',
-- Red
	color6 = '#F45F45',
-- Gentoo Purple
	color7 = '#7A5ADA',
-- Loading lua script for drawning rings
    lua_load = '~/.config/awesome/conky/conky_draw.lua',
    lua_draw_hook_pre = 'main',
    --lua_draw_hook_pre = '~/.config/awesome/conky',
};

conky.text = [[

${image /home/msjche/.config/awesome/conky/arch.png -p 0,0 -s 440x140 }
${voffset 55}${alignr 35}${font Play:size=14:style=bold}${color4}$kernel
${voffset -10}${goto 200}${font Play:size=10:style=normal}${color2}Uptime: ${alignr 35}${font Play:size=11:style=bold}${color1}$uptime
${voffset 20}${goto 50}${font Michroma:size=12:style=normal}${color2}System Updates
${goto 10}${font Play Mono:size=10}${color2}Pacman:	${alignr 150}${color4}${font Play Mono:size=10:bold}${execp checkupdates | awk 'END { print (NR == 0 ? "System up to date" : NR " package" (NR > 1 ? "s" : "")); }'}
${goto 10}${font Play Mono:size=10}${color2}AUR:	${alignr 150}${color4}${font Play Mono:size=10:bold}${execp cat /tmp/aur.updates | wc -l}$color
${goto 10}${font Play Mono:size=10}${color2}Updated:	${alignr 150}${color2}${font Play Mono:size=8:normal}${execp date --date=$(expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n 1 | awk '{print $1 "T" $2}')}$color
# NVIDIA
${image /home/msjche/.config/awesome/conky/NVIDIA.png -p 350,160 -s 73x73 }
${voffset -25}${goto 340}${font Play Mono:size=8}${color2}GPU: ${alignr 10}${color3}${nvidia gpuutil}%
${goto 340}${font Play Mono:size=8}${color2}RAM: ${alignr 10}${color3}${nvidia membwutil}%
${goto 340}${font Play Mono:size=8}${color2}VIDEO: ${alignr 10}${color3}${nvidia videoutil}%
${goto 340}${font Play Mono:size=8}${color2}PCIe: ${alignr 10}${color3}${nvidia pcieutil}%
${image /home/msjche/.config/awesome/conky/play.png -p 10,271 -s 30x30 }
${voffset -40}${goto 45}${font Michroma:size=12:style=normal}${color6}Google Music Player
${voffset 5}${goto 170}${font Play Mono:size=10}${color4}${execp cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.song.title'}
${voffset 8}${goto 170}${font Play Mono:size=8}${color2}${execp cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.song.artist'}
${voffset 3}${goto 170}${font Play Mono:size=7}${color3}${execp cat "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.song.album'}
#${voffset 3}${goto 180}${font Play Mono:size=8}${color3}${execbar "$HOME/.config/Google Play Music Desktop Player/json_store/playback.json" | jq -r '.time.current'}
${execp cat $HOME/.config/Google\ Play\ Music\ Desktop\ Player/json_store/playback.json | jq '.song.albumArt' | xargs --replace=blah curl -s blah | convert - -resize 306x306 /tmp/cover.png}
${image /tmp/cover.png -p 10,305 -s 150x150 -n}

# CPU Text
${font Play:normal:size=7}${voffset 48}${color1}${alignr 200}${acpitemp} °C
${alignr 200}${alignr 200}${freq_g cpu0} Ghz
${voffset -20}${goto 10}${color4}${cpugraph cpu1 40,180}
${goto 35}${voffset -5}${color1}${font Michroma:normal:size=8}Top CPU Processes
${goto 10}${font Play:normal:size=8}${color3}${top name 1}${alignr 215}${color2}${top cpu 1}%
${goto 10}${font Play:normal:size=8}${color3}${top name 2}${alignr 215}${color2}${top cpu 2}%
${goto 10}${font Play:normal:size=8}${color3}${top name 3}${alignr 215}${color2}${top cpu 4}%
${goto 10}${font Play:normal:size=8}${color3}${top name 3}${alignr 215}${color2}${top cpu 5}%
${goto 10}${font Play:normal:size=8}${color3}${top name 3}${alignr 215}${color2}${top cpu 6}%
${font Michroma:bold:size=16}${color4}${goto 211}${voffset 25}CPU
${font Michroma:bold:size=15}${color4}${goto 70}${voffset 224}MEMORY
${goto 240}${voffset -72}${color1}${font Michroma:normal:size=8}Top Memory Processes
${goto 250}${voffset 0}${font Play:normal:size=8}${color3}${top_mem name 1}${color2}${alignr 20}${top_mem mem 1}%
${goto 250}${font Play:normal:size=8}${color3}${top_mem name 2}${alignr 20}${color2}${top_mem mem 2}%
${goto 250}${font Play:normal:size=8}${color3}${top_mem name 3}${alignr 20}${color2}${top_mem mem 3}%
${goto 250}${font Play:normal:size=8}${color3}${top_mem name 4}${alignr 20}${color2}${top_mem mem 4}%
${goto 250}${font Play:normal:size=8}${color3}${top_mem name 4}${alignr 20}${color2}${top_mem mem 5}%
${font Play:normal:normal:size=8}${voffset -13}${goto 108}${color1}SWAP${font Play:normal:size=7}${alignr 210}${color1}${swap} / ${color2}${swapmax}
${font Play:normal:bold:size=8}${voffset 3}${goto 108}${color1}RAM ${font Play:normal:size=7}${alignr 210}${color1}${mem} / ${color2}${memmax}
${font Play:normal:bold:size=8}${voffset 40}${goto 10}${color2}Read${color2}${alignr 240}${voffset 0}${diskiograph_read 20,140}
${font Play:normal:bold:size=8}${voffset -3}${goto 10}${color3}Write${color3}${alignr 240}${voffset 0}${diskiograph_write 20,140}
${font Michroma:bold:size=15}${color4}${goto 143}${voffset -7}HARD DRIVE
${voffset -0}${color2}${font Play:normal:size=8}${goto 110}${fs_used_perc /boot}${color2}%${color1}${font Play:normal:size=8}${goto 145}/boot${alignr 110}${color2}${fs_used /boot} / ${color3}${fs_size /boot}
${voffset 0}${color2}${font Play:normal:size=8}${goto 110}${fs_used_perc /}${color2}%${color1}${font Play:normal:size=8}${goto 145}/${alignr 110}${color2}${fs_used /} / ${color3}${fs_size /}
${color2}${font Play:normal:size=8}${goto 110}${fs_used_perc /home}${color2}%${color1}${font Play:normal:size=8}${goto 145}/home${alignr 110}${color2}${fs_used /home} / ${color3}${fs_size /home}
${color2}${font Play:normal:size=8}${goto 110}${fs_used_perc /media/Data}${color2}%${color1}${font Play:normal:size=8}${goto 145}${voffset 0}/media/Data${alignr 110}${color2}${fs_used /media/Data} / ${color3}${fs_size /media/Data}
${color2}${font Play:normal:size=8}${goto 250}${voffset 20}Local IP${alignr 10}${addr eno1}
#${color2}${font Play:normal:size=8}${goto 250}${voffset -1}Public IP${alignr 10}${execi 3600 wget -qO - ifconfig.co | sed -e 's/[^[:digit:]\|.]//g'}
${color2}${font Play:normal:size=8}${goto 250}${voffset -1}Public IP${alignr 10}${color red}NOPE ;)$color
${color2}${font Play:normal:size=8}${goto 250}${voffset -1}VPN: ${alignr 10}${color5}${font Play:size=9:style=bold}${if_up tun0}UP${else}${color6}Down$endif
${color2}${font Play:normal:size=8}${goto 250}${voffset -3}UFW: ${alignr 10}${font Play:size=9:style=bold}${color5}${execi 30 systemctl is-active ufw}
${color2}${font Play:normal:size=8}${goto 250}${voffset -1}Int:${alignr 10}${color3}$gw_iface 
${color4}${font Play:bold:size=8}${goto 320}${voffset -1}Totals
${color1}${font Play:normal:size=8}${goto 250}${voffset -3}Up${alignr 10}${color2}${totalup eno1}
${color1}${font Play:normal:size=8}${goto 250}${voffset -1}Down${alignr 10}${color2}${totaldown eno1}
${color4}${font Play:bold:size=8}${goto 320}${voffset -1}Packets
${color2}${font Play:normal:size=8}${goto 250}${voffset -1}In: ${color1}${tcp_portmon 1 32767 count} ${color2}${alignr 10}Out: $color1${tcp_portmon 32768 61000 count}$color
${color4}${font Michroma:bold:size=15}${voffset 0}${goto 95}INTERNET
${alignr 20}${voffset -30}${color2}${font Michroma:normal:size=8}Download
${alignr 10}${color2}${downspeedgraph eno1 45,210}
${alignr 20}${voffset 0}${color3}${font Michroma:normal:size=8}Upload
${alignr 10}${color3}${upspeedgraph eno1 45,210}
${color1}${font Play:bold:size=8}${goto 110}${voffset -115}Up${alignr 230}${color2}${color3}${upspeed eno1}
${color1}${font Play:bold:size=8}${goto 110}${voffset 7}Down${alignr 230}${color3}${color3}${downspeed eno1}
]];
