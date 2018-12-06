Some basic instruction on templates and intended use:

Firstly, anytime you want to use a custom template path (or even use the default templates), the dirrectory MUST contain 3
templates at minimum:
layout.template, globals.template, and torrent_default.template

You can set a custom template dirrectory with the cli parameter "-t" or "--templatespath"
A warning though, conkytransmission presently makes NO ATTEMPT to fall back on the default template path if the required templates
are not found, and will instead print an error saying "Could not find templates! Quitting!".

You may in addition to those 3 templates define these other templates, which are used in preference to torrent_default.template
based on a torrents status:
torrent_downloading.template, torrent_finished.template, torrent_idle.template, torrent_seeding.template, torrent_stopped.template,
and torrent_up_&_down.template

These templates must be named EXACTLY as they are above, as they are used automagically based on torrent status, if you do not
name a template properly and therefore the template it is looking for does not exist, conkytransmission will just use the
torrent_default.template.

Now some explanation of the template system and it's veriables:

layout.template:
  This template ONLY arranges in what order the other templates appear, and also can be used to wrap the other output with your own
  custom titles or graphics.
  
  VARIABLES:
    [:TORRENTS:] = determins where the output of the torrents templates will appear
    [:GLOBALS:] = determins where the globals.template will appear
  
globals.template:
  This template is to be used to display the global up and down speeds
  
  VARIABLES:
    [:G_DOWN:] = total downspeed with units as defined by the conkypython.py cli arguments (string)
    [:G_DOWN_KBPS:] = total downspeed in killobytes, no units, with one decimal place (25.3 for example) (decimal)
    [:G_UP:] = total upspeed with units as defined by the conkypython.py cli arguments (string)
    [:G_UP_KBPS:] = total upspeed in killobytes, no units, with one decimal place (25.3 for example) (decimal)
    
torrent_<status>.template:
  These templates are used to show one torrent's data, and have by far the most data, and therefore more variables
  
  VARIABLES:
    [:PERCENT:] = percent downloaded so far (integer 0-100)
    [:DOWNLOADED:] = how much has been downloaded so far, with units pulled directly from transmission (string) 
    [:ETA:] = how much time is left for whatever action it is preforming, with units of secs, min, hrs, days (string)
    [:ETA_SECONDS:] = how much time is left in seconds as an integer, very approximate.  (integer 0 - 9999999999999999 if unknown)
    [:RATIO:] = the ratio of the torrent as a decimal to two places (decimal)
    [:STATUS:] = the status as a string (can be: Downloading, Seeding, Up & Down, Idle, Stopped, Finished) (string)
    [:NAME:] = the file name of the torrent, shortened to the amount of charactes specified in the cli argument "-l" or
               "--namelength" (string)
    [:DOWN:] = downspeed of torrent with units as defined by the conkypython.py cli arguments (string)
    [:DOWN_KBPS:] = downspeed in killobytes, no units, with one decimal place (25.3 for example) (decimal)
    [:UP:] = upspeed with units as defined by the conkypython.py cli arguments (string)
    [:UP_KBPS:] = upspeed in killobytes, no units, with one decimal place (25.3 for example) (decimal)

