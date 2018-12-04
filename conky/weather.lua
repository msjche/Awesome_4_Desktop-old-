conky.config = {

-------------------------------------
--  Generic Settings
-------------------------------------
background=true,
update_interval=1,
double_buffer=true,
no_buffers=true,
imlib_cache_size=0,

draw_shades=false,
draw_outline=false,
draw_borders=false,


-------------------------------------
--  Window Specifications
-------------------------------------
gap_x=0,
gap_y=33,

alignment="top_right",

minimum_height=260,
--maximum_height=270,
minimum_width=475,
maximum_width=475,

own_window=true,
own_window_type='desktop',
own_window_transparent=false,
own_window_argb_visual=true,
own_window_argb_value=100,
own_window_color='000000',
own_window_class='conky-semi',
own_window_hints="undecorated,below,sticky,skip_taskbar,skip_pager",

draw_outline=no,
draw_borders=no,

-------------------------------------
--  Text Settings
-------------------------------------
use_xft=true,
xftalpha=1,
font="Play:size=10",
text_buffer_size=256,
override_utf8_locale=true,


-------------------------------------
--  Color Scheme
-------------------------------------
default_color='FFFFFF',

color0='1793D0', -- clock
color1='DDDDDD', -- date
color2='AAAAAA', -- current temperature
color3='888888', -- high tempratures
color4='1793D0', -- low tempratures
color5='8FEB8F', -- days


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

}


---------------------------------------------------
---------------------------------------------------


conky.text = [[
\
\
\
\
${execi 300 ~/.config/awesome/conky/.conky-vision/get_weather ${template6} ${template7} ${template8} ${template9}}\
\
\
\
\
${font Play:size=65}${color0}\
${alignc}${time %H:%M}\
${font}${color}
\
\
\
\
${font Play:size=25}${color1}\
${voffset 20}\
${alignc}${execi 300 LANG=${template9} LC_TIME=${template9} date +"%A, %B %d"}\
${font}${color}
\
\
\
\
${font Play:size=11}${color1}\
${voffset 26}\
${goto 10}${execi 300 jq .main.temp ~/.cache/conky-vision/weather.json | awk '{print int($1+0.5)}' # round num}°\
${font}${color}\
\
\
\
\
${font Play:size=11}${color1}\
${goto 105}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '1'}°\
${goto 205}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '2'}°\
${goto 305}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '3'}°\
${goto 405}${execi 300 ~/.config/awesome/conky/.conky-vision/parse_weather 'max' '.main.temp' '4'}°\
${font}${color}\
\
\
\
\
${font Play:size=11}${color1}\
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
${goto 18}${execi 300 LANG=${template9} LC_TIME=${template9} date +%a | gawk '{print toupper($0);}'}\
${goto 115}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +1day +%a | gawk '{print toupper($0);}'}\
${goto 211}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +2days +%a | gawk '{print toupper($0);}'}\
${goto 315}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +3days +%a | gawk '{print toupper($0);}'}\
${goto 420}${execi 300 LANG=${template9} LC_TIME=${template9} date -d +4days +%a | gawk '{print toupper($0);}'}\
${font}${color}
${execi 300 cp -f ${template0}/$(jq .weather[0].id ~/.cache/conky-vision/weather.json).png ~/.cache/conky-vision/current.png}${image ~/.cache/conky-vision/current.png -p 12,200 -s 52x52}\
${execi 300 cp -f ${template1}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '1').png ~/.cache/conky-vision/forecast-1.png}${image ~/.cache/conky-vision/forecast-1.png -p 105,200 -s 52x52}\
${execi 300 cp -f ${template2}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '2').png ~/.cache/conky-vision/forecast-2.png}${image ~/.cache/conky-vision/forecast-2.png -p 205,200 -s 52x52}\
${execi 300 cp -f ${template3}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '3').png ~/.cache/conky-vision/forecast-3.png}${image ~/.cache/conky-vision/forecast-3.png -p 305,200 -s 52x52}\
${execi 300 cp -f ${template4}/$(~/.config/awesome/conky/.conky-vision/parse_weather 'first' '.weather[0].id' '4').png ~/.cache/conky-vision/forecast-4.png}${image ~/.cache/conky-vision/forecast-4.png -p 405,200 -s 52x52}\
]]
