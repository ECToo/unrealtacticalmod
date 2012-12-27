/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class UDKAS3UI_Calls extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;

function Init( optional LocalPlayer LocPlay )
{
    Super.Init( LocPlay );
    Advance(0.f);
    RootMC = GetVariableObject("root");
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
    
function AS_ButtonLook(){//works
    local string myString;
    //myBoolean = RootMC.GetBool("MyBoolean");
    RootMC = GetVariableObject("root");//works
    myString = RootMC.GetString("mystr");
    //myNumber = RootMC.GetFloat("MyNumber");
    
    `log("ActionScript var..."@myString);
}

function ASV_BUtton(){//does not work
    ActionScriptVoid("ASVSetText");
}

function ASV_BUtton2(){//works
    ActionScriptVoid("root.ASVSetText");
}

function ASSF_BUtton(){//does not work
    RootMC = GetVariableObject("root");
    ActionScriptSetFunction(RootMC,"ASSFSetText");
    `log("ActionScriptSetFunction...");
}

function ASSF_BUtton2(){//does not work
    //SF("test",10);//does not work
    SF2("test",10);
}

function SF(string _name,int _id){//does not work
    RootMC = GetVariableObject("root");
    ActionScriptSetFunction(RootMC,"root.ASSFSetText");
    `log("ActionScriptSetFunction arge1...");
}

function SF2(string _name,int _id){//does not work
    RootMC = GetVariableObject("root");
    ActionScriptSetFunction(RootMC,"ASSFSetText");
    `log("ActionScriptSetFunction arge2...");
}



function I_BUtton(){//does not work
    local array<ASValue> args;
    local ASValue asval;

    asval.Type = AS_String;
    asval.s = "actionscript3";
    args[0] = asval;
    
    asval.Type = AS_Number;
    asval.n = 38;
    args[1] = asval;

    Invoke("ISetText",args);
    `log("Invoke args...");
}

function I_BUtton2(){//works
    local array<ASValue> args;
    local ASValue asval;

    asval.Type = AS_String;
    asval.s = "actionscript3";
    args[0] = asval;
    
    asval.Type = AS_Number;
    asval.n = 38;
    args[1] = asval;

    GetVariableObject("root").Invoke("MyTestFunction", args);
    `log("Invoke args...");
}

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'CustomHUD.UDKAS3UI'
}