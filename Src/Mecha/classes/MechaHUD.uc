class MechaHUD extends UTHUD;

simulated function PostBeginPlay()
{
  Super.PostBeginPlay();
  //DisplayBuildingInfo();
  `log('           HUD BUILDINGS              ');
}


function DrawLivingHud()
{
         //local UTM_IconHUD MIcon;
         //local Pawn Player;
        // local int i;
	//super.DrawLivingHud();

	Canvas.DrawColor = WhiteColor;
	Canvas.SetPos(35,260);
	//Canvas.DrawText("No. Objectives: " @ buildingcount);
	Canvas.SetPos(35,280);
	Canvas.DrawText("Current Objective: ");
        //i = 0; 
        /*
        foreach AllActors(class'UTM_IconHUD', MIcon)
		{
			if (MIcon != none)
			{       i += 1;
				`log('UTM_IconHUD');
				Canvas.SetPos(35,280+(i*14));
	                        Canvas.DrawText("Current Objective: " @ MIcon.ObjectiveNameIn);
			}
		}
		*/
	//i = 0;
	/*
	foreach AllActors(class'Pawn', Player)
		{
			if (Player != none)
			{       i += 1;
				//`log('UTM_IconHUD');
				Canvas.SetPos(35,280+(i*16));
	                        Canvas.DrawText("Name: " @ Player.GetHumanReadableName() $ "Team ID:" @ Player.GetTeamNum());
			}
		}
		*/

}

simulated function Timer()
{
   Super.Timer();
   //`log('hud timer');
}

//HUDType=class'MyMod.MyHUD';

defaultproperties
{
  bHasMap=True
}