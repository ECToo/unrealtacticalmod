/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class AS3UIActor extends Actor placeable;

var PointUIMoviePlayer PlayerBeacon;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    CreateBeacon();
}

simulated function CreateBeacon()
{
    `log("INIT UI...............");
    PlayerBeacon = new class'PointUIMoviePlayer';
    PlayerBeacon.SetTimingMode(TM_Real);
    PlayerBeacon.Init();
    //PlayerBeacon.start();
}

defaultproperties
{
    
}