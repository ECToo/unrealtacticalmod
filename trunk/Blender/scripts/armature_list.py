import Blender

from Blender import *
print "----------------------"
ob = Blender.Object.Get('Armature')
#ob = Object.Get('Armature')
#pose = ob.getPose()
ob_armature = ob.getData()
print list(ob_armature)
#print dir(ob_armature)#crash do not use

#print pose
#for bonename in pose.bones.keys():
#	print pose.bones[bonename]
#	bone = pose.bones[bonename]