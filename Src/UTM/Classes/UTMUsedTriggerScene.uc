/**
Texture2D'UTMEditor.buildtool'
Texture2D'UTMEditor.maptool'
Texture2D'UTMEditor.pawntool'



*/


Class UTMUsedTriggerScene extends Trigger;

var UTM_UISceneBuildVehicle SceneBuildVehicle;
var UTMBuildingNode BuildingData;
var Name BuildingNodeName;
var bool bDisableUsed; //this will deal with disable used key

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
        super.Touch(Other,OtherComp,HitLocation,HitNormal);
	if (FindEventsOfClass(class'SeqEvent_Touch'))
	{
	   `log('trigger Touch');
	}
}

function SetDisableUsed(bool stated){
   bDisableUsed = stated;
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

function SetBuildingData(UTMBuildingNode D){
  BuildingData = D;
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

        Begin Object Name=Sprite
		Sprite=Texture2D'UTMEditor.buildtool'
		HiddenGame=False
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
	End Object

        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}