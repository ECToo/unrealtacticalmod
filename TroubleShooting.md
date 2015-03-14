# Trouble Shooting #
> Blender Export to Unreal is bit hard if the model is not working probity. If you new at blender modeling will take some time to get it right. The size effect the model a bit if the object is too small. Ratio is the same to unreal for the units. For example creating a box size 32x32x32 it will be the same in unreal once it import to unreal.

## Basic Error ##

  * If the units are too small it will not work for unreal while it import from blender.
  * If the object meshes is not work correctly it is do to the size in blender. Just resize them to be bigger to make unreal detect and it will auto adjust.

  * Q: **I don't know the object mesh size.**
  * A: While in object mode press N key to display Transform Properties.

  * Q: **I create my collision and it not showing up in unreal how to fix it?**
  * A: Your object is too small to able to detect your collision. Scale your object a bit bigger.

  * Q: **How I am getting an error in Physics Asset?**
  * A: Your object is too small to detect your object. Scale your object a bit bigger.

  * Q: **How come I have an bone!=index error?**
  * A: The vehicle class has to be name correctly for the main bone to work. If it fail again add another bone that branch off the main bone for the class vehicle your modding off from.

Here another error I found.
```
	Begin Object class=UTVehicleScorpionWheel Name=LFWheel
		BoneName="Lt_Front_Tire" //Your skeleton mesh bone name
		BoneOffset=(X=0.0,Y=-30.0,Z=0.0)
		SteerFactor=1.0
		LongSlipFactor=2.0
		LatSlipFactor=3.0
		HandbrakeLongSlipFactor=0.8
		HandbrakeLatSlipFactor=0.8
		SkelControlName="F_L_Tire_Ctrl" //Your Animtree controls
        WheelRadius=30
	End Object
//if you miss the name of the bone it will crash if you have other bone name
```

  * Q: **How come my custom vehicle crashes?**
  * A: One is vehicle main bone name mismatch. Check your UTVehicleSim

&lt;name&gt;

 class. There usually the default names for unreal. Two Check your wheels UT

&lt;name&gt;

Wheel class. Three Check your AnimTree that matches your wheel class. Third if you makes changes to your code that you need to rebuild the map else it will crash some time. You can change it.

  * Q: **Does size matter for the objects?**
  * A: Yes, it does matter for the size. It either you are dealing with the collision or physics to make the object usable in the game. For example, if you create a 2 units for the vehicle it will not work. If you try to use the unreal script to size the object to make it sure it fits. Unreal will calculate what has import to it current mass and object.

  * Q:**How come I got one extra material in .ASE file?**
  * A:If you have the prefix name of UCX_... is because it was not assign an material. By default it will create a null material for that collision box._

  * Q:**What my limit on bone name?**
  * A: The limit is 30 character for the naming the name bones when exporting skeleton and animation bones. No spacing are allow in unreal. Example "------------------------------".

  * Q:**How come when I start up my unreal editor it restart on me?**
  * A:Update your graphic driver.

  * Q:**How come my bone are not showing up in the vertex group?**
  * A:If you added in the bone after you parenting the bone to the mesh. You need to parent them again or update the bone.

  * Q:**How come my physics asset keep on flashing in the skeleton mesh physics?**
  * A:The cause of the error if you have one bone in the skeleton mesh it will keep on flashing. It need two or more bone to work or just update the mesh to detect new skeleton mesh.

  * Q:**How come I can only see part of the mesh that is really big?**
  * A: Go to the view properties change the clip end to greater number. That would be your 3D View port.

  * Q:**How come I am getting error with the face?**
  * A: This getting really annoying if you don't connect them correct that it should connect 3-4 vertex to make a polygon to make a face.

  * Q:**How come my vehicle physic are not working?**
  * A: The main Bone should have skin first and has greater value. To have it own collision to support it.

  * Q:**How come my vehicle die or kill on me?**
  * A: One or two of the reasons that does that. Fixed your mesh to have correct collision. And the other one is rig your weapon. Just create a dummy weapon socket. This deal with air vehicle death when reach out world death.