class CustomDataStoreStringList extends UTUIDataStore_StringList
      config(MyData);

event Registered(LocalPlayer PlayerOwner)
{
	Super.Registered(PlayerOwner);
	
	// In case you don't want to set defaultproperties
	FillList();
	//SaveConfig();//this save  your file in your config(MyData)//note depend on what you name as UT<configname>.ini

}

function FillList()
{
	AddStr('String1', "Inside the class",  false);
	AddStr('String1', "This show up TMP",  false);

}

defaultproperties
{
   tag="MyStringStore"

   //StringData(0)=(Tag="String1",ColumnHeaderText="Stringheader",Strings=("Play The Tutorial","Start A New Game", "Save Or Load A Game","Options Menu","Exit The Game"))

   //UIScene > MainMenuList > Data > Data Source > Markup String <MyStringStore:String1>
   //This will setup the data array in the UIscene

}