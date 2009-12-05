class CustomUIDataStore_MenuListItems extends UTUIDataStore_StringList;

event Registered(LocalPlayer PlayerOwner)
{

	Super.Registered(PlayerOwner);
	
	// In case you don't want to set defaultproperties
	FillList();

}

function FillList()
{
	AddStr('String1', "SomeText1",  false);
	AddStr('String1', "SomeText2",  false);
	AddStr('String1', "SomeText3",  false);
	AddStr('String1', "SomeText4",  false);
}

defaultproperties
{
   Tag="MyStringStore"
   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //UISceneMenuList_0 > MainMenuList > Data > Data Source > Markup String <MyStringStore:String1>
   //This will setup the data array in the UIscene

}