/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license: CC (Give Credit -> Check readme.txt)
 */

/*
 * Mech Actions
-Walk
-Run
-Jump
-Hover
-Fly
-Jet Pack

 * Mech Part
-Head
-Back (jet pack / heavy weapon holder)
-Right Arm
-Right Shoulder (for add on weapon)
-Right Hand
-Left Arm
-Left Shoulder (for add on weapon)
-Left Hand
-Leg

 * Weapon -Range for animation action
-Light Weapon
-Meduim Weapon
-Heavy Weapon
-Sniper Weapon
-Special Weapon

 * Armor (Body Frame)
-Light Armor
-Meduim Armor
-Heavy Armor

 * Body Type
-Human -can only carry two weapon
-two walker -different parts
-transform
-Spider
-crawler
-Hover

 *
 */

class UTMMechPart extends Actor
      //placeable
      ;

/** Display name for this Mech Part. */
var localized string FriendlyName;
/** Description of this Mech Part. */
var localized string Description;

//var UTPlayerController Instigator; 

var UTMVMech_ProtypeWalker MechVehicle;

/** Animations */
var name GetInAnim[2];
var name GetOutAnim[2];
var name IdleAnim[2];
var name DeployAnim[2];

var name FireAnim[6];//idle, fire, alt fire, equip, unequip, meduim fire, heavy fire, sniper fire,
var name WalkActionAnim[8];

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

function weaponfire()
{

}

//This will deal vehicle parent // This add or remove damge to the parts that depend on how it coded.
function SetMechVehicle(UTMVMech_ProtypeWalker V)
{
	MechVehicle = V;
	Instigator = V.Instigator;
}


simulated function PlayAnim(name AnimName, optional float AnimDuration = 0.0f)
{
	local float AnimRate;
	if (AnimPlay != none && AnimName != '')
	{
	        `log('Playing Animation found');
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
	Mesh.PlayAnim(AnimName, 0.5f, false, true);//working code for animation

}


/*
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	PlayAnim( IdleAnim[0] );
}
*/

/**
 * Plays a Vehicle Animation
 */
simulated function PlayVehicleAnimation(name EventTag)
{
	local int i;
	local UTAnimNodeSequence Player;
        `log('PlayVehicleAnimation list');
	if ( Mesh != none && mesh.Animations != none && VehicleAnims.Length > 0 )
	{
         `log('Animation list' @ VehicleAnims.Length);
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


function mechtransform()
{

}

function mechdepart()
{

}

function BeginFire(){}

function EndFire(){}



defaultproperties
{
      Begin Object Class=SkeletalMeshComponent Name=MeshFrame
		//SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
		//ShadowParent = SVehicleMesh
		BlockRigidBody=false
		//LightEnvironment=MyLightEnvironment
		PhysicsWeight=0.0
		//TickGroup=TG_PostASyncWork
		//bUseAsOccluder=FALSE
		//CullDistance=1300.0
		//CollideActors=false
		bUpdateSkelWhenNotRendered=false
		//bIgnoreControllersWhenNotRendered=true
		//bAcceptsDecals=false
	End Object
	
	CollisionComponent=MeshFrame
	Mesh=MeshFrame
	Components.Add(MeshFrame)
}