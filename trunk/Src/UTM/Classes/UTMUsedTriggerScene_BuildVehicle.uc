Class UTMUsedTriggerScene_BuildVehicle extends UTMUsedTriggerScene;

function bool UsedBy(Pawn User)
{
        local UTPlayerController CPlayer;
	`log('trigger used');

	CPlayer = UTPlayerController(User.Controller);
	if(bDisableUsed){
           //SetBuildingData(BuildingData);//we need to set the current building spawn scene it one scene so we set the building data in the scene.
           `log("BUILDING INDEX" @ BuildingData.Name);
           //SceneBuildVehicle.SetBuildingData(BuildingData);
           SceneBuildVehicle.setbuildingnodename(BuildingData.Name);
	   CPlayer.OpenUIScene(SceneBuildVehicle);
	}

	return False;
}

defaultproperties
{
        SceneBuildVehicle=UTM_UISceneBuildVehicle'UTMBuildingFactory.UTMBuildVehicle'
}