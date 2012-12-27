class MainMenuTest extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;

function Init( optional LocalPlayer LocPlay )
{
    Super.Init( LocPlay );
    Advance(0.f);
    RootMC = GetVariableObject("root");
    //HudMovie.Advance(0.f);
    
}

function WidgetInit(string WidgetName, string WidgetPath, GFxObject Widget)
{    
    local array<ASValue> args;
    switch(WidgetName)
    {                 
        case ("myAS3Button"):
            MyAS3Button = Widget;
            SetWidgetPathBinding(MyAS3Button, name(WidgetPath));
            `log("flash button press!");
            
             RootMC = GetVariableObject("root");
             ActionScriptVoid("SetText");
             ActionScriptVoid("root.SetText");
             ActionScriptVoid("_root.SetText");
             //ActionScriptVoid("root1.SetText");
             GetVariableObject("_root").Invoke("SetTextInput",args);
             GetVariableObject("root").Invoke("SetTextInput",args);
             Invoke("SetTextInput",Args);
            if(RootMC != none){
                //RootMC.SetVisible(true);
                //`log("found root!");
                //ActionScriptVoid("SetText");
                //ActionScriptVoid("root1.SetText");
                //GetVariableObject("_root").Invoke("SetTextInput",args);
                //GetVariableObject("root").Invoke("SetTextInput",args);
            }else{
                `log("error can't find root!");
            }
            break;
        case ("myAS3Button2"):
        
            args.Length = 2;

            args[0].Type=AS_String;
            args[0].s="Hello,AS3";
            args[1].Type=AS_Number;
            args[1].n=2012;
            GetVariableObject("root").Invoke("SetTextInput",args);
            `log("flash button press2!");
            break;
        default:
            break;
    }
}
    
/*
function WidgetBUtton(){
    
    local array<ASValue> args;
    `log("flash button press!5");
    //ActionScriptVoid("SetText");
    //ActionScriptVoid("root.SetText");
    //ActionScriptVoid("_root.SetText");
    args.Length = 2;

            args[0].Type=AS_String;
            args[0].s="Hello,AS3";
            args[1].Type=AS_Number;
            args[1].n=2012;
            GetVariableObject("_root").Invoke("SetText",args);
            GetVariableObject("root").Invoke("SetText",args);
            
            Invoke("SetText", args);
            ActionScriptSetFunction(RootMC, "SetText");
            ActionScriptString("SetText");
            
            if(RootMC == none){
                    `log("flash button press!5 error");
            }else{
                `log("flash button press!5 pass");
            }
            //ActionScriptVoid("_root.SetText");
            //ActionScriptVoid("root.SetText");
            ActionScriptVoid("_SetText");
   `log("flash button press!5....");
}
*/

function WidgetBUtton(){
    local array<ASValue> args;
local ASValue asval;

asval.Type = AS_String;
asval.s = "Matthew";
args[0] = asval;

asval.Type = AS_Number;
asval.n = 38;
args[1] = asval;

GetVariableObject("_root").Invoke("MyTestFunction", args);
GetVariableObject("root").Invoke("MyTestFunction", args);
`log("flash button press!9....");
}

defaultproperties
{
    WidgetBindings(0)={(WidgetName="myAS3Button",WidgetClass=class'GFxClikWidget')}
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'CustomHUD.UDKAS3UI'
}