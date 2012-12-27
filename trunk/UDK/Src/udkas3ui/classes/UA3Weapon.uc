/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class UA3Weapon extends UA3Item;

var string Weapontype; // weapon type //hand, gun, sword, throw
var string Weaponhandle; // 
var string HandHolder; // right, left
var string HandleType;// either hand, two hand, one hand
var bool bequip; //
var bool bconsume; //
var bool bconsumeammo; //

defaultproperties
{
    HandleType="hand"
	//HandleType="onehand"
}