# Information: #
> This just a script that create a simple mesh in the blender scene in 2.54 version.

```
import bpy

class buildings():
	def create():
		print("")

class VIEW3D_PT_BuildingGenerator(bpy.types.Panel):
	bl_space_type = "VIEW_3D"
	bl_region_type = "TOOLS"
	bl_label = "Building Gen. Tool"
	
	@classmethod
	def poll(cls, context):
		return context.active_object

	def draw(self, context):
		layout = self.layout
		scene = context.scene
		
		layout.operator("object.BuiltBuilding")#button
		layout.operator("object.DestoryBuilding")#button
		
class OBJECT_OT_BuiltBuilding(bpy.types.Operator):
	global exportmessage
	bl_idname = "OBJECT_OT_BuiltBuilding"
	bl_label = "Create"
	__doc__ = ""
	
	def invoke(self, context, event):
		scene = context.scene
		buildmeshbuilding()
		return {'FINISHED'}
		
class OBJECT_OT_DestoryBuilding(bpy.types.Operator):
	global exportmessage
	bl_idname = "OBJECT_OT_DestoryBuilding"
	bl_label = "Delete"
	__doc__ = ""
	
	def invoke(self, context, event):
		scene = context.scene
		return {'FINISHED'}
		
def buildmeshbuilding():
	meshname = "building" #mesh name
	objectname = "building" #object name in the scene
	
	bfoundmesh = False
	
	#check if mesh exist
	for obj in bpy.data.objects:
		print("objects",obj.name)
		if obj.type == 'MESH' and obj.name == objectname:
			print("found")
			bfoundmesh = True
	
	#if mesh if doesn't exit in the scene
	if bfoundmesh == False:
		me_ob = bpy.data.meshes.new(meshname)
		
		faces = []
		verts = []
		#create vertex points
		verts.extend([(1.000000,1.000000,0.000000)]) #index 0
		verts.extend([(1.000000,-1.000000,0.000000)]) #index 1
		verts.extend([(-1.000000,-1.000000,0.000000)]) #index 2
		verts.extend([(-1.000000,1.000000,0.000000)]) #index 3
		#create face from index vertex array
		faces.extend([0,3,2,0])
		faces.extend([0,2,1,0])
		me_ob.vertices.add(len(verts)) # 3 vetex point #count number of vertex point
		me_ob.faces.add(len(faces)//4) # 2 face #count number of faces
		
		print("faces:", (len(faces)//4)," verts:",len(verts))
		
		me_ob.vertices.foreach_set("co", unpack_list(verts)) #vertex
		me_ob.faces.foreach_set("vertices_raw", faces) #face array
		me_ob.faces.foreach_set("use_smooth", [False] * len(me_ob.faces)) #smooth group
		me_ob.update()
		
		obmesh = bpy.data.objects.new(objectname,me_ob)
		bpy.context.scene.objects.link(obmesh)
		bpy.context.scene.update()
		print("object created...")
	print("finish")
	
def unpack_list(list_of_tuples):
    l = []
    for t in list_of_tuples:
        l.extend(t)
    return l

def register():
	pass

def unregister():
	pass

if __name__ == "__main__":
	register()	
```