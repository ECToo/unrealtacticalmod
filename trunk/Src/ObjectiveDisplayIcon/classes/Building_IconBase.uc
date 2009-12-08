Class Building_IconBase extends UTGameObjective;

var String ObjectiveNameIn;

var StaticMeshComponent Mesh;

/**
PostRenderFor()
Hook to allow objectives to render HUD overlays for themselves.
Called only if objective was rendered this tick.
Assumes that appropriate font has already been set
*/
//simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir)
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir)
{

	local float TextXL, XL, YL, BeaconPulseScale; // Dist,
	local vector ScreenLoc;
	local LinearColor TeamColor;
	local Color TextColor;
	local UTWeapon Weap;
	//super.PostRenderFor(PC,Canvas,CameraPosition,CameraDir);
	//`log('simple hud');

	// must be in visible and valid target for player to render HUD overlay
	//if ( bHidden || !ValidTargetFor(PC) )
	//	return;
        
	// only render if player can destroy it (ask weapon)
	if ( PC.Pawn != None )
	{
		if ( UTVehicle(PC.Pawn) != None )
		{
			if ( UTVehicle(PC.Pawn).Driver != None )
			{
				Weap = UTWeapon(UTVehicle(PC.Pawn).Driver.Weapon);
			}
		}
		else
		{
			Weap = UTWeapon(PC.Pawn.Weapon);
		}
	} 
        /*
	if ( (Weap == None) || !Weap.bCanDestroyBarricades )
	{
		return;
	}
        */
	screenLoc = Canvas.Project(Location + GetHUDOffset(PC,Canvas));

	// make sure not clipped out
	if (screenLoc.X < 0 ||
		screenLoc.X >= Canvas.ClipX ||
		screenLoc.Y < 0 ||
		screenLoc.Y >= Canvas.ClipY)
	{
		return;
	}

	// must have been rendered
	if ( !LocalPlayer(PC.Player).GetActorVisibility(self) )
		return;

	// fade if close to crosshair
	if (screenLoc.X > 0.45*Canvas.ClipX &&
		screenLoc.X < 0.55*Canvas.ClipX &&
		screenLoc.Y > 0.45*Canvas.ClipY &&
		screenLoc.Y < 0.55*Canvas.ClipY)
	{
		TeamColor.A = FMax(FMin(1.0, FMax(0.0,Abs(screenLoc.X - 0.5*Canvas.ClipX) - 0.025*Canvas.ClipX)/(0.025*Canvas.ClipX)), FMin(1.0, FMax(0.0, Abs(screenLoc.Y - 0.5*Canvas.ClipY)-0.025*Canvas.ClipX)/(0.025*Canvas.ClipY)));
		if ( TeamColor.A == 0.0 )
		{
			return;
		}
	}

	// make sure not behind weapon

	if ( (Weap != None) && (UTPawn(PC.Pawn) != None) && Weap.CoversScreenSpace(screenLoc, Canvas) )
	{
		return;
	}
	else if ( (UTVehicle_Hoverboard(PC.Pawn) != None) && UTVehicle_Hoverboard(PC.Pawn).CoversScreenSpace(screenLoc, Canvas) )
	{
		return;
	}


	// pulse "key" objective
	BeaconPulseScale = (self == UTPlayerController(PC).LastAutoObjective) ? UTPlayerController(PC).BeaconPulseScale : 1.0;

	Canvas.StrLen(ObjectiveNameIn, TextXL, YL);
	XL = FMax(TextXL * BeaconPulseScale, 0.05*Canvas.ClipX);
	YL *= BeaconPulseScale;

	class'UTHUD'.Static.GetTeamColor( 255, TeamColor, TextColor);
	class'UTHUD'.static.DrawBackground(ScreenLoc.X-0.7*XL,ScreenLoc.Y-3*YL,1.4*XL,3.5*YL, TeamColor, Canvas);

	// draw node name
	Canvas.DrawColor = TextColor;
	Canvas.SetPos(ScreenLoc.X-0.5*TextXL,ScreenLoc.Y - 1.75*YL);
	Canvas.DrawText(ObjectiveNameIn, true);

}


defaultproperties
{
    ObjectiveNameIn="TEST BASE"
    Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.factoryvehicle_flat'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}