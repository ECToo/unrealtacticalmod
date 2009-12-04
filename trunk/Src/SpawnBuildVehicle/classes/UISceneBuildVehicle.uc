class UISceneBuildVehicle extends UTUIScene;

// SpawnVehicle
// ButtonClose

/** Reference to the settings scene. */
var string	SettingsScene;

var UILabelButton ButtonSpawnVehicle;
var UILabelButton ButtonCloseScene;

var BaseSpawnVehicle BuildingData;

event PostInitialize()
{
   Super.PostInitialize();
   ButtonSpawnVehicle = UILabelButton(FindChild('SpawnVehicle', true));// it the name of the SpawnVehicle UILabelButton package of BuildingSpawnVehicle.SceneBuildVehicle
   ButtonSpawnVehicle.OnClicked = BuildSpawnVehicle;

   ButtonCloseScene = UILabelButton(FindChild('ButtonClose', true)); // it the name of the ButtonClose UILabelButton package of BuildingSpawnVehicle.SceneBuildVehicle
   ButtonCloseScene.OnClicked = ButtonCloseVehicle;
}

function SetBuildingData(BaseSpawnVehicle D){
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