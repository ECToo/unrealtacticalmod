/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class GfxUDKMapSpawnNode extends GFxMoviePlayer
     config(AS3UI);

/** Avaiable maps list, provided by the MapInfo DataProvider. */
var array<UTUIDataProvider_MapInfo> MapList;

var GFxObject RootMC;
//var string MapName;
//var string MapID;

struct ViewInfo
{
    /** Unique string. */
    var name ViewName;

    /** SWF content to be loaded. */
    var string SWFName;

    /** Dependant views that should be loaded if this view is displayed. */
    var array<name> DependantViews;
};

/** Structure which defines a unique game mode. */
struct Option
{
    var string OptionName;
    var string OptionLabel;
    var string OptionDesc;
};

/** Aray of all list options, defined in DefaultUI.ini */
var config array<Option> ListOptions;

/** Array of all menu views to be loaded, defined in DefaultUI.ini. */
var config array<ViewInfo>   ViewData;

var config string MapTag;

function Init( optional LocalPlayer LocPlay )
{
    `log("init menu ui");
    //Start();
    Advance(0.0f);
    MapTag = "MapTag";
    SaveConfig();
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
        //ConsoleCommand("open" @ MapName);//UDK Command
    }
    LoadViews();
    MapTag = "MapTag";
    SaveConfig();
    `log("MAP.................................." @ MapTag);
}

final function LoadViews()
{
    
    local byte i;
    `log( "List...");
    for (i = 0; i < ViewData.Length; i++) 
    {
        `log( ViewData[i].ViewName );
        //LoadView( ViewData[i] );
    }
}

/**
 * Sets up the list's dataProvider using the data pulled from
 * DefaultUI.ini.
 */
function UpdateListDataProviderMenus()
{
    local byte i;
    //local GFxObject DataProvider;
    //local GFxObject TempObj;

    //DataProvider = Outer.CreateArray();
    `log("TEST LIST..");
    for (i = 0; i < ListOptions.Length; i++)
    {        
        `log("LIST.." @ ListOptions[i].OptionName);
        //TempObj = CreateObject("Object");
        //TempObj.SetString("name", ListOptions[i].OptionName);
        //TempObj.SetString("label", ListOptions[i].OptionLabel);
        //TempObj.SetString("desc", ListOptions[i].OptionDesc);
        
        //DataProvider.SetElementObject(i, TempObj);
    }

    //ListMC.SetObject("dataProvider", DataProvider);   
    //ListDataProvider = ListMC.GetObject("dataProvider");    
    //ListMC.AddEventListener('CLIK_itemPress', OnListItemPress);
    //ListMC.AddEventListener('CLIK_change', OnListChange);
}

function BtnUpdateMap(){
    //UpdateListDataProvider();
    UpdateListDataProviderMenus();
    UpdateCustomData();
    LoadViews();
    MapTag = "MapTag";
    SaveConfig();
    `log("MAP.................................." @ MapTag);
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

function UpdateCustomData(){
 local array<UDKUIResourceDataProvider> ProviderList;
 local int i;   
 class'AS3UIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'AS3UIDataProvider_MapList', ProviderList);
 `log("LENGETH" @ ProviderList.length);
   for (i = 0; i < ProviderList.length; i++)
    {  
        `log("mapname" @ AS3UIDataProvider_MapList(ProviderList[i]).MapName );

    }
    
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
    MovieInfo=SwfMovie'udkas3hui.UDKMapSpawnNodeUI'
}

