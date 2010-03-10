/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/Mecha/classes/
 * license: CC (Give Credit -> Check readme.txt)
 
 Information: This is on going test and it is Alpha Stage. The coding is not finall yet.

Weapon System:
There will be weapon system build in for mech parts class. But it depend how it is coded for this class.

CounterMeasure:
This will deal with Counter incoming missles and other things.

Crawler, Walker, Spider:
This will be base on the type leg system that will be build some how.

Transform:
This deal with mech transform or change mech stance. While in animaton or type mode.

TO DO LIST:
-Animations
-Weapons
-State idle
-Skeleton mesh
-Morph Damage
-Animtree
-Socket Build
-Part stats

Need to setup animation nodes and other animation code to make the mecha parts work.

//===============================================

Rotation=(Yaw=-16384)
16384 = 45 degree

*/

class MechaPart extends Actor
      //placeable
      ;
      
var string bodypart;
var string bodytype;
var	bool	bIsDead;
var	bool     BInternalWeapon;

var bool bActionWalk;
var bool bAnimationFire;
var bool bTransform;

var bool bFlyMode;

//weapon code
var bool bWeaponDestory;
var bool bWeaponDisable;
var bool bDeplopyAmmo;
var bool bCounterMeasure;

//
var Actor TargetActor;

var string WalkName;

/** The pawn's light environment */
var DynamicLightEnvironmentComponent LightEnvironment;

/** Display name for this Mech Part. */
var localized string FriendlyName;
/** Description of this Mech Part. */
var localized string Description;

//var UTPlayerController Instigator; 

var VehicleMecha MechVehicle;

/** Animations */
var name GetInAnim[2];
var name GetOutAnim[2];
var name IdleAnim[2];
var name DeployAnim[2];

var name FireAnim[6];//idle, fire, alt fire, equip, unequip, meduim fire, heavy fire, sniper fire,
var name WalkActionAnim[8];

/** Holds a list of vehicle animations */
var(Effects) array<VehicleAnim>	VehicleAnims;

var SkeletalMeshComponent Mesh;

/** Helper to allow quick access to playing deploy animations */
var AnimNodeSequence	AnimPlay;

/** Holds the name of the socket to attach a muzzle flash too */
var name	MuzzleFlashSocket;

/** Allow for multiple muzzle flash sockets **FIXME: will become offsets */
var array<name> MuzzleFlashSocketList;

/** Holds a list of emitters that make up the muzzle flash */
var array<UTParticleSystemComponent> MuzzleFlashPSCList;
var class<UTParticleSystemComponent> MuzzleFlashPS;
/** Muzzle flash PSC and Templates*/
var UTParticleSystemComponent	MuzzleFlashPSC;

/** dynamic light */
var	UDKExplosionLight		MuzzleFlashLight;
/** dynamic light class */
var class<UDKExplosionLight> MuzzleFlashLightClass;

/** Normal Fire and Alt Fire Templates */
var ParticleSystem			MuzzleFlashPSCTemplate, MuzzleFlashAltPSCTemplate;

/** Whether muzzleflash has been initialized */
var bool					bMuzzleFlashAttached;

/** Set this to true if you want the flash to loop (for a rapid fire weapon like a minigun) */
var bool					bMuzzleFlashPSCLoops;

/** How long the Muzzle Flash should be there */
var() float					MuzzleFlashDuration;
/** If true, always show the muzzle flash even when the weapon is hidden. */
var bool					bShowAltMuzzlePSCWhenWeaponHidden;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	//PlayAnim( IdleAnim[0] );
}
//===============================================
//  MuzzleFlash
//===============================================

/**
 * Turns the MuzzleFlashlight off
 */
simulated event MuzzleFlashTimer()
{
	if (MuzzleFlashPSC != none && (!bMuzzleFlashPSCLoops) )
	{
		MuzzleFlashPSC.DeactivateSystem();
	}
}


/**
 * Causes the muzzle flashlight to turn on
 */
simulated event CauseMuzzleFlashLight()
{
	if ( WorldInfo.bDropDetail )
		return;

	if ( MuzzleFlashLight != None )
	{
		MuzzleFlashLight.ResetLight();
	}
	else if ( MuzzleFlashLightClass != None )
	{
		MuzzleFlashLight = new(Outer) MuzzleFlashLightClass;
		Mesh.AttachComponentToSocket(MuzzleFlashLight,MuzzleFlashSocket);
	}
}

simulated event StopMuzzleFlash()
{
	ClearTimer('MuzzleFlashTimer');
	MuzzleFlashTimer();

	if ( MuzzleFlashPSC != none )
	{
		MuzzleFlashPSC.DeactivateSystem();
	}
}


/**
 * Called on a client, this function Attaches the WeaponAttachment
 * to the Mesh.
 */
simulated function AttachMuzzleFlash()
{
	//local SkeletalMeshComponent SKMesh;
	
	// Attach the Muzzle Flash
	bMuzzleFlashAttached = true;
	//SKMesh = Mesh;
	//`log("spawn flash muzzle");
	if (  Mesh != none )
	{
		if ( (MuzzleFlashPSCTemplate != none) || (MuzzleFlashAltPSCTemplate != none) )
		{
			MuzzleFlashPSC = new(Outer) class'UTParticleSystemComponent';
			MuzzleFlashPSC.bAutoActivate = false;
			//MuzzleFlashPSC.SetDepthPriorityGroup(SDPG_Foreground);
			//MuzzleFlashPSC.SetFOV(UDKSkeletalMeshComponent(Mesh).FOV);
			Mesh.AttachComponentToSocket(MuzzleFlashPSC, MuzzleFlashSocket);
			//`log("display");
		}
	}
	//`log("end flash muzzle");

}

/**
 * Remove/Detach the muzzle flash components
 */
simulated function DetachMuzzleFlash()
{
	//local SkeletalMeshComponent SKMesh;

	bMuzzleFlashAttached = false;
	//SKMesh = Mesh;
	if (  Mesh != none )
	{
		if (MuzzleFlashPSC != none)
			Mesh.DetachComponent( MuzzleFlashPSC );
	}
	MuzzleFlashPSC = None;
}


/**
 * Causes the muzzle flash to turn on and setup a time to
 * turn it back off again.
 */
simulated event CauseMuzzleFlash()
{
	local ParticleSystem MuzzleTemplate;
	//local UTPawn P;
	
	/*
	if ( WorldInfo.NetMode != NM_Client )
	{
		P = UTPawn(MechVehicle.Instigator);
		if ( (P == None) || !P.bUpdateEyeHeight )
		{
			return;
		}
	}
	*/

        if((MuzzleFlashAltPSCTemplate != None)){
		if ( !bMuzzleFlashAttached )
		{
			AttachMuzzleFlash();
		}
		if (MuzzleFlashPSC != None)
		{
			if (!bMuzzleFlashPSCLoops || (!MuzzleFlashPSC.bIsActive || MuzzleFlashPSC.bWasDeactivated))
			{
				if (Instigator != None && MuzzleFlashAltPSCTemplate != None)
				{
					MuzzleTemplate = MuzzleFlashAltPSCTemplate;

					// Option to not hide alt muzzle
					MuzzleFlashPSC.SetIgnoreOwnerHidden(bShowAltMuzzlePSCWhenWeaponHidden);

				}
				else if (MuzzleFlashPSCTemplate != None)
				{
					MuzzleTemplate = MuzzleFlashPSCTemplate;
				}
				if (MuzzleTemplate != MuzzleFlashPSC.Template)
				{
					MuzzleFlashPSC.SetTemplate(MuzzleTemplate);
				}
				//SetMuzzleFlashParams(MuzzleFlashPSC);
				MuzzleFlashPSC.ActivateSystem();
			}
		}

		// Set when to turn it off.
		SetTimer(MuzzleFlashDuration,false,'MuzzleFlashTimer');
		
          }
}

//===============================================
// Walk Code Animation and Control
//===============================================

function BeginActionWalk();
function EndActionWalk();
function DirectionWalk(String dirname);

//===============================================
// Weapon Code
// It depend if there weapon mount on the part
//===============================================

 function BeginFire();
 function EndFire();
 function weaponfire();

//===============================================
// Weapon Function
//===============================================
function ToggleDisableWeapon(){}
function DestroyWeapon(){}//when the part is reach health it disable some functions


//===============================================
//
//===============================================

//This will deal vehicle parent // This add or remove damge to the parts that depend on how it coded.
function SetMechVehicle(VehicleMecha V)
{
	MechVehicle = V;
	Instigator = V.Instigator;
}

//===============================================
//
//===============================================

simulated function PlayAnim(name AnimName, optional float AnimDuration = 0.0f)
{
	local float AnimRate;
	if (AnimPlay != none && AnimName != '')
	{
	        //`log('Playing Animation found');
		AnimRate = 1.0f;
		AnimPlay.SetAnim(AnimName);
		AnimPlay.PlayAnim(false, AnimRate, AnimPlay.AnimSeq.SequenceLength);
		/*
		if(AnimPlay.AnimSeq != none)
		{
		        `log('Playing Animation test');
			if (AnimDuration > 0.0f)
			{
				AnimRate = AnimPlay.AnimSeq.SequenceLength / AnimDuration;
			}
			AnimPlay.PlayAnim(false, AnimRate, 0.0);
		}
		*/
	}
	//Mesh.PlayAnim('Walk', 1, false, true);//working code for animation
	Mesh.PlayAnim('Walk', 1, true, false);//working code for animation
}

/**
 * Plays a Vehicle Animation
 */
simulated function PlayVehicleAnimation(name EventTag)
{
	local int i;
	local UTAnimNodeSequence Player;
        //`log('PlayVehicleAnimation list');
	if ( Mesh != none && mesh.Animations != none && VehicleAnims.Length > 0 )
	{
         //`log('Animation list' @ VehicleAnims.Length);
		for (i=0;i<VehicleAnims.Length;i++)
		{
			if (VehicleAnims[i].AnimTag == EventTag)
			{
				Player = UTAnimNodeSequence(Mesh.Animations.FindAnimNode(VehicleAnims[i].AnimPlayerName));
				if ( Player != none )
				{
					Player.PlayAnimationSet( VehicleAnims[i].AnimSeqs,
												VehicleAnims[i].AnimRate,
												VehicleAnims[i].bAnimLoopLastSeq );
				}
			}
		}
	}
}

function playanimationtest(){
      `log('Play Animation test');
      //PlayAnim( 'walk' );
      //Mesh.Animations.AnimationSet('Walk',1.0f,false);
}


function mechtransform();
function mechdepart();

event Destroyed()
{
	Super.Destroyed();
        `log("delete me please");
        PlayDying();
}

function PlayDying()
{
	//local int i;

	Lifespan = 8.0;
	//CustomGravityScale = 1.5;
	bCollideWorld = true;
	bIsDead = true;

	Mesh.SetTraceBlocking(true, false);
	Mesh.SetBlockRigidBody(true);
	Mesh.SetShadowParent(None);
}

defaultproperties
{
       	MuzzleFlashSocket=MuzzleFlashSocket
	bShowAltMuzzlePSCWhenWeaponHidden=TRUE
       	bMuzzleFlashPSCLoops=false
       	MuzzleFlashLightClass=class'UTGame.UTLinkGunMuzzleFlashLight'
       	MuzzleFlashDuration=0.33
       	//MuzzleFlashPSCTemplate=WP_RocketLauncher.Effects.P_WP_RockerLauncher_Muzzle_Flash
       	//MuzzleFlashAltPSCTemplate=ParticleSystem'WP_LinkGun.Effects.P_FX_LinkGun_MF_Beam'
        MuzzleFlashPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt
        MuzzleFlashAltPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt


	bWeaponDisable=false
	bActionWalk=false
        BInternalWeapon=false
	
	//bBlockActors=True
	bCollideActors=true

	bStatic=false
	bNoDelete=False
	bProjTarget=true
	
	//RemoteRole=ROLE_None

	//Physics=PHYS_RigidBody
	  
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		ModShadowFadeoutTime=0.25
		MinTimeBetweenFullUpdates=0.2
		AmbientGlow=(R=.01,G=.01,B=.01,A=1)
		AmbientShadowColor=(R=0.15,G=0.15,B=0.15)
		LightShadowMode=LightShadow_ModulateBetter
		ShadowFilterQuality=SFQ_High
		bSynthesizeSHLight=TRUE
	End Object
	LightEnvironment=MyLightEnvironment
	Components.Add(MyLightEnvironment)

	Begin Object Class=SkeletalMeshComponent Name=MeshFrame
		CastShadow=true
		bCastDynamicShadow=true
		//LightEnvironment=MyLightEnvironment
		bOverrideAttachmentOwnerVisibility=true
		bAcceptsDynamicDecals=FALSE
		bAllowAmbientOcclusion=false
		CollideActors=true
		BlockActors=true
		BlockZeroExtent=true
		BlockNonZeroExtent=true
	End Object
	CollisionComponent=MeshFrame
	Mesh=MeshFrame
	Components.Add(MeshFrame)
}
