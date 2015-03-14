# Unreal Script Coding #
We Will be dealing with 1P and 3P view and the AnimSet. To see if the weapon is working correctly. This way you can test out if your weapon work in the game from blender export.


# Unreal Script: #

Gun = ShockRilfe

UTAmmo\_Gun.uc
```
	TargetWeapon=class'UTWeap_Gun'
```

UTAttachment\_Gun.uc
```
	Begin Object Name=SkeletalMeshComponent0
	                                        //3rd Person
		SkeletalMesh=SkeletalMesh'customweapon.Mesh.demo_weapon_3P'
		Scale=3.0 //weapon Draw scale
	End Object
```

UTWeap\_Gun.uc
```
	ItemName="Gun" //added
	PickupMessage="Pick up Gun" //added
	// Weapon SkeletalMesh
	Begin Object Name=FirstPersonMesh
                                         //1 Person
		SkeletalMesh=SkeletalMesh'customweapon.Mesh.demo_weapon_1P'
		//AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
		AnimSets(0)=AnimSet'customweapon.Anims.demo_weapon_1P_animset' //Need to work on the animation later.
		Animations=MeshSequenceA
		Rotation=(Yaw=-16384)  //Weapon Rotation Direction
		FOV=60.0
		Scale=3.0 //weapon Draw scale
	End Object

	AttachmentClass=class'mymod.UTAttachment_Gun'

	Begin Object Name=PickupMesh // When player die when drop weapon or picking up an weapon
		SkeletalMesh=SkeletalMesh'customweapon.Mesh.demo_weapon_3P'
		Scale=3.0  //weapon Draw scale
	End Object
```

Once you done setting up the and compile and should have no errors.

# SVN: #

http://code.google.com/p/unrealtacticalmod/source/browse/trunk/Src/mymod/classes/UTWeap_Gun.uc

http://code.google.com/p/unrealtacticalmod/source/browse/trunk/Src/mymod/classes/UTAttachment_Gun.uc

http://code.google.com/p/unrealtacticalmod/source/browse/trunk/Src/mymod/classes/UTAmmo_Gun.uc


givewewapon packageclass.UTWeap\_Gun