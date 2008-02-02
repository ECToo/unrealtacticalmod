from Blender import *
ob = Object.Get('Armature')
pose = ob.getPose()
print "-----------------"
for bonename in pose.bones.keys():
	
	print pose.bones[bonename]
	bone = pose.bones[bonename]
	print bone.constraints,bone.name
	print "loc ",bone.loc
