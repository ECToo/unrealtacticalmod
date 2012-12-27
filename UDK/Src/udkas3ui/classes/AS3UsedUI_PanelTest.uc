/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 * This is just a test build for testing how to deal with interacting the something...
 *
 * This trigger button will display icon that need to be rework later.
 */

class AS3UsedUI_PanelTest extends Trigger;

var GFxUDKPanelTest PanelTestMovie;
var   class<GFxUDKPanelTest> HUDType;
var Name BuildingNodeName;
var bool bDisableUsed;

singular event Destroyed()
{
    if (PanelTestMovie != none)
    {
        PanelTestMovie.Close(true);//unload and never be used as it clear data
        PanelTestMovie = none;
    }
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    //PanelTestMovie = new class'udkas3ui.UDKAS3UI_HUDMoviePlayer';
    PanelTestMovie = new HUDType;
    //PC.ClientSetHUD(HudType); // UTPlayerController
    PanelTestMovie.init();
    //HudMovie.Start();//do not start if player is not pressing the used button
}

function bool UsedBy(Pawn User)
{
    //local UTPlayerController CPlayer;
    `log('trigger used');
    
    //CPlayer = UTPlayerController(User.Controller);
    if(bDisableUsed){
        if (PanelTestMovie != none){
            PanelTestMovie.Start();
        }
        //`log("RANDOM" @ Rand(5));
    }
    return False;
}

defaultproperties
{
    HUDType=class'udkas3ui.GFxUDKPanelTest';

    bDisableUsed=true
    bStatic=false
    bNoDelete=False
    bHidden=false
    
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