# Introduction #
> The basic of building your character or pawn in the game. It depend on how you want to use it. To use the default or create a custom build pawn. For purpose for creating from the ground up. I creating from scrap.

DeathMatchOnlyMechaGame.uc
```
class DeathMatchOnlyMechaGame extends UTDeathmatch;

function PreBeginPlay()
{
	Super.PreBeginPlay();
}

defaultproperties
{
	DefaultPawnClass=class'MechaPawn'
}
```

MechaPawn.uc
```
class MechaPawn extends GamePawn;

defaultproperties
{
	Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
                   SkeletalMesh=SkeletalMesh''
                   PhysicsAsset=PhysicsAsset''
	End Object
	Mesh=WPawnSkeletalMeshComponent
	Components.Add(WPawnSkeletalMeshComponent)
}
```
You need a skeleton mesh and physics. By default for this. It goes in third person. You will notice that there no HUD when you load up the game. Just the cross HUD. Since we do not use UTPawn extend from it.