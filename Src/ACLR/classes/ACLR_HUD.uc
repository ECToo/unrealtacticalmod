//Texture2D'HUD_ACLR.ACLR_HUD'
class ACLR_HUD extends UTHUD;

/** Cached reference to the another hud texture */
var const Texture2D VHMechaHUD;


static simulated function DrawBackground2(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	//DrawColor.R *= 0.25;
	//DrawColor.G *= 0.25;
	//DrawColor.B *= 0.25;
	//DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 631,202,98,48, DrawColor);
	//DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 0,0,163,56, DrawColor);
	//DrawCanvas.DrawTile(Default.AltHudTexture, Width, Height, 631,202,98,48, DrawColor); //UDK
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 0,0,163,56, DrawColor);
}

static simulated function DrawArmorPoint(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	//DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 631,202,98,48, DrawColor);
	//DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 0,0,163,56, DrawColor);
	//DrawCanvas.DrawTile(Default.AltHudTexture, Width, Height, 631,202,98,48, DrawColor); //UDK
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 15,15,337,101, DrawColor);
}

static simulated function DrawFuelPoint(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 18,173,66,696, DrawColor);
}

static simulated function DrawRadorMap(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 810,16,194,233, DrawColor);
}


static simulated function DrawSquareIn(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 79,111,533,539, DrawColor);
}


static simulated function DrawFuelBar(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 634,320,19,460, DrawColor);
}

static simulated function DrawTmperBar(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 377,27,171,7, DrawColor);
}

static simulated function DrawExternalBar(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	DrawColor.R *= 0.25;
	DrawColor.G *= 0.25;
	DrawColor.B *= 0.25;
	DrawCanvas.DrawTile(Default.VHMechaHUD, Width, Height, 585,24,65,21, DrawColor);
}

defaultproperties
{
    VHMechaHUD=Texture2D'HUD_ACLR.ACLR_HUD'
    //VHMechaHUD=Texture2D'UI_HUD.HUD.UI_HUD_BaseA'
}