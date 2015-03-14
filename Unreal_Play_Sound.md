# Support: #
  * UT3
  * UDK


# Information: #
> This is code is the simple part of how to play the sound in unreal script. But you need to have Instigator != None for it to work. To make it work you just need a pawn or vehicle to make the code work.


```
...
var SoundCue FireSound;
...
Instigator.PlaySound(FireSound, false, true);
...
defaultproperties
{
...
FireSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
...
}
```

The code function are found in different part of the class.
```
...
simulated function WeaponPlaySound( SoundCue Sound, optional float NoiseLoudness )
...
```

Here a simple version of the sound being play.

PawnPlaySound.uc
```
/*
  this only work with pawn or vehicle
*/

class PawnPlaySound extends Pawn
	placeable;

var SoundCue FireSound;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1, true, 'PlaySoundPackage');
}

function PlaySoundPackage(){
	if( FireSound == None || Instigator == None ){
		//do nothing...
	}else{
		Instigator.PlaySound(FireSound, false, true);
		`log("play sound...");
	}
	Instigator.PlaySound(FireSound, false, true);
}

defaultproperties
{
	FireSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'

}
```

This goes on building a pawn or vehicle class when building a custom players or vehicles.