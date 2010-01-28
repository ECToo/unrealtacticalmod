/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UISceneMechaPart extends UTUIScene
      config(Mecha);

/** Reference to the settings scene. */
var string	SettingsScene;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;
var UILabelButton ButtonChangePart;

var transient UTUIMenuList MenuList;
var string partname;

var() VehicleMechaPart MechBuild;
var transient UTUIDataStore_MechPartList MenuDataStore;

event PostInitialize()
{
   InitDataStores();
   Super.PostInitialize();

   MenuList =  UTUIMenuList(FindChild('UTUIML_Parts', true));
//   MenuList.SetDataStoreBinding("<PartItem:PartName>");
      MenuList.SetDataStoreBinding("<PartItem:MechPart>");
   if (MenuList != None){
     MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
     MenuList.OnValueChanged = OnMenu_ValueChanged;
   }

   ButtonChangePart = UILabelButton(FindChild('ButChangePart', true));
   ButtonChangePart.OnClicked = ButChangePartEvent;

   ButtonCloseScene = UILabelButton(FindChild('ButClose', true));
   ButtonCloseScene.OnClicked = ButtonCloseMenu;
}

function setvehiclebuild(VehicleMechaPart tvb){
MechBuild = tvb;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = UTUIDataStore_MechPartList(FindDataStore(class'UTUIDataStore_MechPartList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'UTUIDataStore_MechPartList');
                         //saveconfig();
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
/*
         local int SelectedItem;
	local string StringValue;
	//local UTMBuildingNode_BaseSpawnVehicle UTMNode;
	//local UTMBuildingNode_BaseSpawn UTMNode2;
	//local WorldInfo WI;
	//local UTMapInfo MI;

	//WI = GetWorldInfo();

	SelectedItem = MenuList.GetCurrentItem();
        //if(class'UTUIMenuList'.static.GetCellFieldString(lstWeapons, 'Description', SelectedItem, NewDescription))
	if(class'UTUIMenuList'.static.GetCellFieldString(MenuList, 'Spawn', SelectedItem, StringValue))
	{

		`log("Description " @ StringValue);
	}
	*/
}

///
// Called when the user changes the currently selected list item.
//
function OnMenu_ValueChanged( UIObject Sender, optional int PlayerIndex=0 )
{
	local int SelectedItem;
	local string StringValue;
	//local UTMBuildingNode_BaseSpawnVehicle UTMNode;
	//local UTMBuildingNode_BaseSpawn UTMNode2;
        //local WorldInfo WI;

	SelectedItem = MenuList.GetCurrentItem();
        //WI = GetWorldInfo();

	if(class'UTUIMenuList'.static.GetCellFieldString(MenuList, 'MechPart', SelectedItem, StringValue))
	{

		`log("Description " @ StringValue);

		partname = StringValue;

	}
}

function bool ButChangePartEvent(UIScreenObject EventObject, int PlayerIndex){
/*
* Note this give some code build and understand if user read this code
* Just idea how code work with string and then create the class
* This still under testing.
*/
    local string packages;
    local class<MechaPart> MechData;
    /*
    if (partname){
       partname = "MechaPart_Leg01";
    }
    */


     `log("clicked > close ");
    if(MechBuild != none){
      `log("CHANGE PARTS");
      //MechBuild.changeparts(class'MechaPart_Leg01');
       //you need to have package and then the class else give "none.MechaPart_Leg01"
       packages = ("Mecha." $ partname);
       // Mecha.MechaPart_Leg01 //this works
       MechData = class<MechaPart>(DynamicLoadObject(packages, class'Class'));
      MechBuild.changeparts(MechData);
    }
    ExitMenu();
    return true;
}

function bool ButtonCloseMenu(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    ExitMenu();
    return true;
}

function ExitMenu()
{
	CloseScene(self);
}

defaultproperties
{

}