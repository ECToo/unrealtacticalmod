/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */


Class UsedTriggerHttpTest extends Trigger;

var GfxUIHttp HudMovie;
//this goes in below our class declaration
var TcpLinkClient mytcplink;


simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    
    HudMovie = new class'udkas3ui.GfxUIHttp';
    HudMovie.init();
	
	mytcplink = Spawn(class'TcpLinkClient'); //spawn the class
	HudMovie.mytcplink = mytcplink;
}

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
        HudMovie.Start();
    }else{
        `log("error can't find gfx UI");
    }

    return False;
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