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
print mesh.name
print mesh.verts
for vert in mesh.verts:
	print( 'v %f %f %f' % (vert.co.x, vert.co.y, vert.co.z) )#,'\n Hello'
#for vert in mesh.verts:

for face in mesh.faces:
	fstr = ""
    #out.write('f')
	fstr = "f"
	for vert in face.v:
		fstr += ( ' %i' % (vert.index + 1) )
        #out.write( ' %i' % (vert.index + 1) )
    #out.write('\n')
	#fstr += ('\n')
	print fstr	
	
sce = bpy.data.scenes.active
ob2 = sce.objects.active
mesh2 = ob2.getData(mesh=1)
print mesh2
#for vert in mesh2.verts:
#	print( 'v %f %f %f' % (vert.co.x, vert.co.y, vert.co.z) ),'\n'
    #out.write( 'v %f %f %f\n' % (vert.co.x, vert.co.y, vert.co.z) )