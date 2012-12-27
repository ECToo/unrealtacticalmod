/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */
class UDKFactoryDataStore_StringList extends UTUIDataStore_StringList;

event Registered(LocalPlayer PlayerOwner)
{

    Super.Registered(PlayerOwner);
    
    // In case you don't want to set defaultproperties
    FillList();

}

function FillList()
{
    //AddStr('Vehicle', "Scorpion",  false);
    //AddStr('Vehicle', "Manta",  false);
    //AddStr('Vehicle', "Cicada",  false);

    //AddStr('Desscription', "Land Vehicle",  false);
    //AddStr('Desscription', "Hover Vehicle",  false);
    //AddStr('Desscription', "Air Vehicle",  false);
    //not tested just ref.
    //AddStr('Spawn', "class'UTVehicle_Scorpion_Content'",  false);
    //AddStr('Spawn', "class'UTVehicle_Manta_Content'",  false);
    //AddStr('Spawn', "class'UTVehicle_Cicada_Content'",  false);
}

defaultproperties
{
   Tag="VehicleList"
   //WriteAccessType=ACCESS_WriteAll
   //pacakge > CustomSceneMenuList.UISceneMenuList_0 > edit
   //pacakge > custom uiscene name > Data > Data Source > Markup String <VehicleList:Vehicle>
   //This will setup the data array in the UIscene

}