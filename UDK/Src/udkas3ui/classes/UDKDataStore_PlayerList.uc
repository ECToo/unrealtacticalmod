/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class UDKDataStore_PlayerList extends UDKUIDataStore_StringList
      config(AS3UI);

/** Structure which defines a unique game mode. */
struct Option
{
    var string OptionName;
    var string OptionLabel;
    var string OptionDesc;
};

/** Aray of all list options, defined in DefaultUI.ini */
var config array<Option> ListPlayer;      
      
event Registered(LocalPlayer PlayerOwner)
{
    Super.Registered(PlayerOwner);
    `log("register player owner...");
    // In case you don't want to set defaultproperties
    //FillList();
        //saveconfig();
}

function FillList()
{    
    //AddStr('JobClass', "Default",  false);
    //AddStr('JobClass', "Assault",  false);
    //AddStr('JobClass', "Recon",  false);
    //AddStr('JobClass', "Medic",  false);    
    //AddStr('JobClass', "Sniper",  false);
}


defaultproperties
{
   Tag="PlayerList"
   //WriteAccessType=ACCESS_WriteAll
}