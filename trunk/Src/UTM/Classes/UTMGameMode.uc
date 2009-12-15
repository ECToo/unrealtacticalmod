class UTMGameMode extends UTTeamGame;

var	  class<HUD>  HUDObjectives;	// HUD class this game uses.

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


defaultproperties
{
        Acronym="GM"
	MapPrefixes[0]="GM"
	HUDType=class'UTMGameModeHUD';
	//HUDObjectives=class'UTMAssaultHUD';
}