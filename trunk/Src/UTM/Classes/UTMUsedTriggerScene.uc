Class UTMUsedTriggerScene extends Trigger;

var UTM_UISceneBuildVehicle SceneBuildVehicle;
var UTMBuildingNode_BaseSpawnVehicle BuildingData;
var Name BuildingNodeName;
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
           //SetBuildingData(BuildingData);//we need to set the current building spawn scene it one scene so we set the building data in the scene.
           `log("BUILDING INDEX" @ BuildingData.Name);
           //SceneBuildVehicle.SetBuildingData(BuildingData);
           SceneBuildVehicle.setbuildingnodename(BuildingData.Name);
	   CPlayer.OpenUIScene(SceneBuildVehicle);
	}

	return False;
}

function SetBuildingData(UTMBuildingNode_BaseSpawnVehicle D){
  BuildingData = D;
  //SceneBuildVehicle.SetBuildingData(D);
}

defaultproperties
{       
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False

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