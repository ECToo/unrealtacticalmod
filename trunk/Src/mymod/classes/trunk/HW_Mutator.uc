class HW_Mutator extends UTMutator;


//C:\Documents and Settings\~\My Documents\My Games\Unreal Tournament 3\UTGame\Unpublished\CookedPC\Script

function InitMutator(string Options, out string ErrorMessage)
{
     loginternal( "Hello World" );

Super.InitMutator(Options, ErrorMessage);
}