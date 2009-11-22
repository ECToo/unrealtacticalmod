/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMMechWalkerBody extends Actor
	//native(Vehicle)
	//abstract
	placeable;

/** Skel mesh for the legs. */
//var() /*const*/ editconst SkeletalMeshComponent	SkeletalMeshComponent;
var SkeletalMeshComponent	SkeletalMeshComponent;



/** Ref to the walker vehicle that we are attached to. */
var transient UTMVehicle_MechWalker WalkerVehicle;

var protected const bool	bHasCrouchMode;
var	bool			bIsDead;

/*
  Custom code here
*/

//var SkeletalMeshComponent LegMesh;



function PostBeginPlay()
{
	//local int Idx;

	super.PostBeginPlay();

	// make sure the rb is awake //make the bones come to life
	//SkeletalMeshComponent.WakeRigidBody();
}

simulated function UpdateShadowSettings(bool bWantShadow)
{
	local bool bNewCastShadow, bNewCastDynamicShadow;

	if (SkeletalMeshComponent != None)
	{
		bNewCastShadow = default.SkeletalMeshComponent.CastShadow && bWantShadow;
		bNewCastDynamicShadow = default.SkeletalMeshComponent.bCastDynamicShadow && bWantShadow;
		if (bNewCastShadow != SkeletalMeshComponent.CastShadow || bNewCastDynamicShadow != SkeletalMeshComponent.bCastDynamicShadow)
		{
			SkeletalMeshComponent.CastShadow = bNewCastShadow;
			SkeletalMeshComponent.bCastDynamicShadow = bNewCastDynamicShadow;
			// defer if we can do so without it being noticeable
			if (LastRenderTime < WorldInfo.TimeSeconds - 1.0)
			{
				SetTimer(0.1 + FRand() * 0.5, false, 'ReattachMesh');
			}
			else
			{
				ReattachMesh();
			}
		}
	}
}

/** reattaches the mesh component, because settings were updated */
simulated function ReattachMesh()
{
	DetachComponent(SkeletalMeshComponent);
	AttachComponent(SkeletalMeshComponent);
}

/* epic ===============================================
* ::StopsProjectile()
*
* returns true if Projectiles should call ProcessTouch() when they touch this actor
*/
simulated function bool StopsProjectile(Projectile P)
{
	// Don't block projectiles fired from this vehicle
	return (P.Instigator != WalkerVehicle) && (bProjTarget || bBlockActors);
}

/** Called once to set up legs. */
//native function InitFeet();

/** Called on landing to reestablish a foothold */
//native function InitFeetOnLanding();

function SetWalkerVehicle(UTMVehicle_MechWalker V)
{
	WalkerVehicle = V;
	SkeletalMeshComponent.SetShadowParent(WalkerVehicle.Mesh);
	//SkeletalMeshComponent.SetLightEnvironment(LegLightEnvironment);
	WalkerVehicle.Mesh.AttachComponentToSocket(SkeletalMeshComponent, 'AntennaSocket');
	//WalkerVehicle.Mesh.AttachComponentToSocket(LegMesh,'AntennaSocket');
	`log('ADDDDDDDDDDDDDDDDDDDDDDD');
	//InitFeet();
}

event PlayFootStep(int LegIdx)
{
        /*
	local AudioComponent AC;
	local UTPhysicalMaterialProperty PhysicalProperty;
	local int EffectIndex;

	local vector HitLoc,HitNorm,TraceLength;
	local TraceHitInfo HitInfo;


	if (FootStepEffects.Length == 0)
	{
		return;
	}


	// figure out what we landed on

	TraceLength = vector(QuatToRotator(SkeletalMeshComponent.GetBoneQuaternion(FootBoneName[LegIdx])))*5.0;
	//Trace(HitLoc,HitNorm, CurrentFootPosition[LegIdx]+TraceLength,CurrentFootPosition[LegIdx],true,,HitInfo);
	Trace(HitLoc,HitNorm, CurrentFootPosition[LegIdx]-TraceLength,CurrentFootPosition[LegIdx]-TraceLength*4.0,true,,HitInfo);
	if(HitInfo.PhysMaterial != none)
	{
		PhysicalProperty = UTPhysicalMaterialProperty(HitInfo.PhysMaterial.GetPhysicalMaterialProperty(class'UTPhysicalMaterialProperty')); //(StepAnimData[LegIdx].DesiredFootPosPhysMaterial.GetPhysicalMaterialProperty(class'UTPhysicalMaterialProperty'));
	}
	if (PhysicalProperty != None)
	{
		EffectIndex = FootStepEffects.Find('MaterialType', PhysicalProperty.MaterialType);
		if (EffectIndex == INDEX_NONE)
		{
			EffectIndex = 0;
		}
		// Footstep particle
		if (FootStepEffects[EffectIndex].ParticleTemplate != None && EffectIsRelevant(Location, false))
		{
			if (FootStepParticles[LegIdx] == None)
			{
				FootStepParticles[LegIdx] = new(self) class'UTParticleSystemComponent';
				FootStepParticles[LegIdx].bAutoActivate = false;
				SkeletalMeshComponent.AttachComponent(FootStepParticles[LegIdx], FootBoneName[LegIdx]);
			}
			FootStepParticles[LegIdx].SetTemplate(FootStepEffects[EffectIndex].ParticleTemplate);
			FootStepParticles[LegIdx].ActivateSystem();
		}
	}

	AC = WorldInfo.CreateAudioComponent(FootStepEffects[EffectIndex].Sound, false, true);
	if (AC != None)
	{
		AC.bUseOwnerLocation = false;

		// play it closer to the player if he's controlling the walker
		AC.Location = (PlayerController(WalkerVehicle.Controller) != None) ? 0.5 * (Location + CurrentFootPosition[LegIdx]) : CurrentFootPosition[LegIdx];

		AC.bAutoDestroy = true;
		AC.Play();
	}
	//WalkerVehicle.TookStep(LegIdx);
	*/
}


/**
 * Default behavior when shot is to apply an impulse and kick the KActor.
 */
event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local vector ApplyImpulse;

	if (damageType.default.KDamageImpulse > 0 )
	{
		if ( VSize(momentum) < 0.001 )
		{
			`Log("Zero momentum to KActor.TakeDamage");
			return;
		}

		// Make sure we have a valid TraceHitInfo with our SkeletalMesh
		// we need a bone to apply proper impulse
		CheckHitInfo( HitInfo, SkeletalMeshComponent, Normal(Momentum), hitlocation );

		ApplyImpulse = Normal(momentum) * damageType.default.KDamageImpulse;
		if ( HitInfo.HitComponent != None )
		{
			HitInfo.HitComponent.AddImpulse(ApplyImpulse, HitLocation, HitInfo.BoneName);
		}
	}
}


function PlayDying()
{

}


function AddVelocity( vector NewVelocity, vector HitLocation,class<DamageType> DamageType, optional TraceHitInfo HitInfo )
{
/*
	if ( !IsZero(NewVelocity) )
	{
		if (Location.Z > WorldInfo.StallZ)
		{
			NewVelocity.Z = FMin(NewVelocity.Z, 0);
		}
		NewVelocity = DamageType.Default.VehicleMomentumScaling * DamageType.Default.KDamageImpulse * Normal(NewVelocity);
		SkeletalMeshComponent.AddImpulse(NewVelocity, HitLocation);
	}
*/
}

state DyingVehicle
{
	event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
	{
		if ( DamageType == None )
			return;
		AddVelocity(Momentum, HitLocation, DamageType, HitInfo);
	}
}

simulated function TeamChanged()
{

}

simulated function SetBurnOut()
{

}


defaultproperties
{
	TickGroup=TG_PostAsyncWork

	Physics=PHYS_RigidBody

	bEdShouldSnap=true
	bStatic=false
	bCollideActors=true
	bBlockActors=false
	bWorldGeometry=false
	bCollideWorld=false
	bProjTarget=true
	bIgnoreEncroachers=true
	bNoEncroachCheck=true

	RemoteRole=ROLE_None

	Begin Object Class=SkeletalMeshComponent Name=LegMeshComponent
	        SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.MechProtypeLeg'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.MechProtypeLeg_Physics'
		CollideActors=true
		BlockActors=false
		BlockZeroExtent=true
		BlockNonZeroExtent=true
		PhysicsWeight=1
		bHasPhysicsAssetInstance=true
		BlockRigidBody=false
		RBChannel=RBCC_Nothing
		RBCollideWithChannels=(Default=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE)
		bUseAsOccluder=FALSE
		bUpdateSkelWhenNotRendered=true
		bIgnoreControllersWhenNotRendered=true
		bAcceptsDecals=false
		bUseCompartment=FALSE
		//LightEnvironment=LegLightEnvironmentComp
	End Object
	CollisionComponent=LegMeshComponent
	SkeletalMeshComponent=LegMeshComponent
	Components.Add(LegMeshComponent)

	//BodyBoneName=Root
	//BodyBoneName=BodyRoot
	//CustomGravityScale=0.f
}