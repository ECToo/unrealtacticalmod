Class UTMTriggerBuildVehicle extends Trigger;

var UTM_UISceneBuildVehicle SceneBuildVehicle;
var UTMBuilding_BaseSpawnVehicle BuildingData;
var bool bDisableUsed;

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
	if(bDisableUsed){
	   CPlayer.OpenUIScene(SceneBuildVehicle);
	}
	return False;
}

function SetBuildingData(UTMBuilding_BaseSpawnVehicle D){
  BuildingData = D;
  SceneBuildVehicle.SetBuildingData(D);
}

defaultproperties
{       
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False
	
	//custom code
	//bDisableUsed=false

	//UIScene
        //SceneBuildVehicle=UIScene'UTMBuildingFactory.UTMBuildVehicle' //will not work code will change a bit.
        SceneBuildVehicle=UTM_UISceneBuildVehicle'UTMBuildingFactory.UTMBuildVehicle'

        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}