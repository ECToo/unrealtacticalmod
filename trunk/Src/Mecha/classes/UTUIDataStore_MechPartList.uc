class UTUIDataStore_MechPartList extends UTUIDataStore_StringList
      config(Mecha);

event Registered(LocalPlayer PlayerOwner)
{
	Super.Registered(PlayerOwner);
	// In case you don't want to set defaultproperties
	FillList();
        //saveconfig();
}

function FillList()
{       /*
	AddStr('PartName', "Leg1",  false);
	AddStr('PartName', "leg2",  false);
	AddStr('PartName', "LeftArm",  false);
	AddStr('PartName', "LeftArm02",  false);
	AddStr('PartName', "RightArm",  false);
	AddStr('PartName', "RightArm02",  false);
	AddStr('PartName', "RightWeapon",  false);
	AddStr('PartName', "RightWeapon02",  false);
	AddStr('PartName', "LeftWeapon",  false);
	AddStr('PartName', "LeftWeapon02",  false);

	AddStr('MechPart', "MechaPart_Leg",  false);
	AddStr('MechPart', "MechaPart_Leg01",  false);
	AddStr('MechPart', "MechaPart_LeftArm",  false);
	AddStr('MechPart', "MechaPart_LeftArm02",  false);
	AddStr('MechPart', "MechaPart_RightArm",  false);
	AddStr('MechPart', "MechaPart_RightArm02",  false);
	AddStr('MechPart', "MechaPart_RightWeapon",  false);
	AddStr('MechPart', "MechaPart_RWeap_Gun",  false);
	AddStr('MechPart', "MechaPart_LeftWeapon",  false);
	AddStr('MechPart', "MechaPart_LWeap_Minigun4",  false);
	*/
	//================================================
        //
/**
* Information on this build. 
There are two type of data that need to to be input to the mech part list for changing other parts.

*/

        //================================================
        //Head
	//================================================
	AddStr('PartHeadName', "None",  false);
	//AddStr('PartHeadName', "Head",  false);
	//AddStr('PartHeadName', "Head02",  false);

        AddStr('MechPartHead', "None",  false);
	//AddStr('MechPartHead', "MechaPart_Head",  false);
	//AddStr('MechPartHead', "MechaPart_Head02",  false);
	
	//================================================
	//Right Arm
        //================================================
	AddStr('PartRightArmName', "RightArm",  false);
	AddStr('PartRightArmName', "RightArm02",  false);
	
	AddStr('MechPartRightArm', "MechaPart_RightArm",  false);
	AddStr('MechPartRightArm', "MechaPart_RightArm02",  false);
	
	//================================================
	//Left Arm
	//================================================
	
	AddStr('PartLeftArmName', "LeftArm",  false);
	AddStr('PartLeftArmName', "leftArm02",  false);
	
	AddStr('MechPartLeftArm', "MechaPart_LeftArm",  false);
	AddStr('MechPartLeftArm', "MechaPart_LeftArm02",  false);
	
	//================================================
	//Right Weapon
	//================================================

	AddStr('PartRightWeaponHandName', "RightWeapon",  false);
	AddStr('PartRightWeaponHandName', "RightWeapon02",  false);

	AddStr('MechPartRightWeaponHand', "MechaPart_RightWeapon",  false);
	AddStr('MechPartRightWeaponHand', "MechaPart_RWeap_Gun",  false);


	//================================================
	//Left Weapon
	//================================================

	AddStr('PartLeftWeaponHandName', "LeftWeapon",  false);
	AddStr('PartLeftWeaponHandName', "LeftWeapon02",  false);
	
	AddStr('MechPartLeftWeaponHand', "MechaPart_LeftWeapon",  false);
	AddStr('MechPartLeftWeaponHand', "MechaPart_LWeap_Minigun4",  false);

	//================================================
	//Leg
	//================================================
	
	AddStr('PartLegName', "Leg1",  false);
	AddStr('PartLegName', "leg2",  false);
	
	AddStr('MechPartLeg', "MechaPart_Leg",  false);
	AddStr('MechPartLeg', "MechaPart_Leg01",  false);
	
	//================================================
}

defaultproperties
{

   Tag="MechPartList"
   WriteAccessType=ACCESS_WriteAll

   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //pacakge > custom uiscene name > Data > Data Source > Markup String <VehicleList:Vehicle>
   //This will setup the data array in the UIscene
   
   //Name="Default__UTUIDataStore_MechPartList"
   //ObjectArchetype=UTUIDataStore_StringList'UTGame.Default__UTUIDataStore_StringList'
}