/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class DamageActor extends Actor placeable;

var	CylinderComponent		CylinderComponent;

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
    {
        super.TakeDamage(DamageAmount,EventInstigator, HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
		`log('hit box');
        WorldInfo.Game.Broadcast(self,"Damage Taken:"@DamageAmount);
    }

defaultproperties
{
    Begin Object Class=SpriteComponent Name=Sprite
        //Sprite=Texture2D'CustomHUD.icon_interface_panel'
        Sprite=Texture2D'CustomHUD.icon_pawn'
        //HiddenGame=true
		HiddenGame=false
        AlwaysLoadOnClient=False
        AlwaysLoadOnServer=False
    End Object
    Components.Add(Sprite)
	
	bCollideActors=true
	bCollideWorld=true
	bBlockActors=true

	Begin Object Class=CylinderComponent Name=CollisionCylinder
		CollisionRadius=+0034.000000
		CollisionHeight=+0078.000000
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
	End Object
	CollisionComponent=CollisionCylinder
	CylinderComponent=CollisionCylinder
	Components.Add(CollisionCylinder)

	Begin Object Class=ArrowComponent Name=Arrow
		ArrowColor=(R=150,G=200,B=255)
		bTreatAsASprite=True
		SpriteCategoryName="Pawns"
	End Object
	Components.Add(Arrow)
}