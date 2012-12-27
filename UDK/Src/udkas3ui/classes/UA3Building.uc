/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class UA3Building extends Actor placeable;

var SkeletalMeshComponent Mesh;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	if(Mesh !=none){
		AttachComponent(Mesh);//attach to actor Component
	}
}

defaultproperties
{
    Begin Object class=SkeletalMeshComponent Name=MeshFrame
        SkeletalMesh=SkeletalMesh'CustomHUD.Test01'
    End Object
    Mesh=MeshFrame
	Components.Add(MeshFrame)
}