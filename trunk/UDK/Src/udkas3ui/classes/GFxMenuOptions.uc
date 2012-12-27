/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 * This is just a test build for testing how to deal with interacting the something...
 * 
 */

class GFxMenuOptions extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;
var GFxMainMenuSandBox MainMenu;

function Init( optional LocalPlayer LocPlay )
{
    `log("init menu ui");
    //Start();
    Advance(0.0f);
    
    RootMC = GetVariableObject("root");
    
    Super.Init( LocPlay );
}

function BtnClose(){
    `log("close");
     ClosePlayer();
}
 
/*
function BtnClose(GFxObject EventObject, int PlayerIndex){
    `log("close function...");
     ClosePlayer();
}
*/

function BtnBack(GFxObject EventObject, int PlayerIndex){
    `log("back function...");
     ClosePlayer();
}

//close UI
function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI
	if(MainMenu !=none){
		MainMenu.Start();
	}
}

//call to AddMenuList function
function AddMenuList(string _mn,string _id,string _info){//works
    local array<ASValue> args;
    local ASValue asval;

    asval.Type = AS_String;
    asval.s = _mn;
    args[0] = asval;
    
    asval.Type = AS_String;
    asval.s = _id;
    args[1] = asval;
    
    asval.Type = AS_String;
    asval.s = _info;
    args[2] = asval;

    GetVariableObject("root").Invoke("AddMenuList", args);
    `log("Invoke args...");
}

function ClearMenuList(){
    ActionScriptVoid("root.ClearMenuList");
}

function WidgetInit(string WidgetName, string WidgetPath, GFxObject Widget)//works
{    
    switch(WidgetName)
    {                 
        case ("myAS3Button"):
            MyAS3Button = Widget;
            SetWidgetPathBinding(MyAS3Button, name(WidgetPath));
            `log("found...");
            break;
        case ("myAS3Button2"):
            break;
        default:
            break;
    }
}

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    TimingMode=TM_Real
	bDisplayWithHudOff=TRUE
    MovieInfo=SwfMovie'udkas3hui.UDKSettingsUI'
}

