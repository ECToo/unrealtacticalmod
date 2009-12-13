class UISceneBuildVehicle extends UTUIScene;

// SpawnVehicle
// ButtonClose

/** Reference to the settings scene. */
var string	SettingsScene;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;

// Reference to the menu list for this scene. //
var transient UTUIMenuList	MenuList;
var transient DataStore_VehicleList MenuDataStore;

var Name BaseSpawnVehicleTagName;

event PostInitialize()
{
   InitDataStores();
   Super.PostInitialize();
   ButtonSpawnVehicle = UILabelButton(FindChild('SpawnVehicle', true));// it the name of the SpawnVehicle UILabelButton package of BuildingSpawnVehicle.SceneBuildVehicle
   ButtonSpawnVehicle.OnClicked = BuildSpawnVehicle;
   MenuList = UTUIMenuList(FindChild('VehicleMenuList', true));

   if(MenuList != none)
	{
		MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
		MenuList.OnValueChanged = OnMenu_ValueChanged;
	}

   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true)); // it the name of the ButtonClose UILabelButton package of BuildingSpawnVehicle.SceneBuildVehicle
   ButtonCloseScene.OnClicked = ButtonCloseVehicle;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = DataStore_VehicleList(FindDataStore(class'DataStore_VehicleList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'DataStore_VehicleList');

			if(MenuDataStore != None) {
				DSClient.RegisterDataStore(MenuDataStore);
			}
		}
	}
}


function setbuildingnametag(Name buildingname){
     BaseSpawnVehicleTagName = buildingname;
}

function bool BuildSpawnVehicle(UIScreenObject EventObject, int PlayerIndex){

    local BaseSpawnVehicle BNode;
    local WorldInfo WI;
    WI = GetWorldInfo();
    ForEach WI.AllNavigationPoints(class'BaseSpawnVehicle', BNode)
    {
            if(BNode.Name ==  BaseSpawnVehicleTagName){
                            BNode.spawnvehicle();
            }
    }

    `log("clicked > spawn vehicle");
    //BuildingData.spawnvehicle();
    ExitMenu();
    return true;
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
	local BaseSpawnVehicle BNode;
	local WorldInfo WI;

	WI = GetWorldInfo();

	SelectedItem = MenuList.GetCurrentItem();

	if(MenuList.GetCellFieldString(MenuList, 'Vehicle', SelectedItem, StringValue))
	{

		`log("Vehicle " @ StringValue);

		ForEach WI.AllNavigationPoints(class'BaseSpawnVehicle', BNode)
                {
                        if(BNode.Name ==  BaseSpawnVehicleTagName){
                           BNode.SetVehicleName(StringValue);
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
	local BaseSpawnVehicle BNode;
        local WorldInfo WI;

	SelectedItem = MenuList.GetCurrentItem();
        WI = GetWorldInfo();

	if(MenuList.GetCellFieldString(MenuList, 'Vehicle', SelectedItem, StringValue))
	{

		`log("Vehicle " @ StringValue);
		ForEach WI.AllNavigationPoints(class'BaseSpawnVehicle', BNode)
                {
                        if(BNode.Name ==  BaseSpawnVehicleTagName){
                           BNode.SetVehicleName(StringValue);
                        }
                }
	}
}

function bool ButtonCloseVehicle(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    ExitMenu();
    return true;
}

function ExitMenu()
{
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