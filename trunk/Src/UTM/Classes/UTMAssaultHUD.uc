class UTMAssaultHUD extends UTTeamHUD;

function DrawLivingHud()
{
	super.DrawLivingHud();

	Canvas.DrawColor = WhiteColor;
	Canvas.SetPos(35,260);
	Canvas.DrawText("No. Objectives: ");
	Canvas.SetPos(35,280);
	Canvas.DrawText("Current Objective: ");
}

//HUDType=class'MyMod.MyHUD';