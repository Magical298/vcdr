/*
______           __  _____  _____ 
| ___ \         /  ||  _  ||  _  |
| |_/ /_____  __`| || |/' || |_| |
|    // _ \ \/ / | ||  /| |\____ |
| |\ \  __/>  < _| |\ |_/ /.___/ /
\_| \_\___/_/\_\\___/\___/ \____/ 

*/

//Version 1.4

init(ver)
{
    level.elev_threshold = 3; //Threshold to detect the elevator: this should be at the sweet spot but adjust this if someone gets a false detect: >3 = more difficulty to detect the elevator but less false detects (if probably none), <3 = less difficulty to detect the elevator but more false detects.
    level.elev_detect_mode = 0; //What to do when an elevator is detected: 0 = Kill, 1 = Kick
    thread onPlayerSpawn();
}



onPlayerSpawn()
{
    self endon("disconnect");
    while(1)
    {
        level waittill("player_spawn", player);
        player thread watchForElevator();
    }
}

watchForElevator()
{
    self endon("disconnect");
    self endon("death");

    self.detection = 0;
    self.prevpos = 0;
    self.elev_force_ignore = false; //This could be useful for scripting, if anything on the map trips the anti elevator you can set this to true to force ignore the elevator check then back to false to re-enable it

    while(1)
    {
        wait 0.01;
        self.vel = self getVelocity();
        self.pos = self getOrigin();

        if (!self.elev_force_ignore && self.vel[2] == 0 && !self isOnGround() && !self isOnLadder() && (self.prevpos > int(self.pos[2])+level.elev_threshold || self.prevpos < int(self.pos[2])-level.elev_threshold) )
        {
            if(self.detection > 2)
            {
                if(level.elev_detect_mode == 0)
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
            else
            {
                self.detection ++;
            }
        }
        else
        {
            self.detection = 0;
        }

        self.prevpos = int(self.pos[2]);
    }
}