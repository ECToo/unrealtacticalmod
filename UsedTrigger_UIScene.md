# Simple Version #
> The code is quite simple. This deal with a simple test. To use the Trigger Class to use 'Use' key to able to show the Scene (Menu).

```
Class UseTriggerScene extends Trigger;

var UIScene MyUseTriggerScene;//custom class

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
        super.Touch(Other,OtherComp,HitLocation,HitNormal);
	if (FindEventsOfClass(class'SeqEvent_Touch'))
	{
	   `log('trigger Touch');
	}
}

function bool UsedBy(Pawn User)
{//note this will pause the game and use escape key to exit the Scene
        local UTPlayerController CPlayer;
	CPlayer = UTPlayerController(User.Controller);
	CPlayer.OpenUIScene(HUDBuildVehicle);
        `log('trigger used');
	return False;
}

defaultproperties
{
        bAlwaysTick=True
        MyUseTriggerScene=UIScene'package.scenename'//package
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}
```

# Credits: #
  * http://utforums.epicgames.com/forumdisplay.php?f=20