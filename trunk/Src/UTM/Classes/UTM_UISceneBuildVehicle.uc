class UTM_UISceneBuildVehicle extends UTUIScene;

// SpawnVehicle
// ButtonClose

/** Reference to the settings scene. */
var string	SettingsScene;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;

var UTMBuilding_BaseSpawnVehicle BuildingData;

event PostInitialize()
{
   Super.PostInitialize();
   ButtonSpawnVehicle = UILabelButton(FindChild('SpawnVehicle', true));
   if(ButtonSpawnVehicle != None){
   ButtonSpawnVehicle.OnClicked = BuildSpawnVehicle;
   `log('FOUND');
   }
   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true));
   ButtonCloseScene.OnClicked = ButtonCloseVehicle;
}

function SetBuildingData(UTMBuilding_BaseSpawnVehicle D){
  BuildingData = D;
}


function bool BuildSpawnVehicle(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > spawn vehicle");
    BuildingData.spawnvehicle();
    ExitMenu();
    return true;
}

function bool ButtonCloseVehicle(UIScreenObject EventObject, int PlayerIndex){
    `log("clicked > close ");
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