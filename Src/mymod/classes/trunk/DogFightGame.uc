class DogFightGame extends UTDeathmatch
	config(game);
	
/**

struct ReplacementInfo
{
	// class name of the weapon we want to get rid of
	var name OldClassName;
	// fully qualified path of the class to replace it with
	var string NewClassPath;
};

var config array<ReplacementInfo> WeaponsToReplace;
var config array<ReplacementInfo> AmmoToReplace;
*/
function PostBeginPlay()
{
	local UTGame Game;
	local int i;//, Index;

	Super.PostBeginPlay();

	// replace default weapons
	Game = UTGame(WorldInfo.Game);
	if (Game != None){
	   for (i = 0; i < Game.DefaultInventory.length; i++){
	       `log("[Reamove Weapon] - Initialized and running" @ Game.DefaultInventory[i].Name);
               Game.DefaultInventory.Remove(i, 1);
	       i--;
            }
	}
}


defaultproperties
{
 //extend from deathmatch from it
	//bAllowTranslocator=false
       //	DefaultInventory.Remove(1)
//        DefaultInventory.Remove(0)
        //DefaultInventory[0] = ''
        //DefaultInventory[1] = ''
        //DefaultInventory.Remove(i, 1)
	bAllowTranslocator=true

	Acronym="DM"
	MapPrefixes[0]="DM"
	MapPrefixes[1]="TM"
	MapPrefixes[2]="DF"
	DefaultEnemyRosterClass="UTGame.UTDMRoster"
//	HUDType=class'UTGame.UTCTFHUD'
//	MidGameMenuTemplate=UTUIScene_MidGameMenu'TMod_GameMenuMod.Menus.MidGameMenu'

	// Class used to write stats to the leaderboard
	//OnlineStatsWriteClass=class'UTGame.UTLeaderboardWriteDM'
	OnlineStatsWriteClass=class'UTGame.UTLeaderboardWriteCTF'
	// Default set of options to publish to the online service
	//OnlineGameSettingsClass=class'UTGame.UTGameSettingsDM'
	OnlineGameSettingsClass=class'UTGameSettingsCTF'

	bScoreDeaths=true

	// Deathmatch games don't care about teams for voice chat
	bIgnoreTeamForVoiceChat=true

}
