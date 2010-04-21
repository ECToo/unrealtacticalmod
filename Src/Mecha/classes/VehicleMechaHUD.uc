class VehicleMechaHUD extends UTHUD;


/** Cached reference to the another hud texture */
var const Texture2D VHMechaHUD;


static simulated function DrawBackground2(float X, float Y, float Width, float Height, LinearColor DrawColor, Canvas DrawCanvas)
{
	DrawCanvas.SetPos(X,Y);
	//DrawColor.R *= 0.25;
	//DrawColor.G *= 0.25;
	//DrawColor.B *= 0.25;
	//DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 631,202,98,48, DrawColor);
	DrawCanvas.DrawColorizedTile(Default.VHMechaHUD, Width, Height, 0,0,163,56, DrawColor);
}

defaultproperties
{
    VHMechaHUD=Texture2D'VH_Mecha_HUD.mecha_hud'
    //VHMechaHUD=Texture2D'UI_HUD.HUD.UI_HUD_BaseA'
}