class FirstMutator extends UTMutator;

function InitMutator(string Options, out string ErrorMessage)
{
if (UTGame(WorldInfo.Game) != None)
{
UTGame(WorldInfo.Game).DefaultInventory[0] = class'mymod.UTWeap_EnforcerPlusOne';
}

Super.InitMutator(Options, ErrorMessage);
}

function bool CheckReplacement(Actor Other)
{
if (Other.IsA('UTWeap_Enforcer') && !Other.IsA('UTWeap_EnforcerPlusOne'))
{
ReplaceWith(Other, "UTWeap_EnforcerPlusOne");
}

return true;
}

DefaultProperties
{
 //Description = "Hello World!" in your package.ini in config folder
 GroupNames(0)="TEST"
}