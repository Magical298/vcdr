init(modversion)
{
    level.elev_threshold = 3; //Threshold to detect the elevator: this should be at the sweet spot but adjust this if someone gets a false detect: >3 = more difficulty to detect the elevator but less false detects (if probably none), <3 = less difficulty to detect the elevator but more false detects.
    level.elev_detect_mode = 0; //What to do when an elevator is detected: 0 = Kill, 1 = Kick
    if(canEnable())
    {
        thread onplayerconnect();
        thread onplayerspawn();
        wait 0.5;
        iPrintLn("^5[^7Anti-Elevator^5]^7: Enabled");
    }
}

canEnable(enb)
{
    map = getdvar("mapname");
    switch(map)
    {
        case "mp_deathrun_semtex":
        return false;

        default:
        return true;
    }
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected",player);
        player thread watchForElevator();
    }
}

onplayerspawn()
{
    for(;;)
    {
        level waittill( "player_spawn" , player);
        player thread watchForElevator();
    }
}

watchForElevator()
{
    self endon("disconnect");
    self endon("death");

    self.prevpos = 0;

    for(;;)
    {
        wait 0.01;
        self.vel = self getVelocity();
        self.pos = self getOrigin();

        if (self.vel[2] == 0 && !self isOnGround() && !self IsOnLadder() && (self.prevpos > int(self.pos[2])+level.elev_threshold || self.prevpos < int(self.pos[2])-level.elev_threshold) )
        {
            if(level.elev_detect_mode == 0 && ( !isdefined(self.ispicked_up) || self.ispicked_up == false ) )
            {
                iPrintLn(self.name + " ^1has been killed for elevating");
                self iPrintLnBold("^1You have been killed for elevating!");
                self suicide();
            }

            if(level.elev_detect_mode == 1)
            {
                iPrintLn(self.name + " ^1has been kicked for elevating");
                self setClientDvar( "ui_dr_info", "^1Warning" );
		        self setClientDvar( "ui_dr_info2", "You have been kicked for elevating!" );
		        self braxi\_common::clientCmd( "disconnect" );
            }
        }

        self.prevpos = int(self.pos[2]);
    }
}