Class UTMTriggerVehicleObjective extends Trigger;

var UTMObjective_VehicleTrigger ObjTrigger;
//VehiclePositionString="in an Vehicle"
//VehicleNameString="Vehicle"
event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
      local UTVehicle P;
      super.Touch(Other,OtherComp,HitLocation,HitNormal);
      
      P = UTVehicle(Other);
      if(P != None && P.Controller != None){
         if(ObjTrigger.OffenceTeamIndex == P.GetTeamNum() && P.VehicleNameString  == ObjTrigger.VehicleID.VehicleNameString){
            `log('found pawn');
            `log('Name ' @ P.VehicleNameString);
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

function setobjecttag(UTMObjective_VehicleTrigger Obj){
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
	
	//Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}