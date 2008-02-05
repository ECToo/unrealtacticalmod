#!BPY
"""
Name: 'Mesh Bone List'
Blender: 245
Group: 'Export'
Tip: 'This for look for bones and object proporties'
""" 

__author__ = "Optimus_P-Fat/Active_Trash" 
__version__ = "0.0.2" 
__bpydoc__ = """\ 

-- Unreal Skeletal Mesh and Animation Export (.psk  and .psa) export script v0.0.1 --<br> 

- NOTES:
""" 
import bpy
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
EVENT_BONE_LIST = 6
EVENT_BONE_LOCATION = 7
EVENT_BONE_ROTATION = 8
EVENT_BONE_WEIGHT = 9
EVENT_MESH_FACE = 10
EVENT_MESH_VERTEX = 12
EVENT_MESH_EDGE = 13
EVENT_MESH_NAME = 14
EVENT_BONE_ANIMATION = 15
EVENT_OTHERFUNCTION = 16

#Menu
Menu_Height = 20


print "Welcome to Object mesh and bone Information"

def bone_names():
	print "Bone List"
	ob = Blender.Object.Get('Armature')
	pose = ob.getPose()
	print "-----------------"
	for bonename in pose.bones.keys():
		print pose.bones[bonename]
		bone = pose.bones[bonename]
		print bone.constraints,bone.name
		print "loc ",bone.loc
		
#animation frame code like playng a movie
def done_animation():
	print "Other Function"
#get list of the each bones rotation
def bone_rotation():
	print "Other Function"
#list of bone parent from
def bone_parent():
	print "Other Function"
#list of each bone weight
def bone_weight():
	print "Other Function"
#name of the mesh object
def mesh_name():
	print "Other Function"
#mesh face that is part of vertex
def mesh_face():

	print "Other Function"
#mesh vertex a point to make a tri or qaut point to make visiable.
def mesh_vertex():
	print "Other Function"
#mesh uv texture code
def mesh_uv():
	print "Other Function"
def object_list():
	print "Other Function"
def otherfunction():
	print bpy.data.objects
	list(bpy.data.objects)
	print list
	print "Other Function"
	cube = bpy.data.objects["Cube"]
	print cube
	#print cube.type
	#print type(cube)#crash
	#print dir(cube)
	#print cube.RotX,cube.RotZ,cube.RotY,
	
#=====This print out the list of codes
#cube = bpy.data.objects["Cube"]
#print cube
#print dir(cube)
#print cube.RotX,cube.RotZ,cube.RotY,
#========END
def draw():
		global EVENT_NOEVENT,EVENT_DRAW,EVENT_EXIT,EVENT_PSK_EXT,EVENT_PSA_EXT,EVENT_BONE_LIST
		global EVENT_BONE_LIST,EVENT_BONE_ANIMATION,EVENT_BONE_LOCATION,EVENT_BONE_ROTATION,EVENT_BONE_WEIGHT,EVENT_MESH_FACE
		global EVENT_MESH_FACE,EVENT_MESH_VERTEX,EVENT_MESH_EDGE,EVENT_OTHERFUNCTION
		# Draw and Exit Buttons
		Button("Other Function",EVENT_OTHERFUNCTION, 10, Menu_Height*8, 80, 18)
		Button("Bone Animation",EVENT_BONE_ANIMATION, 10, Menu_Height*7, 80, 18)
		Button("Bone List",EVENT_BONE_LIST, 10, Menu_Height*7, 80, 18)
		Button("Bone Loc",EVENT_BONE_LOCATION, 10, Menu_Height*6, 80, 18)
		Button("Bone roll",EVENT_BONE_ROTATION, 10, Menu_Height*5, 80, 18)
		Button("Bone weight",EVENT_BONE_WEIGHT, 10, Menu_Height*4, 80, 18)
		Button("Mesh face",EVENT_MESH_FACE, 10, Menu_Height*3, 80, 18)
		Button("Mesh vertex",EVENT_MESH_VERTEX, 10, Menu_Height*2, 80, 18)
		Button("Mesh edge",EVENT_MESH_EDGE, 10, Menu_Height*1, 80, 18)
		
		Button("Exit",EVENT_EXIT , 140, 10, 80, 18)
		print "Draw GUI"
	
def event(evt, val):
	global EVENT_EXIT,QKEY
	if (evt == QKEY and not val):
		print "Hello EXIT"
		Exit()

def bevent(evt):
	global EVENT_NOEVENT,EVENT_DRAW,EVENT_EXIT
	global EVENT_BONE_LIST,EVENT_BONE_ANIMATION,EVENT_BONE_LOCATION,EVENT_BONE_ROTATION,EVENT_BONE_WEIGHT,EVENT_MESH_FACE
	global EVENT_MESH_FACE,EVENT_MESH_VERTEX,EVENT_MESH_EDGE,EVENT_OTHERFUNCTION
	# Manages GUI events
	if evt == EVENT_BONE_LIST:
			bone_names()
	if evt == EVENT_EXIT:
		Exit()
	if evt == EVENT_OTHERFUNCTION:
		otherfunction()
	#if evt == EVENT_EXIT:
	

Register(draw, event, bevent)				