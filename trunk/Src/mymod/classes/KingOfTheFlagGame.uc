


class KingOfTheFlagGame extends UTDeathmatch
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
}


/*

http://utforums.epicgames.com/showthread.php?t=592530&highlight=King+Flag

The name of the game mode might confuse people but I think it fits.

(If anyone ever played THPS3/PS4/UG1/UG2/AW on PC, PS2, or XBOX there was an online/multiplayer game mode called "King of the Hill." If you've played it then I don't need to explain the game mode. If not then I will try to explain the best I can. Also bare with me. I'm posting this on a PS3 and I might need to make a second post to finish my description)

- First a flag appears in a random location on the map.
- Everyone has a timer with a limit of 2:00. (minutes)
-> Each person's timer can start with either 0:00 and count up to 2:00 or have it count down from 2:00.
- When you grab the flag you slow down to about half the normal running speed and your timer starts.
-> To gain speed you must kill people but you can not gain any health.
- If killed by someone else while holding the flag it will drop where you land and your timer stops. However you respawn where you died 3 seconds after you die, but you do not have the same weapons from before.



}- Once someone reaches 2:00 (Or 0:00) the game ends and everyone dies. (Maybe I should call this Meltdown and have them hold like a timer thing that has the counter on it to detonate the other players.)

Basically the object of the game is to hold the flag as long as you can for a set time limit.

(We have a dieing community on http://www.kxth.com - a site made for this game mode - that is slowly dwindling down to nothing since Neversoft decided to drop this game mode from THP8 and on. We were bummed to hear that it was dropped. No more KOTH for Tony Hawk games. Our last resort was Delta Force: Black Hawk Down seeing that it had a game mode like this in it. Its also found on Socom: Fireteam Bravo 2 for the PSP but no one wants to play it on a PSP. Thats why I am hoping for this game to be a success with PS3 accepting mods so everyone can play again.)

Extras:

- During the game it has an arrow that points to where the flag is so camping will be hard. Hiding won't work either.


(Continued)
- As you kill people while holding the flag you gain speed while the other players lose speed.

- You can kill other team players to stop them from getting the flag but they respawn where they died 3 seconds later as well.

- Health pickups are only available to people who are not holding the flag.

- Armor upgrades are available to everyone in the game including the flag carrier.

- Using the warp gun is prohibited while holding the flag, but getting on your hover board is not prohibitted.

- Use of tanks and other vehicles is allowed while holding the flag, but the damage taken should increase by %150 to be fair.

- If someone falls off the map while holding the flag (Basically going out of bounds) then it should respawn in a random area on the map. As for the player who was holding the flag, s/he spawns in a new location. (Basically if they suicide with the flag it should respawn in a random area. If the flag falls out of bounds it should re-appear in a random location on the map as well.)
__________________


(Continued)

- Flying vehicles should be prohibited. If not then they should also have the %150 damage taken. Although I think people would find it pretty cheap.

I think that is pretty much it. I can't think of anything else to add. If anyone lse has an idea to add to this mode please post!
*/