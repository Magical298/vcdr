init()
{
	if(isdefined(game["mysql"]))
		return;

	level.mysql_host = "localhost";
	level.mysql_user = "root";
	level.mysql_pass = "wya9Lr5np9cpfGBa";
	level.mysql_data = "vc_stats";
	level.mysql_port = "3306";
	level.mysql_web = "http://vistic-gaming.co.uk/cod4http.php";

	game["mysql"] = "{ \"host\":\""+level.mysql_host+"\", \"user\":\""+level.mysql_user+"\", \"password\":\""+level.mysql_pass+"\", \"database\":\""+level.mysql_data+"\", \"query\":\"";
	game["mysql_bans"] = "{ \"host\":\""+level.mysql_host+"\", \"user\":\""+level.mysql_user+"\", \"password\":\""+level.mysql_pass+"\", \"database\":\"mam2_logKickBan\", \"query\":\"";
}

testWarn(type,kicked,admin,reason,server)
{
	kType = type;
	kPlayer = kicked.name;
	kAdmin = admin.name;
	kGuid = kicked getguid();
	kServer = server;

	if(!isdefined(reason))
		kReason = "Admin Decission";
	else 
		kReason = reason;

	wait .1;

	#if isSyscallDefined httpPostJson

	query = "INSERT INTO `mam2_logKickBan` (kType, kPlayer, kAdmin, kGuid, kReason, kServer) VALUES ('"+kType+"', '"+kPlayer+"', '"+kAdmin+"', '"+kGuid+"', '"+kReason+"', '"+kServer+"')";
	json = game["mysql"]+query+"\"}";

	httpPostJson(level.mysql_web, json, ::release);

	iprintln("DB Transmition: "+kType+", "+kPlayer+", "+kAdmin+", "+kGuid+", "+kReason+", "+kServer);

	#endif
}

release( handle )
{
	if( !handle )
		return;
	
	#if isSyscallDefined jsonReleaseObject
		jsonReleaseObject( handle );
	#endif
}