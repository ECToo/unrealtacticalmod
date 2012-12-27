/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class UA3_HUD extends UTHUDBase;

var GfxPlayerHUD PlayerUI;

/** The Pawn that is currently owning this hud */
var UA3Pawn OwnerPlayer;

singular event Destroyed()
{
    if (PlayerUI != none)
    {
        PlayerUI.Close(true);
        PlayerUI = none;
    }
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    
    PlayerUI = new class'GfxPlayerHUD';
    PlayerUI.init();
    PlayerUI.Start();
}

event PostRender()
{
    DrawPlayerHealthBars();
    //DrawPoints();
}
//need to rework the code here for more smoothing...
function DrawPlayerHealthBars()
{
    local UA3Pawn P;
    local Vector loc;
    //local LocalPlayer Lp;
    
    //LP = LocalPlayer(PlayerOwner.Player);
    
    OwnerPlayer = UA3Pawn(PlayerOwner.ViewTarget);

    foreach WorldInfo.AllPawns(class'UA3Pawn',P )
    {    
        if(P!=none)
        {
            loc = Canvas.Project(P.Location + P.hudpoint_offset);
            //`log("REDNER UI");
            //Right here is where you would offset your Loc, by default it will use the movieplayer's top left corner as the "origin".
            //P.PlayerBeacon.SetViewPort(loc.X,loc.Y+500,120*RatioX,120*RatioX);   //I multiplied it by RatioX because you want to scale it depending on the window size.
            if((P.PlayerIconHealth != none)){
                if(P != OwnerPlayer){
                    P.PlayerIconHealth.SetViewPort(loc.X,loc.Y,120*5,120*5);   //I multiplied it by RatioX because you want to scale it depending on the window size.
                }else{
                    P.PlayerIconHealth.SetViewPort(loc.X,loc.Y,0,0);//scale to 0
                }
            }
        }
    }
}
    
defaultproperties
{

}




