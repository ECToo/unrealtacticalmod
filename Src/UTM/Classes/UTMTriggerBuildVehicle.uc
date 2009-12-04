Class UTMTriggerBuildVehicle extends Trigger;

var UIScene HUDBuildVehicle;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
        super.Touch(Other,OtherComp,HitLocation,HitNormal);
	if (FindEventsOfClass(class'SeqEvent_Touch'))
	{
	   `log('trigger Touch');
	}
}

function bool UsedBy(Pawn User)
{
        local UTPlayerController CPlayer;
	`log('trigger used');
	CPlayer = UTPlayerController(User.Controller);
	CPlayer.OpenUIScene(HUDBuildVehicle);
	return False;
}

defaultproperties
{
        bHidden=False
        bStatic=false
	bNoDelete=False
        HUDBuildVehicle=UIScene'UTMBuildingFactory.UTMBuildVehicle'
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}