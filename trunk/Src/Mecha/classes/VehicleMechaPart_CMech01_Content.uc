/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class VehicleMechaPart_CMech01_Content extends VehicleMechaPart;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

simulated event Destroyed()
{
	Super.Destroyed();
}

defaultproperties
{

         //VehiclePositionString="in an Mech Walker"
         //VehicleNameString="Mech Walker"
         
         Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=0.0,Y=0.0,Z=50.0)
	End Object


         //MechPart=class'MechaPart_Leg'
         //head
         MechPart_Head=class'MechaPart_Head'
         //leg
         //MechPart_Leg=class'MechaPart_Leg'
         MechPart_Leg=class'MechaPart_Leg01'

         //right arm
         MechPart_RightArm=class'MechaPart_RightArm02'

         //right hand
         MechPart_RightHand=class'MechaPart_RWeap_LightningGun'

         //left arm
         MechPart_LeftArm=class'MechaPart_LeftArm02'

         //left hand
         MechPart_LeftHand=class'MechaPart_LWeap_Minigun4'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Mecha.MechaWalkerB01_Body'
		//AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype02_animtree'
		PhysicsAsset=PhysicsAsset'VH_Mecha.MechaWalkerB01_Body_Physics'
	End Object

//	FlagBone=Head
}
