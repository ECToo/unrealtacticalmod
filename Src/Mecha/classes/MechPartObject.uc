class MechPartObject extends Object PerObjectConfig config(MechaParts);

//var const string ConfigFile;
 
// config variables and logic
var config string FriendlyName;//name of the mecha part name
var config string PartType;//body type
var config float PartCost;
var config string ObjectClass;//class name must be full that depend on package location
//var config MechaPart objectclass;//does not work for ini stuff

defaultproperties
{
  //ConfigFile="PartSystem"
}