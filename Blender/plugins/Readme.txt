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
point count : must equal  to inlfuence count else it will crash.
inlfuence count : must equal  to point count else it will crash.

I see my object flashing how I fix this?
Update your animtree,animset,etc if you reimport your mesh again to fix some error. Check your log.