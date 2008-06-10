class CustomGame extends UTDeathmatch
        config(game);

function PostBeginPlay()
{
        local UTGame Game;
        local int i;//, Index;

        Super.PostBeginPlay();

        // remove default weapons
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
                 MapPrefixes(0)="DM"
                 MapPrefixes(1)="VDM"
                 OnlineGameSettingsClass=class'mymod.UTGameSettingsVDM'
                 //OnlineGameSettingsClass=class'UTGameSettingsCTF'
                 Description="Free-for-all kill or be killed.  The player with the most frags wins."
                 GameName="VehicleDeathMatch"
}