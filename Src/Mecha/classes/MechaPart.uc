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
      
/*********************************************************************************************
 Damage Morphing
********************************************************************************************* */

struct FDamageMorphTargets
{
	/** These are used to reference the MorphNode that is represented by this struct */
	var	name MorphNodeName;

	/** Link to the actual node */
	var	MorphNodeWeight	MorphNode;

	/** These are used to reference the next node if this is at 0 health.  It can be none */
	var name LinkedMorphNodeName;

	/** Actual Node pointed to by LinkMorphNodeName*/
	var	int LinkedMorphNodeIndex;

	/** This holds the bone that influences this node */
	var Name InfluenceBone;

	/** This is the current health of the node.  If it reaches 0, then we should pass damage to the linked node */
	var	int Health;

	/** Holds the name of the Damage Material Scalar property to adjust when it takes damage */
	var array<name> DamagePropNames;

	structdefaultproperties
	{
		Health=1.0f;
	}
};

/** replicated information on a hit we've taken */
var UTPawn.UTTakeHitInfo LastTakeHitInfo;

var int Health;
var int HealthMax;
      
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

var array<MaterialList> SpawnMaterialLists;

/** Holds the Damage Morph Targets */
var	array<FDamageMorphTargets> DamageMorphTargets;

/** Holds the damage skel controls */
var array<UTSkelControl_Damage> DamageSkelControls;

/**
 * This is a reference to the Emitter we spawn on death.  We need to keep a ref to it (briefly) so we can
 * turn off the particle system when the vehicle decided to burnout.
 **/
var Emitter DeathExplosion;

/**
 * How long to wait after the InitialVehicleExplosion before doing the Secondary VehicleExplosion (if it already has not happened)
 * (e.g. due to the vehicle falling from the air and hitting the ground and doing it's secondary explosion that way).
 **/
var float TimeTilSecondaryVehicleExplosion;

/** class to spawn for blown off vehicle pieces */
var class<UTGib_Vehicle> VehiclePieceClass;


/** Templates used for explosions */
var ParticleSystem ExplosionTemplate;
var array<DistanceBasedParticleTemplate> BigExplosionTemplates;
/** Secondary explosions from vehicles.  (usually just dust when they are impacting something) **/
var ParticleSystem SecondaryExplosion;

/** socket to attach big explosion to (if 'None' it won't be attached at all) */
var name BigExplosionSocket;

//===============================================
// Sound effects
//===============================================

var SoundCue FireSound;
var SoundCue AltFireSound;
var SoundCue ReloadSound;
var SoundCue FireChargeSound;
var SoundCue ExplosionSound;
var SoundCue EquipSound;
var SoundCue UnEquipSound;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	//PlayAnim( IdleAnim[0] );
}

//===============================================
// Start Sound Play
//===============================================

/**
 * This function handles playing sounds for weapons.  How it plays the sound depends on the following:
 *
 * If we are a listen server, then this sound is played and replicated as normal
 * If we are a remote client, but locally controlled (ie: we are on the client) we play the sound and don't replicate it
 * If we are a dedicated server, play the sound and replicate it to everyone BUT the owner (he will play it locally).
 *
 *
 * @param	SoundCue	- The Source Cue to play
 */
simulated function WeaponPlaySound( SoundCue Sound, optional float NoiseLoudness )
{
	// if we are a listen server, just play the sound.  It will play locally
	// and be replicated to all other clients.
	if( Sound == None || Instigator == None )
	{
		return;
	}

	Instigator.PlaySound(Sound, false, true);
}
//===============================================
// End Sound Play
//===============================================


//===============================================
// Start  MuzzleFlash
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
// End  MuzzleFlash
//===============================================

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
 
 function AdjustWeaponAim();
 
 function AdjustArmAim();

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


/************************************************************************************
 * Morphs
 ***********************************************************************************/

/**
 * Initialize the damage modeling system
 */
simulated function InitializeMorphs()
{
	local int i,j;

	for (i=0;i<DamageMorphTargets.Length;i++)
	{
		// Find this node

		if(DamageMorphTargets[i].MorphNodeName != 'None')
		{
			DamageMorphTargets[i].MorphNode 	  = MorphNodeWeight( Mesh.FindMorphNode(DamageMorphTargets[i].MorphNodeName) );
			if (DamageMorphTargets[i].MorphNode == None)
			{
				`Warn("Failed to find Morph node named" @ DamageMorphTargets[i].MorphNodeName @ "in" @ Mesh.SkeletalMesh);
			}
		}

		// Fix up all linked references to this node.

		for (j=0;j<DamageMorphTargets.Length;j++)
		{
			if ( DamageMorphTargets[j].LinkedMorphNodeName == DamageMorphTargets[i].MorphNodeName )
			{
				DamageMorphTargets[j].LinkedMorphNodeIndex = i;
			}
		}
	}
	//InitDamageSkel();
}

/*
function PlayHit(float Damage, Controller InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum, TraceHitInfo HitInfo)
{
	local UTPlayerController Hearer;
	local class<UTDamageType> UTDamage;

	if (InstigatedBy != None && class<UTDamageType>(DamageType) != None && class<UTDamageType>(DamageType).default.bDirectDamage)
	{
		Hearer = UTPlayerController(InstigatedBy);
		if (Hearer != None)
		{
			Hearer.bAcuteHearing = true;
		}
	}
	//@todo FIXME: play vehicle hit sound here?
	//Super.PlayHit(Damage, InstigatedBy, HitLocation, DamageType, Momentum, HitInfo);
	if (Hearer != None)
	{
		Hearer.bAcuteHearing = false;
	}

	if (Damage > 0 || ((Controller != None) && Controller.bGodMode))
	{
		CheckHitInfo( HitInfo, Mesh, Normal(Momentum), HitLocation );

		LastTakeHitInfo.Damage = Damage;
		LastTakeHitInfo.HitLocation = HitLocation;
		LastTakeHitInfo.Momentum = Momentum;
		LastTakeHitInfo.DamageType = DamageType;
		LastTakeHitInfo.HitBone = HitInfo.BoneName;
		UTDamage = class<UTDamageType>(DamageType);
		LastTakeHitTimeout = WorldInfo.TimeSeconds + ( (UTDamage != None) ? UTDamage.static.GetHitEffectDuration(self, Damage)
									: class'UTDamageType'.static.GetHitEffectDuration(self, Damage) );

		PlayTakeHitEffects();
	}
}
*/

/** plays take hit effects; called from PlayHit() on server and whenever LastTakeHitInfo is received on the client */
simulated event PlayTakeHitEffects()
{
        /*
	local class<UTDamageType> UTDamage;

	if (EffectIsRelevant(Location, false))
	{
		UTDamage = class<UTDamageType>(LastTakeHitInfo.DamageType);
		if (UTDamage != None)
		{
			UTDamage.static.SpawnHitEffect(self, LastTakeHitInfo.Damage, LastTakeHitInfo.Momentum, LastTakeHitInfo.HitBone, LastTakeHitInfo.HitLocation);
		}
	}

	ApplyMorphDamage(LastTakeHitInfo.HitLocation, LastTakeHitInfo.Damage, LastTakeHitInfo.Momentum);
	ClientHealth -= LastTakeHitInfo.Damage;
	*/
}
/** called when the client receives a change to Health
 * if LastTakeHitInfo changed in the same received bunch, always called *after* PlayTakeHitEffects()
 * (this is so we can use the damage info first for more accurate modelling and only use the direct health change for corrections)
 */
simulated event ReceivedHealthChange()
{
	local int Diff;
        if (MechVehicle !=None){
           Diff = Health - MechVehicle.ClientHealth;
        }else{
           Diff = 0;
        }
	//Diff = Health - ClientHealth;
	if (Diff > 0)
	{
		ApplyMorphHeal(Diff);
	}
	else
	{
		ApplyRandomMorphDamage(Diff);
	}
	//ClientHealth = Health;

	//CheckDamageSmoke();
}


/**
 * Since vehicles can be healed, we need to apply the healing to each MorphTarget.  Since damage modeling is
 * client-side and healing is server-side, we evenly apply healing to all nodes
 *
 * @param	Amount		How much health to heal
 */
simulated event ApplyMorphHeal(int Amount)
{
	local int Individual, Total, Remaining;
	local int i;
	local float Weight;

	if (Health >= HealthMax)
	{
		// fully heal everything
		for (i = 0; i < DamageMorphTargets.length; i++)
		{
			DamageMorphTargets[i].Health = default.DamageMorphTargets[i].Health;
			if(DamageMorphTargets[i].MorphNode != none)
			{
				DamageMorphTargets[i].MorphNode.SetNodeWeight(0.0);
			}
		}
		for(i=0; i< DamageSkelControls.length; i++)
		{
			DamageSkelControls[i].RestorePart();
		}
	}
	else
	{
		// Find out the total amount of health needed for all nodes that have been "hurt"
		for ( i = 0; i < DamageMorphTargets.Length; i++)
		{
			if ( DamageMorphTargets[i].Health < Default.DamageMorphTargets[i].Health )
			{
				Total += Default.DamageMorphTargets[i].Health;
			}
		}

		// Deal out health evenly
		if (Amount > 0 && Total > 0)
		{
			Remaining = Amount;
			for (i = 0; i < DamageMorphTargets.length; i++)
			{
				Individual = Min( default.DamageMorphTargets[i].Health - DamageMorphTargets[i].Health,
						int(float(Amount) * float(Default.DamageMorphTargets[i].Health) / float(Total)) );
				DamageMorphTargets[i].Health += Individual;
				Remaining -= Individual;
			}

			// deal out any leftovers and update node weights
			for (i = 0; i < DamageMorphTargets.length; i++)
			{
				if (Remaining > 0)
				{
					Individual = Min(Remaining, default.DamageMorphTargets[i].Health - DamageMorphTargets[i].Health);
					DamageMorphTargets[i].Health += Individual;
					Remaining -= Individual;
				}
				Weight = 1.0 - (float(DamageMorphTargets[i].Health) / float(Default.DamageMorphTargets[i].Health));
				if(DamageMorphTargets[i].MorphNode != none)
				{
					DamageMorphTargets[i].MorphNode.SetNodeWeight(Weight);
				}
			}
		}

		// heal skel controls up one at a time.
		Total = 0;
		for( i = 0; i < DamageSkelControls.length; i++ )
		{
			if( Total < Amount)
			{
				Total += (1-DamageSkelControls[i].HealthPerc)*DamageSkelControls[i].DamageMax;
				// either we can cover the whole heal, or we fix the percentage left on this loop:
				DamageSkelControls[i].HealthPerc = Total<Amount?DamageSkelControls[i].RestorePart() : DamageSkelControls[i].HealthPerc + (float(Amount)-float(Total))/float(DamageSkelControls[i].DamageMax);
			}
			else
			{
				break;
			}
		}
	}

	//UpdateDamageMaterial();
}

/** called to apply morph damage where we don't know what was actually hit
 * (i.e. because the client detected it by receiving a new Health value from the server)
 */
simulated function ApplyRandomMorphDamage(int Amount)
{
	local int min, minindex;
	local int i;
	local float MinAmt;
	local float Weight;

	// Search for the skel control to damage (if any)
	for(i=0;i<DamageSkelControls.Length;i++)
	{
		if(DamageSkelControls[i].HealthPerc > 0 && minindex < 0)
		{
			MinAmt = FMin(Amount/(DamageSkelControls[i].DamageMax*DamageSkelControls.Length),DamageSkelControls[i].HealthPerc);
			DamageSkelControls[i].HealthPerc -= MinAmt;
		}
	}
	while (Amount > 0)
	{
		minindex = -1;

		// Search for the node with the least amount of health
		minindex=-1;
		for (i=0;i<DamageMorphTargets.Length;i++)
		{
			if ((DamageMorphTargets[i].Health > 0) && (minindex < 0 || DamageMorphTargets[i].Health < min))
			{
				min = DamageMorphTargets[i].Health;
				minindex = i;
			}
		}

		// Deal out damage to that node
		if (minindex>=0)
		{
			if (min < Amount)
			{
				DamageMorphTargets[minindex].Health = 0;
				Amount -= min;
			}
			else
			{
				DamageMorphTargets[minindex].Health -= Amount;
				Amount = 0;
			}

			// Adjust the target
			Weight = 1.0 - ( FLOAT(DamageMorphTargets[minindex].Health) / FLOAT(Default.DamageMorphTargets[minindex].Health) );
			if(DamageMorphTargets[minindex].MorphNode != none)
			{
				DamageMorphTargets[minindex].MorphNode.SetNodeWeight(Weight);
			}
		}
		else
		{
			break;
		}

	}

	//UpdateDamageMaterial();
}

/**
 * The event is called from the native function ApplyMorphDamage when a node is destroyed (health <= 0).
 *
 * @param	MorphNodeIndex 		The Index of the node that was destroyed
 */
simulated event MorphTargetDestroyed(int MorphNodeIndex);

/**
 * We use this function as the UTPawn's spawngib as for our vehicles we are spawning the gibs at specific locations based on the
 * skelcontrollers and the placement of meshes on the exterior of the vehicle
 **/
 /*
simulated function UTGib SpawnGibVehicle(vector SpawnLocation, rotator SpawnRotation, StaticMesh TheMesh, vector HitLocation, bool bSpinGib, vector ImpulseDirection, ParticleSystem PS_OnBreak, ParticleSystem PS_Trail)
{
	local UTGib_Vehicle Gib;
	local float GibPerterbation;
	local rotator VelRotation;
	local vector X, Y, Z;

	//`log("SpawnGibVehicle "$TheMesh);
	Gib = Spawn(VehiclePieceClass, self,, SpawnLocation, SpawnRotation,, TRUE );

	if ( Gib != None )
	{
		Gib.SetGibStaticMesh( TheMesh );
		//Gib.SetCollision( FALSE, FALSE, TRUE );
		Gib.GibMeshComp.SetBlockRigidBody( FALSE );
		Gib.GibMeshComp.SetRBChannel( RBCC_Nothing ); // nothing will request to collide with us
	// @todo make a RBChannelContainer function to do all this
		Gib.GibMeshComp.SetRBCollidesWithChannel( RBCC_Default, FALSE );
		Gib.GibMeshComp.SetRBCollidesWithChannel( RBCC_Pawn, FALSE );
		Gib.GibMeshComp.SetRBCollidesWithChannel( RBCC_Vehicle, FALSE );
		Gib.GibMeshComp.SetRBCollidesWithChannel( RBCC_GameplayPhysics, FALSE );
		Gib.GibMeshComp.SetRBCollidesWithChannel( RBCC_EffectPhysics, FALSE );

		Gib.SetTimer( 0.100f, FALSE, 'TurnOnCollision' );

		// add initial impulse
		GibPerterbation = 30000;
		VelRotation = rotator(Gib.Location - HitLocation);
		VelRotation.Pitch += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
		VelRotation.Yaw += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
		VelRotation.Roll += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
		GetAxes(VelRotation, X, Y, Z);

		// use the passed in impulse dir if it is decently big enough
		if( VSize(ImpulseDirection) > 100.0f )
		{
			Gib.Velocity = Velocity + ImpulseDirection;
		}
		else
		{
			if( VSize(Velocity) > 10.0f )
			{
				Gib.Velocity = Velocity + (Z * ( FRand() * 100 )) + vect(0,0,1000);
			}
			else
			{
				Gib.Velocity = (vect(1,0,0) * ( (FRand() * 400) ) )
					+ (vect(0,1,0) * ( (FRand() * 400) ) )
					+ (Z * ( FRand() * 300 )) + vect(0,0,1000);
			}
		}


		Gib.GibMeshComp.WakeRigidBody();
		Gib.GibMeshComp.SetRBLinearVelocity( Gib.Velocity, FALSE );

		if( bSpinGib )
		{
			Gib.GibMeshComp.SetRBAngularVelocity( VRand() * 500, FALSE );
		}

		Gib.LifeSpan = Gib.LifeSpan + (2.0 * FRand());

		Gib.OwningClass = Class;


		if( PS_OnBreak != none )
		{
			Gib.PS_GibExplosionEffect = PS_OnBreak;
		}

		if( PS_Trail != none )
		{
			Gib.PS_GibTrailEffect = PS_Trail;
		}

		Gib.SetTimer( class'UTGib_Vehicle'.default.TimeBeforeGibExplosionEffect, FALSE, 'ActivateGibExplosionEffect' );
	}

	return Gib;
}
*/

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
        
        //=======================================
        // sounds
        //=======================================
	//FireSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
	FireSound=None
        AltFireSound=None
        ReloadSound=None
        FireChargeSound=None
        ExplosionSound=None
        EquipSound=None
        UnEquipSound=None

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
	
	//not yet work on
	//DamageMorphTargets(0)=()
}
