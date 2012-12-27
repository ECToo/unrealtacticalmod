/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class UAPawn_male extends UA3Pawn;

defaultproperties
{
    Begin Object Name=MeshFrame
        SkeletalMesh=SkeletalMesh'UDKAS3_Chars.base_male'
        PhysicsAsset=PhysicsAsset'UDKAS3_Chars.base_male_Physics'
        AnimTreeTemplate=AnimTree'UDKAS3_Chars.base_male_animtree'
        AnimSets(0)=AnimSet'UDKAS3_Chars.base_gender_anim'
        Rotation=(pitch=0,yaw=-16384,roll=0)
    End Object

}
