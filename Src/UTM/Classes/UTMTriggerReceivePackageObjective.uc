Class UTMTriggerReceivePackageObjective extends Trigger;

var UTMObjective_ReceivePackage ObjTrigger;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
      local Pawn P;
      super.Touch(Other,OtherComp,HitLocation,HitNormal);
      P = Pawn(Other);
      if(P != None && P.Controller != None){
         if(P.Health < 0){
          //do something
         }

         if(ObjTrigger.OffenceTeamIndex == P.GetTeamNum()){
            `log('found pawn');
            worldinfo.game.broadcast (self,"Got Object Objective");
            //ObjTrigger.Location = P.Location;
            //P.Attach(ObjTrigger);
            }
            else
            {
             `log('You Are Protect This Area');
             worldinfo.game.broadcast (self,"Protect The Object");
            }
      }
      //worldinfo.game.broadcast (self,"Touch the world game");
}

function setobjecttag(UTMObjective_ReceivePackage Obj){
         ObjTrigger = Obj;
}

/*
simulated event Tick( float DeltaTime )
{
          super.Tick(DeltaTime);
      `log('test');
}
*/

simulated function Timer()
{
   Super.Timer();
   `log('hud timer');
}

defaultproperties
{
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False
	
	bAlwaysTick=true

        Begin Object NAME=CollisionCylinder LegacyClassName=Trigger_TriggerCylinderComponent_Class
		CollideActors=true
		CollisionRadius=+0064.000000
		CollisionHeight=+0040.000000
	End Object
	
	SupportedEvents.Add(class'SeqEvent_Used')

}