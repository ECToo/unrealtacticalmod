/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class GfxCustomLoadAndSave extends GFxMoviePlayer
      config(AS3UI);

//Create variables to hold references to the Flash MovieClips and Text Fields that will be modified
var GFxObject RootMC;
var GFxObject MC;

var transient UDKDataStore_PlayerList MenuDataStore;

function Init(optional LocalPlayer LocPlay) {
     super.Init(LocPlay);
    //Start and load the SWF Movie
    //Start();
    //Advance(0.f);
    RootMC = GetVariableObject("_root");
    `log("init ####################### GFX ######################");
}

event bool Start(optional bool StartPaused = false){
      super.Start(StartPaused);
      Advance(0.f);//make sure you addd this to init
      RootMC = GetVariableObject("_root");
      InitDataStores();
   return StartPaused;
}

//===============================================
//actionscript call
//===============================================
function CloseFileScript(){
  `log("CloseFileScript click....");
  Close();
}

function LoadFileScript(){
   local int index;
   local int max;
   local string JobName;
    `log("LoadFileScript click....");
    ClearStringList();
    if(MenuDataStore != none){
                     //string type, index
                     //MenuDataStore.GetStr('MechPartLeg',SelectedItem));
                     max = MenuDataStore.Num('JobClass');
                     `log("Num. Class: " $ max);
                     for (index = 0;index < max ;index++ ){
                     JobName = MenuDataStore.GetStr('JobClass',index);
                     `log("JOB Class: " $ JobName);
                     AddStringList(JobName,index);
                     }
      `log("load done  #############################################");
    }else{
      `log("load fail  #############################################");
    }

}



function SaveFileScript(){
   if(MenuDataStore != None) {
     MenuDataStore.SaveConfig();
     `log("saving config");
   }else{
     `log("fail config");
   }
   //SaveConfig();
  `log("click....");
}

function CreateFileScript(){
  local int max;
  local string TextString;
  `log("CreateFileScript click....");
  TextString = "Other";
   if(MenuDataStore != none){
     max = MenuDataStore.Num('JobClass');
      //string type, index
      //MenuDataStore.AddStr('JobClass', TextString,   false);
     AddStringList(TextString,max+1);
  }
}

function DeleteFileScript(){
  `log("DeleteFileScript click....");

  if(MenuDataStore != none){
    
`log("Delete String:"$    MenuDataStore.GetStr('JobClass',0));
  DeleteStringList(MenuDataStore.GetStr('JobClass',0),0);

      //string type, index
     MenuDataStore.RemoveStrByIndex('JobClass',0);
`log("Index String:" $    MenuDataStore.GetStr('JobClass',0));

  }
}


//unreal script to actionscript2
function AddStringList(String tag_name,int tag_id){
   `log("StringList actionscript...");
    ActionScriptVoid("_root.addlist");
}

function DeleteStringList(String tag_name,int tag_id){
   `log("StringList actionscript...");
    ActionScriptVoid("_root.deletelist");
}

function ClearStringList(){
   `log("StringList actionscript...");
    ActionScriptVoid("_root.ClearList");
}
//init data string list
function InitDataStores() {
    local DataStoreClient DSClient;

    DSClient = class'UIInteraction'.static.GetDataStoreClient();

    if(DSClient != None) {
        MenuDataStore = UDKDataStore_PlayerList(DSClient.FindDataStore(class'UDKDataStore_PlayerList'.default.Tag));
        if(MenuDataStore == None) {
            MenuDataStore = DSClient.CreateDataStore(class'UDKDataStore_PlayerList');
            saveconfig();
            if(MenuDataStore != None) {
                DSClient.RegisterDataStore(MenuDataStore);

            }
        }
    }
}

DefaultProperties
{
    //MovieInfo=SwfMovie'ACLRHUD.CustomHUDVariable'
    bDisplayWithHudOff = false
    bCaptureInput = true
}
