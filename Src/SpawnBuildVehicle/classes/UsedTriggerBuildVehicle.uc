Class UsedTriggerBuildVehicle extends Trigger;

var UISceneBuildVehicle SceneBuildVehicle;
var BaseSpawnVehicle BuildingData;
var Name BaseSpawnVehicleTagName;

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
	SceneBuildVehicle.setbuildingnametag(BuildingData.Name);//set id when loop match check
	CPlayer.OpenUIScene(SceneBuildVehicle);
	return False;
}


function SetBuildingData(BaseSpawnVehicle D){
  BuildingData = D;
}

defaultproperties
{
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False

	//UIScene
        SceneBuildVehicle=UISceneBuildVehicle'BuildingSpawnVehicle.SceneBuildVehicle'

        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}