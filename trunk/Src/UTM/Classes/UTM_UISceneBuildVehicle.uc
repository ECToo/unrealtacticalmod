class UTM_UISceneBuildVehicle extends UTUIScene
      Config(UTM);

/** Reference to the settings scene. */
var string	SettingsScene;

// Reference to the menu list for this scene. //
var transient UTUIMenuList	MenuList;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;

var UTMBuildingNode_BaseSpawnVehicle Building_Node;
var Name buildingnodename;

var transient UTMUIDataStore_VehicleList MenuDataStore;

event PostInitialize()
{
   InitDataStores();
   Super.PostInitialize();

   ButtonSpawnVehicle = UILabelButton(FindChild('SpawnVehicle', true));
   if(ButtonSpawnVehicle != None){
   ButtonSpawnVehicle.OnClicked = BuildSpawnVehicle;
   `log('FOUND');
   }

   MenuList = UTUIMenuList(FindChild('VehicleMenuList', true));
   if(MenuList != none)
	{
		MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
		MenuList.OnValueChanged = OnMenu_ValueChanged;
	}
   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
   ButtonCloseScene.OnClicked = ButtonCloseVehicle;
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

//
// * Called when the user presses Enter (or any other action bound to UIKey_SubmitListSelection) while this list has focus.
// *
// * @param	Sender	the list that is submitting the selection
//
function OnMenu_SubmitSelection(UIObject EventObject, optional int PlayerIndex=0 )
{
         local int SelectedItem;
	local string StringValue;
	local UTMBuildingNode_BaseSpawnVehicle UTMNode;
	local WorldInfo WI;
	//local UTMapInfo MI;

	WI = GetWorldInfo();

	SelectedItem = MenuList.GetCurrentItem();

	if(MenuList.GetCellFieldString(MenuList, 'Vehicle', SelectedItem, StringValue))
	{

		`log("Description " @ StringValue);
		/*
		if(BuildingData != None){
		                BuildingData.SetVehicleName(StringValue);
		}
		*/

		ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawnVehicle', UTMNode)
                {
                        if(UTMNode.Name ==  buildingnodename){
                           UTMNode.SetVehicleName(StringValue);
                        }
                }


	}
}

///
// Called when the user changes the currently selected list item.
//
function OnMenu_ValueChanged( UIObject Sender, optional int PlayerIndex=0 )
{
	local int SelectedItem;
	local string StringValue;
	local UTMBuildingNode_BaseSpawnVehicle UTMNode;
        local WorldInfo WI;

	SelectedItem = MenuList.GetCurrentItem();
        WI = GetWorldInfo();

	if(MenuList.GetCellFieldString(MenuList, 'Vehicle', SelectedItem, StringValue))
	{

		`log("Description " @ StringValue);
		/*
		if(BuildingData != None){
		                BuildingData.SetVehicleName(StringValue);
		}
		*/
		ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawnVehicle', UTMNode)
                {
                        if(UTMNode.Name ==  buildingnodename){
                           UTMNode.SetVehicleName(StringValue);
                        }
                }
	}
}


function bool BuildSpawnVehicle(UIScreenObject EventObject, int PlayerIndex){
    local UTMBuildingNode_BaseSpawnVehicle UTMNode;
    local WorldInfo WI;
    WI = GetWorldInfo();
    
    ForEach WI.AllNavigationPoints(class'UTMBuildingNode_BaseSpawnVehicle', UTMNode)
    {
            if(UTMNode.Name ==  buildingnodename){
                            UTMNode.spawnvehicle();
            }
    }
    `log("clicked > spawn vehicle");
    /*
    if(BuildingData != None){
       BuildingData.spawnvehicle();
    }
    */
    ExitMenu();
    return true;
}

function bool ButtonCloseVehicle(UIScreenObject EventObject, int PlayerIndex){
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
  
}