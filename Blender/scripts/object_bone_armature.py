import Blender

from Blender import *
ob = Object.Get('Armature')
pose = ob.getPose()
#print pose.matrix()

ob_bone = Blender.Object.Get('Armature')
partbone = ob_bone.getPose()
key_bone = partbone.bones.keys()
bones = partbone.bones
print "B-----"
print bones.martrix['ARMATURESPACE']
print "-------"
print key_bone[2]

print "-----------------"
print pose.bones.keys()
print pose.bones.values()
"""
"""
for bonename in pose.bones.keys():
	
	print pose.bones[bonename]
	bone = pose.bones[bonename]
	#print bone.constraints,bone.name
	#print "localtion: ",bone.loc
	#print "parent: ",bone.parent
	#print "head: ",bone.head
	#print "tail: ",bone.roll()







"""
from Blender import *
def test_arm():
	scn= Scene.GetCurrent()
	arm_ob= scn.objects.active

	if not arm_ob or arm_ob.type != 'Armature':
		Draw.PupMenu('not an armature object')
		return

	# Deselect all
	for ob in scn.objects:
		if ob != arm_ob:
			ob.sel= 0

	arm_mat= arm_ob.matrixWorld

	arm_data= arm_ob.getData()

	bones= arm_data.bones.values()
	for bone in bones:
		print bone.parent, bone.name
		#print "OPTIONS:" ,bone.options('ROOT_SELECTED')
		bone_mat= bone.matrix['ARMATURESPACE']
		bone_mat_world= bone_mat*arm_mat

		ob_empty= scn.objects.new('Empty')
		ob_empty.setMatrix(bone_mat_world)

test_arm()
"""

#print "---"	
"""
from Blender import *


scn= Scene.GetCurrent()
arm_ob= scn.objects.active
if not arm_ob or arm_ob.type != 'Armature':
	Draw.PupMenu('not an armature object')
	
# Deselect all


for ob in scn.objects:
	if ob != arm_ob:
		ob.sel= 0
        arm_mat= arm_ob.matrixWorld
        arm_data= arm_ob.getData()
        bones= arm_data.bones.values()
        for bone in bones:
            bone_mat= bone.matrix['ARMATURESPACE']
            bone_mat_world= bone_mat*arm_mat
            ob_empty= scn.objects.new('Empty')
            ob_empty.setMatrix(bone_mat_world)
			
from Blender import *

print "Hello" , " Qoeld"
ob = Object.Get('Armature')
pose = ob.getPose()
for bonename in pose.bones.keys():
    bone = pose.bones[bonename],
	print bone
    for const in bone.constraints:
        print bone.name,'=>',const

"""
"""
import Blender
from Blender import Armature
from Blender.Mathutils import *

arm_obj = Armature.Get()
arm_mat= arm_obj.matrixWorld
arm_data= arm_ob.getData()
bones= arm_data.bones.values()
for bone in bones:
    bone_mat= bone.matrix['ARMATURESPACE']
    bone_mat_world= bone_mat*arm_mat
    ob_empty= scn.objects.new('Empty')
    ob_empty.setMatrix(bone_mat_world)
"""
"""
import Blender
from Blender import Armature
from Blender.Mathutils import *
#
arms = Armature.Get()
for arm in arms.values():
	arm.drawType = Armature.STICK #set the draw type
	arm.makeEditable() #enter editmode
	#generating new editbone
	eb = Armature.Editbone()
	eb.roll = 10
	eb.parent = arm.bones['Bone.003']
	eb.head = Vector(1,1,1)
	eb.tail = Vector(0,0,1)
	eb.options = [Armature.HINGE, Armature.CONNECTED]
	
	#add the bone
	arm.bones['myNewBone'] = eb
 
	#delete an old bone
	del arm.bones['Bone.002']

	arm.update()  #save changes

	for bone in arm.bones.values():
		#print bone.matrix['ARMATURESPACE']
		print bone.parent, bone.name
		print bone.children, bone.name
		print bone.options, bone.name
"""
	

"""
# Adds empties for every bone in the selected armature, an example of getting worldspace locations for bones.
from Blender import *

def test_arm():
	scn= Scene.GetCurrent()
    arm_ob= scn.objects.active
    if not arm_ob or arm_ob.type != 'Armature':
		Draw.PupMenu('not an armature object')
	return

# Deselect all
for ob in scn.objects:
	if ob != arm_ob:
		ob.sel= 0
        arm_mat= arm_ob.matrixWorld
        arm_data= arm_ob.getData()
        bones= arm_data.bones.values()
        for bone in bones:
            bone_mat= bone.matrix['ARMATURESPACE']
            bone_mat_world= bone_mat*arm_mat
            ob_empty= scn.objects.new('Empty')
            ob_empty.setMatrix(bone_mat_world)

test_arm()
"""