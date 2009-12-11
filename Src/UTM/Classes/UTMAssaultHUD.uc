class UTMAssaultHUD extends UTTeamHUD;

var float buildingcount;

simulated function PostBeginPlay()
{
  Super.PostBeginPlay();
  DisplayBuildingInfo();
  `log('           HUD BUILDINGS              ');
}

function DisplayBuildingInfo()
{
      local UTMObjective UTMNode;
      `log('           COUNT BUILDINGS              ');
      ForEach WorldInfo.AllNavigationPoints(class'UTMObjective', UTMNode)
      {
            buildingcount += 1;
	    `log("======================+++++===================");
      }

}

function DrawLivingHud()
{
	super.DrawLivingHud();

	Canvas.DrawColor = WhiteColor;
	Canvas.SetPos(35,260);
	Canvas.DrawText("No. Objectives: " @ buildingcount);
	Canvas.SetPos(35,280);
	Canvas.DrawText("Current Objective: ");
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