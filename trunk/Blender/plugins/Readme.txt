README Opti_PSK_Dump
There should be one mesh and one armature object else will cause an error.
You need to convert to triangles (Ctrl + t) when your done.

Opti_PSK_Dump.py
-This work all the wired frame work but the vehicle base does not work.
-This has not built a weight yet in main root bone.
-animation not fixed for the new version for 2.45
-Extra bone add to the main root.

Opti_PSK_Dump_UT3.py
- This will work on UT3 and it is a stable version that work with vehicle for testing. 
- Main Bone fix no dummy needed to be there. Some part of the area may not work when main bone did not detect.
- Fix the bone offset position as head bone that connect to it.
- There are two points which is the head and tail.
- Note I add on to the notes a bit and comments out the other ones that are not need in here.
- Did not work with psk export yet.
- Edit by: Darknet

Trouble shooting:
point count : must equal to inlfuence count else it will crash.
inlfuence count : must equal  to point count else it will crash.

I see my object flashing how I fix this?
Update your animtree,animset,etc if you reimport your mesh again to fix some error. Check your log.

http://www.p-fat.net/

Blender Python Scripts for PSK/PSA export
These are a couple of hacked together scripts that Bob (active_trash) and I worked on to allow Blender to export the files that Unreal Tournament 2004 requires for Skeletal Meshes (PSK) and Animations (PSA). These are pretty hacked together betas, not cleaned up at all, and use at your own risk. They work for the couple of meshes, skeletons, and animations I've tested with so far, but they haven't been that heavy or complex.

Caveats:

    * You MUST convert all quads to triangles before running these scripts. The scripts require 3 vertexes per face ONLY.
    * You must not SCALE your armature. Scaling the armature after it has been linked to your mesh with parenting will also scale the mesh, but we did not account for this in the script.
    * Multiple Materials aren't supported yet (but should be easy to add when I get around to it)
    * There may be some other stuff we forgot to account for, dont complain if it doesn't work!
    * Modify and add features to this script as you will, if you can make it better, or add features we've left out, by all means do so, just please, email me a copy!
