/**
 *  Created by: Darknet
 *  svn:https://unrealtacticalmod.googlecode.com/svn/trunk/Src/DeployTurret
 */

class Turret extends Actor
      placeable;

//var rotator TurretPitch;
//var rotator TurretYaw;

//var SkeletalMeshComponent MeshGun;
//var SkeletalMeshComponent MeshBase;
var SkeletalMeshComponent Mesh;

var	float LastUpdateFreq;
var SkeletalMeshComponent MeshGun;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	//if ( bMovable || (Level.NetMode != NM_DedicatedServer && DrawType == DT_Mesh) )
	//if ( bMovable || (DrawType == DT_Mesh) )
	if ( bMovable )
        {
		SetTimer( 0.02 + FRand()*0.1, false);
	}
}

simulated function UpdateSwivelRotation( Rotator TurretRotation );

//function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	// Defer damage to Turret...
	if ( Owner.Role == Role_Authority && EventInstigator != Owner )
	{
		//log("ASTurret_Base::TakeDamage - Deferring damage to Pawn...");
		//Owner.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType) ;
		Owner.TakeDamage(DamageAmount,EventInstigator,HitLocation,Momentum,DamageType, HitInfo,DamageCauser);
	}
}

simulated event Timer()
{
	local float		UpdateFreq;

	UpdateFreq = 0.15;
	`log('timers');

	// hack to fix a hack :)
	if ( PlayerController(Vehicle(Owner).Controller) != None && PlayerController(Vehicle(Owner).Controller).ViewTarget != Owner )
		Vehicle(Owner).Controller = None;

	if ( Vehicle(Owner).Controller == None || PlayerController(Vehicle(Owner).Controller) == None 
		|| !Vehicle(Owner).IsLocallyControlled() )
	{
	        /*
		if ( Level.NetMode != NM_DedicatedServer && DrawType == DT_Mesh ){
			UpdateOverlay();
		}*/

		if ( bMovable ){
			UpdateSwivelRotation( Owner.Rotation );
		}

		if ( EffectIsRelevant(Location, true) ){
			UpdateFreq = 0.02;
		}
		else{
			UpdateFreq = 0.1;
                }
                /*
		if ( Level.bDropDetail || Level.DetailMode == DM_Low ){
			UpdateFreq += 0.02;
			}
			*/
	}
	// else Update is performed every frame from ASTurret.UpdateRocketAcceleration()
		
	LastUpdateFreq = UpdateFreq;
	SetTimer( UpdateFreq, false );
}

simulated function UpdateOverlay()
{
	//if ( Owner.OverlayMaterial != OverlayMaterial || Owner.OverlayTimer != OverlayTimer )
	//	SetOverlayMaterial( Owner.OverlayMaterial, Owner.OverlayTimer, false );
}


//360 rotation in unreal
simulated function Tick(float DeltaTime)
{
          super.Tick(DeltaTime);
          //`log('tick');
          //TurretPitch.Pitch += 100;
          //SetRotation(TurretPitch);
}

/*event Timer(){super.Timer();`log('TIMER');}*/

/**
//=================================================================================================
// This is for state and animation stuff
//=================================================================================================
*/

auto state Sleeping
{
	simulated event AnimEnd( int Channel )
	{
	        /*
		if ( ASVehicle_Sentinel(Owner).bActive )
			GotoState('Opening');
			`log('Opening state');
		else
			PlayAnim('IdleClosed', 4, 0.0);
			`log('IdleClosed state');
		*/
	}
        /*
	simulated function BeginState()
	{
		AnimEnd( 0 );
	}
	*/
}

state Active
{
/*
	simulated function BeginState()
	{
		LoopAnim('IdleOpen', 4, 0.0);
		`log('idle open state');
	}*/
}

state Opening
{
	simulated event AnimEnd( int Channel )
	{
		GotoState('Active');
		`log('Active state');
	}
        /*
	simulated function BeginState()
	{
		PlayAnim('Open', 0.33, 0.0);
		`log('Open state');
	}
	*/
}

state Closing
{       /*
	simulated function BeginState()
	{
		PlayAnim('Close', 0.33, 0.0);
		`log('Close state');
	}
	*/
}

/**
//=================================================================================================

//=================================================================================================
*/


defaultproperties
{

   Begin Object Class=SkeletalMeshComponent Name=MeshPart
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   Mesh=MeshPart
   Components.Add(MeshPart)
   
   DrawScale=1.0
	RemoteRole=Role_None
	bMovable=false
	bShouldBaseAtStartup=false
	bIgnoreEncroachers=true
	bCollideActors=true
	bBlockActors=true
	bCollideWorld=false

/*
    Begin Object Class=SkeletalMeshComponent Name=PartGun
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretGun'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretGun_Physics'
         Translation=(X=0.0,Y=0.0,Z=0.0)
   End Object
   MeshGun=PartGun
   Components.Add(PartGun)

   Begin Object Class=SkeletalMeshComponent Name=PartBase
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
         SkeletalMesh=PhysicsAsset'UTMTurret.TurretBase_Physics'
         Translation=(X=0.0,Y=0.0,Z=-28.0)
   End Object
   MeshBase=PartBase
   Components.Add(PartBase)

   Begin Object Class=SkeletalMeshComponent Name=MeshMain
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretStand_Physics'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   Mesh=MeshMain
   Components.Add(MeshMain)
   */
}




