Class UTMBuilding_Barrack extends UTMBuilding;

defaultproperties
{
    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.BarracksSimple'
                AlwaysLoadOnClient=true
                CollideActors=true
                CastShadow=FALSE
		bCastDynamicShadow=TRUE
		bAcceptsLights=TRUE
		bForceDirectLightMap=TRUE
		LightingChannels=(BSP=TRUE,Dynamic=TRUE,Static=TRUE,CompositeDynamic=TRUE)
    End Object
}