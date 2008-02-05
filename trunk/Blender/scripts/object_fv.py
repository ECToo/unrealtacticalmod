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

sce = bpy.data.scenes.active
ob2 = sce.objects.active
mesh2 = ob2.getData(mesh=1)
print mesh2
#for vert in mesh2.verts:
#	print( 'v %f %f %f' % (vert.co.x, vert.co.y, vert.co.z) ),'\n'
    #out.write( 'v %f %f %f\n' % (vert.co.x, vert.co.y, vert.co.z) )