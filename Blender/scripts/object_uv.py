#this section give you the faces and the vertex
#this is for object mesh current name file or default as "Cube" with counter number add

import bpy
import Blender

from Blender import NMesh
from Blender.BGL import *
from Blender.Draw import *

import math
from math import *

ob = Blender.Object.Get('Cube')
mesh = ob.getData()
for face in mesh.faces:
	for v in face.uv:
		print("%f %f" % (v[0], v[1]))
		
# write all the uv coordinates to a file denoted by modelname-uv.txt
def dumpUV( self, obj ):
	print obj.name
	mesh = Mesh.get( obj.name )
	if mesh != None:
		filename = obj.name + "-uv.txt"
		file = open( filename, "w" )
		print "Dumping UV to ", filename

		for face in mesh.faces:
			for uv in face.uv:
				file.write( "%f %f\n" % ( uv[0], uv[1] ) )
				file.close()
		return "Dumped UV coords to file"
	else:
		return "Cannot Dump UV: Invalid Mesh Selected"