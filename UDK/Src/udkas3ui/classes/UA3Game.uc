/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class UA3Game extends UDKGame;

/** Whether to give physics gun to human players in this game type (meant for testing only) */
var bool bGivePhysicsGun;

var bool bStartWithLockerWeaps;
var bool                bPlayersVsBots;
var bool                bCustomBots;

var int DesiredPlayerCount;         // bots will fill in to reach this value as needed
var float AdjustedDifficulty;
var int PlayerKills, PlayerDeaths;


// console server
var bool bConsoleServer;

/** PlayerController class to use on consoles */
var class<PlayerController> ConsolePlayerControllerClass;

/** class used for AI bots */
var class<UDKBot> BotClass;

/** Array of active bot names. */
struct ActiveBotInfo
{
    /** name of character */
    var string BotName;
    /** whether the bot is currently in the game */
    var bool bInUse;
};
var globalconfig array<ActiveBotInfo> ActiveBots;

var UTTeamInfo EnemyRoster;
var string EnemyRosterName;

/** object containing speech recognition data to use for this gametype */
var SpeechRecognition SpeechRecognitionData;



/**
 * This being false implies that only gamepads are valid for input type.
 * This is not 100% precise as you could have a keyboard + gamepad which could be valid if we wanted to allow typing but no movement.
 **/
var bool bAllowKeyboardAndMouse;


var array< class<Inventory> >   DefaultInventory;


function AddDefaultInventory( pawn PlayerPawn )
{
	local int i;
	local UTWeaponLocker Locker, BestLocker;
	local float Dist, BestDist;

	// may give the physics gun to non-bots
	if( bGivePhysicsGun && PlayerPawn.IsHumanControlled() )
	{
		PlayerPawn.CreateInventory(class'UTWeap_PhysicsGun',true);
	}

	for (i=0; i<DefaultInventory.Length; i++)
	{
		// Ensure we don't give duplicate items
		if (PlayerPawn.FindInventoryType( DefaultInventory[i] ) == None)
		{
			// Only activate the first weapon
			PlayerPawn.CreateInventory(DefaultInventory[i], (i > 0));
		}
	}

	if ( bStartWithLockerWeaps )
	{
		// find nearest weapon locker and provide the weapons
		ForEach DynamicActors(class'UTWeaponLocker', Locker)
		{
			Dist = VSize(PlayerPawn.Location - Locker.Location);
			if ( (BestLocker == None) || (BestDist > Dist) )
			{
				BestDist = Dist;
				BestLocker = Locker;
			}
		}

		if ( BestLocker != None )
		{
			BestLocker.Touch(PlayerPawn, None, BestLocker.Location, Normal(BestLocker.Location-PlayerPawn.Location) );
		}
	}

	PlayerPawn.AddDefaultInventory();
}

// Parse options for this game...
event InitGame( string Options, out string ErrorMessage )
{
    Super.InitGame(Options, ErrorMessage);
    `log("INIT GAME MODE...............................");
}


function DiscardInventory( Pawn Other, optional controller Killer )
{
    Super.DiscardInventory(Other);
}

exec function KillBots()
{
    local UDKBot B;

    DesiredPlayerCount = NumPlayers;
    bPlayersVsBots = false;

    foreach WorldInfo.AllControllers(class'UDKBot', B)
    {
        KillBot(B);
    }
}

exec function KillOthers()
{
    local UDKBot B, ViewedBot;
    local PlayerController PC;

    DesiredPlayerCount = NumPlayers;
    bPlayersVsBots = false;

    foreach LocalPlayerControllers(class'PlayerController', PC)
    {
        if ( Pawn(PC.ViewTarget) != None )
        {
            ViewedBot = UDKBot(Pawn(PC.ViewTarget).Controller);
DesiredPlayerCount = NumPlayers + 1;
            break;
        }
    }

    foreach WorldInfo.AllControllers(class'UDKBot', B)
    {
        if ( B != ViewedBot )
            KillBot(B);
    }
}

exec function KillThis()
{
    local PlayerController PC;
    local UDKBot ViewedBot;

    foreach LocalPlayerControllers(class'PlayerController', PC)
    {
        if ( Pawn(PC.ViewTarget) != None )
        {
            ViewedBot = UDKBot(Pawn(PC.ViewTarget).Controller);
            if ( ViewedBot != None )
                KillBot(ViewedBot);
            break;
        }
    }
}
function KillBot(UDKBot B)
{
    if ( B == None )
        return;

    if ( (Vehicle(B.Pawn) != None) && (Vehicle(B.Pawn).Driver != None) )
        Vehicle(B.Pawn).Driver.KilledBy(Vehicle(B.Pawn).Driver);
    else if (B.Pawn != None)
    B.Pawn.KilledBy( B.Pawn );
    if (B != None)
        B.Destroy();
}
/*
exec function AddBots(int Num)
{
    local int AddCount;

    DesiredPlayerCount = Clamp(Max(DesiredPlayerCount, NumPlayers+NumBots)+Num, 1, 32);

    // add up to 8 immediately, then the rest automatically via game timer.
    while ( (NumPlayers + NumBots < DesiredPlayerCount) && (AddBot() != none) && (AddCount < 8) )
    {
        `log("added bot");
        AddCount++;
    }
}
*/
/*
exec function UDKBot AddNamedBot(string BotName, optional bool bUseTeamIndex, optional int TeamIndex)
{
    DesiredPlayerCount = Clamp(Max(DesiredPlayerCount, NumPlayers + NumBots) + 1, 1, 32);
    return AddBot(BotName, bUseTeamIndex, TeamIndex);
}
*/

defaultproperties
{
	bGivePhysicsGun=true
	
    PlayerControllerClass=class'UA3PlayerController'
	PlayerReplicationInfoClass=class'UA3PlayerReplicationInfo'
    DefaultPawnClass=class'UA3Pawn'
    PopulationManagerClass=class'GameFramework.GameCrowdPopulationManager'
    HUDType = class'UA3_HUD'
    bRestartLevel=false
    bWaitingToStartMatch=true
    bDelayedStart=false
    //DefaultInventory(0)=class'UTWeap_LinkGun'
    //DefaultInventory(0)=class'UAWeap_Builder'
    //DefaultInventory(0)=class'UTWeap_Pointgun'
    DefaultInventory(0)=class'UAWeap_Pointgun'
    //Acronym="UA"
    //MapPrefixes[0]="UA"
	
	BotClass=class'UA3Bot'
}