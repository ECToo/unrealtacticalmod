# Information: #

> This section deal with more control with your animations. You can control speed of the animation or where to start your animation. But the default animation speed is 1.0 float rate. Note you need to config your own speed since there different on how fast your animation set is. The AnimNodeSequence node needed to be setup the link to the packages  and unreal script to able play the animations. Some part was explain in [SkeletalMesh\_AnimaitonB](SkeletalMesh_AnimaitonB.md).



> When creating the AnimTree for your animation set up to work. You need to add AnimNodeSequence into your kismet area and link the node to the Animation.

![http://unrealtacticalmod.googlecode.com/svn/trunk/image/SkeletalMesh_AnimaitonA_01.jpg](http://unrealtacticalmod.googlecode.com/svn/trunk/image/SkeletalMesh_AnimaitonA_01.jpg)

Then we name the AnimNode to match your code in unreal script.

```
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlayControl = AnimNodeSequence(Mesh.Animations.FindAnimNode('AnimPlayer'));//AnimTree
}
```
Once part of the set up is finish you can use the AnimNodeSequence to run your animation instead of Skeletal Mesh class. This will initial the animation set with the skeleton mesh.

Here code line example of how to play your animation. Example:
```
AnimPlayControl.SetAnim('fire');//name of your animatino
AnimPlayControl.PlayAnim(false,0.01,0);//loop play, animation speed, start animation frame
```
It will trigger the animation once play. If you loop it in tick it will start at frame 0. Making look still or starting from begin few second.

To make sure it not loop while playing the animation again from tick function or other events that may happen.

```
...
simulated event Tick( float DeltaTime )
...
if(AnimPlayControl.bPlaying == false){//if animation not playing, play the animation
   AnimPlayControl.SetAnim(AnimSetName);
   AnimPlayControl.PlayAnim(false,0.01,0);//loop play, animation speed, start animation frame
}
...
```
This is with in the tick function. Making sure it finish the animation that is currently in play then loop when it finish the last of the animation.

Here the full code.

SkeletonFrame-AnimationB.uc
```
class SkeletonFrame_AnimationB extends Actor
	placeable;

var SkeletalMeshComponent mesh;
var bool bplayed;
var Name AnimSetName;

/** Helper to allow quick access to playing deploy animations */
var AnimNodeSequence	AnimPlayControl;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlayControl = AnimNodeSequence(Mesh.Animations.FindAnimNode('AnimPlayer'));//AnimTree
}

simulated event Tick( float DeltaTime )
{
    super.Tick(DeltaTime);

    if(AnimPlayControl != none){
		//`log("ANIM RATE " $ AnimPlayControl.Rate);
		//`log("ANIM GetAnimPlaybackLength " $ AnimPlayControl.GetAnimPlaybackLength());
		if(AnimPlayControl.bPlaying == false){
			AnimPlayControl.SetAnim(AnimSetName);
			AnimPlayControl.PlayAnim(false,0.01,0);//loop play, animation speed, start animation frame
		}
		`log("time left " $ AnimPlayControl.GetTimeLeft());
    }
}

defaultproperties
{
	AnimSetName=fire
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

Tips: The image shown there those were added just one kismet and AnimNode name to find in unreal script.

Note: This from my work and testing out the animation nodes. There are many other example out in the site that give a simple example.