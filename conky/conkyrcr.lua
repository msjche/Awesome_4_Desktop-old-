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
	temperature_unit = 'fahrenheight',

	double_buffer = true,
	no_buffers = true,
	text_buffer_size = 2048,

	gap_x = 0,
	gap_y = 33,
	minimum_width = 477, 
	maximum_width = 477,
	minimum_height = 900,

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
	own_window_color = '#000000', 

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
--	lua_load = '~/.config/awesome/conky/.conkytransmission/conkytransmission.lua',

-------------------------------------
--  Icon Sources
-------------------------------------
template0='~/.config/awesome/conky/.conky-vision/#fff__32',  --  today
template1='~/.config/awesome/conky/.conky-vision/#fff__32',  --  +1day
template2='~/.config/awesome/conky/.conky-vision/#fff__32',  --  +2days
template3='~/.config/awesome/conky/.conky-vision/#fff__32',  --  +3days
template4='~/.config/awesome/conky/.conky-vision/#fff__32',  --  +4days

-------------------------------------
--  API Key
-------------------------------------
template6="eff739afa6a15cf12d1204c85e0f1c3c",

-------------------------------------
--  City ID
-------------------------------------
template7="5570160",

-------------------------------------
--  Temp Unit (default, metric, imperial)
-------------------------------------
template8="imperial",

-------------------------------------
--  Locale (e.g. "es_ES.UTF-8")
--  Leave empty for default
-------------------------------------
template9=""

};

conky.text = [[
${execi 300 ~/.config/awesome/conky/.conky-vision/get_weather ${template6} ${template7} ${template8} ${template9}}\
${font Play:size=70}${color4}\
${alignc}${time %H:%M}\
${font}${color}
\
${font Play:size=20}${color2}\
${voffset 10}\
${alignc}${execi 300 LANG=${template9} LC_TIME=${template9} date +"%A, %B %d"}\
${font}${color}
\
${font Play:size=11}${color3}\
${voffset 20}\
${goto 10}${execi 300 jq .main.temp ~/.cache/conky-vision/weather.json | awk '{print int($1+0.5)}' # round num}°\
${font}${color}\
\
${font Play:size=11}${color3}\
${goto 105}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '1'}°\
${goto 205}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '2'}°\
${goto 305}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '3'}°\
${goto 405}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '4'}°\
${font}${color}\
\
${font Play:size=11}${color3}\
${voffset 57}\
${goto 150}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'min' '.main.temp' '1'}°\
${goto 250}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'min' '.main.temp' '2'}°\
${goto 350}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'min' '.main.temp' '3'}°\
${goto 450}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'min' '.main.temp' '4'}°\
${font}${color}
\
\
${font Play:regular:size=14}${color2}\
${voffset 10}\
${goto 15}${execi 300 LANG=${template9} LC_TIME=${template9} date +%a | gawk '{print toupper($0);}'}\
${goto 110}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +1day +%a | gawk '{print toupper($0);}'}\
${goto 217}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +2days +%a | gawk '{print toupper($0);}'}\
${goto 315}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +3days +%a | gawk '{print toupper($0);}'}\
${goto 410}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +4days +%a | gawk '{print toupper($0);}'}\
${font}${color}
${execi 300 cp -f ${template0}/$(jq .weather[0].id ~/.cache/conky-vision/weather.json).png ~/.cache/conky-vision/current.png}${image ~/.cache/conky-vision/current.png -p 12,180 -s 52x52}\
${execi 300 cp -f ${template1}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '1').png ~/.cache/conky-vision/forecast-1.png}${image ~/.cache/conky-vision/forecast-1.png -p 105,180 -s 52x52}\
${execi 300 cp -f ${template2}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '2').png ~/.cache/conky-vision/forecast-2.png}${image ~/.cache/conky-vision/forecast-2.png -p 205,180 -s 52x52}\
${execi 300 cp -f ${template3}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '3').png ~/.cache/conky-vision/forecast-3.png}${image ~/.cache/conky-vision/forecast-3.png -p 305,180 -s 52x52}\
${execi 300 cp -f ${template4}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '4').png ~/.cache/conky-vision/forecast-4.png}${image ~/.cache/conky-vision/forecast-4.png -p 405,180 -s 52x52}\

${color4}${font xirod:size=10}Google Calendar ${hr 2}$font$color
${voffset -10}${font Droid Sans Mono:size=7:bold}$color2${execi 300 gcalcli --nocolor --lineart ascii --conky calw 2}
${voffset -10}${font Droid Sans Mono:size=9:bold}$color3${execi 300 gcalcli --nocolor --lineart ascii --conky agenda}

${color4}${font xirod:Bold:size=10}News ${hr 2}$font$color
${color2}${font Play:size=9}Zerohedge Latest Headlines:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://feeds.feedburner.com/zerohedge/feed 4 2}

${color2}${font Play:size=9}Fox News Latest Headlines:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://feeds.foxnews.com/foxnews/latest 4 2}

${color2}${font Play:size=9}Joe Rogan Experience:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh http://joeroganexp.joerogan.libsynpro.com/irss 2 2}

${color2}${font Play:size=9}Arch Linux News:
${color1}${font Play:size=9}${execi 300 /home/msjche/.config/awesome/conky/conky-rss.sh https://www.archlinux.org/feeds/news/ 3 2}

${color7}${font xirod:size=10}TRANSMISSION ${hr 2}
${color1}${font Droid Sans Mono:size=6}${execi 30 transmission-remote -l}
#${execpi 3 python2 '/home/msjche/.config/awesome/conky/.conkytransmission/conkytransmission.py' }

# TCP & UDP     
${font xirod:size=10}${color5}CONNECTIONS ${hr 2}$font$color
${font Play:Bold:size=9}Inbound Connections:  ${tcp_portmon 1 32767 count}  ${alignr} Local Service / Port
   ${color2}${font Play:size=9}${tcp_portmon 1 32767 rhost 0} ${alignr} ${tcp_portmon 1 32767 lservice 0}
   ${tcp_portmon 1 32767 rhost 1} ${alignr} ${tcp_portmon 1 32767 lservice 1}
   ${tcp_portmon 1 32767 rhost 2} ${alignr} ${tcp_portmon 1 32767 lservice 2}
   ${tcp_portmon 1 32767 rhost 3} ${alignr} ${tcp_portmon 1 32767 lservice 3}
${color1}${font Play:Bold:size=9}Outbound Connections:  ${tcp_portmon 32768 61000 count}  ${alignr} Remote Service / Port
   ${color2}${font Play:size=9}${tcp_portmon 32768 61000 rhost 0} ${alignr} ${tcp_portmon 32768 61000 rservice 0}
   ${tcp_portmon 32768 61000 rhost 1} ${alignr} ${tcp_portmon 32768 61000 rservice 1}
   ${tcp_portmon 32768 61000 rhost 2} ${alignr} ${tcp_portmon 32768 61000 rservice 2}
   ${tcp_portmon 32768 61000 rhost 3} ${alignr} ${tcp_portmon 32768 61000 rservice 3}

${color4}${font xirod:size=10}PACMAN LOG ${hr 2}
${color2}${font Play:size=9}${execi 30 tail -n8 /var/log/pacman.log}

]];
