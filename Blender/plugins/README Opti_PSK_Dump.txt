LINK:http://www.p-fat.net/

Blender Python Scripts for PSK/PSA export
These are a couple of hacked together scripts that Bob (active_trash) and I worked on to allow Blender to export the files that Unreal Tournament 2004 requires for Skeletal Meshes (PSK) and Animations (PSA). These are pretty hacked together betas, not cleaned up at all, and use at your own risk. They work for the couple of meshes, skeletons, and animations I've tested with so far, but they haven't been that heavy or complex.

Caveats:

    * You MUST convert all quads to triangles before running these scripts. The scripts require 3 vertexes per face ONLY.
    * You must not SCALE your armature. Scaling the armature after it has been linked to your mesh with parenting will also scale the mesh, but we did not account for this in the script.
    * Multiple Materials aren't supported yet (but should be easy to add when I get around to it)
    * There may be some other stuff we forgot to account for, dont complain if it doesn't work!
    * Modify and add features to this script as you will, if you can make it better, or add features we've left out, by all means do so, just please, email me a copy!
