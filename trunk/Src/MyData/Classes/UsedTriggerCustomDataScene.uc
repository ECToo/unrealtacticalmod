Class UsedTriggerCustomDataScene extends Trigger;

var UISceneCustomData SceneBuild;

function bool UsedBy(Pawn User)
{
        local UTPlayerController CPlayer;
	`log('trigger used');
	CPlayer = UTPlayerController(User.Controller);
	CPlayer.OpenUIScene(SceneBuild);
	return False;
}

defaultproperties
{
        //Actor
        bHidden=False
        bStatic=false
	bNoDelete=False

	//UIScene
        SceneBuild=UISceneCustomData'CustomMydataScene.MyCustomData'

        //Used Event
	Begin Object Class=Sequence Name=Sequence0
	End Object

	Begin Object Class=SeqEvent_Used Name=SeqEvent_Used0
		InteractDistance=300.0
		ParentSequence=Sequence0
	End Object
	GeneratedEvents.Add(SeqEvent_Used0)
}