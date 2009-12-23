class UTMUISceneMapSpawn extends UTUIScene_Hud
      Config(UTM);
/**
Information: Note the code is offline not yet build for online yet.
*/

// Map
// SpawnPont
// spawn player
// ButtonClose

/** Reference to the settings scene. */
var string	SettingsScene;

// Reference to the menu list for this scene. //
var transient UTUIMenuList	MenuList;
var transient UTUIList	SpawnList;

var transient UILabel Caption;
var transient bool bTeleportDisabled;
var transient bool bEditMap;
var transient bool bFineTune;

var transient UTMDrawMapPanel Map;

var UILabelButton ButtonCloseScene;
var UILabelButton ButtonSpawnPlayer;

var UTMBuildingNode_BaseSpawnVehicle Building_Node;
var Name buildingnodename;

var transient UTMUIDataStore_SpawnList MenuDataStore;
var UTUIDataStore_StringList StringStore;

event PostInitialize()
{

   local UTMBuildingNode_BaseSpawn UTMNode;
   local WorldInfo WI;
   WI = GetWorldInfo();
   InitDataStores();
   Super.PostInitialize();

   Map = UTMDrawMapPanel(FindChild('Map',true));
   Map.bAllowTeleport = true;
   Map.OnActorSelected = MapActorSelected;
   Map.FindBestActor();

   StringStore = UTUIDataStore_StringList( ResolveDataStore('SpawnList'));//find this name to add on
   StringStore.Empty('SpawnName');//clear out the old string to update spawn point

   ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawn', UTMNode)
      {
      if(UTMNode != none){
      StringStore.AddStr('SpawnName',String(UTMNode.Name));
      }
      }
   //StringStore.AddStr('Vehicle',"Second Entry");
   //StringStore.AddStr('Vehicle',"Third Entry");

   SpawnList = UTUIList(FindChild('SpawnPoint', true));
   //SpawnList.SetDatastoreBinding("<SpawnList:SpawnName>");
   SpawnList.SetDatastoreBinding("<SpawnList:SpawnName>");//works!
   SpawnList.OnSubmitSelection = UIListOnSubmitSelection;

    ButtonSpawnPlayer = UILabelButton(FindChild('Spawn', true));
    ButtonSpawnPlayer.OnClicked = ButCloseScene;


   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
   ButtonCloseScene.OnClicked = ButCloseScene;
}


function TeleportToActor(UTPlayerController PCToTeleport, Actor Destination)
{
	if ( !bTeleportDisabled && PCToTeleport != none && Destination != none )
	{
		UTPlayerReplicationInfo(PCToTeleport.PlayerReplicationInfo).ServerTeleportToActor(Destination);
		SceneClient.CloseScene(self);
	}
}

/*
 * Teleport to the node
 */
function bool ButtonBarSelect(UIScreenObject InButton, int InPlayerIndex)
{
	local UTPlayerController UTPC;
	local UTMapInfo Mi;
	UTPC = GetUTPlayerOwner();
	if ( UTPC != none && Map != none )
	{
		MI = Map.GetMapInfo();
		if ( MI != none && MI.CurrentActor != none )
		{
			TeleportToActor( UTPC, MI.CurrentActor);
		}
	}
	return true;
}


///#*
// * Call back - Attempt to teleport
// #/
function MapActorSelected(Actor Selected, UTPlayerController SelectedBy)
{
        `log('MAP SELECTED THIS SCENE');
	if ( SelectedBy != none && Selected != none && Map != none )
	{
		TeleportToActor(SelectedBy, Selected);
	}
}


/*
 * Provides a hook for unrealscript to respond to input using actual input key names (i.e. Left, Tab, etc.)
 *
 * Called when an input key event is received which this widget responds to and is in the correct state to process.  The
 * keys and states widgets receive input for is managed through the UI editor's key binding dialog (F8).
 *
 * This delegate is called BEFORE kismet is given a chance to process the input.
 *
 * @param	EventParms	information about the input event.
 *
 * @return	TRUE to indicate that this input key was processed; no further processing will occur on this input key event.
 */
function bool InputKey( const out InputEventParameters EventParms )
{

	if (EventParms.EventType == IE_Released)
	{
		if ( EventParms.InputKeyName == 'XboxTypeS_A' )
		{
			ButtonBarSelect(none,EventParms.PlayerIndex);
		}

		else if ( EventParms.InputKeyName == 'Escape' || EventParms.InputKeyName == 'XboxTypeS_B' || EventParms.InputKeyName == 'XboxTypeS_Y' || (EventParms.InputKeyName =='F2' && bTeleportDisabled) )
		{
			//ButtonBarCancel(none, EventParms.PlayerIndex);
		}
	}

	if ( EventParms.EventType == IE_Released && EventParms.InputKeyName == 'F12' && GetWorldInfo().NetMode == NM_Standalone )
	{
		bEditMap = !bEditMap;
		Map.bShowExtents = bEditMap;
	}

	if (bEditMap)
	{

		if ( (EventParms.EventType == IE_Pressed || EventParms.EventType == IE_Released) &&
				(EventParms.InputKeyName == 'LeftShift' || EventParms.InputKeyName == 'RightShift') )
		{
			bFineTune = !bFineTune;
		}

		if ( EventParms.EventType == IE_Pressed || EventParms.EventType == IE_Repeat )
		{
			if ( EventParms.InputKeyName == 'Minus' || EventParms.InputKeyName == 'Subtract' )
			{
				AdjustMapExtent(bFineTune ? -16.0 : -256.0);
			}
			else if ( EventParms.InputKeyName =='Equals' || EventParms.InputKeyName == 'Add' )
			{
				AdjustMapExtent(bFineTune ? 16.0 : 256.0);
			}

			else if ( EventParms.InputKeyName == 'I' || EventParms.InputKeyName =='NumPadEight' )
			{
				AdjustMapCenter(bFineTune ? vect(0,-16,0) : vect(0,-256,0));
			}
			else if ( EventParms.InputKeyName == 'M' || EventParms.InputKeyName =='NumPadTwo' )
			{
				AdjustMapCenter(bFineTune ? vect(0,16,0) : vect(0,256,0));
			}
			else if ( EventParms.InputKeyName == 'J' || EventParms.InputKeyName =='NumPadFour' )
			{
				AdjustMapCenter(bFineTune ? vect(-16,0,0) : vect(-256,0,0));
			}
			else if ( EventParms.InputKeyName == 'K' || EventParms.InputKeyName =='NumPadSix' )
			{
				AdjustMapCenter(bFineTune ? vect(16,0,0) : vect(256,0,0));
			}
		}
	}

	return true;
}


function AdjustMapExtent(float Adjustment)
{
	//local UTOnslaughtMapInfo UMI;
	//UTMapInfo
	local UTMapInfo UMI;

	UMI = UTMapInfo( GetWorldInfo().GetMapInfo() );
	if ( UMI != None )
	{
		UMI.MapExtent += Adjustment;
		return;
	}

}

function AdjustMapCenter(vector Adjustment)
{
	//local UTOnslaughtMapInfo UMI;
	//UTMapInfo
	local UTMapInfo UMI;

	UMI = UTMapInfo( GetWorldInfo().GetMapInfo() );
	if ( UMI != None )
	{
		UMI.MapCenter += Adjustment;
		return;
	}

}

function DisableTeleport()
{
	//bTeleportDisabled = true;
	bTeleportDisabled = false;
	//ButtonBar.ClearButton(1);
	Caption.SetVisibility(false);
}

function setbuildingnodename(Name buildingname){
         buildingnodename = buildingname;
         //`log('Building ID ' @ buildingnodename);
}

function SetBuildingData(UTMBuildingNode_BaseSpawnVehicle D){
  Building_Node = D;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = UTMUIDataStore_SpawnList(FindDataStore(class'UTMUIDataStore_SpawnList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'UTMUIDataStore_SpawnList');

			if(MenuDataStore != None) {
				DSClient.RegisterDataStore(MenuDataStore);
			}
		}
	}
}


function UIListOnSubmitSelection(UIList Sender, optional int PlayerIndex){
   //local int SelectedItem;
   local string StringValue;
   local UTMBuildingNode_BaseSpawn UTMNode;
   //local UTPlayerController SelectedBy;
   local Pawn P;
   local WorldInfo WI;
   //local UTPlayerController UTPC;
   WI = GetWorldInfo();
   //UTPC = GetUTPlayerOwner();

    P = GetPawnOwner();
    //SelectedBy = P.Controller();
  //`log('TEST ' @ Sender);
  //SelectedItem = SpawnList.GetCurrentItem();
  //`log('TEST ' @ SelectedItem );
  //`log('TEST ' @ SpawnList.Items[SelectedItem] $ Sender.Name);
  //`log('TEST ' @ SpawnList.GetElementValue(SpawnList.GetCurrentItem(),0));
  StringValue = SpawnList.GetElementValue(SpawnList.GetCurrentItem(),0);
  `log('TEST ' @ StringValue);


  ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawn', UTMNode)
      {
      if (UTMNode != none){
         if (StringValue == String(UTMNode.Name)){
            //TeleportToActor(UTPC, UTMNode);
            //teleportpawn(UTPC, UTMNode);
            TeleportPawnPoint(P, UTMNode);
            //`log('name pawn' @ P.Name);
            //P.SetLocation(UTMNode.Location);//working code
            //`log('TELEPORT TEST');
            ExitMenu();
         }
      }
      }
}
//test code to teleport //not working yet deal with online code but my be different later
function teleportpawn(UTPlayerController PCToTeleport, Actor Destination){
         PCToTeleport.SetLocation(Destination.Location);
}
//random spawn test
function TeleportPawnPoint(Pawn PCToTeleport,  UTMBuildingNode_BaseSpawn Destination){
           //PCToTeleport.SetLocation(Destination.Location);
         local int numpoint;
         numpoint = Rand(Destination.PlayerStarts.length);
         PCToTeleport.SetLocation(Destination.PlayerStarts[numpoint].Location);
         `log("TLEPORT POINT Random" @ (numpoint) $ " Destination " $ Destination.PlayerStarts[numpoint].Location);
         //PCToTeleport.SetLocation(Destination.Location);
}


/*
function TeleportToActor(UTPlayerController PCToTeleport, Actor Destination)
{
    if ( PCToTeleport != none && Destination != none )
    {
        UTPlayerReplicationInfo(PCToTeleport.PlayerReplicationInfo).ServerTeleportToActor(Destination);
        //CloseParentScene();
    }
}
*/


function bool BuildSpawnVehicle(UIScreenObject EventObject, int PlayerIndex){
    /*
    local UTMBuildingNode_BaseSpawnVehicle UTMNode;
    local WorldInfo WI;
    WI = GetWorldInfo();

    ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawnVehicle', UTMNode)
    {
            if(UTMNode.Name ==  buildingnodename){
                            UTMNode.spawnvehicle();
            }
    }
    */
    `log("clicked");
    /*
    if(BuildingData != None){
       BuildingData.spawnvehicle();
    }
    */
    ExitMenu();
    return true;
}

function bool ButCloseScene(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    ExitMenu();
    return true;
}

function ExitMenu()
{
        //Building_Node = none;
	CloseScene(self);
}

function bool HandleInputKey( const out InputEventParameters EventParms )
{
	local bool bResult;

	bResult=false;

	if(EventParms.EventType==IE_Released)
	{
		if(EventParms.InputKeyName=='Escape')
		{
			ExitMenu();
			bResult=true;
		}
	}

	return bResult;
}                                                                                                                                                                
	//bCloseOnLevelChange=true

defaultproperties
{
        SceneInputMode=INPUTMODE_MatchingOnly
	SceneRenderMode=SPLITRENDER_PlayerOwner
	bDisplayCursor=true
	bRenderParentScenes=false
	bAlwaysRenderScene=true
}