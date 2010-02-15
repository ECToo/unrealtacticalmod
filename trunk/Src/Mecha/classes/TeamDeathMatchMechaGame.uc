class TeamDeathMatchMechaGame extends UTTeamGame;

function PreBeginPlay()
{
	Super.PreBeginPlay();
}

defaultproperties
{
        Acronym="TeamDeathMatch"
	MapPrefixes[0]="TDM"
	//HUDType=class'UTMAssaultHUD';
}