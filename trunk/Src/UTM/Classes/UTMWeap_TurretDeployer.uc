class UTMWeap_TurretDeployer extends UTWeapon;

var StaticMeshComponent MeshPointer;

var bool bDeploying;

/*
simulated state WeaponFiring
{

}
*/


simulated function InstantFire()
{
 `log('InstantFire');

}

simulated function StartFire(byte FireModeNum)
{
        `log('StartFire');
	Super.StartFire(FireModeNum);
	DeployTurret();
}

//Don't use ammo this way, consume it directly from the fire modes using AddAmmo instead.
function ConsumeAmmo(byte FireModeNum){}



function DeployTurret(){


}



/**
 * Drop ammo instead of weapon.
 */
function DropFrom(Vector StartLocation, Vector StartVelocity)
{

}


/**
 * State entered when primary fire held. Pressing secondary fire in this state does the appropriate action (deploy, open upgrade menu).
 */
simulated state DeployState
{
        simulated function BeginState(Name PreviousStateName)
	{
		bDeploying = false;

		if(Instigator.IsHumanControlled())
		{
			if(Instigator.IsLocallyControlled())
			{
				//SymbolComponent.SetHidden(false);
			}
		}
		else if(Role == ROLE_Authority)
		{
			//Bots just deploy straight away. Upgrading is done elsewhere for them.
			bDeploying = true;
			//IncrementFlashCount(); //So animations play.
			//SetTimer(GetFireInterval(0), true, 'RefireCheckTimer'); //Ensure refiring prevented for the appropriate period.
			//BotDeploy();
			//Bot.StopFiring();
		}
	}

	simulated function BeginFire(byte FireModeNum)
	{
		global.BeginFire(FireModeNum);
		
		if(FireModeNum == 1 && !bDeploying)
		{
			bDeploying = true;
			//IncrementFlashCount(); //So animations play.
			//SetTimer(GetFireInterval(0), true, 'RefireCheckTimer'); //Ensure refiring prevented for the appropriate period.

			//if(!TryOpenUpgradeMenu())
			//{
			//	Deploy();
			//}
		}
		else if(FireModeNum == 0)
		{
			if(Instigator.IsHumanControlled())
			{
				if(Instigator.IsLocallyControlled())
				{
				        `log('show mesh');
					//SymbolComponent.SetHidden(false);
					MeshPointer.SetHidden(false);
				}
			}
		}
	}

	simulated function EndFire(byte FireModeNum)
	{
		global.EndFire(FireModeNum);

		if(FireModeNum == 0)
		{
			if(!bDeploying)
			{
				//RefireCheckTimer();
			}
			else
			{
				//SymbolComponent.SetHidden(true);
				MeshPointer.SetHidden(true);
			}
		}
	}
	
	/**
	 * Displays the symbol.
	 */
	simulated function Tick(float DeltaTime)
	{
		//local Rotator AimRotation;
		//local Vector Aim;


                if(!Instigator.IsLocallyControlled())
		{
			return;
		}
		//AimRotation = Instigator.GetBaseAimRotation();
		//Aim = Vector(AimRotation);
		`log('pointer draw' @ Location);
		
		MeshPointer.SetTranslation(InstantFireStartTrace());

	}

}

simulated function Tick(float DeltaTime)
{
     super.Tick(DeltaTime);
}

defaultproperties
{
	//ItemName="Turret Deployer"
	//PickupMessage="Turret Deployer"
	
	WeaponColor=(R=128,G=128,B=128,A=255)
	
	Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'UTW_Repair.WeapRepair'
		//AnimSets[0]=AnimSet'Pickups.Deployables.Anims.K_Deployables_Shield_1P'
		//Animations=MeshSequenceA
		CollideActors=false
		BlockActors=false
		CastShadow=false
		bForceDirectLightMap=true
		bCastDynamicShadow=false
		BlockRigidBody=false
		FOV=60.0
		bUseAsOccluder=FALSE
	End Object

	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'UTW_Repair.WeapRepair'
		Translation=(Z=-20.0)
	End Object
	
	
	AttachmentClass=class'UTAttachment_TurretDeployer'

	FiringStatesArray(0)=DeployState
	
	IconX=394
	IconY=38
	IconWidth=60
	IconHeight=38
	
	AmmoCount=100
	LockerAmmoCount=100
	MaxAmmoCount=280
	RespawnTime=40.0
	
	
	//CrosshairImage=Texture2D'EngineResources.White'
	//CrossHairCoordinates=(U=0,V=0,UL=3,VL=3)
	//SimpleCrosshairCoordinates=(U=0,V=0,UL=3,VL=3)
	//CrosshairColor=(R=64,G=255,B=64)
	//IconCoordinates=(U=620,V=587,UL=59,VL=56)
        Begin Object class=StaticMeshComponent  Name=Pointer
              StaticMesh=StaticMesh'UTMEditor.downpointer'
        End Object
        MeshPointer=Pointer
        Components.Add(Pointer)
}