# Introduction #
This just blender and python working with code bits of pieces.

Note they shorten code build. Working with new version of the blender 2.45.

# Bone And Armature #
```
#For Object Armature
parent_mat.rotationPart()
parent_mat

#For bone
blender_bone.head['ARMATURESPACE']
blender_bone.tail['ARMATURESPACE'] 
blender_bone.matrix['ARMATURESPACE']
blender_bone.head['BONESPACE']
blender_bone.tail['BONESPACE']
blender_bone.matrix['BONESPACE']
blender_bone.roll['BONESPACE']

#=== Root ID
	if not blender_bone.hasParent():
		parent_root = blender_bone
	#print "---------------PARENT ROOT BONE: ",parent_root
	#print "BONESPACE:Matrix:]",blender_bone.matrix['ARMATURESPACE'].toQuat()
	
	if blender_bone.hasChildren():
		child_count = len(blender_bone.children)
	else:
		child_count = 0
	#parent
	child_parent = blender_bone.parent

#Work Area For Bone Fix and Rotation:
		quat_parent = child_parent.matrix['BONESPACE'].toQuat().inverse()
		parent_head = child_parent.head['BONESPACE']* quat_parent
		parent_tail = child_parent.tail['BONESPACE']* quat_parent
		set_position = parent_tail + blender_bone.head['BONESPACE']
		set_position = set_position - parent_head
		print quat_parent
```