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
	   //`log("RANDOM" @ Rand(5));
	}

	return False;
}

defaultproperties
{
        bDisableUsed=true
        bStatic=false
	bNoDelete=False
        bHidden=false
        SceneMap=UTMUISceneMapSpawn'UTMUISceneHUD.SceneMapSpawn'
        
        Begin Object Name=Sprite
		Sprite=Texture2D'UTMEditor.maptool'
		HiddenGame=False
		AlwaysLoadOnClient=False
		AlwaysLoadOnServer=False
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