import Blender
from Blender import *

import Blender
RotationMatrix= Blender.Mathutils.RotationMatrix

MATRIX_IDENTITY_3x3 = Blender.Mathutils.Matrix([1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0])
def eulerRotateOrder(x,y,z): 
        x,y,z = x%360,y%360,z%360 # Clamp all values between 0 and 360, values outside this raise an error.
        xmat = RotationMatrix(x,3,'x')
        ymat = RotationMatrix(y,3,'y')
        zmat = RotationMatrix(z,3,'z')
        # Standard BVH multiplication order, apply the rotation in the order Z,X,Y
        # Change the order here
        return (ymat*(xmat * (zmat * MATRIX_IDENTITY_3x3))).toEuler()

def bone_locations():
	print "---------------------"
	ob_armature = Blender.Object.Get('Armature')
	ob = Object.Get('Armature')
	armature_data = ob.getData()
	#armature_mat = armature_data.matrixWorld()
	#print dir(ob_armature.getPose())
	ob_pose = ob_armature.getPose()
	#print dir(ob_pose.bones.keys() )
	ob_keys = ob_pose.bones.keys() 
	print dir(ob_keys[0].translate)
	armature_bones = armature_data.bones.values()
	#print dir(armature_bones.index)
	#print armature_mat

	#for bone in armature_bones:
		#print bone.name
		#print dir(bone)
		#print bone.name
		#print bone.weight
		#print bone.head
		#print bone.rotation
		#bone_mat= bone.matrix['ARMATURESPACE']
		#print bone_mat #hm
        #bone_mat_world= bone_mat*arm_mat
		#ob_empty= Object.New('Empty', bone.name)
        #scn.link(ob_empty)
        #ob_empty.setMatrix(bone_mat_world)
        #ob_empty.sel= 1	
	
	#Bone Name Print
	#print (ob_armature)
	#print (type(ob_armature))
	#print (dir(ob_armature.bones.keys())) #This print out the functions
	#bones_keys = ob_armature.bones.keys()
	#print dir(ob_armature.bones.values)
	#print dir(bones_keys[0])
	#print bones_keys[0].BonePos

	#pose = ob_armature.getPose()
	#print "-----------------"
	#bone_list = pose.bones.keys()
	#print help(bone_list[0]) #Crash for blender
	#type(bone_list)
	

def bone_list_name():
	ob = Object.Get('Armature')
	#Bone Name Print
	pose = ob.getPose()
	print "-----------------"
	for bonename in pose.bones.keys():
		#print pose.bones[bonename]
		print bonename
		#bone = pose.bones[bonename]
		#print bone.constraints,bone.name
		#print "loc ",bonename.loc
		
#bone_list_name()
bone_locations()