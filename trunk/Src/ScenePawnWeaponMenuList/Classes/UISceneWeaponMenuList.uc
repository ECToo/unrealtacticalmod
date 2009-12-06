/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/
 */

class UISceneWeaponMenuList extends UTUIScene;

var UILabelButton ButtonAddWeapon;
var UILabelButton ButtonRemoveWeapon;
var UILabelButton ButtonCloseScene;

// Reference to the menu list for this scene. //
var transient UTUIMenuList	MenuList;

var transient UIDataStoreWeapon_MenuListItems MenuDataStore;

event PostInitialize()
{
      InitDataStores();
      Super.PostInitialize();

      MenuList = UTUIMenuList(FindChild('WeaponMenuList', true));
      if(MenuList != none)
	{
		MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
		MenuList.OnValueChanged = OnMenu_ValueChanged;
	}
	ButtonAddWeapon = UILabelButton(FindChild('ButtonAddWeapon', true));
	ButtonRemoveWeapon = UILabelButton(FindChild('ButtonRemoveWeapon', true));
      ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
      ButtonCloseScene.OnClicked =  ButtonClose;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = UIDataStoreWeapon_MenuListItems(FindDataStore(class'UIDataStoreWeapon_MenuListItems'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'UIDataStoreWeapon_MenuListItems');

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

	SelectedItem = MenuList.GetCurrentItem();
	`log("Selected " @ SelectedItem);
}

///
// Called when the user changes the currently selected list item.
//
function OnMenu_ValueChanged( UIObject Sender, optional int PlayerIndex=0 )
{
	local int SelectedItem;
	SelectedItem = MenuList.GetCurrentItem();
	`log("Selected " @ SelectedItem);
}

function bool ButtonClose(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    pawnaddweapon();
    ExitMenu();
    return true;
}


function pawnaddweapon(){
    //local LocalPlayer UTPC;
        local Pawn OwnerPawn;
        
        //UTPC = GetPlayerOwner();
        OwnerPawn = GetPawnOwner(); //this is from UTUIScene class

        if(OwnerPawn != None)
        {
        OwnerPawn.CreateInventory(class'UTWeap_RocketLauncher_Content');
        `log('pawn found');
         // Do what you need with your pawn...
         }
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