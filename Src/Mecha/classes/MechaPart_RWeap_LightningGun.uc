/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_RWeap_LightningGun extends MechaPartWeapon;

defaultproperties
{
        //WeaponProjectiles=class'UTProj_LinkPlasma'
        //WeaponProjectiles=class'UTProj_Rocket'
        //WeaponProjectiles=class'UTProj_ShockBall'
        //WeaponProjectiles=class'UTProj_Grenade'
        
        FireSound=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
        
        WeaponProjectiles=class'UTProj_LinkPowerPlasma'
        SocketName=FlashPointSocket01
        firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.RMechaWeaponA01_LightningGun'
                PhysicsAsset=PhysicsAsset'VH_Mecha.RMechaWeaponA01_LightningGun_Physics'
	End Object
}