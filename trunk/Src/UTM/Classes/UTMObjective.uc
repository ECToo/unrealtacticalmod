class UTMObjective extends UTGameObjective;

var() String ObjectiveNameIn;
var() int ObjectiveIndex;
var() int HUDOffsetHeight;
var bool bHealthBar;
var() float Health;
var float DamageCapacity;

var() int OffenceTeamIndex;
var() int DefenceTeamIndex;


/** whether to render icon on HUD beacon (using DrawBeaconIcon()) */
var bool bDrawBeaconIcon;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

}
simulated function vector GetHUDOffset(PlayerController PC, Canvas Canvas)
{
	local float Z;

	//Z = 460;
	Z = HUDOffsetHeight;
	if ( PC.ViewTarget != None )
	{
		Z += 0.1 * VSize(PC.ViewTarget.Location - Location);
	}

	return Z*vect(0,0,1);
}

/**
PostRenderFor()
Hook to allow objectives to render HUD overlays for themselves.
Called only if objective was rendered this tick.
Assumes that appropriate font has already been set
*/
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir)
{
	local float TextXL, XL, YL, HealthX, HealthMaxX, HealthY, BeaconPulseScale, TextDistScale, IconYL;
	local vector ScreenLoc, IconLoc;
	local LinearColor TeamColor;
	local Color TextColor;
	local UTWeapon Weap;
	local string NodeName;
	//`log('HUD Render Health');
        /*
	if ( !PoweredBy(PC.GetTeamNum()) )
	{
		if ( bIsNeutral )
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

	// make sure not behind weapon
	if ( UTPawn(PC.Pawn) != None )
	{
		Weap = UTWeapon(UTPawn(PC.Pawn).Weapon);
		if ( (Weap != None) && Weap.CoversScreenSpace(screenLoc, Canvas) )
		{
			return;
		}
	}
	else if ( (UTVehicle_Hoverboard(PC.Pawn) != None) && UTVehicle_Hoverboard(PC.Pawn).CoversScreenSpace(screenLoc, Canvas) )
	{
		return;
	}

	//if ( !IsKeyBeaconObjective(UTPlayerController(PC))  )
	if ( PC != None  )
	{
		// periodically make sure really visible using traces
		if ( WorldInfo.TimeSeconds - LastPostRenderTraceTime > 0.5 )
		{
			LastPostRenderTraceTime = WorldInfo.TimeSeconds + 0.2*FRand();
			bPostRenderTraceSucceeded = FastTrace(Location, CameraPosition)
										|| FastTrace(Location+CylinderComponent.CollisionHeight*vect(0,0,1), CameraPosition);
		}
		if ( !bPostRenderTraceSucceeded )
		{
			return;
		}
		BeaconPulseScale = 1.0;
	}
	else
	{
		// pulse "key" objective
		BeaconPulseScale = UTPlayerController(PC).BeaconPulseScale;
	}

	//BeaconPulseScale = 1.0;//hmm

	class'UTHUD'.Static.GetTeamColor( GetTeamNum(), TeamColor, TextColor);

	TeamColor.A = 1.0;

	// fade if close to crosshair
	if (screenLoc.X > 0.4*Canvas.ClipX &&
		screenLoc.X < 0.6*Canvas.ClipX &&
		screenLoc.Y > 0.4*Canvas.ClipY &&
		screenLoc.Y < 0.6*Canvas.ClipY)
	{
		TeamColor.A = FMax(FMin(1.0, FMax(0.0,Abs(screenLoc.X - 0.5*Canvas.ClipX) - 0.05*Canvas.ClipX)/(0.05*Canvas.ClipX)), FMin(1.0, FMax(0.0, Abs(screenLoc.Y - 0.5*Canvas.ClipY)-0.05*Canvas.ClipX)/(0.05*Canvas.ClipY)));
		if ( TeamColor.A == 0.0 )
		{
			return;
		}
	}

	// fade if far away or not visible
	TeamColor.A = FMin(TeamColor.A, LocalPlayer(PC.Player).GetActorVisibility(self)
									? FClamp(1800/VSize(Location - CameraPosition),0.35, 1.0)
									: 0.2);

	HealthY = PostRenderShowHealth() ? Canvas.ClipX*BeaconPulseScale/64 : 0.0;
	
	NodeName =  ObjectiveNameIn;


        /*
	if ( PrimeCore != None )
	{
		NodeName = 	(bDualPrimeCore || WorldInfo.GRI.OnSameTeam(PC, PrimeCore)) ? class'UTOnslaughtPowernode'.default.PrimeNodeName : class'UTOnslaughtPowernode'.default.EnemyPrimeNodeName;
	}
	else
	{
		NodeName = (UTOnslaughtPowerCore(self) != None) ? default.ObjectiveName : ObjectiveName;
	}*/

	Canvas.Font = class'UTHUD'.static.GetFontSizeIndex(1);
	Canvas.StrLen(NodeName, TextXL, YL);
	TextDistScale = FMin(1.5, 0.1 * Canvas.ClipX/TextXL);
	TextXL *= TextDistScale;
	XL = 0.1 * Canvas.ClipX * BeaconPulseScale;
	YL *= TextDistScale*BeaconPulseScale;

	IconYL = bDrawBeaconIcon ? XL * 0.75 : 0.0;
	class'UTHUD'.static.DrawBackground(ScreenLoc.X-0.7*XL,ScreenLoc.Y-0.6*(YL+HealthY)- 0.5*(YL+IconYL),1.4*XL,1.2*(YL+HealthY) + YL + IconYL, TeamColor, Canvas);

	Canvas.DrawColor = TextColor;
	Canvas.DrawColor.A = 255.0 * TeamColor.A;

	if (bDrawBeaconIcon)
	{
		IconLoc = ScreenLoc;
		IconLoc.Y -= 0.25 * IconYL;

		DrawBeaconIcon(Canvas, IconLoc, 0.5*IconYL, TeamColor.A, BeaconPulseScale, UTPlayerController(PC));

		ScreenLoc.Y += IconYL * 0.25;
	}

	// draw node name
	Canvas.DrawColor.A = FMin(255.0, 128.0 * (1.0 + TeamColor.A));
	Canvas.SetPos(ScreenLoc.X-0.5*BeaconPulseScale*TextXL, ScreenLoc.Y - 0.5*YL - 0.6*HealthY );
	//Canvas.DrawTextClipped(NodeName, true, TextDistScale*BeaconPulseScale, TextDistScale*BeaconPulseScale);
	Canvas.DrawText(NodeName, true, TextDistScale*BeaconPulseScale, TextDistScale*BeaconPulseScale);

	// draw health bar
	if ( (HealthY > 0) && LocalPlayer(PC.Player).GetActorVisibility(self) )
	{
		HealthMaxX = 0.9 * XL;
		HealthX = HealthMaxX* FMin(1.0, Health/DamageCapacity);
		Class'UTHUD'.static.DrawHealth(ScreenLoc.X-0.45*XL,ScreenLoc.Y,HealthX,HealthMaxX,HealthY, Canvas, Canvas.DrawColor.A);
	}
	Canvas.Font = class'UTHUD'.static.GetFontSizeIndex(0);
}

simulated function bool PostRenderShowHealth()//to draw health bar
{
	return bHealthBar;
}

/** draws the icon for the HUD beacon */
simulated function DrawBeaconIcon(Canvas Canvas, vector IconLocation, float IconWidth, float IconAlpha, float BeaconPulseScale, UTPlayerController PlayerOwner)
{
	local linearcolor DrawColor;

	DrawColor = (DefenderTeamIndex < 2) ? ControlColor[DefenderTeamIndex] : ControlColor[2];
	DrawIcon(Canvas, IconLocation, IconWidth, IconAlpha, PlayerOwner, DrawColor);
}

defaultproperties
{
   ObjectiveNameIn="Objective"
   OffenceTeamIndex=0
   DefenceTeamIndex=1


   HUDOffsetHeight=256
   bHealthBar=false
   bDrawBeaconIcon=false
   ObjectiveIndex=0

}