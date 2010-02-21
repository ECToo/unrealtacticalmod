/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class AirVehicleMechaPart_BMech04_Content extends AirVehicleMechaPart;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

defaultproperties
{

         //head
         BodyAttachHeadSocketName=MechHeadSocket
         MechPart_Head=class'MechaPart_Head'
         //leg
         BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_Leg01'
         
         //right arm
         BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechaPart_RightArm03'

         //right hand
         BodyAttachRightHandSocketName=RightHandSocket
         MechPart_RightHand=class'MechaPart_RightWeapon'

         //left arm
         BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechaPart_LeftArm03'

         //left hand
         BodyAttachLeftHandSocketName=LeftHandSocket
         MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechdrone_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechdrone_body_Physics'
	End Object

        /*
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_body03'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_body03_Physics'
	End Object
	*/

        /*
        Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Mecha.aircube'
		//AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VH_Mecha.aircube_Physics'
	End Object
	*/

        /*
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Cicada.Mesh.SK_VH_Cicada'
		AnimTreeTemplate=AnimTree'VH_Cicada.Anims.AT_VH_Cicada'
		PhysicsAsset=PhysicsAsset'VH_Cicada.Mesh.SK_VH_Cicada_Physics'
		AnimSets.Add(AnimSet'VH_Cicada.Anims.VH_Cicada_Anims')
	End Object
	*/

//	FlagBone=Head
}
