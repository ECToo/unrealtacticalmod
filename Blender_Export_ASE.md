# Information: #
When your exporting to unreal. Make sure you Duplicate your object that is simple collsion.  Make that object same as your current object with the prefix "UCX_" before the object name. Example default name object is "cube" for the first object and the second name is "UCX\_cube". If there is too much compelex build a simple collision else it will tell you that there is a problems. The collision have to be simple._

This from OutLiner Panel:

Scene
  * RenderLayer
  * World
  * Camera
  * Lamp
  * Cube
  * UCX\_Cube

Trouble shooting:
If you can't get your collision working try to scale your mesh to one to one unit. If you create a small that it seem it does not detect your collision very well when the object little.

If you can't the import your mesh when trying to import your mesh again close and reopen the unreal editor. It some time the file get corrupt. So delete your current mesh.ase file.

Trying to get more than one materials. Assign new material for your face. Under the material create one texture. Under that texture import your image so it will create diffuse image and the link of the file.

# Pros #
1:1 Ratio to blender to unreal scale. For Vehicle varery in "rawscale=1.3".

# Cons #

http://www.katsbits.com/htm/tools_utilities.htm#ase

http://www.neewo.de/ToolsDemos.html#3