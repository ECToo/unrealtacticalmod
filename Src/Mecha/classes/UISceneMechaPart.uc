/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
/**
* Information: The Mecha custom parts build menu. The parts will change in real time.
But it will spawn new part every time it selected. Since each part is diferent and has different functions.
UIScene will hold the parts for spawning new custom mech. But I haven't testing it yet.

Warn: Event trigger all the parts. This deal with loading and event listeners.

*/

class UISceneMechaPart extends UTUIScene
	config(Mecha);

/** Reference to the settings scene. */
var string	SettingsScene;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;
var UILabelButton ButtonChangePart;

var transient UTUIMenuList MenuList;

var transient UTUIComboBox CBMechPart;
var transient UTUIComboBox UTUICB_MechPartHead;
var string MechPartHead;
var transient UTUIComboBox UTUICB_MechPartRightArm;
var string MechPartRightArm;
var transient UTUIComboBox UTUICB_MechPartLeftArm;
var string MechPartLeftArm;
var transient UTUIComboBox UTUICB_MechPartRightHand;
var string MechPartRightHand;
var transient UTUIComboBox UTUICB_MechPartLeftHand;
var string MechPartLeftHand;
var transient UTUIComboBox UTUICB_MechPartLeg;
var string MechPartLeg;

var string partname;
var name mechaid;

var VehicleMechaPart MechBuild;
var transient UTUIDataStore_MechPartList MenuDataStore;

event PostInitialize()
{
   InitDataStores();
   Super.PostInitialize();

   //MenuList =  UTUIMenuList(FindChild('UTUIML_Parts', true));
   //MenuList.SetDataStoreBinding("<MechPartList:PartName>");
   //MenuList.SetDataStoreBinding("<PartItem:MechPart>");
   //if (MenuList != None){
   //  MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
   //  MenuList.OnValueChanged = OnMenu_ValueChanged;
   //}

   CBMechPart = UTUIComboBox(FindChild('UTUICB_MechPart', true));
   CBMechPart.OnValueChanged  = CBSelectedItemChanged;

   UTUICB_MechPartHead = UTUIComboBox(FindChild('UTUICB_MechPartHead', true));
   UTUICB_MechPartHead.OnValueChanged  = CBSelectedItemChangedHead;

   UTUICB_MechPartRightArm = UTUIComboBox(FindChild('UTUICB_MechPartRightArm', true));
   UTUICB_MechPartRightArm.OnValueChanged  = CBSelectedItemChangedRightArm;

   UTUICB_MechPartLeftArm = UTUIComboBox(FindChild('UTUICB_MechPartLeftArm', true));
   UTUICB_MechPartLeftArm.OnValueChanged  = CBSelectedItemChangedLeftArm;

   UTUICB_MechPartRightHand = UTUIComboBox(FindChild('UTUICB_MechPartRightHand', true));
   UTUICB_MechPartRightHand.OnValueChanged  = CBSelectedItemChangedRightHand;

   UTUICB_MechPartLeftHand = UTUIComboBox(FindChild('UTUICB_MechPartLeftHand', true));
   UTUICB_MechPartLeftHand.OnValueChanged  = CBSelectedItemChangedLeftHand;

   UTUICB_MechPartLeg = UTUIComboBox(FindChild('UTUICB_MechPartLeg', true));
   UTUICB_MechPartLeg.OnValueChanged  = CBSelectedItemChangedLeg;

   ButtonChangePart = UILabelButton(FindChild('ButChangePart', true));
   ButtonChangePart.OnClicked = ButChangePartEvent;

   ButtonCloseScene = UILabelButton(FindChild('ButClose', true));
   ButtonCloseScene.OnClicked = ButtonCloseMenu;
}

function setvehiclebuild(VehicleMechaPart tvb){
MechBuild = tvb;
}

function setvehicleid(name tvb){
mechaid = tvb;
}

/*
* Selected Item Change when selected
*/
function CBSelectedItemChanged (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  UTUICB_MechPartHead.GetSelectionIndex() );
	SelectedItem = CBMechPart.GetSelectionIndex();
	`log("Name CLASS: " @ MenuDataStore.GetStr('MechPart',SelectedItem));
	partname = MenuDataStore.GetStr('MechPart',SelectedItem);
}
function CBSelectedItemChangedHead (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  UTUICB_MechPartHead.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartHead.GetSelectionIndex();
	`log("Name CLASS H: " @ MenuDataStore.GetStr('MechPartHead',SelectedItem));
	MechPartHead =  MenuDataStore.GetStr('MechPartHead',SelectedItem);
	//setpartname(MechPartHead);
	partname = MechPartHead;
}
function CBSelectedItemChangedRightArm (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  CBMechPart.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartRightArm.GetSelectionIndex();
	`log("Name CLASS RA: " @ MenuDataStore.GetStr('MechPartRightArm',SelectedItem));
	MechPartRightArm = MenuDataStore.GetStr('MechPartRightArm',SelectedItem);
	//setpartname(MechPartRightArm);
	partname = MechPartRightArm;
}

function CBSelectedItemChangedLeftArm (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  CBMechPart.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartleftArm.GetSelectionIndex();
	`log("Name CLASS LA: " @ MenuDataStore.GetStr('MechPartLeftArm',SelectedItem));
	MechPartleftArm = MenuDataStore.GetStr('MechPartLeftArm',SelectedItem);
	//setpartname(MechPartleftArm);
	partname = MechPartleftArm;
}

function CBSelectedItemChangedRightHand (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  CBMechPart.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartRightHand.GetSelectionIndex();
	`log("Name CLASS RH: " @ MenuDataStore.GetStr('MechPartRightWeaponHand',SelectedItem));
	MechPartRightHand = MenuDataStore.GetStr('MechPartRightWeaponHand',SelectedItem);
	//setpartname(MechPartRightHand);
	partname = MechPartRightHand;
}
function CBSelectedItemChangedLeftHand (UIObject Sender, int PlayerIndex){
	local int SelectedItem;
	//`log("SELECTED: "  $  CBMechPart.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartLeftHand.GetSelectionIndex();
	`log("Name CLASS LH: " @ MenuDataStore.GetStr('MechPartLeftWeaponHand',SelectedItem));
	MechPartLeftHand = MenuDataStore.GetStr('MechPartLeftWeaponHand',SelectedItem);
	//setpartname(MechPartLeftHand);
	partname = MechPartLeftHand;
}
function CBSelectedItemChangedLeg (UIObject Sender, int PlayerIndex){
	local int SelectedItem;

	//`log("SELECTED: " $ Sender.GetSelectionIndex());
	//`log("SELECTED: "  $  CBMechPart.GetSelectionIndex() );
	SelectedItem = UTUICB_MechPartLeg.GetSelectionIndex();
	`log("Name CLASS L: " @ MenuDataStore.GetStr('MechPartLeg',SelectedItem));
	MechPartLeg = MenuDataStore.GetStr('MechPartLeg',SelectedItem);
	//setpartname(MechPartLeg);
	partname = MechPartLeg;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = UTUIDataStore_MechPartList(FindDataStore(class'UTUIDataStore_MechPartList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'UTUIDataStore_MechPartList');
                        // saveconfig();
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
	//local string StringValue;

	SelectedItem = MenuList.GetCurrentItem();
	
	`log("Name CLASS: " @ MenuDataStore.GetStr('MechPart',SelectedItem));
	
	 partname = MenuDataStore.GetStr('MechPart',SelectedItem);
}


function bool ButChangePartEvent(UIScreenObject EventObject, int PlayerIndex){
/*
* Note this give some code build and understand if user read this code
* Just idea how code work with string and then create the class
* This still under testing.
*/
    local string packages;
    local class<MechaPart> MechData;
    local WorldInfo WI;
    local VehicleMechaPart MechaNode;
    /*
    if (partname){
       partname = "MechaPart_Leg01";
    }
    */
    
    
    //mechaid
    WI = GetWorldInfo();

    ForEach WI.AllPawns(class'VehicleMechaPart', MechaNode)
    {
		if(MechaNode.Name ==  mechaid){
			//UTMNode.SetVehicleName(StringValue);
			`log('FOUND ' $ mechaid);
			`log("CHANGE PARTS");
			//MechBuild.changeparts(class'MechaPart_Leg01');
			//you need to have package and then the class else give "none.MechaPart_Leg01"
			packages = ("Mecha." $ partname);
			// Mecha.MechaPart_Leg01 //this works
			MechData = class<MechaPart>(DynamicLoadObject(packages, class'Class'));
			MechaNode.changeparts(MechData);
		}
    }
  
     `log("clicked > close ");
     /*
    if(MechBuild != none){
      `log("CHANGE PARTS");
      //MechBuild.changeparts(class'MechaPart_Leg01');
       //you need to have package and then the class else give "none.MechaPart_Leg01"
       packages = ("Mecha." $ partname);
       // Mecha.MechaPart_Leg01 //this works
       MechData = class<MechaPart>(DynamicLoadObject(packages, class'Class'));
      MechBuild.changeparts(MechData);
    }
    */
    //ExitMenu();
    return true;
}


function setpartname(string partnametag){

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
		packages = ("Mecha." $ partnametag);
		// Mecha.MechaPart_Leg01 //this works
		MechData = class<MechaPart>(DynamicLoadObject(packages, class'Class'));
		MechBuild.changeparts(MechData);
    }

}


function bool ButtonCloseMenu(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    ExitMenu();
    return true;
}

function ExitMenu()
{
        MechBuild = None;
	CloseScene(self);
}

defaultproperties
{

}