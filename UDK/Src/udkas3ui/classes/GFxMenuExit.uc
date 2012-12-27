/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 * This is just a test build for testing how to deal with interacting the something...
 * 
 */

class GFxMenuExit extends GFxMoviePlayer;

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
    ConsoleCommand("exit");//UDK Command
}

//close UI
function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI   
	if(MainMenu !=none){
		MainMenu.Start();
	}	
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
    MovieInfo=SwfMovie'udkas3hui.UDKUIMenuExit'
}

