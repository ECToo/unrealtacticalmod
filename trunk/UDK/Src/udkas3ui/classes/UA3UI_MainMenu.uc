/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class UA3UI_MainMenu extends GFxMoviePlayer//;
    config(UDKAS3UI);

var GFxObject MyAS3Button;
var GFxObject RootMC;


/** Structure which defines a unique menu view to be loaded. */
struct ViewInfo
{
    /** Unique string. */
    var name ViewName;

    /** SWF content to be loaded. */
    var string SWFName;

    /** Dependant views that should be loaded if this view is displayed. */
    var array<name> DependantViews;
};


/** Array of all menu views to be loaded, defined in DefaultUI.ini. */
var config array<ViewInfo>          ViewData;



function Init( optional LocalPlayer LocPlay )
{
    Super.Init( LocPlay );
    Advance(0.1f);
    RootMC = GetVariableObject("root");
    Advance(0.1f);
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
    
function BtnSinglePlayer(){
    `log("BtnSinglePlayer found...");
}

function BtnMultiplePlayers(){
    `log("BtnMultiplePlayers found...");
}


function BtnOptions(){
    `log("BtnOptions found...");
}

function BtnCredits(){
    `log("BtnCredits found...");
}

function BtnExit(){
    `log("BtnExit found...");
}

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'udkas3hui.UDKAS3_MainMenuUI'
}