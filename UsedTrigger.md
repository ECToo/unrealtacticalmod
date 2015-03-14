# Simple Version #

Class UsedTriggerLog extends Trigger;

```
function bool UsedBy(Pawn User)
{
	//Stuff here.
	`log('trigger used');
	return False;
}

defaultproperties
{
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