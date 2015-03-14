**Work In Progress**

# Information: #
> There are different method on build your unreal script to make your animation work in unreal. It will just required SkeletalMesh, AnimSets, AnimTree and one unreal script file. When creating the SkeletalMesh and AnimSets. You need to link the animation together with the mesh since it not connected by a AnimNode from AnimTree. AnimTree will link them up in unreal script code by reference them.

## Basic: ##
> This simple explain about how the animation work for class actor. The simple animation play function build into SkeletalMeshComponent class. Here one of the example code lines.

```
...
var AnimNodeSequence	AnimPlay;
var SkeletalMeshComponent Mesh;
...
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence(Mesh.Animations.FindAnimNode('AnimPlayer'));//AnimTree
}
...
Mesh.PlayAnim('Fire', 1, false, false);//play animation name, play frame speed,play loop,if loop in play do not restart it
...
```
> It has few functions to work with. But you can work with for basic class build for event stuff. Example rise the flag pole. AnimNodeSequence is to link the the animation and mesh together to make the animation able to play those actions. This will be explain in the next section of it.

## Advance: ##
> AnimNodeSequence and UTAnimNodeSequence have more control on the animations in unreal scripts. Those have more features to control your animations. But there are other classes that control animations. When you setup the AinmTree link AnimNodes that link to the unreal script file. It will run smoothly if the nodes matches the names of the AnimNodes. Making sure the animation speed is normal and knowing the animation is finish.
> The next part will deal with how animation are code and tested to run a simple animation play.

  * [SkeletalMesh\_AnimaitonA](SkeletalMesh_AnimaitonA.md) This has simple animation with few functions of SkeletalMeshComponent class.
  * [.md](.md)

# FAQS: #
> Q)  I create my own class base from Actor class and the animation not working. How Come?

> A)  You got to setup a link on your animtree and unreal script.

```
var AnimNodeSequence	AnimPlay;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );//AnimTree
}
```

# Tips: #
  * Be sure you name the AnimNodeSequence class correctly and not to over lap them. From your animtree package.