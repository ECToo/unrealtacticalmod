class UTMGameAssault extends UTTeamGame;

var	  class<HUD>  HUDObjectives;	// HUD class this game uses.
var float CreditTeamRed;
var float CreditTeamBlue;

/** handles all player initialization that is shared between the travel methods
 * (i.e. called from both PostLogin() and HandleSeamlessTravelPlayer())
 */
/*
function GenericPlayerInitialization(Controller C)
{
        super.GenericPlayerInitialization(C);
	var PlayerController PC;

	PC = PlayerController(C);
	if (PC != None)
	{
		// tell client what hud and scoreboard to use
		PC.ClientSetHUD(HUDObjectives, ScoreboardType);

		//ReplicateStreamingStatus(PC);

		// see if we need to spawn a CoverReplicator for this player
		//if (CoverReplicatorBase != None)
		//{
		//	PC.SpawnCoverReplicator();
		//}

		// Set the rich presence strings on the client (has to be done there)
		//PC.ClientSetOnlineStatus();
	}

	//if (BaseMutator != None)
	//{
	//	BaseMutator.NotifyLogin(C);
	//}
}
*/

function PreBeginPlay()
{
	Super.PreBeginPlay();
}


defaultproperties
{
        Acronym="Assualt"
	MapPrefixes[0]="AS"
	HUDType=class'UTMAssaultHUD';
	//HUDObjectives=class'UTMAssaultHUD';
}