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

var bool bActionWalk;
var bool bAnimationFire;
var bool bTransform;

var bool bFlyMode;

//weapon code
var bool bWeaponDestory;
var bool bWeaponDisable;
var bool bDeplopyAmmo;
var bool bCounterMeasure;

var string WalkName;

/** The pawn's light environment */
var DynamicLightEnvironmentComponent LightEnvironment;

struct native VehicleAnim
{
	/** Used to look up the animation */
	var() name AnimTag;

	/** Animation Sequence sets to play */
	var() array<name> AnimSeqs;

	/** Rate to play it at */
	var() float AnimRate;

	/** Does it loop */
	var() bool bAnimLoopLastSeq;

	/**  The name of the UTAnimNodeSequence to use */
	var() name AnimPlayerName;
};

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

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	//PlayAnim( IdleAnim[0] );
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

defaultproperties
{

      bWeaponDisable=false;
      bActionWalk=false;

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
	End Object
	
	CollisionComponent=MeshFrame
	Mesh=MeshFrame
	Components.Add(MeshFrame)
}
