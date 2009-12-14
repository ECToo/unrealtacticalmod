Class UTMTriggerUsedObjective extends Trigger;

var UTMObjective_UsedTrigger ObjTrigger;

function bool UsedBy(Pawn User)
{
        //local UTPlayerController Player;
	`log('trigger used');

       //User = Pawn(User);
      if(User != None && User.Controller != None){
         if(ObjTrigger.OffenceTeamIndex == User.GetTeamNum()){
            `log('Objective Used');
            worldinfo.game.broadcast (self,"Objective Used");
            }
            else
            {
             `log('Protect the Used Trigger');
             worldinfo.game.broadcast (self,"Protect the Used Trigger");
            }
      }

	return False;
}

function setobjecttag(UTMObjective_UsedTrigger Obj){
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