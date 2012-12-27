/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class GFxUDKFactorySpawn extends GFxMoviePlayer;

var GFxObject MyAS3Button;
var GFxObject RootMC;
var transient UDKFactoryDataStore_StringList MenuDataStore;
var string VehicleName;
var Name BaseSpawnVehicleTagName;
var FactorySpawn factoryspawn;

function Init( optional LocalPlayer LocPlay )
{
    `log("init menu ui");
    //Start();
    Advance(0.0f);
    
    RootMC = GetVariableObject("root");
    
    Super.Init( LocPlay );
}


function BtnSpawn(){
    //local UDKAS3Pawn P;
    //local WorldInfo WorldInfo;
    `log("spawn");
    if(RootMC !=none){
        VehicleName = RootMC.GetString("VechicleName");
        `log("spawn" @ VehicleName);    
    }else{
        RootMC = GetVariableObject("root");
        VehicleName = RootMC.GetString("VechicleName");
        `log("spawn" @ VehicleName);    
    }
    
    if(factoryspawn !=none){
        factoryspawn.SetVehicleName(VehicleName);
        factoryspawn.spawnvehicle();
    }else{
        `log("Error not found factory.");
    }
    
    /*
    WorldInfo = class'WorldInfo'.static.GetWorldInfo();
    foreach WorldInfo.AllPawns(class'UDKAS3Pawn',P ){
        if(P!=none)
        {
            `log("pawn found");
        }
    }
    */
    
    
}

function SetFactory(FactorySpawn factory){
     factoryspawn = factory;
}

function BtnClose(){
    `log("close");
     ClosePlayer();
}

 //close UI
function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI   
}

//SetName
function setbuildingnametag(Name buildingname){
    BaseSpawnVehicleTagName = buildingname;
}

function bool HandleInputKey( const out InputEventParameters EventParms )
{
    local bool bResult;

    bResult=false;

    if(EventParms.EventType==IE_Released)
    {
        if(EventParms.InputKeyName=='Escape')
        {
            ClosePlayer();
            bResult=true;
        }
    }
    return bResult;
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
    MovieInfo=SwfMovie'udkas3hui.UDKSpawnFactoryUI'
}

