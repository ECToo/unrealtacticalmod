bl_info = {
    "name": "Export DAE",
    "author": "Darknet",
    "version": (1, 0),
    "blender": (2, 5, 7),
    "api": 00000,
    "location": "File > Export > DAE",
    "description": "DAE",
    "warning": "",
    "wiki_url": "http://wiki.blender.org/index.php/Extensions:2.5/Py/"\
        "Scripts/Import-Export/Unreal_psk_psa",
    "tracker_url": "https://projects.blender.org/tracker/index.php?"\
        "func=detail&aid=21366",
    "category": "Import-Export"}


"""
	To build the basic of the skelton mesh you need to build the static mesh.
"""

import bpy
import mathutils
from bpy.props import *
from mathutils import Vector
Vector = mathutils.Vector
from math import radians
import xml.parsers.expat
from xml.dom.minidom import Document
import io


#p = xml.parsers.expat.ParserCreate()
#print(dir(p))

#new = document.createElement('chapter')
#new.setAttribute('number', '5')
#document.documentElement.appendChild(new)
"""
# Create the minidom document
doc = Document()

# Create the <wml> base element
wml = doc.createElement("wml")
doc.appendChild(wml)

# Create the main <card> element
maincard = doc.createElement("card")
maincard.setAttribute("id", "main")
wml.appendChild(maincard)

# Create a <p> element
paragraph1 = doc.createElement("p")
maincard.appendChild(paragraph1)

# Give the <p> elemenet some text
ptext = doc.createTextNode("This is a test!")
paragraph1.appendChild(ptext)


print(doc.toprettyxml(indent="  "))

f = open('blender255_BETA.fbx', 'w')
f.write(doc.toprettyxml(indent="  "))
f.close()
"""

class VIEW3D_PT_FBX_TOOLS(bpy.types.Panel):
	bl_space_type = "VIEW_3D"
	bl_region_type = "TOOLS"
	bl_label = "FBX Tools"
	
	@classmethod
	def poll(cls, context):
		return context.active_object

	def draw(self, context):
		layout = self.layout
		scene = context.scene
		layout.operator(OBJECT_OT_ExportDAE.bl_idname)
		
class OBJECT_OT_ExportDAE(bpy.types.Operator):
	bl_idname = "object.exportdae"
	bl_label = "Export Objects dae"
	__doc__ = ""
	
	def invoke(self, context, event):
		scene = context.scene
		for obj in bpy.data.objects:
			#print("objects",obj.name)
			if obj.type == 'MESH':
				prasemesh(obj)
		return {'FINISHED'}
		
def prasemesh(obj):
	print("[=OBJECT=]")
	# Create the minidom document
	doc = Document()
	doc_tmp = Document()
	_COLLADA = doc_tmp.createElement("COLLADA")
	
	_COLLADA.setAttribute("version", "1.4.0")
	_COLLADA.setAttribute("xmlns", "http://www.collada.org/2005/11/COLLADASchema")
	
	doc.appendChild(_COLLADA)	
	_DAE_asset = DAE_asset(_COLLADA)
	
	_DAE_library_effects = DAE_library_effects(_COLLADA)
	_DAE_library_materials = DAE_library_materials(_COLLADA)
	_DAE_library_geometries = DAE_library_geometries(_COLLADA)
	_DAE_library_visual_scenes = DAE_library_visual_scenes(_COLLADA)
	_DAE_library_physics_materials = DAE_library_physics_materials(_COLLADA)
	_DAE_library_physics_models = DAE_library_physics_models(_COLLADA)
	_DAE_library_physics_scenes = DAE_library_physics_scenes(_COLLADA)
	_DAE_scene = DAE_scene(_COLLADA)
	
	meshdata(obj,_DAE_library_geometries)
	
	print(doc.toprettyxml(indent="  "))

	f = open('blender255_BETA.dae', 'w')
	f.write(doc.toprettyxml(indent="  "))
	f.close()

##=========================================================
#
##=========================================================

def meshdata(obj,gem):
	#doc_tmp = Document()
	#_geometry = doc_tmp.createElement("geometry")
	_mesh = DocCreateElement("mesh")
	
	#doc_tmp.appendChild(_geometry)
	_mesh.setAttribute("id", obj.data.name)#mesh
	_mesh.setAttribute("name", obj.name)#object name
	print("Position")
	#print(dir(obj.data))
	# # =========================================
	# Position
	# # =========================================
	_source_Position = DocCreateElement("source")	
	_source_Position.setAttribute("id",( obj.data.name+"-Position"))	
	_source_float_array = DocCreateElement("float_array")	
	_source_float_array.setAttribute("id", obj.data.name+"-Position-array")
	#print(dir(obj.data))
	count = 0
	
	strvertex = ''
	
	for vertex in obj.data.vertices:
		#print(dir(vertex.co.x))
		#print(strvertex)
		pvert = str(format(vertex.co.x,'.5f')) + " "+str(format(vertex.co.y,'.5f')) + " "+str(format(vertex.co.z,'.5f')) + " "
		#pvert = str(" "+ vertex.co.x + " " + vertex.co.y + " " + vertex.co.z)
		#print(pvert)
		strvertex += pvert
		count += 1
	_source_float_array.setAttribute("count", str(count * 3))#(x,y,z) * vertex 
	ptext = DocCreateTextNode(strvertex)	
	_source_float_array.appendChild(ptext)
	
	_source_Position.appendChild(_source_float_array)	
	_source_technique_common = None
	_source_technique_common = DocCreateElement("technique_common")
	_accessor = None
	_accessor = DocCreateElement("accessor")
	#count vertex point
	_accessor.setAttribute("count", str(count))#number vertex point
	_accessor.setAttribute("source",("#" + obj.data.name + "-Position-array"))
	_accessor.setAttribute("stride",("3"))
	
	_paramx = DocCreateElement("param")
	_paramx.setAttribute("type","float")
	_paramx.setAttribute("name","X")
	_accessor.appendChild(_paramx)
	
	_paramy = DocCreateElement("param")
	_paramy.setAttribute("type","float")
	_paramy.setAttribute("name","Y")
	_accessor.appendChild(_paramy)
	
	_paramz = DocCreateElement("param")
	_paramz.setAttribute("type","float")
	_paramz.setAttribute("name","Z")
	_accessor.appendChild(_paramz)	
	_source_technique_common.appendChild(_accessor)
	
	_source_Position.appendChild(_source_technique_common)
	
	_mesh.appendChild(_source_Position)
	# # =========================================
	# Normals
	# # =========================================
	print("Normals")
	_source_Normals = DocCreateElement("source")
	_source_Normals.setAttribute("id",( obj.data.name+"-Normals"))#mesh
	
	_source_float_array = DocCreateElement("float_array")
	#_source_float_array.setAttribute("count", "")
	_source_float_array.setAttribute("id",obj.data.name+"-Normals-array")
	
	strnormal = ''
	count = 0
	for face in obj.data.faces:
		#print(face.normal)
		strnormal += str(format(face.normal.x,'.5f')) + " "+str(format(face.normal.y,'.5f')) + " "+str(format(face.normal.z,'.5f')) + " "
		count += 1
	_source_float_array.setAttribute("count", str(count * 3))#(x,y,z) * vertex 
	ptext = DocCreateTextNode(strnormal)	
	_source_float_array.appendChild(ptext)
	
	_source_Normals.appendChild(_source_float_array)
	
	_source_technique_common = None
	_accessor = None
	_accessor = DocCreateElement("accessor")
	_source_technique_common = DocCreateElement("technique_common")
	_accessor.setAttribute("count", str(count))
	_accessor.setAttribute("source",("#" + obj.data.name + "-Normals-array"))
	_accessor.setAttribute("stride",("3"))
	
	_paramx = DocCreateElement("param")
	_paramx.setAttribute("type","float")
	_paramx.setAttribute("name","X")
	_accessor.appendChild(_paramx)
	
	_paramy = DocCreateElement("param")
	_paramy.setAttribute("type","float")
	_paramy.setAttribute("name","Y")
	_accessor.appendChild(_paramy)
	
	_paramz = DocCreateElement("param")
	_paramz.setAttribute("type","float")
	_paramz.setAttribute("name","Z")
	_accessor.appendChild(_paramz)
	_source_technique_common.appendChild(_accessor)
	_source_Normals.appendChild(_source_technique_common)
	_mesh.appendChild(_source_Normals)
	# # =========================================
	# UV
	# # =========================================
	print("UV")
	_source_UV = DocCreateElement("source")
	_source_UV.setAttribute("id",( obj.data.name+"-UV"))#mesh
	
	_source_float_array = DocCreateElement("float_array")
	
	struv = ''
	count = 0
	#object mode needed
	for current_face in obj.data.faces:
		face_index = current_face.index
		uv_layer = obj.data.uv_textures.active
		
		if uv_layer != None:
			faceUV = uv_layer.data[face_index]
			for fuv in faceUV.uv:
				#print("--UV--")
				#print(str(fuv[0]),str(fuv[1]))
				struv += str(format(fuv[0],'.5f')) + " " + str(format(fuv[0],'.5f')) + " "
				count += 1

	ptext = DocCreateTextNode(struv)
	_source_float_array.appendChild(ptext)
	
	_source_float_array.setAttribute("count", str(count * 2))
	
	_source_float_array.setAttribute("id",obj.data.name+"-UV-array")
	_source_UV.appendChild(_source_float_array)
	
	_source_technique_common = None
	_accessor = None
	_accessor = DocCreateElement("accessor")
	_source_technique_common = DocCreateElement("technique_common")
	_accessor.setAttribute("count", "")
	_accessor.setAttribute("source",("#" + obj.data.name + "-UV-array"))
	_accessor.setAttribute("stride",("3"))
	
	_params = DocCreateElement("param")
	_params.setAttribute("type","float")
	_params.setAttribute("name","S")
	_accessor.appendChild(_params)
	
	_paramt = DocCreateElement("param")
	_paramt.setAttribute("type","float")
	_paramt.setAttribute("name","T")
	_accessor.appendChild(_paramt)
	
	_source_technique_common.appendChild(_accessor)
	_mesh.appendChild(_source_UV)
	
	# # =========================================
	# vertices
	# # =========================================
	print("vertices")
	_vertices = DocCreateElement("vertices")
	_vertices.setAttribute("id", "#"+obj.data.name+"-Vertex")
	_vertices_input = DocCreateElement("input")
	_vertices_input.setAttribute("semantic", "POSITION")
	_vertices_input.setAttribute("source", ("#"+ obj.data.name+ "-Position"))
	_vertices.appendChild(_vertices_input)
	_mesh.appendChild(_vertices)
	
	# # =========================================
	# triangles
	# # =========================================
	print("triangles")
	_triangles = DocCreateElement("triangles")
	_triangles.setAttribute("count", "")
	_triangles.setAttribute("material", "Material")
	_triangles_input = DocCreateElement("input")
	_triangles_input.setAttribute("offset","0")
	_triangles_input.setAttribute("semantic","VERTEX")
	_triangles_input.setAttribute("source","#"+obj.data.name+"-Vertex")
	_triangles.appendChild(_triangles_input)
	_triangles_input = DocCreateElement("input")
	_triangles_input.setAttribute("offset","1")
	_triangles_input.setAttribute("semantic","NORMAL")
	_triangles_input.setAttribute("source","#"+obj.data.name+"-Normals")
	_triangles.appendChild(_triangles_input)
	_triangles_input = DocCreateElement("input")
	_triangles_input.setAttribute("offset","2")
	_triangles_input.setAttribute("semantic","TEXCOORD")
	_triangles_input.setAttribute("source","#"+obj.data.name+"-UV")
	_triangles.appendChild(_triangles_input)
	
	_triangles_p = DocCreateElement("p")
	_triangles.appendChild(_triangles_p)
	
	strfaceid = ''
	count = 0
	for current_face in obj.data.faces:
		#print(dir(current_face))
		for vertex in current_face.vertices:
			print((vertex))
			#print((vertex))
			strfaceid += str(vertex) + ' '
			count += 1
			pass
	
	
	_ptext = DocCreateTextNode(strfaceid)
	_triangles_p.appendChild(_ptext)
	_mesh.appendChild(_triangles)
	# # =========================================
	# 
	# # =========================================
	gem.appendChild(_mesh)
	#_geometry.appendChild(_mesh)
	#doc_tmp.appendChild(_geometry)
	#print(doc_tmp.toprettyxml(indent="  "))
##=========================================================
#
##=========================================================	

def DocCreateElement(xmlstring):
	doc_tmp = Document()
	return doc_tmp.createElement(xmlstring)
	
def DocSetAttribute(xml,var,value):
	return xml.setAttribute(var,value)
	
def DocCreateTextNode(xmlstring):
	doc_tmp = Document()
	return doc_tmp.createTextNode(xmlstring)
	
	
##=========================================================
#
##=========================================================

def DAE_asset(xml):
	# Create the minidom document
	doc_tmp = Document()
	# Create the <wml> base element
	_asset = doc_tmp.createElement("asset")
	_contributor = doc_tmp.createElement("contributor")	
	_contributor_author = doc_tmp.createElement("author")	
	_contributor_authoring_tool = doc_tmp.createElement("authoring_tool")
	_contributor.appendChild(_contributor_authoring_tool)
	_contributor_comments = doc_tmp.createElement("comments")
	_contributor.appendChild(_contributor_comments)
	_contributor_copyright = doc_tmp.createElement("copyright")
	_contributor.appendChild(_contributor_copyright)
	_contributor_source_data = doc_tmp.createElement("source_data")
	_contributor.appendChild(_contributor_source_data)
	_asset.appendChild(_contributor)
	
	_asset_created = doc_tmp.createElement("created")
	_asset.appendChild(_asset_created)
	_asset_modified = doc_tmp.createElement("modified")
	_asset.appendChild(_asset_modified)
	_asset_unit = doc_tmp.createElement("unit")
	_asset.appendChild(_asset_unit)
	_asset_up_axis = doc_tmp.createElement("up_axis")
	_asset.appendChild(_asset_up_axis)
		
	xml.appendChild(_asset)
	
def DAE_library_effects(xml):
	doc_tmp = Document()
	_library_effects = doc_tmp.createElement("library_effects")
	xml.appendChild(_library_effects)
	return _library_effects
	
def DAE_library_materials(xml):
	doc_tmp = Document()
	_library_effects = doc_tmp.createElement("library_materials")
	xml.appendChild(_library_effects)
	return _library_effects
	
def DAE_library_geometries(xml):
	doc_tmp = Document()
	_library_geometries = doc_tmp.createElement("library_geometries")
	xml.appendChild(_library_geometries)
	return _library_geometries
	
def DAE_library_visual_scenes(xml):
	doc_tmp = Document()
	_library_visual_scenes = doc_tmp.createElement("library_visual_scenes")
	xml.appendChild(_library_visual_scenes)
	return _library_visual_scenes
	
def DAE_library_physics_materials(xml):
	doc_tmp = Document()
	_library_effects = doc_tmp.createElement("library_effects")
	xml.appendChild(_library_effects)
	return _library_effects
	
def DAE_library_physics_models(xml):
	doc_tmp = Document()
	_library_physics_models = doc_tmp.createElement("library_physics_models")
	xml.appendChild(_library_physics_models)
	return _library_physics_models
	
def DAE_library_physics_scenes(xml):
	doc_tmp = Document()
	_library_physics_scenes = doc_tmp.createElement("library_physics_scenes")
	xml.appendChild(_library_physics_scenes)
	return _library_physics_scenes
	
def DAE_scene(xml):
	doc_tmp = Document()
	_scene = doc_tmp.createElement("scene")
	xml.appendChild(_scene)
	return _scene

##=========================================================
#
##=========================================================
def register():
	bpy.utils.register_module(__name__)

def unregister():
	bpy.utils.unregister_module(__name__)

if __name__ == "__main__":
	register()	