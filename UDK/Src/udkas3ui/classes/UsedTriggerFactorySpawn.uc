/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */


Class UsedTriggerFactorySpawn extends Trigger;

//var UISceneBuildVehicle SceneBuildVehicle;
var FactorySpawn BuildingData;
var GFxUDKFactorySpawn HudMovie;
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
    `log('trigger used');
    if(HudMovie !=none)
    {
        HudMovie.SetFactory(BuildingData);
        HudMovie.Start();
    }else{
        `log("error can't find gfx UI");
    }

    return False;
}

function SetGfxUI(GFxUDKFactorySpawn D){
  HudMovie = D;
}

function SetBuildingData(FactorySpawn D){
  BuildingData = D;
}

defaultproperties
{
    //Actor
    bHidden=False
    bStatic=false
    bNoDelete=False

    //SceneBuildVehicle=UISceneBuildVehicle'BuildingSpawnVehicle.SceneBuildVehicle'
	Begin Object Name=Sprite
        //Sprite=Texture2D'UTMEditor.maptool'
		Sprite=Texture2D'CustomHUD.icon_interface_panel'
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