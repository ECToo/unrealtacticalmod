class UTMUIDataStore_SpawnList extends UTUIDataStore_StringList;

event Registered(LocalPlayer PlayerOwner)
{
	Super.Registered(PlayerOwner);
	// In case you don't want to set defaultproperties
	//FillList();

}

function FillList()
{
	//AddStr('SpawnName', "None",  false);
}

defaultproperties
{
   Tag="SpawnList"
   WriteAccessType=ACCESS_WriteAll
   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //pacakge > custom uiscene name > Data > Data Source > Markup String <VehicleList:Vehicle>
   //This will setup the data array in the UIscene

}