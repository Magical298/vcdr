init()
{
    precacheShader("vc_w");
    precacheShader("vc_a");
    precacheShader("vc_s");
    precacheShader("vc_d");

	for(;;)
	{
		level waittill("connected",who);

		who thread getFps();
		who thread wasd_setup();

		who thread on_spectating();
	}
}

getFps()
{
    if(!isDefined(self.pers["fps_plugin_getfps"]))
    {
        self braxi\_common::clientcmd("setu com_maxfps 125");
        self.pers["fps_plugin_getfps"] = true;
    }
}

wasd_setup()
{
	if(!isdefined(self.moving_keys))
        self.moving_keys = [];

    wait .05;

    if(isdefined(self.moving_keys[0]))
        self.moving_keys[0] destroy();

    self.moving_keys[0] = newclienthudelem(self);
    self.moving_keys[0].horzAlign = "center_safearea";
    self.moving_keys[0].vertAlign = "center_safearea";
    self.moving_keys[0].alignX = "center";
    self.moving_keys[0].alignY = "middle";
    self.moving_keys[0].x = 0;
    self.moving_keys[0].y = 153;
    self.moving_keys[0].alpha = 0;
    self.moving_keys[0].hidewheninmenu = true;
    self.moving_keys[0].archived = false;
    self.moving_keys[0] setshader("vc_w", 25, 25);

    if(isdefined(self.moving_keys[1]))
        self.moving_keys[1] destroy();

    self.moving_keys[1] = newclienthudelem(self);
    self.moving_keys[1].horzAlign = "center_safearea";
    self.moving_keys[1].vertAlign = "center_safearea";
    self.moving_keys[1].alignX = "center";
    self.moving_keys[1].alignY = "middle";
    self.moving_keys[1].x = -27;
    self.moving_keys[1].y = 180;
    self.moving_keys[1].alpha = 0;
    self.moving_keys[1].hidewheninmenu = true;
    self.moving_keys[1].archived = false;
    self.moving_keys[1] setshader("vc_a", 25, 25);

    if(isdefined(self.moving_keys[2]))
        self.moving_keys[2] destroy();

    self.moving_keys[2] = newclienthudelem(self);
    self.moving_keys[2].horzAlign = "center_safearea";
    self.moving_keys[2].vertAlign = "center_safearea";
    self.moving_keys[2].alignX = "center";
    self.moving_keys[2].alignY = "middle";
    self.moving_keys[2].x = 27;
    self.moving_keys[2].y = 180;
    self.moving_keys[2].alpha = 0;
    self.moving_keys[2].hidewheninmenu = true;
    self.moving_keys[2].archived = false;
    self.moving_keys[2] setshader("vc_d", 25, 25);

    if(isdefined(self.moving_keys[3]))
        self.moving_keys[3] destroy();

    self.moving_keys[3] = newclienthudelem(self);
    self.moving_keys[3].horzAlign = "center_safearea";
    self.moving_keys[3].vertAlign = "center_safearea";
    self.moving_keys[3].alignX = "center";
    self.moving_keys[3].alignY = "middle";
    self.moving_keys[3].x = 0;
    self.moving_keys[3].y = 180;
    self.moving_keys[3].alpha = 0;
    self.moving_keys[3].hidewheninmenu = true;
    self.moving_keys[3].archived = false;
    self.moving_keys[3] setshader("vc_s", 25, 25);

	if(isdefined(self.spec_fps_hud))
        self.spec_fps_hud destroy();

    self.spec_fps_hud = newclienthudelem(self);
    self.spec_fps_hud.horzAlign = "center_safearea";
    self.spec_fps_hud.vertAlign = "center_safearea";
    self.spec_fps_hud.alignX = "center";
    self.spec_fps_hud.alignY = "top";
    self.spec_fps_hud.x = 0;
    self.spec_fps_hud.y = -150;
    self.spec_fps_hud.alpha = 0;
    self.spec_fps_hud.archived = false;
    self.spec_fps_hud.fontscale = 2;
}

destroyHuds()
{
	for(i=0;i<self.moving_keys.size;i++)
    {
        if(isdefined(self.moving_keys[i]))
            self.moving_keys[i].alpha = 0;
    }

	if(isdefined(self.spec_fps_hud))
		self.spec_fps_hud.alpha = 0;
}

on_spectating()
{
	self endon("disconnect");

	old_spectated = self;
	while(1)
	{
		spectated = self getspectatorclient();
		if(isdefined(self) && (!isdefined(self.sessionstate) || self.sessionstate == "spectator") && game["state"] == "playing")
		{
			if(!isdefined(spectated))
				spectated = self;

			if(old_spectated != spectated)
			{
				if(spectated == self)
					self destroyHuds();

				old_spectated = spectated;
			}

			if(spectated != self)
			{
				if(self plugins\_clients::get_drstat("DR_FPS") == 1)
				{
					self.spec_fps_hud.alpha = 1;
					
                    max_fps = spectated getuserinfo("com_maxfps");
                    self.spec_fps_hud settext(max_fps);
				}

				if(self plugins\_clients::get_drstat("DR_WASD") == 1)
				{
					if(spectated MoveLeftButtonPressed())
                        self.moving_keys[1].alpha = 0.9;
                    else
                        self.moving_keys[1].alpha = 0.2;   
                            
                    if(spectated BackButtonPressed())
                        self.moving_keys[3].alpha = 0.9;
                    else
                        self.moving_keys[3].alpha = 0.2;
                            
                    if(spectated ForwardButtonPressed())
                        self.moving_keys[0].alpha = 0.9;
                    else
                        self.moving_keys[0].alpha = 0.2;
                            
                    if(spectated MoveRightButtonPressed())
                        self.moving_keys[2].alpha = 0.9;
                    else
                        self.moving_keys[2].alpha = 0.2;
				}
			}
		}
		else
			self destroyHuds();
		
		wait 0.001;
	}
}