/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class GfxUIHttp extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;
var TcpLinkClient mytcplink;

function Init( optional LocalPlayer LocPlay )
{
    //Start();
    Advance(0.0f);
    RootMC = GetVariableObject("root");
    Super.Init( LocPlay );
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

function BtnSumbit(){
	local String textarea;
    if(RootMC !=none){
		textarea = RootMC.GetString("outtext");
	}else{
		RootMC = GetVariableObject("root");
		textarea = RootMC.GetString("outtext");
	}
	`log(textarea);
}

function BtnClose(){
    ClosePlayer();
}

 

function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI   
}

 function StartPlayer(){
     Start();
}
  
 function HealthSet(float _health){
     
 }
    

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'udkas3hui.UDKAS3UIHttp'
}