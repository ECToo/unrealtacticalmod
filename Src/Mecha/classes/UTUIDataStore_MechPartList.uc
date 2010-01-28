class UTUIDataStore_MechPartList extends UTUIDataStore_StringList
      config(Mecha);

event Registered(LocalPlayer PlayerOwner)
{
	Super.Registered(PlayerOwner);
	// In case you don't want to set defaultproperties
	FillList();
}

function FillList()
{
	AddStr('PartName', "Leg1",  false);
	AddStr('PartName', "leg2",  false);

	AddStr('MechPart', "MechaPart_Leg",  false);
	AddStr('MechPart', "MechaPart_Leg01",  false);

	AddStr('Cost', "0",  false);
	AddStr('Cost', "0",  false);
}

defaultproperties
{
   Tag="PartItem"
   WriteAccessType=ACCESS_WriteAll
   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //pacakge > custom uiscene name > Data > Data Source > Markup String <VehicleList:Vehicle>
   //This will setup the data array in the UIscene
   
   Name="Default__UTUIDataStore_MechPartList"
   ObjectArchetype=UTUIDataStore_StringList'UTGame.Default__UTUIDataStore_StringList'


}