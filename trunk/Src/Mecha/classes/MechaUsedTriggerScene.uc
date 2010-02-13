Class MechaUsedTriggerScene extends Trigger;

var UISceneMechaPart SceneBuildVehicle;
var() VehicleMechaPart VehicleBuildingData;
var Name BuildingNodeName;
var() bool bDisableUsed; //this will deal with disable used key

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
           //`log("BUILDING INDEX" @ BuildingData.Name);
           if (VehicleBuildingData != None){
              //SceneBuildVehicle.setvehiclebuild(VehicleBuildingData); //note this will crash when used
              SceneBuildVehicle.setvehicleid(VehicleBuildingData.Name); //vehicle id
	      CPlayer.OpenUIScene(SceneBuildVehicle);
	      `log("open");
	   }
	}

	return False;
}

defaultproperties
{
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False
	
        bDisableUsed=true

        SceneBuildVehicle=UISceneMechaPart'VH_Mecha.UISceneMechaPartMenu'

        /*
        Begin Object Name=Sprite
		Sprite=Texture2D'UTMEditor.buildtool'
		HiddenGame=False
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
	End Object
	*/

        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}