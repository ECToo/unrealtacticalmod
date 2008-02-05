#!BPY
"""
Name: 'Unreal Menu PSK/PSA'
Blender: 245
Group: 'Export'
Tip: 'This For Unreal Animation build for UT3'
""" 

__author__ = "Optimus_P-Fat/Active_Trash" 
__version__ = "0.0.2" 
__bpydoc__ = """\ 

-- Unreal Skeletal Mesh and Animation Export (.psk  and .psa) export script v0.0.1 --<br> 

- NOTES:
""" 

import Blender
from Blender import NMesh
from Blender.BGL import *
from Blender.Draw import *

import math
from math import *

# Events
EVENT_NOEVENT = 1
EVENT_DRAW = 2
EVENT_EXIT = 3
EVENT_EXPORT = 4
EVENT_TRIANGLES = 5
EVENT_FILEPATH = 6
EVENT_CHECKMESH = 7
EVENT_PSK_EXT = 1
EVENT_PSA_EXT = 0

#Menu
Menu_Height = 20


print "Hello"

def draw():
		global EVENT_NOEVENT,EVENT_DRAW,EVENT_EXIT,EVENT_PSK_EXT,EVENT_PSA_EXT
		######### Draw and Exit Buttons
		Button("File Path",EVENT_FILEPATH , 10, Menu_Height*6, 80, 18)
		Button("Check Mesh",EVENT_CHECKMESH, 10, Menu_Height*5, 80, 18)
		Button("Export",EVENT_EXPORT, 10, Menu_Height*4, 80, 18)
		Button("PSK ",EVENT_PSK_EXT, 10, Menu_Height*3, 80, 18)
		Button("PSA ",EVENT_PSA_EXT, 10, Menu_Height*2, 80, 18)
		Button("Exit",EVENT_EXIT , 140, 10, 80, 18)
		
		
		print "Draw GUI"
	
def event(evt, val):
	#if (evt == QKEY and not val):
	if (evt == QKEY):
		print "Hello EXIT"
		Exit()

def bevent(evt):
        global T_NumberOfSides
        global T_Radius
        global EVENT_NOEVENT,EVENT_DRAW,EVENT_EXIT
		
        ######### Manages GUI events
        if (evt == EVENT_EXIT):
                Exit()
		#elif (evt == EVENT_DRAW):
		#	print "Draw Object"
		#	Blender.Redraw()

Register(draw, event, bevent)				