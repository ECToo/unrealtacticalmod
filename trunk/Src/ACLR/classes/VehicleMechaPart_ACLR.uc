class VehicleMechaPart_ACLR extends VehicleMechaPart;

var float timebar;

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
      local LinearColor TeamColor;
      super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);
      class'ACLR_HUD'.static.DrawArmorPoint(0,0,320,100, TeamColor, Canvas);


      class'ACLR_HUD'.static.DrawFuelPoint(0,128,51,524, TeamColor, Canvas);

      class'ACLR_HUD'.static.DrawRadorMap(831,84,194,233, TeamColor, Canvas);
      class'ACLR_HUD'.static.DrawSquareIn(253,110,533,539, TeamColor, Canvas);

      //class'ACLR_HUD'.static.DrawFuelBar(9,151+(460 - 460*timebar),19,(460*timebar), TeamColor, Canvas);
      class'ACLR_HUD'.static.DrawFuelBar(9, 151+(460*timebar),19,460-(460*timebar), TeamColor, Canvas);
      

      class'ACLR_HUD'.static.DrawTmperBar(31,71,(171*timebar),7, TeamColor, Canvas);
      class'ACLR_HUD'.static.DrawExternalBar(949,285,(65*timebar),21, TeamColor, Canvas);

      timebar += 0.01f;
      if (timebar > 1){
        timebar = 0.0f;
      }
      //`log("time" $ timebar);


}


defaultproperties
{
 timebar=0.0f

}