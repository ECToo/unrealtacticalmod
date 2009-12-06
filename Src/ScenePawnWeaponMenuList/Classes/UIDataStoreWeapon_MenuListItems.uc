/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/
 */

class UIDataStoreWeapon_MenuListItems extends UTUIDataStore_StringList;

event Registered(LocalPlayer PlayerOwner)
{
	Super.Registered(PlayerOwner);
	
	// In case you don't want to set defaultproperties
	FillList();

}

function FillList()
{
	AddStr('Weapon', "Link Gun",  false);
	AddStr('Weapon', "Rocket Lanucher",  false);

}

defaultproperties
{
   Tag="WeaponStore"
   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //UISceneMenuList_0 > MainMenuList > Data > Data Source > Markup String <MyStringStore:String1>
   //This will setup the data array in the UIscene

}