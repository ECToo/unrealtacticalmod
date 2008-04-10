#!BPY
""" 
Name: 'UT3 Armature Bones' 
Blender: 245
Group: 'Export' 
Tooltip: 'Unreal Skeletal Mesh and Animation Export (*.psk, *.psa)' 
""" 
__author__ = "Darknet" 
__version__ = "0.1" 
__bpydoc__ = """\ 

-- UT3 Armature bones
""" 
import sys, os, os.path, struct, math, string
import Blender
from Blender import *
from Blender.Armature import *

import Blender
from Blender import Armature
from Blender.Mathutils import *
from Blender import *
print "----"
#print dir(Armature)
armObj = Object.New('Armature', "Armature_obj")
armData = Armature.New('MAIN') #Main Armature Data


armData.drawType = Armature.STICK
armData.makeEditable()
eb = Armature.Editbone()
eb.roll = 10
print (eb.parent) 
#eb.parent = #arm.bones['Bone.003']
eb.head = Vector(1,1,1)
eb.tail = Vector(0,0,1)
#eb.options = [Armature.HINGE, Armature.CONNECTED]
armData.bones['myNewBone'] = eb
armData.bones['myNewBone2'] = eb
#print dir(armData)

armObj.link(armData)
armData.update()
#Arm_Raw = Armature.GetRaw()


#Armature.PutRaw(Arm_Raw,"Armature",1);
scn = Blender.Scene.getCurrent() #Get Current Scene
scn.link(armObj) #Link the armature

#Blender.Redraw()







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
				
#test_arm()
'''
import Blender, time, os, math, sys as osSys, operator
from Blender import sys, Window, Draw, Scene, Mesh, Material, Texture, Image, Mathutils, Armature
from cStringIO import StringIO
from struct import pack, calcsize

print "Unreal Tournament 3 Export Testing..."

def ArmatureBone(objectbones):
	print "[-- Start Armature --]"
	arm = objectbones.getData()
	arm_mat = objectbones.matrixWorld
	print "---- PRASE ARMATURE ---"
	for bones in arm.bones.values():
		print "----",bones.name
		if bones.hasParent:
			bones.parent
			print bones.head['BONESPACE']
		else:
			print bones.head['BONESPACE']
		#print bones
		#print dir(bones)
	
	print "[-- End Armature --]"
	
def BoneItems(objectbones):
	arm = objectbones.getData()
	#print arm
	print dir(arm.bones.items())
	for bone in arm.bones.items():
		print "----"
		print dir(bone)
def BoneKeys(objectbones):
	print objectbones
	
def BoneValues(objectbones):
	print objectbones
	#for value in Blender.Armature.NLA.GetActions().keys():
	#	print dir(value)
	
	#for value in Blender.Armature.NLA.GetActions().values():
	#	print dir(value)
def PoseBone(objectbones):
	print "POSE BONE-------"
	#print dir(objectbones)
	pose = objectbones.getPose() #object get bone pose
	bones = pose.bones #bones
	values = bones.values() #List bones
	for bone in values:
		print "----",bone.name
		print dir(bone.head)
		#print dir(bone)
		#print "head"
		#print bone.head
		#print bone.head.normalize()
		
		#print dir(bone.head.normalize())
	#print  dir(bones.values)
	#print dir(pose.getPose())
	#print dir(pose)
	
def PoseBoneVaules():
		print "Pose Bone Vaules"
def Non():
	#BoneItems(objectbones)
	
	#print dir(objectbones)
	#arm = objectbones.getData()
	#print arm
	
	#for bones in arm.bones.keys():
	#	print "--------"
	#	print bones
		#print bones.translate
		#print bones
		#print dir(bones)
	#action = objectbones
	#print dir(action)
	#print dir(action.copyNLA)
	#print dir(Blender.Armature.NLA.GetActions().items())
	
	#for item in Blender.Armature.NLA.GetActions().items():
	#	print "ITEM---"
	#	#print dir(item)
	#	print list in item:
	#		print dir(list)
		
	#for value in Blender.Armature.NLA.GetActions().values():
	#	print "value"
	#	print dir(value)
	
	
	#print dir(Blender.Armature.NLA.GetActions().values())
	#print dir(Blender.Armature.NLA.GetActions().keys())
	
	

	for act in Armature.NLA.GetActions().values():#action set
		print "Actions-", act.getName()
		print dir(act)
		action_keyframes = act.getFrameNumbers()
		start_frame = min(action_keyframes)
		end_frame = max(action_keyframes)
		scene_frames = xrange(start_frame, end_frame+1) 
		#scene_frames = action_keyframes
		
		frame_count = len(scene_frames)
	
def ArmatureBoneAction(objectbones):
	#print objectbones.getPose()
	#poses = objectbones.getPose() #just get pose
	ArmatureBone(objectbones)
	PoseBone(objectbones)

ob = Blender.Object.Get()
# This will start working on the bones and mesh and other things.
print "|-----------------------------------------------"
print "|- Export Script Starting..."
print "|-----------------------------------------------"
print "[-- Starting Objects --]"
for objects in ob:
	print objects.getType()
	if 'Armature' == objects.getType():
		print 'Armature Prase'
		#ArmatureBone(objects)
		ArmatureBoneAction(objects)
		
print "[-- Ending Objects --]"
	
	
"""
This a work in progress of bone test build to fix off set of the bone position and rotation.
"""
'''