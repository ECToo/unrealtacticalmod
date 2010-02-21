class DeathMatchOnlyMechaGame extends UTDeathmatch;

function PreBeginPlay()
{
	Super.PreBeginPlay();
}

defaultproperties
{
        Acronym="DeathMatch"
	MapPrefixes[0]="DM"
	HUDType=class'Mecha.MechaHUD';
	DefaultPawnClass=class'MechaPawn'	
}