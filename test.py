from Cocoa import *
from Foundation import *
from PyObjCTools import AppHelper
from time import sleep
import os
import keycode
import string
import sys

class AppDelegate(NSObject):
    def applicationDidFinishLaunching_(self, aNotification):
        NSEvent.addGlobalMonitorForEventsMatchingMask_handler_(NSKeyDownMask, handler)

def handler(event):
    try:
	activeApps = NSWorkspace.sharedWorkspace().runningApplications()
	for app in activeApps:
		if app.isActive() and app.localizedName() != "Photo Booth":
			return
	if event.type() == NSKeyDown and keycode.tostring(event.keyCode()) in string.printable:
            if(event.keyCode() == 36):
		sleep(4)
		os.system("ls -t /Users/mmwang/Pictures/Photo\ Booth\ Library/Pictures/ | head -1 > file_name.txt")
		f = open("file_name.txt")
		name = f.readline()
		if(len(name) == 0):
		    #handle exception
		    print "u dun goofed"
		fullname = "/Users/mmwang/Pictures/Photo\ Booth\ Library/Pictures/" + name.replace(" ", "\ ")
		os.system("./upload-to-imageshack.sh " + fullname);
    except ( KeyboardInterrupt ) as e:
        print 'handler', e
        AppHelper.stopEventLoop()

def main():
    app = NSApplication.sharedApplication()
    delegate = AppDelegate.alloc().init()
    NSApp().setDelegate_(delegate)
    AppHelper.runEventLoop()


if __name__ == '__main__':
   main()
