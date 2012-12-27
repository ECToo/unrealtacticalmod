/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class UA3Pawn extends UDKPawn placeable;

var SkeletalMeshComponent CharMesh;
var GfxHealthBarUI PlayerIconHealth;
var vector hudpoint_offset;

var float CamOffsetDistance; //distance to offset the camera from the player in unreal units 
var float CamMinDistance, CamMaxDistance; 
var float CamZoomTick; //how far to zoom in/out per command 
var float CamHeight; //how high cam is relative to pawn pelvis 

var AnimNodeSequence AnimPlay;
var name ActionName;

/** Slot node used for playing full body anims. */
//var AnimNodeSlot FullBodyAnimSlot;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super.PostInitAnimTree(SkelComp);
    //AimNode.bForceAimDir = true; //forces centercenter
    
    //FullBodyAnimSlot = AnimNodeSlot(Mesh.FindAnimNode('FullBodySlot'));
    /*
    AnimPlay = AnimNodeSequence( CharMesh.Animations.FindAnimNode('AnimPlayer') );
    //`log("INIT PAWN.....................");
    if(AnimPlay != none){
        `log('FOUND ANIMATIONS');
        AnimPlay.SetAnim(ActionName);
        AnimPlay.PlayAnim(false, 1.0f, AnimPlay.AnimSeq.SequenceLength);
    }else{
        `log('NO ANIMATIONS');
    }
    */
}

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    `log("INIT PAWN.....................");
    initcharmesh();
    CreatePlayerHUD();
}

//override to make player mesh visible by default 
simulated event BecomeViewTarget( PlayerController PC ) 
{ 
    local UTPlayerController UTPC; 

    Super.BecomeViewTarget(PC); 

    if (LocalPlayer(PC.Player) != None) 
    { 
        UTPC = UTPlayerController(PC); 
        if (UTPC != None) 
        { 
            //set player controller to behind view and make mesh visible 
            UTPC.SetBehindView(true); 
            //SetMeshVisibility(UTPC.bBehindView); 
         
            //Show Crosshair = false, hide = true 
            UTPC.bNoCrosshair = false; 
        } 
    } 
} 
//orbit cam, follows player controller rotation 
simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV ) 
{ 
    local vector HitLoc,HitNorm, End, Start, vecCamHeight; 

    vecCamHeight = vect(-20,20,0); 
    vecCamHeight.Z = CamHeight; 
    Start = Location; 
    End = (Location+vecCamHeight)-(Vector(Controller.Rotation) * CamOffsetDistance);  //cam follow behind player controller 
    out_CamLoc = End; 

    //trace to check if cam running into wall/floor 
    if(Trace(HitLoc,HitNorm,End,Start,false,vect(12,12,12))!=none) 
    { 
        out_CamLoc = HitLoc + vecCamHeight; 
    } 

   return true; 
} 

simulated function CamZoomIn() 
{ 
    if(CamOffsetDistance > CamMinDistance)        CamOffsetDistance-=CamZoomTick; 
} 

simulated function CamZoomOut() 
{ 
    if(CamOffsetDistance < CamMaxDistance)     CamOffsetDistance+=CamZoomTick; 
} 

function initcharmesh(){
    if(CharMesh !=none){
        //AttachComponent(CharMesh);//attach to actor Component
        AttachComponent(CharMesh);//attach to actor Component
    }
}

simulated function CreatePlayerHUD()
{
    `log("INIT HEALTH UI...............");
    PlayerIconHealth = new class'GfxHealthBarUI';
    PlayerIconHealth.SetTimingMode(TM_Real);
    PlayerIconHealth.Init();
    PlayerIconHealth.start();
}

function HealthBarDisaply(bool _hide){
    if(PlayerIconHealth != None){
        PlayerIconHealth.HealthBarDisplay(_hide);
    }
}

defaultproperties
{
    ActionName=Idle
    CamHeight = 50.0 
    CamMinDistance = 60.0 
    CamMaxDistance = 350.0 
    CamOffsetDistance=250.0
    CamZoomTick=20.0  
    
    //BaseEyeHeight=+00032.000000
    BaseEyeHeight=+00042.000000

    hudpoint_offset = (X=0,Y=0,Z=48)
    Begin Object class=SkeletalMeshComponent Name=MeshFrame
        SkeletalMesh=SkeletalMesh'UDKAS3_Chars.base_male'
        PhysicsAsset=PhysicsAsset'UDKAS3_Chars.base_male_Physics'
        AnimTreeTemplate=AnimTree'UDKAS3_Chars.base_male_animtree'
        AnimSets(0)=AnimSet'UDKAS3_Chars.base_gender_anim'
        Rotation=(pitch=0,yaw=-16384,roll=0)
    End Object
    CharMesh=MeshFrame
    Components.Add(MeshFrame)
    
    //Begin Object Class=SpriteComponent Name=Sprite
	Begin Object Name=Sprite
        //Sprite=Texture2D'CustomHUD.icon_interface_panel'
        Sprite=Texture2D'CustomHUD.icon_pawn'
        HiddenGame=true
        AlwaysLoadOnClient=False
        AlwaysLoadOnServer=False
    End Object
    //Components.Add(Sprite)
    /*
    //Begin Object Class=CylinderComponent Name=CollisionCylinder
    Begin Object Name=CollisionCylinder
        CollisionRadius=+0034.000000
        CollisionHeight=+0078.000000
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        BlockActors=true
        CollideActors=true
    End Object
    */
}


