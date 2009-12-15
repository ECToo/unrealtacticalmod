Class UTMUsedTriggerScene_MapSpawn extends Trigger;

var UTMUISceneMapSpawn SceneMap;
var Name BuildingNodeName;
var bool bDisableUsed;

function bool UsedBy(Pawn User)
{
        local UTPlayerController CPlayer;
	`log('trigger used');

	CPlayer = UTPlayerController(User.Controller);
	if(bDisableUsed){
	   CPlayer.OpenUIScene(SceneMap);
	}

	return False;
}

defaultproperties
{
        bDisableUsed=true
        SceneMap=UTMUISceneMapSpawn'UTMUISceneHUD.SceneMapSpawn'
        
        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}