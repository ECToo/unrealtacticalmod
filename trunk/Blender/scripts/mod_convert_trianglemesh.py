#!BPY
""" 
Name: 'UT3 Convert Tri Mesh' 
Blender: 245
Group: 'Export' 
Tooltip: 'Convert Mesh Tri' 
""" 
__author__ = "" 
__version__ = "" 
__bpydoc__ = """\ 


""" 

"""
To Do List:
-uv
-v
-faces
-no
-getVertGroupNames()
-
-
-

"""
import Blender
from Blender import Texture,Image,Material

def triangulateNMesh(nm):
	import Blender
        '''
        Converts the meshes faces to tris, modifies the mesh in place.
        '''
        #============================================================================#
        # Returns a new face that has the same properties as the origional face      #
        # but with no verts                                                          #
        #============================================================================#
        def copyFace(face):
				#Blender.NMesh.Face()#Current Version of 2.45
				#NMesh.Face() #Out Date Script
                newFace = Blender.NMesh.Face()
                # Copy some generic properties
                newFace.mode = face.mode
                if face.image != None:
                        newFace.image = face.image
                newFace.flag = face.flag
                newFace.mat = face.mat
                newFace.smooth = face.smooth
                return newFace
        # 2 List comprehensions are a lot faster then 1 for loop.
        tris = [f for f in nm.faces if len(f) == 3]
        quads = [f for f in nm.faces if len(f) == 4]
        
        
        if quads: # Mesh may have no quads.
                has_uv = quads[0].uv 
                has_vcol = quads[0].col
                for quadFace in quads:
                        print "4"
                        # Triangulate along the shortest edge
                        if (quadFace.v[0].co - quadFace.v[2].co).length < (quadFace.v[1].co - quadFace.v[3].co).length:
                                # Method 1
                                triA = 0,1,2
                                triB = 0,2,3
                        else:
                                # Method 2
                                triA = 0,1,3
                                triB = 1,2,3
                                
                        for tri1, tri2, tri3 in (triA, triB):
                                newFace = copyFace(quadFace)
                                newFace.v = [quadFace.v[tri1], quadFace.v[tri2], quadFace.v[tri3]]
                                if has_uv: newFace.uv = [quadFace.uv[tri1], quadFace.uv[tri2], quadFace.uv[tri3]]
                                if has_vcol: newFace.col = [quadFace.col[tri1], quadFace.col[tri2], quadFace.col[tri3]]
                                
                                nm.addEdge(quadFace.v[tri1], quadFace.v[tri3]) # Add an edge where the 2 tris are devided.
                                tris.append(newFace)
                nm.faces = tris
		return nm

ob = Blender.Object.Get('Cube')
me = ob.data
nme = Blender.NMesh.GetRaw()
lenfaces = 0

print "----"	
#print dir(me.materials)
'''
materials = me.materials
for mat in materials:
	print mat.name

print "-TEXUTRE-"
textures = Blender.Texture.Get()
for tex in textures:
	print tex.name
'''		
matno = -1
for mat in me.getMaterials():
	print "MATERIAL NAME:",mat.name
	matno = matno + 1
	print "ID:",matno
	#print dir(mat)
	
for f in me.faces:
	#print "<:>",dir(f)
	print "Material ID:",f.image,"mat:",f.mat
	
'''
for mat in me.getMaterials():
	#print"Mat:",me.name
	#print dir(me)
	#print dir(mat)
	#print "MATERIAL INDEX:",mat.refracIndex
	matindex = -1
	for tex in mat.getTextures():
		if tex is not None:
			print "TEX"
			#print dir(tex)
			print "Col:",tex.tex.name
			matindex = matindex + 1
			print matindex	
'''	
	
'''
for mat in me.materials:
	print mat.name
	print dir(mat)
	print dir(mat)
	#for tex in mat.textures:
	#	print "TEXTURES"
Material = Blender.Material.get()
print len(material)
'''
'''
for v in me.verts:
	nv = Blender.NMesh.Vert(v.co[0], v.co[1], v.co[2])
	nme.verts.append(nv)

# creates new all-triangle mesh
# ignores single vertices and edges
for f in me.faces:

	# number of vertices used for this face
	numv = len(f.v)

	# if triangle, copy as is, else, if quad, create two triangles
	if numv==3:

		nf = Blender.NMesh.Face()
		nf.v.append(nme.verts[f.v[0].index])
		nf.v.append(nme.verts[f.v[1].index])
		nf.v.append(nme.verts[f.v[2].index])
		nme.faces.append(nf)

	elif numv==4:

		nf = Blender.NMesh.Face()
		nf.v.append(nme.verts[f.v[0].index])
		nf.v.append(nme.verts[f.v[1].index])
		nf.v.append(nme.verts[f.v[2].index])
		nme.faces.append(nf)

		nf = Blender.NMesh.Face()
		nf.v.append(nme.verts[f.v[2].index])
		nf.v.append(nme.verts[f.v[3].index])
		nf.v.append(nme.verts[f.v[0].index])
		nme.faces.append(nf)
'''
#Blender.NMesh.PutRaw(me, "TRIMESH")
#Blender.Window.RedrawAll()