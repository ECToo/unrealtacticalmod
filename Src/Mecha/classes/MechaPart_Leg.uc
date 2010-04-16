/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 * Walk code is base on the timer code. To deal with the delay code for animatin when finish.

 SetTimer(1, true, 'StartCount');//this count to seconds.
 ClearTimer('StartCount');//clear timer
 function StartCount(){}

 */

class MechaPart_Leg extends MechaPart;

var name LegWalkName;
var name LegIdleName;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}
//===============================================
//  STATE
//Animations:idle,leftwalk,rightwalk,Walk
//===============================================

state StartWalkState
{
    function playaimationstate(){
        //Mesh.PlayAnim('Walk', 1, false, true);//working code for animation
        Mesh.PlayAnim('Walk', 1, true, true);//working code for animation
    }
    Begin:
      //`log(' WALKING OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      bActionWalk= true;
      playaimationstate();
      //Sleep(3);//
      //GoToState('FinishWalkState');
}

state IdleWalkState
{
    Begin:
      bActionWalk = false;
      Mesh.PlayAnim('idle', 1, true, false);
      Mesh.StopAnim();
      //`log(' Finish Delay OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
}

function SetWalkTimer(){ //Timer
  //bActionWalk = false;
  GoToState('IdleWalkState');
}

//===============================================
// Action Walk Code
//===============================================

//This code deal with will loop animation that is already in running.
function BeginActionWalk(){
      super.BeginActionWalk();
      //PlayAnim( 'Walk' );
      //Mesh.PlayAnim('Walk', 1, true, false);//working code for animation
      if(bActionWalk == false){
         GoToState('StartWalkState');
         SetTimer(3, false, 'SetWalkTimer'); //how many seconds, bloop,name of the function to execute
      }
      //`log('move');
}
//this will stop the animation.
function EndActionWalk(){
      super.EndActionWalk();
      ClearTimer('SetWalkTimer');
      GoToState('IdleWalkState');
      //Mesh.StopAnim();
      //`log('Stop Animation');
}

function DirectionWalk(String dirname ){
//`log(dirname);
WalkName = dirname;
}

//===============================================
// Test Code
//===============================================

function playanimationtest(){
      super.playanimationtest();
}

defaultproperties
{
      bodytype = "leg"
      LegWalkName=Walk
      
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_leg_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_leg_at'
		AnimSets(0)=AnimSet'VHUTM_MechProtypeWalker.mechprotype_leg_animation'
	End Object

}