class UISceneCustomData extends UTUIScene
      config(MyData);
var config string SceneName;

var UILabelButton ButtonCloseScene;

// Reference to the menu list for this scene. //
var transient UTUIMenuList	MenuList;

var transient CustomDataStoreStringList MenuDataStore;

event PostInitialize()
{
      InitDataStores();
      Super.PostInitialize();

      MenuList = UTUIMenuList(FindChild('MainMenuList', true));
      if(MenuList != none)
	{
		MenuList.OnSubmitSelection = OnMenu_SubmitSelection;
		MenuList.OnValueChanged = OnMenu_ValueChanged;
	}
      ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
      ButtonCloseScene.OnClicked = ButtonCloseVehicle;
}

function InitDataStores() {
	local DataStoreClient DSClient;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();

	if(DSClient != None) {
		MenuDataStore = CustomDataStoreStringList(FindDataStore(class'CustomDataStoreStringList'.default.Tag));
		if(MenuDataStore == None) {
			MenuDataStore = DSClient.CreateDataStore(class'CustomDataStoreStringList');

			if(MenuDataStore != None) {
                                `log('Fail to find it and creating new data');
				DSClient.RegisterDataStore(MenuDataStore);
				//SaveConfig(); //note this will save all the config currently there in the data base

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

function bool ButtonCloseVehicle(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
    `log("SCENE NAME" @ SceneName);
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