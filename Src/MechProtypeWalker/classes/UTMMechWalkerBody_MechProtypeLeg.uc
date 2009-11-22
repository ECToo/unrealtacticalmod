/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMMechWalkerBody_MechProtypeLeg extends UTMMechWalkerBody;


function PostBeginPlay()
{
	//local int Idx;

	super.PostBeginPlay();

	//EnergyBallMatInst = SkeletalMeshComponent.CreateAndSetMaterialInstanceConstant(1);
	//SetEnergyBallPowerPercent(0.f);

	// attach powerball light to the ball
	//SkeletalMeshComponent.AttachComponent(EnergyBallLight, BodyBoneName);

	// attach leg attach beam emitters to the ball
	/*
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		SkeletalMeshComponent.AttachComponent(LegAttachBeams[Idx], BodyBoneName);
	}
        */
	//SkeletalMeshComponent.AttachComponent(LegMesh, BodyBoneName);
	
	
	
	//Mesh.AttachComponentToSocket(AntennaMesh,'AntennaSocket');
	//WalkerVehicle.Mesh.AttachComponentToSocket(LegMesh, 'AntennaSocket');
	//WalkerVehicle.AttachComponentToSocket(LegMesh, 'AntennaSocket');

}

function Tick(float DeltaTime)
{
         super.Tick(DeltaTime);
         //WalkerVehicle.Mesh.AttachComponentToSocket(LegMesh, 'AntennaSocket');
         
         //`log('time');


         /*
	local float NewPowerPct, NewBrightness;
	local int Idx;
	local vector LegLocation;

	super.Tick(DeltaTime);

	// ball is powered on when driven, powered off otherwise
	GoalEnergyBallPowerPct = (WalkerVehicle.bDriving && !WalkerVehicle.bDeadVehicle) ? 1.f : 0.f;

	if (GoalEnergyBallPowerPct != CurrentEnergyBallPowerPct)
	{
		NewPowerPct = FInterpTo(CurrentEnergyBallPowerPct, GoalEnergyBallPowerPct, DeltaTime, EnergyBallPowerInterpSpeed);
		SetEnergyBallPowerPercent(NewPowerPct);
	}
	else if (WalkerVehicle.bDeadVehicle)
	{
		// this will fade light to zero after it gets to the zero-energy color
		NewBrightness = FInterpTo(EnergyBallLight.Brightness, 0.f, DeltaTime, EnergyBallPowerInterpSpeed);
		EnergyBallLight.SetLightProperties(NewBrightness);
		EnergyBallMatInst.SetScalarParameterValue(EnergyBallMaterialParameterName, 0.0f);
	}

	// set leg attach beam endpoints
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		LegLocation = SkeletalMeshComponent.GetBoneLocation(TopLegBoneName[Idx]);

		if( VSize(PreviousLegLocation[Idx] - LegLocation) > 1.0f )
		{
			//`log( "Ticking Walker PSC: " $ LegAttachBeams[Idx] );
			LegAttachBeams[Idx].SetVectorParameter(LegAttachBeamEndPointParamName, LegLocation );
			PreviousLegLocation[Idx] = LegLocation;
		}
	}
	*/
}


/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
/*
simulated function TeamChanged()
{
	local int LegIdx;
	local ParticleSystem PS_LegBeam;

	Super.TeamChanged();

	if( WalkerVehicle.GetTeamNum() == 1 )
	{
		PS_LegBeam=PS_LegBeamTemplate_Blue;
	}
	else
	{
		PS_LegBeam=PS_LegBeamTemplate;
	}

	for( LegIdx = 0; LegIdx < NUM_WALKER_LEGS; ++LegIdx )
	{
		LegAttachBeams[LegIdx].SetTemplate( PS_LegBeam );
	}

	SetEnergyBallPowerPercent( CurrentEnergyBallPowerPct );
}
*/
/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
simulated function SetBurnOut()
{
	Super.SetBurnOut();
}

defaultproperties
{
	//bHasCrouchMode=true

	Begin Object Name=LegMeshComponent
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.MechProtypeLeg'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.MechProtypeLeg_Physics'
		//AnimSets(0)=AnimSet'VH_DarkWalker.Anims.K_VH_DarkWalker_Legs'
		//AnimTreeTemplate=AnimTree'VH_DarkWalker.Anims.AT_VH_DarkWalker_Legs'
		//bUpdateJointsFromAnimation=TRUE
	End Object
	SkeletalMeshComponent=LegMeshComponent

}