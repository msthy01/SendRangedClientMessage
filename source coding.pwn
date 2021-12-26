public OnPlayerText(playerid,text[])
{
    if(IsPlayerLogged[playerid])
	{
	    new string[128];
	    GetPlayerName(playerid,string,MAX_PLAYER_NAME);
		format(string,sizeof(string),"(( %s : %s ))",string,text);
		SendRangedClientMessage(playerid,20.0,string,true);
	}
	return 0;
}

stock SendRangedClientMessage(senderid,Float:range,string[],bool:fading,color=0)
{
    new Float:pPos[3],pRange,MaxRange,interior,world;
    MaxRange = floatround(range);
    interior = GetPlayerInterior(senderid);
    world = GetPlayerVirtualWorld(senderid);
    GetPlayerPos(senderid,pPos[0],pPos[1],pPos[2]);
    if(fading) SendClientMessage(senderid,COLOR_WHITE,string);
    else SendClientMessage(senderid,color,string);
	foreach(new i : Player)
	{
	    if(i == senderid) continue;
        if(GetPlayerVirtualWorld(i) == world && GetPlayerInterior(i) == interior)
        {
			pRange = floatround(GetPlayerDistanceFromPoint(i,pPos[0],pPos[1],pPos[2]));
			if(pRange < MaxRange)
			{
			    if(fading)
			    {
			        new fadeRGB = (255-((pRange*255)/MaxRange));
			    	SendClientMessage(i,RGBAToInt(fadeRGB,fadeRGB,fadeRGB,255),string);
				}
				else
				{
				    SendClientMessage(i,color,string);
				}
			}
		}
	}
	return 1;
}
