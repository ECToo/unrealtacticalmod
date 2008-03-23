import Blender

ob = Blender.Object.Get(meshname)
me = ob.data
nme = Blender.NMesh.GetRaw()

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

Blender.NMesh.PutRaw(nme, "TRIMESH")
Blender.Window.RedrawAll()