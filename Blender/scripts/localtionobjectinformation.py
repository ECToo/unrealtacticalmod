""" 
Name: 'Location Object' 
Blender: 240 
Group: 'Export' 
Tooltip: 'Unreal Skeletal Mesh and Animation Export (*.psk, *.psa)' 
""" 


import Blender, time, os, math, sys as osSys, operator
from Blender import sys, Window, Draw, Scene, Mesh, Material, Texture, Image, Mathutils, Armature


from cStringIO import StringIO
from struct import pack, calcsize


#ob = Blender.Object.Get('Cube')
#print  ob		# the object
#print  ob.name	# object name
#print 'location', ob.loc	# object location

import Blender as B
#return a list of selected objects
#ob_list = B.Object.GetSelected()
#print ob_list

#for i in ob_list:
#	print i

selection = B.Object.GetSelected()
print"---"
#for i in selection:
#	#print name and location
#	print 'object', i.name, i.loc
	
#ob = selection[0] #the first selected object
#ob.name = 'MyObject' #name it object
#B.Redraw(-1) #redraw blender's interface

# a list of selected objects
#selection = B.Object.GetSelected() 
#ob = selection[0] # the first selected object
#ob.LocX += 0.5 # increment the X position by 0.5
#B.Redraw( -1 )    # redraw Blender's Interface

import Blender as B


# get a list of selected objects
objects = B.Object.GetSelected()

# for each object in our list
#  print its name and type
#  get the ObData part
#  print the name and type of the ObData

for i in objects:    
	print i.name, type(i)
	obdata = i.data
	print obdata.name, type(obdata)
