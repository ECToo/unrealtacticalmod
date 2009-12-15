class UTMUISceneMapSpawn extends UTUIScene
      Config(UTM);

/*
foreach AllActors(class'UTGameObjective', O)
		{
			if (O != self)
			{
				CurrentObjective.NextObjective = O;
				O.bFirstObjective = false;
				CurrentObjective = O;
			}
		}
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

//var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;
var UILabelButton ButtonSpawnPlayer;

var UTMBuildingNode_BaseSpawnVehicle Building_Node;
var Name buildingnodename;

var transient UTMUIDataStore_VehicleList MenuDataStore;

event PostInitialize()
{
   Local UTUIDataStore_StringList StringStore;
   local UTMNodePawn UTMNode;
   local WorldInfo WI;
   WI = GetWorldInfo();
   InitDataStores();
   Super.PostInitialize();

   StringStore = UTUIDataStore_StringList( ResolveDataStore('VehicleList'));//find this name to add on
   StringStore.Empty('Vehicle');//clear out the odd string to update spawn point

   ForEach WI.AllNavigationPoints(class'UTMNodePawn', UTMNode)
      {
      if(UTMNode != none){
      StringStore.AddStr('Vehicle',String(UTMNode.Name));
      }
      }
   //StringStore.AddStr('Vehicle',"Second Entry");
   //StringStore.AddStr('Vehicle',"Third Entry");

   SpawnList = UTUIList(FindChild('SpawnPoint', true));
   //SpawnList.SetDatastoreBinding("<SpawnList:SpawnName>");
   SpawnList.SetDatastoreBinding("<VehicleList:Vehicle>");//works!
   SpawnList.OnSubmitSelection = UIListOnSubmitSelection;

    ButtonSpawnPlayer = UILabelButton(FindChild('Spawn', true));
    ButtonSpawnPlayer.OnClicked = ButCloseScene;


   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
   ButtonCloseScene.OnClicked = ButCloseScene;
}

function DisplaySpawnListUpdate(){
      /*
      local UTMNodePawn UTMNode;
      local WorldInfo WI;
      StringStore = UTUIDataStore_StringList( ResolveDataStore('SpawnList'));
      WI = GetWorldInfo();
      //StringStore.Empty('SpawnList');
      //StringStore = UTUIDataStore_StringList( ResolveDataStore('SpawnList'));

      ForEach WI.AllNavigationPoints(class'UTMNodePawn', UTMNode)
      {
      if(UTMNode != none){
      //UTMNode.SetVehicleName(StringValue);
      StringStore.AddStr('Desscription',String(UTMNode.Name));
      }
      }
      StringStore.AddStr('Desscription',"Second Entry");
      StringStore.AddStr('Desscription',"Third Entry");


      foreach AllActors(class'UTMNodePawn', Nodep)
      {
            if(Nodep != none){
            StringStore.AddStr('ID',Nodep.Name);
            }
      }
      */

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
         `log('Building ID ' @ buildingnodename);
}

function SetBuildingData(UTMBuildingNode_BaseSpawnVehicle D){
  Building_Node = D;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = UTMUIDataStore_VehicleList(FindDataStore(class'UTMUIDataStore_VehicleList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'UTMUIDataStore_VehicleList');

			if(MenuDataStore != None) {
				DSClient.RegisterDataStore(MenuDataStore);
			}
		}
	}
}


function UIListOnSubmitSelection(UIList Sender, optional int PlayerIndex){
  `log('TEST ' @ Sender);
}

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

defaultproperties
{
        SceneInputMode=INPUTMODE_MatchingOnly
	SceneRenderMode=SPLITRENDER_PlayerOwner
	bDisplayCursor=true
	bRenderParentScenes=false
	bAlwaysRenderScene=true
	bCloseOnLevelChange=true
}