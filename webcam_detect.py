from Cocoa import *
from Foundation import *
from PyObjCTools import AppHelper
from time import sleep
import matlab.engine as matlab
import os
import keycode
import string
import sys

eng = matlab.start_matlab()

class AppDelegate(NSObject):
    def applicationDidFinishLaunching_(self, aNotification):
        NSEvent.addGlobalMonitorForEventsMatchingMask_handler_(NSKeyDownMask, handler)

def handler(event):
    try:
	activeApps = NSWorkspace.sharedWorkspace().runningApplications()
	for app in activeApps:
		if app.isActive() and app.localizedName() != "Photo Booth":
			return
	os.system("clear")
	if event.type() == NSKeyDown and keycode.tostring(event.keyCode()) in string.printable:
            if(event.keyCode() == 36):
		sleep(4)
		os.system("ls -t /Users/mmwang/Pictures/Photo\ Booth\ Library/Pictures/ | head -1 > file_name.txt")
		f = open("file_name.txt")
		name = f.readline()
		if(len(name) == 0):
		    return
		fullname = "/Users/mmwang/Pictures/Photo\ Booth\ Library/Pictures/" + name.replace(" ", "\ ")
		os.system("./upload-to-imageshack.sh " + fullname)
		os.system("./webcam-data-collect.sh")
		os.system("clear")
		eng.workspace['face'] = eng.load('webcam_matrix.dat')
		print eng.eval('predictEmotion(face)')
    except ( KeyboardInterrupt ) as e:
        print 'Ending', e
        AppHelper.stopEventLoop()
    except:
	os.system("clear")
	print 'Face not detected'

def main():
    app = NSApplication.sharedApplication()
    delegate = AppDelegate.alloc().init()
    NSApp().setDelegate_(delegate)
    AppHelper.runEventLoop()


if __name__ == '__main__':
   main()
