# Information: #
> This build will be base off Actor class. I will keep it simple as I can. This part animation is control by the SetTimer function.

> When we are making a stand alone class. The animation link is not connect to your Skeletal Mesh. Because it new build from your own class from Actor. It does work when using the UTVehicle class. That they are link to their animation. Here an example of it unlink animation to Skeletal Mesh.

SkeletonFrame\_Animation.uc
```
class SkeletonFrame_Animation extends Actor
      placeable;

var SkeletalMeshComponent mesh;

simulated function PostBeginPlay()
{
      Super.PostBeginPlay();
      SetTimer(2, true, 'PlayAnimation'); //play every 2 sec then execute function
}

function PlayAnimation(){
     Mesh.PlayAnim('Fire', 1, false, false);//play animation name, play frame speed,play loop,if loop in play do not restart it, keep current play
}

defaultproperties
{
Begin Object class=SkeletalMeshComponent Name=MeshFrame
      SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
      AnimSets.Add(AnimSet'VHUTM_MechProtypeWalker.mecharm_minigun_animset')
      AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mecharm_minigun_animtree'
End Object

CollisionComponent=MeshFrame
mesh=MeshFrame
Components.Add(MeshFrame)
}
```
The Result will give Animation Node None error or animation can't be played.

To link the Animation to the Skeletal Mesh. We need to setup the AnimTree. It quite simple to do. That we just need to name the node to make our animation working. Then we code it into our script to look for our animation node to set it.

![http://unrealtacticalmod.googlecode.com/svn/trunk/image/SkeletalMesh_AnimaitonA_01.jpg](http://unrealtacticalmod.googlecode.com/svn/trunk/image/SkeletalMesh_AnimaitonA_01.jpg)
```
AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
```

Once it is setup for the node to link each other. Skeletal Mesh will able play the animation.

SkeletonFrame\_Animation.uc
```
class SkeletonFrame_Animation extends Actor
      placeable;

var SkeletalMeshComponent mesh;

/** Helper to allow quick access to playing deploy animations */
var AnimNodeSequence	AnimPlay;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	SetTimer(2, true, 'PlayAnimation'); //play every 2 sec then execute function
}

function PlayAnimation(){
     Mesh.PlayAnim('Fire', 1, false, false);//play animation name, play frame speed,play loop,if loop in play do not restart it, keep current play
}

defaultproperties
{
      Begin Object class=SkeletalMeshComponent Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		AnimSets.Add(AnimSet'VHUTM_MechProtypeWalker.mecharm_minigun_animset')
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mecharm_minigun_animtree'
	End Object

 CollisionComponent=MeshFrame
 mesh=MeshFrame
 Components.Add(MeshFrame)
}
```