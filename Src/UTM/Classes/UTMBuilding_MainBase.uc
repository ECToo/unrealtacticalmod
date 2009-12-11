Class UTMBuilding_MainBase extends UTMBuilding_BaseSpawnVehicle;


simulated function PostBeginPlay()
{
	super.PostBeginPlay();
}

/*
function SetVehicleName(String vehiclename){
         if(vehiclename == "Scorpion"){
            UTMVehicle=class'UTVehicle_Scorpion_Content';
         }
         if(vehiclename == "Manta"){
            UTMVehicle=class'UTVehicle_Manta_Content';
         }
         if(vehiclename == "Cicada"){
            UTMVehicle=class'UTVehicle_Cicada_Content';
         }
}
*/

defaultproperties
{   //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=128,y=160,z=128)
    buildcontroloffset=(x=0,y=-64,z=96)

    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.MainBaseSimple'
                AlwaysLoadOnClient=true
                CollideActors=true
                CastShadow=FALSE
		bCastDynamicShadow=TRUE
		bAcceptsLights=TRUE
		bForceDirectLightMap=TRUE
		LightingChannels=(BSP=TRUE,Dynamic=TRUE,Static=TRUE,CompositeDynamic=TRUE)
    End Object
}