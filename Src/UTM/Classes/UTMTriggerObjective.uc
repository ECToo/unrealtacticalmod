Class UTMTriggerObjective extends Trigger;

var UTMObjective_Trigger ObjTrigger;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
      local Pawn P;
      super.Touch(Other,OtherComp,HitLocation,HitNormal);
      P = Pawn(Other);
      if(P != None && P.Controller != None){
         if(ObjTrigger.OffenceTeamIndex == P.GetTeamNum()){
            `log('found pawn');
            worldinfo.game.broadcast (self,"Objective Reach");
            }
            else
            {
             `log('You Are Protect This Area');
             worldinfo.game.broadcast (self,"You Are Protecting This Area");
            }
      }
      //worldinfo.game.broadcast (self,"Touch the world game");
}

function setobjecttag(UTMObjective_Trigger Obj){
         ObjTrigger = Obj;
}

defaultproperties
{
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False

        Begin Object NAME=CollisionCylinder LegacyClassName=Trigger_TriggerCylinderComponent_Class
		CollideActors=true
		CollisionRadius=+0064.000000
		CollisionHeight=+0040.000000
	End Object
	
	SupportedEvents.Add(class'SeqEvent_Used')

}