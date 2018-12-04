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
	gap_y = 359,
	minimum_width = 477, 
	maximum_width = 477,
	minimum_height = 700,

	own_window = true,
	own_window_type = 'desktop',
--	own_window_transparent = true,
	own_window_argb_visual = true,
	own_window_class = 'conky-semi',
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

	border_inner_margin = 0,
	border_outer_margin = 0,
	alignment = 'top_right',

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
	color5 = '#8FEB8F',
-- Red
	color6 = '#F45F45',
};

conky.text = [[
${color4}${font xirod:size=10}Google Calendar ${hr 2}$font$color
${voffset -10}${font Droid Sans Mono:size=7:bold}$color2${execi 300 gcalcli --nocolor --lineart ascii --conky calw 2}
${voffset -10}${font Droid Sans Mono:size=9:bold}$color3${execi 300 gcalcli --nocolor --lineart ascii --conky agenda}
${color4}${font xirod:Bold:size=10}News ${hr 2}$font$color
${color2}${font Play:size=9}Zerohedge Latest Headlines:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://feeds.feedburner.com/zerohedge/feed 4 2}

${color2}${font Play:size=9}Fox News Latest Headlines:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://feeds.foxnews.com/foxnews/latest 4 2}

${color2}${font Play:size=9}Joe Rogan Experience:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://joeroganexp.joerogan.libsynpro.com/irss 4 2}

${color2}${font Play:size=9}Arch Linux News:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh https://www.archlinux.org/feeds/news/ 3 2}

# TCP & UDP     
${font xirod:size=10}${color5}CONNECTIONS ${hr 2}$font$color
${font Play:Bold:size=9}Inbound Connections:  ${tcp_portmon 1 32767 count}  ${alignr} Local Service / Port
   ${color2}${font Play:size=9}${tcp_portmon 1 32767 rhost 0} ${alignr} ${tcp_portmon 1 32767 lservice 0}
   ${tcp_portmon 1 32767 rhost 1} ${alignr} ${tcp_portmon 1 32767 lservice 1}
   ${tcp_portmon 1 32767 rhost 2} ${alignr} ${tcp_portmon 1 32767 lservice 2}
   ${tcp_portmon 1 32767 rhost 3} ${alignr} ${tcp_portmon 1 32767 lservice 3}
   ${tcp_portmon 1 32767 rhost 4} ${alignr} ${tcp_portmon 1 32767 lservice 4}
   ${tcp_portmon 1 32767 rhost 4} ${alignr} ${tcp_portmon 1 32767 lservice 5}   
${color1}${font Play:Bold:size=9}Outbound Connections:  ${tcp_portmon 32768 61000 count}  ${alignr} Remote Service / Port
   ${color2}${font Play:size=9}${tcp_portmon 32768 61000 rhost 0} ${alignr} ${tcp_portmon 32768 61000 rservice 0}
   ${tcp_portmon 32768 61000 rhost 1} ${alignr} ${tcp_portmon 32768 61000 rservice 1}
   ${tcp_portmon 32768 61000 rhost 2} ${alignr} ${tcp_portmon 32768 61000 rservice 2}
   ${tcp_portmon 32768 61000 rhost 3} ${alignr} ${tcp_portmon 32768 61000 rservice 3}
   ${tcp_portmon 32768 61000 rhost 4} ${alignr} ${tcp_portmon 32768 61000 rservice 4}
   ${tcp_portmon 32768 61000 rhost 5} ${alignr} ${tcp_portmon 32768 61000 rservice 5}
   ${tcp_portmon 32768 61000 rhost 6} ${alignr} ${tcp_portmon 32768 61000 rservice 6}
   ${tcp_portmon 32768 61000 rhost 7} ${alignr} ${tcp_portmon 32768 61000 rservice 7}
   ${tcp_portmon 32768 61000 rhost 8} ${alignr} ${tcp_portmon 32768 61000 rservice 8}

${color6}${font xirod:size=10}PACMAN LOG ${hr 2}
${color2}${font Play:size=9}${execi 30 tail -n8 /var/log/pacman.log}

]];
