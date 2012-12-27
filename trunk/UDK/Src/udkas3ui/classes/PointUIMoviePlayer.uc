/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class PointUIMoviePlayer extends GFxMoviePlayer;


var GFxObject MyAS3Button;
var GFxObject RootMC;

function Init( optional LocalPlayer LocPlay )
{
    Start();
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

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'udkas3hui.UDKIndicatorUI'
}

