class MechaPawn extends GamePawn;

defaultproperties
{
	Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
                   SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_body'
                   PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_body_Physics'
	End Object
	Mesh=WPawnSkeletalMeshComponent
	Components.Add(WPawnSkeletalMeshComponent)
}