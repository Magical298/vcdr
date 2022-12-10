main()
{
	entTransporter = getentarray( "enter", "targetname" );
	if(isdefined(entTransporter))
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter();
}
 
transporter()
{
	for(;;)
	{
		self waittill ("trigger", player);
		player SetOrigin(getentarray("mp_jumper_spawn","classname")[2].origin);
		player SetPlayerAngles(getentarray("mp_jumper_spawn","classname")[2].angles);
		player iPrintlnBold ("Teleported back to spawn!");
		iprintln (player.name + " tried to skip the map using the secret.");		
	}
}