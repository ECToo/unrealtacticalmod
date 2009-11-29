/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMMechPart_LeftWeapon extends UTMMechPartWeapon;



defaultproperties
{

        WeaponProjectiles=class'UTProj_StingerShard'
        SocketName=FlashPointSocket01
        firerate=10

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		//AnimTreeTemplate=AnimTree''
	End Object
}