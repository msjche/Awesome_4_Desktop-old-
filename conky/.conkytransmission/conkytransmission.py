#!/usr/bin/env python

# conkytransmission.py by Eric Lien
# Designed to scrape torrent data from transmission-remote (on localhost) and output the data in a format
# that looks good with conkycolors themes.
# License is creative commons...give me some credit
#
# To make this work:
# 1) install conky
# 2) install transmission-cli and uninstall transmission-daemon
#    if installed, the web interface for transmission must be enabled as well
# 3) in your ~/.conkyrc file, ABOVE the TEXT area, you will need to add a line like:
#    lua_load /path/to/conkytransmission.lua
# 4) add a line like:
#    ${execpi 3 /path/to/conkytransmission.py}
#    to your ~/.conkyrc file below the TEXT area

#tested on ubuntu 10.04 x86_64 with python v2.6.5 and conky v1.8.0 (conky-all package)

__author__="Eric Lien"
__date__ ="$Aug 20, 2010 6:30:03 PM$"
__version__="0.2 beta"

import os
import sys
import codecs
from optparse import OptionParser
from subprocess import Popen, PIPE
from operator import attrgetter

class CommandLineParser:

    parser = None

    def __init__(self):
        self.parser = OptionParser()
        self.parser.add_option("-a","--showactive", dest="show_active", default=False, action="store_true", help=u"Show only active torrents")
        self.parser.add_option("-k","--kbps",dest="k_unit", default="K", type="string", metavar="STRING", help=u"How you would like KiB/s to be shown [default: %default]")
        self.parser.add_option("-l","--namelength",dest="name_length", type="int", default=35, metavar="NUMBER", help=u"[default: %default] Length of torrent name in characters")
        self.parser.add_option("-n","--number",dest="number", default=99, type="int", metavar="NUMBER", help=u"How many torrents will be shown [default: %default]")
        self.parser.add_option("-m","--mbps",dest="m_unit", default="M", type="string", metavar="STRING", help=u"How you would like MiB/s to be shown [default: %default]")
        self.parser.add_option("-r","--reverse", dest="reverse_sort", default=False, action="store_true", help=u"Sort in reverse order")
        self.parser.add_option("-s","--sortby", dest="sort_by", default="progress", type="string", metavar="option", help=u"How torrents are sorted. [default: %default] options=(percent,eta,down,up,ratio,status,progress,name)")
        self.parser.add_option("-t","--templatespath", dest="template_folder", default=False, metavar="PATH", help=u"Folder where your custom templates are")
        self.parser.add_option("-v", "-V", "--version", dest="version", default=False, action="store_true", help=u"Displays the version of the script.")        
        
    def parse_args(self):
        (options, args) = self.parser.parse_args()
        #it's possible they entered in something stupid into the sortby field...
        sort_options = ['percent','eta','down','up','ratio','status','progress','name']
        try:
            i = sort_options.index(options.sort_by)
        except Exception, e:
            options.sort_by = "progress"
        options.base_path = os.path.abspath(os.path.dirname(sys.argv[0]))
        return (options, args)

    def print_help(self):
        return self.parser.print_help()

class ConkyTransmission:
    """Gets transmission information and forms conky scripts from it"""
    config = None
    torrent_list = list()
    templater = None
    
    def __init__(self, config):
        self.config = config
        try:
            self.templater = TemplateWriter(config)
        except Exception:
            print "Could not find templates! Quitting!"
        else:
            self.run()
    
    # scrape data from transmission-remote, separating lines
    # returns list of lines of transmission-remote -l
    def scrapeTransmission(self):
        p = Popen(["transmission-remote", "-l"], stdout=PIPE, stderr=PIPE)
        output = p.communicate()[0]
        return output.splitlines()

    # Gathers output for conky into variables
    def getTorrentData(self):
        havetorrents = False
        torrent_lines = self.scrapeTransmission()
        length = len(torrent_lines)
        count = 1
        for t in torrent_lines:
            #for lines that contain data about torrents
            if count > 1 and count < length:
                t = Torrent(t, self.config)
                if self.config.show_active:
                    if(t.status == "Seeding" or t.status == "Downloading" or t.status == "Up & Down"):
                        self.torrent_list.append(t)
                        havetorrents = True
                else:
                    havetorrents = True
                    self.torrent_list.append(t)
            #last line has relevent global stats
            elif count == length:
                #store global stats
                self.getGlobalStats(t)
            count = count + 1
        return havetorrents
    
    #sort logic wrapper
    #calls multiple sort methods      
    def sortTorrents(self):
        sb = self.config.sort_by
        if sb == "eta":
            self.simpleSort("eta_seconds")
        elif sb == "name":
            self.simpleSort("file")
        elif sb == "progress":
            self.sortByProgress()
        else:
            self.simpleSort(sb)
    
    #only sorts one field, no advanced sorting        
    def simpleSort(self, field):
        sortover = "torrent."+field
        self.torrent_list = sorted(self.torrent_list, key=lambda torrent: eval(sortover), reverse=self.config.reverse_sort)
    
    #sorts by percent, then ratio
    def sortByProgress(self):
        self.torrent_list = sorted(self.torrent_list, key=attrgetter('percent', 'ratio'), reverse=True)    
        if self.config.reverse_sort:
            self.torrent_list.reverse()
    
    # Parses out global stats from last line of
    # transmission-remote -l output and forms 
    # conky script for it
    def getGlobalStats(self, info_line):
        out = ''
        #properties are separated by at least 2 spaces
        info_list = info_line.split("  ")
        count = 0
        for p in info_list:
            #strip extra white space
            p = p.lstrip().rstrip() 
            if p != '':
                count = count + 1
                # we only care about properties 3 and 4 (up and down speed)
                if count == 3:
                    self.total_up = p                      
                elif count == 4:
                    self.total_down = p
        
    
    # Runs the process from start to finish, printing data for conky
    def run(self):
        if self.getTorrentData():
            self.sortTorrents()
            #get rid of any torrents more than the configured max
            self.torrent_list = self.torrent_list[:self.config.number]
            self.templater.getTorrentOutput(self.torrent_list)
            self.templater.getGlobalsOutput(self.total_up, self.total_down)
            print self.templater.getOutput()
            
class Torrent:
    """Parses out torrent properties from a line of output of transmission-remote -l"""
    id = 0
    percent = 0
    downloaded = ""
    eta = ""
    eta_seconds = 0
    up = 0.0
    down = 0.0
    ratio = 0.00
    status = ""
    file = ""

    # parses an input line of torrent properties into
    # class variables
    def __init__(self, properties, config):
        self.config = config
        properties = properties.split("  ")
        count = 0
        for p in properties:
            p = p.lstrip().rstrip()
            if p != '':
                #convert non-blanks into proper format
                count = count + 1
                if count == 1:
                    self.setId(p)
                elif count == 2:
                    self.setPercent(p)
                elif count == 3:
                    self.downloaded = p
                elif count == 4:
                    self.setETA(p)
                elif count == 5:
                    self.up = p
                elif count == 6:
                    self.down = p
                elif count == 7:
                    self.ratio = p
                elif count == 8:
                    self.status = p
                elif count == 9:
                    self.file = p
        #for some crazy reason, sometimes transmission-remote returns
        #the wrong status
        if self.status == "Up & Down" and float(self.down) < 0.1:
            self.status = "Seeding"
        if self.status == "Up & Down" and float(self.up) < 0.1:
            self.status = "Downloading"
        if self.status == "Seeding" and float(self.up) < 0.1:
            self.status = "Idle"
        elif self.status == "Downloading" and float(self.down) < 0.1:
            self.status = "Idle"
    
    # sets id of torrent
    def setId(self, str):
        self.id = int(str.strip("*"))

    # sets percent downloaded
    def setPercent(self, str):
        self.percent = int(str.strip("%"))

    # sets estimated time left
    def setETA(self, str):
        if str == 'Unknown':
            self.eta = "?"
        else:
            self.eta = str
        self.setETASeconds(str)    
            
    #sets the ETA in seconds (so we can sort them by eta)
    def setETASeconds(self, eta):
        if eta.find("secs") > 0:
            self.eta_seconds = int(eta.strip(' secs'))
        elif eta.find("min") > 0:
            self.eta_seconds = 60 * int(eta.strip(' mins'))
        elif eta.find("hrs")  > 0:
            self.eta_seconds = 3600 * int(eta.strip(' hrs'))
        elif eta.find("days")  > 0:
            self.eta_seconds = 86400 * int(eta.strip(' days'))
        elif eta == "Done":
            self.eta_seconds = 0
        else:
            self.eta_seconds = 9999999999999999
            
class TemplateWriter:
    """Finds and writes to the templates"""
    config = None
    path = ''
    layout = None
    globals_template = None 
    torrent_default = None
    loaded_templates = dict()
    missing_templates = list()
    globals_output = ""
    torrent_output = ""
    
    def __init__(self, config):
        self.config = config
        if config.template_folder:
            self.path = config.template_folder
        else:
            self.path = config.base_path+"/templates"
        if not self.getCriticalTemplates():
            raise Exception("Critical templates missing!")
    
    def getCriticalTemplates(self):
        path = self.path
        self.layout = getFile(path+"/layout.template")
        self.globals_template = getFile(path+"/globals.template")
        self.torrent_default = getFile(path+"/torrent_default.template")
        if(self.layout and self.globals_template and self.torrent_default):
            return True
        else:
            return False
            
    def getOutput(self):
        if self.torrent_output != "":
            template = self.layout
            template = template.replace("[:TORRENTS:]", self.torrent_output.rstrip("\n"))
            template = template.replace("[:GLOBALS:]", self.globals_output.rstrip("\n"))
            return template
        else:
            return ""
            
    def getGlobalsOutput(self, up, down):
        template = self.globals_template
        template = template.replace("[:G_UP:]", self.getSpeed(up))
        template = template.replace("[:G_UP_KBPS:]", str(up))
        template = template.replace("[:G_DOWN:]", self.getSpeed(down))
        template = template.replace("[:G_DOWN_KBPS:]", str(down))
        self.globals_output = template        
    
    def getTorrentOutput(self, torrents):
        for torrent in torrents:
            template = self.getTorrentTemplate(torrent)
            template = template.replace("[:PERCENT:]", `torrent.percent`)
            template = template.replace("[:DOWNLOADED:]", torrent.downloaded)
            template = template.replace("[:ETA:]", torrent.eta)
            template = template.replace("[:ETA_SECONDS:]", `torrent.eta_seconds`)
            template = template.replace("[:UP:]", self.getSpeed(torrent.up))
            template = template.replace("[:UP_KBPS:]", torrent.up)
            template = template.replace("[:DOWN:]", self.getSpeed(torrent.down))
            template = template.replace("[:DOWN_KBPS:]", torrent.down)
            template = template.replace("[:RATIO:]", torrent.ratio)
            template = template.replace("[:STATUS:]", torrent.status) 
            template = template.replace("[:NAME:]", torrent.file[:self.config.name_length])
            self.torrent_output+=template        
        
    def getTorrentTemplate(self, torrent):
        template_name = "torrent_"+torrent.status.lower().replace(" ","_")
        try:
            template = self.loaded_templates[template_name]
        except KeyError:
            try:
                self.missing_templates.index(template_name)
            except ValueError:
                filename = template_name+".template"
                template = getFile(self.path+"/"+filename)
                if not template:
                    self.missing_templates.append(template_name)
                    return self.torrent_default
                else:
                    self.loaded_templates[template_name] = template
                    return template
            else:
                return self.torrent_default
        else:
            return template
            
    def getSpeed(self, v):
        return getSpeed(v, self.config.m_unit, self.config.k_unit)
    
# function formatting KiB/s output by transmission into
# a human readable but succinct format
def getSpeed(str, m_unit, k_unit):
    kbps = float(str)
    if kbps > 1024:
        speed = `round(float(kbps/1024), 2)`
        unit = m_unit
    else:
        speed = `round(kbps, 2)`
        unit = k_unit
    return speed[:(speed.find('.') + 2)] + " " + unit

def getFile(path):
    path = path.replace("//","/")
    try:
        fileinput = codecs.open(os.path.expanduser(path),encoding='utf-8')
        filedata = fileinput.read()
        fileinput.close()
    except Exception, e:
        return False
    else:
        return filedata

if __name__ == "__main__":
    (options, args) = CommandLineParser().parse_args()
    if options.version:
        print "conkyTransmission v.0.2"
    else:    
        ConkyTransmission(options)
