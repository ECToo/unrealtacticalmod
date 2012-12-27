/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class GFxUDKMapList extends GFxMoviePlayer;

/** Avaiable maps list, provided by the MapInfo DataProvider. */
var array<UTUIDataProvider_MapInfo> MapList;

var GFxObject RootMC;
//var string MapName;
//var string MapID;

function Init( optional LocalPlayer LocPlay )
{
    `log("init menu ui");
    //Start();
    Advance(0.0f);
    
    RootMC = GetVariableObject("root");
    
    Super.Init( LocPlay );
}

function BtnSeletedMap(){
    local String MapName;
    //local String MapID;
     RootMC = GetVariableObject("root");
     MapName = RootMC.GetString("mapname");
     //MapID = RootMC.GetString("mapid");
     
     //if( Len(MapID)  > 0) && (Len(MapName) > 0)){
     if( (Len(MapName) > 0)){
        //fscommand("open " $ MapName); 
        //fscommand("open ");
        ConsoleCommand("open" @ MapName);//UDK Command
     }
}


function BtnUpdateMap(){
    UpdateListDataProvider();
}


function BtnCloseMap(){
    `log("close");
     ClosePlayer();
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

//close UI
function ClosePlayer(){
    Close(false);//this options for make it not to unload the gfx UI   
}


/** 
 *  Creates the data provider for the map list based on the ListOptions array
 *  and passes it to the map list for display. 
 */
function UpdateListDataProvider()
{
    //local int i, ListCounter;
    //local GFxObject DataProvider;
    //local GFxObject TempObj;
    //local array<UDKUIResourceDataProvider> ProviderList; 
    //local array<UTUIDataProvider_MapInfo> LocalMapList;

    local int i;    
    local array<UDKUIResourceDataProvider> ProviderList; 
    //local array<UTUIDataProvider_MapInfo> LocalMapList;
    
    ActionScriptVoid("root.ClearMapList");
    
    // fill the local map list    
    MapList.Length = 0;
    //LocalMapList.Length = 0;
    class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_MapInfo', ProviderList);
    for (i = 0; i < ProviderList.length; i++)
    {       
        //LocalMapList.AddItem(UTUIDataProvider_MapInfo(ProviderList[i]));
        `log("mapname" @ UTUIDataProvider_MapInfo(ProviderList[i]).MapName );
         AddMapName(UTUIDataProvider_MapInfo(ProviderList[i]).MapName,  string(UTUIDataProvider_MapInfo(ProviderList[i]).MapId));
    }   
    
    // No need to create an object if no maps are available.
    //if (LocalMapList.Length == 0)
    //{
        // return;
    //}
}

//call to flash player function
function AddMapName(string _mn,string _data ){//works
    local array<ASValue> args;
    local ASValue asval;

    asval.Type = AS_String;
    asval.s = _mn;
    args[0] = asval;
    
    asval.Type = AS_String;
    asval.s = _data;
    args[1] = asval;

    GetVariableObject("root").Invoke("AddMapList", args);
    `log("Invoke args...");
}



defaultproperties
{
    bDisplayWithHudOff=false
    MovieInfo=SwfMovie'udkas3hui.UDKMapListUI'
}

