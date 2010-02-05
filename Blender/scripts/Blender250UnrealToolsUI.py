#
"""
Create By: Darknet

Information: This is just a layout design build. There are not function yet.
This is for Blender 2.50 svn build.
"""
import bpy

exporttypedata = []

# [index,text field,0] #or something like that
exporttypedata.append(("0","PSK","Export PSK3"))
exporttypedata.append(("1","PSA","Export PSA3"))
exporttypedata.append(("2","ALL","Export ALL3"))

IntProperty= bpy.types.Scene.IntProperty

IntProperty(attr="unrealfpsrate", name="fps rate",
    description="A user defined property",
    default=24,min=1,max=100)
	
bpy.types.Scene.EnumProperty( attr="unrealexport_settings",
    name="Export:",
    description="Select a export settings...",
    items = exporttypedata, default = '0')
		
bpy.types.Scene.BoolProperty( attr="unrealtriangulatebool",
    name="Triangulate Mesh",
    description="Convert Quad to Tri Boolean...",
    default=False)

class VIEW3D_PT_unrealtools_objectmode(bpy.types.Panel):
	bl_space_type = "VIEW_3D"
	bl_region_type = "TOOLS"
	bl_label = "Unreal Tools"
	
	def poll(self, context):
		return context.active_object
    
	def draw(self, context):
		layout = self.layout
		Titlelable = layout.label(text="Unreal Tools")
		rd = context.scene
		#drop box
		layout.prop(rd, "unrealexport_settings")
		#bool checkbox triangulate mesh
		layout.prop(rd, "unrealtriangulatebool")
		#button
		layout.operator("object.UnrealExport")
		#FPS Rate
		#print("FPS:",(context.scene.render_data.fps))
		layout.prop(rd, "unrealfpsrate")

class OBJECT_OT_UnrealExport(bpy.types.Operator):
	bl_idname = "OBJECT_OT_UnrealExport"
	bl_label = "Unreal Export"
	__doc__ = "Export Skeleton Mesh / Action Set(Animation Set) for .psk/.psa"
	
	def invoke(self, context, event):
		print("Init Export Script:")
		if(int(bpy.context.scene.unrealexport_settings) == 0):
			print("Exporting PSK...")
		if(int(bpy.context.scene.unrealexport_settings) == 1):
			print("Exporting PSA...")
		if(int(bpy.context.scene.unrealexport_settings) == 2):
			print("Exporting ALL...")
		print("FPS RATE:",bpy.context.scene.unrealfpsrate)
		print("Triangulate Mesh",bpy.context.scene.unrealtriangulatebool)
		print("Done Event...")
		return{'FINISHED'}
		
bpy.types.register(OBJECT_OT_UnrealExport)
bpy.types.register(VIEW3D_PT_unrealtools_objectmode)