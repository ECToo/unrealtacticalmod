/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

//class UA3PlayerController extends UTPlayerController;
class UA3PlayerController extends UDKPlayerController;
    //config(UDKAS3);
	
	
var float LastCameraTimeStamp; /** Used during matinee sequences */
/** if true, while in the spectating state, behindview will be forced on a player */
var bool bForceBehindView;	

var		bool	bBehindView;
var bool bFreeCamera;
var class<Camera> MatineeCameraClass;	
	
/** cached result of GetPlayerViewPoint() */
var Actor CalcViewActor;
var vector CalcViewActorLocation;
var rotator CalcViewActorRotation;
var vector CalcViewLocation;
var rotator CalcViewRotation;
var float CalcEyeHeight;
var vector CalcWalkBob;
	
state Spectating
{
	exec function BehindView()
	{
		bForceBehindView = !bForceBehindview;
	}
	
	/**
	 * Handle forcing behindview/etc
	 */
	simulated event GetPlayerViewPoint( out vector out_Location, out Rotator out_Rotation )
	{
		// Force first person mode if we're performing automated perf testing.
		if( WorldInfo.Game!=None && WorldInfo.Game.IsAutomatedPerfTesting() )
		{
			SetBehindView(false);
		}
		else if (bBehindview != bForceBehindView && UTPawn(ViewTarget)!=None)
		{
			SetBehindView(bForceBehindView);
		}
		Global.GetPlayerViewPoint(out_Location, out_Rotation);
	}

}

function SetBehindView(bool bNewBehindView)
{
	bBehindView = bNewBehindView;
	if ( !bBehindView )
	{
		bFreeCamera = false;
	}

	if (LocalPlayer(Player) == None)
	{
		ClientSetBehindView(bNewBehindView);
	}
	else if (UTPawn(ViewTarget) != None)
	{
		UTPawn(ViewTarget).SetThirdPersonCamera(bNewBehindView);
	}
	// make sure we recalculate camera position for this frame
	LastCameraTimeStamp = WorldInfo.TimeSeconds - 1.0;
}

reliable client function ClientSetBehindView(bool bNewBehindView)
{
	if (LocalPlayer(Player) != None)
	{
		SetBehindView(bNewBehindView);
	}
	// make sure we recalculate camera position for this frame
	LastCameraTimeStamp = WorldInfo.TimeSeconds - 1.0;
}

/* GetPlayerViewPoint: Returns Player's Point of View
	For the AI this means the Pawn's Eyes ViewPoint
	For a Human player, this means the Camera's ViewPoint */
simulated event GetPlayerViewPoint( out vector POVLocation, out Rotator POVRotation )
{
	local float DeltaTime;
	local UA3Pawn P;

	P = IsLocalPlayerController() ? UA3Pawn(CalcViewActor) : None;
	//P = UA3Pawn(CalcViewActor);
	/*
	if (PlayerCamera == None
		&& LastCameraTimeStamp == WorldInfo.TimeSeconds
		&& CalcViewActor == ViewTarget
		&& CalcViewActor != None
		&& CalcViewActor.Location == CalcViewActorLocation
		&& CalcViewActor.Rotation == CalcViewActorRotation
		)
	{
		if ( (P == None) || ((P.EyeHeight == CalcEyeHeight) && (P.WalkBob == CalcWalkBob)) )
		{
			// use cached result
			POVLocation = CalcViewLocation;
			POVRotation = CalcViewRotation;
			return;
		}
	}
	*/
	DeltaTime = WorldInfo.TimeSeconds - LastCameraTimeStamp;
	LastCameraTimeStamp = WorldInfo.TimeSeconds;

	// support for using CameraActor views
	if ( CameraActor(ViewTarget) != None )
	{
		if ( PlayerCamera == None )
		{
			super.ResetCameraMode();
			SpawnCamera();
		}
		super.GetPlayerViewPoint( POVLocation, POVRotation );
	}
	else
	{
		if ( PlayerCamera != None )
		{
			PlayerCamera.Destroy();
			PlayerCamera = None;
		}

		if ( ViewTarget != None )
		{
			POVRotation = Rotation;
			if ( (PlayerReplicationInfo != None) && PlayerReplicationInfo.bOnlySpectator && (UTVehicle(ViewTarget) != None) )
			{
				UTVehicle(ViewTarget).bSpectatedView = true;
				ViewTarget.CalcCamera( DeltaTime, POVLocation, POVRotation, FOVAngle );
				UTVehicle(ViewTarget).bSpectatedView = false;
			}
			else
			{
			ViewTarget.CalcCamera( DeltaTime, POVLocation, POVRotation, FOVAngle );
			}
			if ( bFreeCamera )
			{
				POVRotation = Rotation;
			}
		}
		else
		{
			CalcCamera( DeltaTime, POVLocation, POVRotation, FOVAngle );
			return;
		}
	}

	// apply view shake
	POVRotation = Normalize(POVRotation + ShakeRot);
	POVLocation += ShakeOffset >> Rotation;

	if( CameraEffect != none )
	{
		CameraEffect.UpdateLocation(POVLocation, POVRotation, GetFOVAngle());
	}


	// cache result
	CalcViewActor = ViewTarget;
	CalcViewActorLocation = ViewTarget.Location;
	CalcViewActorRotation = ViewTarget.Rotation;
	CalcViewLocation = POVLocation;
	CalcViewRotation = POVRotation;

	if ( P != None )
	{
		CalcEyeHeight = P.EyeHeight;
		//CalcWalkBob = P.WalkBob;
	}
}
	
function SpawnCamera()
{
	local Actor OldViewTarget;

	// Associate Camera with PlayerController
	PlayerCamera = Spawn(MatineeCameraClass, self);
	if (PlayerCamera != None)
	{
		OldViewTarget = ViewTarget;
		PlayerCamera.InitializeFor(self);
		PlayerCamera.SetViewTarget(OldViewTarget);
	}
	else
	{
		`Log("Couldn't Spawn Camera Actor for Player!!");
	}
}	
	
//Update player rotation when walking 
state PlayerWalking 
{ 
	ignores SeePlayer, HearNoise, Bump; 
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot) 
	{ 
		local Vector tempAccel; 
		local Rotator CameraRotationYawOnly; 

		if( Pawn == None ) 
		{ 
			return; 
		} 

		if (Role == ROLE_Authority) 
		{ 
			// Update ViewPitch for remote clients 
			Pawn.SetRemoteViewPitch( Rotation.Pitch ); 
		} 

		tempAccel.Y =  PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed; 
		tempAccel.X = PlayerInput.aForward * DeltaTime * 100 * PlayerInput.MoveForwardSpeed; 
		tempAccel.Z = 0; //no vertical movement for now, may be needed by ladders later 

		//get the controller yaw to transform our movement-accelerations by 
		CameraRotationYawOnly.Yaw = Rotation.Yaw;  
		tempAccel = tempAccel>>CameraRotationYawOnly; //transform the input by the camera World orientation so that it's in World frame 
		Pawn.Acceleration = tempAccel; 

		Pawn.FaceRotation(Rotation,DeltaTime); //notify pawn of rotation 

		CheckJumpOrDuck(); 
	} 
} 

//Controller rotates with turning input 
function UpdateRotation( float DeltaTime ) 
{ 
	local Rotator   DeltaRot, newRotation, ViewRotation; 

	ViewRotation = Rotation; 
	if (Pawn!=none) 
	{ 
		Pawn.SetDesiredRotation(ViewRotation); 
	} 

	// Calculate Delta to be applied on ViewRotation 
	DeltaRot.Yaw   = PlayerInput.aTurn; 
	DeltaRot.Pitch   = PlayerInput.aLookUp; 

	ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot ); 
	SetRotation(ViewRotation); 

	NewRotation = ViewRotation; 
	NewRotation.Roll = Rotation.Roll; 

	if ( Pawn != None ) 
		Pawn.FaceRotation(NewRotation, deltatime); //notify pawn of rotation 
}    

exec function NextWeapon()  
{ 
    //AnotherTestActionPawn(Pawn).CamZoomOut(); 
} 

exec function PrevWeapon()  
{ 
    //AnotherTestActionPawn(Pawn).CamZoomIn(); 
}

exec function SetPoint()  
{ 
    //AnotherTestActionPawn(Pawn).CamZoomIn(); 
} 





DefaultProperties
{
    MatineeCameraClass=class'Engine.Camera'
}