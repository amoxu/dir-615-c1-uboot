<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Status | Log Setting</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	
	function loadSettings(){
		var schedule_rule = get_by_id("schedule_rule_00").value.split("/");
		var log_email_schedule = get_by_id("log_email_schedule").value.split("/");
		var temp_log_email_schedule=log_email_schedule[0];
		var email_sch = get_by_name("email_sch");
		var temp_schedule_rule = schedule_rule[1];
		var temp_schedule_time = schedule_rule[2];
		var temp_schedule_hour = temp_schedule_time.split(":");
		var syslog_ser = get_by_id("syslog_server").value.split("/");
		set_checked("<% CmoGetCfg("log_system_activity","none"); %>", get_by_id("type1"));
		set_checked("<% CmoGetCfg("log_debug_information","none"); %>", get_by_id("type2"));
		set_checked("<% CmoGetCfg("log_attacks","none"); %>", get_by_id("type3"));
		set_checked("<% CmoGetCfg("log_dropped_packets","none"); %>", get_by_id("type4"));
		set_checked("<% CmoGetCfg("log_notice","none"); %>", get_by_id("type5"));
		set_checked("<% CmoGetCfg("log_email_auth","none"); %>",get_by_name("log_email_auth"));
		
		enable_smtp_auth();

                
  		get_by_id("sys_server").value = syslog_ser[1];

                 if (temp_log_email_schedule==0)
	               email_sch[1].checked=true;
                 else
	               email_sch[0].checked=true;
                
	 if (temp_schedule_rule == "1000000"){
			get_by_id("email_sch_day").selectedIndex = 0;
		}else if (temp_schedule_rule == "0100000"){
			get_by_id("email_sch_day").selectedIndex = 1;
		}else if (temp_schedule_rule == "0010000"){
			get_by_id("email_sch_day").selectedIndex = 2;
		}else if (temp_schedule_rule == "0001000"){
			get_by_id("email_sch_day").selectedIndex = 3;
		}else if (temp_schedule_rule == "0000100"){
			get_by_id("email_sch_day").selectedIndex = 4;
		}else if (temp_schedule_rule == "0000010"){
			get_by_id("email_sch_day").selectedIndex = 5;
		}else if (temp_schedule_rule == "0000001"){
			get_by_id("email_sch_day").selectedIndex = 6;
		}else if (temp_schedule_rule == "1111111"){
			get_by_id("email_sch_day").selectedIndex = 7;
		}
    if (temp_schedule_hour[0] == 12){
    	get_by_id("email_sch_ampm").selectedIndex = 1;
    	get_by_id("email_sch_time").selectedIndex = temp_schedule_hour[0]-1;
    }
    else if(temp_schedule_hour[0]>=12)
    {
    	get_by_id("email_sch_ampm").selectedIndex = 1;
		    	get_by_id("email_sch_time").selectedIndex = temp_schedule_hour[0]-13;
		    }
    else
    {
    	get_by_id("email_sch_ampm").selectedIndex = 0;
    	if (temp_schedule_hour[0]== 00 ){
    		get_by_id("email_sch_time").selectedIndex = temp_schedule_hour[0]+11;
    	}
    	else{
		    	get_by_id("email_sch_time").selectedIndex = temp_schedule_hour[0]-1;
		    } 
		}
	}
	
	function check_smtp(){
		var send_to = get_by_id("log_email_sender").value;
		var send_fm = get_by_id("log_email_recipien").value;
		var index_to = -1;
		var index_fm = -1;
		
		index_to = send_to.indexOf("@");
		index_fm = send_fm.indexOf("@");
		
		if (get_by_id("log_email_server").value == ""){	// check the smtp server is empty or not
			alert(msg[MSG14]);
			return false;
		}else if (index_to == -1 || index_fm == -1){	// check the email address is in correct format or not
			alert(msg[MSG15]);
			return false;
		}
		save_system_cfg();
		
		get_by_id("form1").action = "send_log_email.cgi";
		get_by_id("html_response_message").value = "Finish.";
		send_submit("form1");
		return true;
	}
	
	function save_system_cfg(){
		var log_res_type ="";
		
		get_by_id("log_system_activity").value = get_checked_value(get_by_id("type1"));
		get_by_id("log_debug_information").value = get_checked_value(get_by_id("type2"));
		get_by_id("log_attacks").value = get_checked_value(get_by_id("type3"));
		get_by_id("log_dropped_packets").value = get_checked_value(get_by_id("type4"));
		get_by_id("log_notice").value = get_checked_value(get_by_id("type5"));
				
		if (get_by_id("type1").checked==true){
				log_res_type = "system";
		}
		if (get_by_id("type2").checked==true){
				log_res_type = log_res_type +"| debug" ;
		}
		if (get_by_id("type3").checked==true){
				log_res_type = log_res_type +"| attack";
		}
		if (get_by_id("type4").checked==true){
				log_res_type = log_res_type +"| dropped";
		}
		if (get_by_id("type5").checked==true){
				log_res_type = log_res_type +"| notice";
		}
		
		get_by_id("log_response_type").value =log_res_type;
	}
	
	function enable_smtp_auth(){
		var smtp_enable = get_by_name("log_email_auth");
		
		get_by_id("log_email_username").disabled = smtp_enable[1].checked;
		get_by_id("log_email_password").disabled = smtp_enable[1].checked;
	}
	
	function email_sch_time(){
		var schedule_rule = get_by_id("schedule_rule_00").value.split("/");
		var temp_schedule_rule = schedule_rule[1];
		if (temp_schedule_rule == "1000000"){
			get_by_id("email_sch_day").selectedIndex = 0;
		}else if (temp_schedule_rule == "0100000"){
			get_by_id("email_sch_day").selectedIndex = 1;
		}else if (temp_schedule_rule == "0010000"){
			get_by_id("email_sch_day").selectedIndex = 2;
		}else if (temp_schedule_rule == "0001000"){
			get_by_id("email_sch_day").selectedIndex = 3;
		}else if (temp_schedule_rule == "0000100"){
			get_by_id("email_sch_day").selectedIndex = 4;
		}else if (temp_schedule_rule == "0000010"){
			get_by_id("email_sch_day").selectedIndex = 5;
		}else if (temp_schedule_rule == "0000001"){
			get_by_id("email_sch_day").selectedIndex = 6;
		}else if (temp_schedule_rule == "1111111"){
			get_by_id("email_sch_day").selectedIndex = 7;
		}

		var temp_rule = get_by_id("schedule_rule_00").value;
		var rule = temp_rule.split("/");					
		var st_hour,en_hour;

			var temp_s= rule[2].split(":");
			var temp_e= rule[3].split(":");
	
			if(parseInt(temp_s[0],10)>11){
				get_by_id("email_sch_ampm").selectedIndex = 1; //pm
				st_hour=parseInt(temp_s[0],10)-12;
				if(st_hour < 1){
					st_hour = parseInt(12);
				}
				get_by_id("email_sch_time").selectedIndex = st_hour;
			}else{
				get_by_id("email_sch_ampm").selectedIndex = 0;  //am
				st_hour=parseInt(temp_s[0],10);
				if(st_hour < 1){
					st_hour = parseInt(12);
				}
				get_by_id("email_sch_time").selectedIndex = st_hour;
			}	

	}
	
	function email_sch_auth(){

		var enabled = get_by_name("email_sch");
		get_by_id("email_sch_day").disabled = enabled[0].checked;
		get_by_id("email_sch_time").disabled = enabled[0].checked;
		get_by_id("email_sch_ampm").disabled = enabled[0].checked;

	
	}
	
	function time_hour(hour){
		var hour_c = hour;
		if (parseInt(hour,10) >= 12){
			hour_c = 00;
		}
		return hour_c;
	}
	
	
	function send_request(){
		var syslog_server = get_by_id("sys_server").value;
		var syslog_server_msg = replace_msg(all_ip_addr_msg,"Syslog server IP address");
		var temp_sys_ip_obj = new addr_obj(syslog_server.split("."), syslog_server_msg, false, false);
		var s_hour,start_time_total,e_hour,end_time_total,temp_hour;

		if (syslog_server != "" && syslog_server != "0.0.0.0"){
			if (!check_address(temp_sys_ip_obj)){		
				return false;
			}
			get_by_id("syslog_server").value = "1/"+ get_by_id("sys_server").value;
		}else{
			get_by_id("syslog_server").value = "0/0.0.0.0";
		}

		var email_sch = get_by_name("email_sch");
		if (email_sch[0].checked){	//log full
			get_by_id("log_email_schedule").value = "1/0/0/email_schedule_name";
		}else{	//schedule
			get_by_id("log_email_schedule").value = "0/25/0/email_schedule_name";
			if(get_by_id("email_sch_ampm").selectedIndex ==1){	//pm
				s_hour = parseInt(get_by_id("email_sch_time").value,10);
				if (s_hour == 12){
					e_hour = parseInt(get_by_id("email_sch_time").value,10)+1;
				}
				else
				{
					s_hour = parseInt(get_by_id("email_sch_time").value,10)+12;
					if (s_hour == 23){
						e_hour = "00";
					}
					else{
					e_hour = parseInt(get_by_id("email_sch_time").value,10)+13;
				}
			}
			}
			else{  //am
				if (parseInt(get_by_id("email_sch_time").value,10) == 12){
					s_hour = "00";
					e_hour = "0"+(parseInt(get_by_id("email_sch_time").value)-11);

				}
				else{
					if(parseInt(get_by_id("email_sch_time").value,10)<10){
						s_hour ="0" + parseInt(get_by_id("email_sch_time").value,10);
						if (s_hour != 9)
							e_hour ="0" + (parseInt(get_by_id("email_sch_time").value,10)+1);
				else
							e_hour =parseInt(get_by_id("email_sch_time").value,10)+1;
				}else{
					s_hour = get_by_id("email_sch_time").value;
						e_hour = parseInt(get_by_id("email_sch_time").value,10)+1;
				}
				}
			}
			
			start_time_total =s_hour + ":00";
			if (e_hour=="010")
				end_time_total = "10:00";
			else
				end_time_total = e_hour + ":00";
				
			var dat ="email_schedule_name/"+ get_by_id("email_sch_day").value +"/"+ start_time_total +"/"+ end_time_total;
			get_by_id("schedule_rule_00").value = dat;			
		}
		
		save_system_cfg();
		send_submit("form1");
	}
</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');loadSettings();">
<table width="750" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21"><img src="c1_tl.gif" width="21" height="21"></td>
    <td width="708" background="bg1_t.gif"><img src="top_1.gif" width="390" height="21"></td>
    <td width="21"><img src="c1_tr.gif" width="21" height="21"></td>
  </tr>
  <tr>
    <td valign="top" background="bg1_l.gif"><img src="top_2.gif" width="21" height="69"></td>
    <td background="bg.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="13%"><img src="logo.gif" width="270" height="69"></td>
        <td width="87%" align="right"><img src="description.gif"></td>
      </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="20%" valign="top"><table width="56%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td><a href="lan.asp"><img src="but_main_0.gif" name="Image2" width="144" height="28" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','but_main_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="wireless_basic.asp"><img src="but_wireless_0.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a><a href="w_basic.asp"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="status.asp"><img src="but_status_1.gif" name="Image1" width="144" height="28" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','but_status_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                  <tr>
                    <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td width="87%"><a href="status.asp" class="submenus"><b>Device Information </b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="log.asp" class="submenus"><b>Log</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="log_setting.asp" class="submenus"><b><u>Log Setting </u></b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="statistic.asp" class="submenus"><b>Statistic</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wla_conn.asp" class="submenus"><b>Wireless</b></a></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="static_routing.asp"><img src="but_routing_0.gif" name="Image4" width="144" height="28" border="0" id="Image4" onMouseOver="MM_swapImage('Image4','','but_routing_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="filters.asp"><img src="but_access_0.gif" name="Image5" width="144" height="28" border="0" id="Image5" onMouseOver="MM_swapImage('Image5','','but_access_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="remote_management.asp"><img src="but_management_0.gif" width="144" height="28" border="0" id="Image6" onMouseOver="MM_swapImage('Image6','','but_management_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="restart.asp"><img src="but_tools_0.gif" width="144" height="28" border="0" id="Image7" onMouseOver="MM_swapImage('Image7','','but_tools_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="#" onClick="show_wizard('wizard.asp')"><img src="but_wizard_0.gif" name="Image71" width="144" height="28" border="0" id="Image71" onMouseOver="MM_swapImage('Image71','','but_wizard_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="15" height="15"></td>
            </tr>
          </table></td>
          <td width="2%"><img src="spacer.gif" width="15" height="15"></td>
          <td width="78%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10"><img src="c2_tl.gif" width="10" height="10"></td>
              <td width="531" background="bg2_t.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td width="10"><img src="c2_tr.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td background="bg2_l.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td height="400" valign="top" background="bg3.gif">
                <table width="100%" border="0" cellpadding="3" cellspacing="0">
                  <tr>
                    <td width="85%" class="headerbg">Log Setting </td>
                    <td width="15%" class="headerbg"><a href="help_status.asp#status_log_settings" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                  </tr>
                </table>
                <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="log_setting.asp">
                <input type="hidden" id="log_system_activity" name="log_system_activity" value="<% CmoGetCfg("log_system_activity","none"); %>">
                <input type="hidden" id="log_debug_information" name="log_debug_information" value="<% CmoGetCfg("log_debug_information","none"); %>">
                <input type="hidden" id="log_attacks" name="log_attacks" value="<% CmoGetCfg("log_attacks","none"); %>">
                <input type="hidden" id="log_dropped_packets" name="log_dropped_packets" value="<% CmoGetCfg("log_dropped_packets","none"); %>">
                <input type="hidden" id="log_notice" name="log_notice" value="<% CmoGetCfg("log_notice","none"); %>">
                <input type="hidden" id="log_response_type" name="log_response_type" value="<% CmoGetCfg("log_response_type","none"); %>">
                <input type="hidden" id="log_per_page" name="log_per_page" value="<% CmoGetCfg("log_per_page","none"); %>">
                <input type="hidden" id="log_email_enable" name="log_email_enable" value="<% CmoGetCfg("log_email_enable","none"); %>">
				<input type="hidden" id="syslog_server" name="syslog_server" value="<% CmoGetCfg("syslog_server","none"); %>">
				<input type="hidden" id="schedule_rule_00" name="schedule_rule_00" value="<% CmoGetCfg("schedule_rule_00","none"); %>">
				<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<% CmoGetCfg("log_email_schedule","none"); %>">
				<input type="hidden" id="reboot_type" name="reboot_type" value="application">				
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td align="right" class="bgblue">SMTP Authentication&nbsp;</td>
                      <td class="bggrey"><input onClick=enable_smtp_auth() type=radio value=1 name=log_email_auth>					    
						Enabled
 					 <input onclick=enable_smtp_auth() type=radio value=0 name=log_email_auth>
					    Disabled</td></tr>
                    <tr>
                      <td align="right" class="bgblue">SMTP Account</td>
                      <td class="bggrey"><input type="text" id="log_email_username" name="log_email_username" size="25" maxlength="32" value="<% CmoGetCfg("log_email_username","none"); %>">
                      </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">SMTP Password</td>
                      <td class="bggrey"><input type="password" id="log_email_password" name="log_email_password" size="25" maxlength="32" value="<% CmoGetCfg("log_email_password  ","none"); %>"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">SMTP
                        Server </td>
                      <td class="bggrey"><input type=text id=log_email_server name=log_email_server size="25" maxlength="31" value="<% CmoGetCfg("log_email_server","none"); %>"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">From Email Address </td>
                      <td class="bggrey">
                        <input type=text id=log_email_sender name=log_email_sender size="25" maxlength="63" value="<% CmoGetCfg("log_email_sender","none"); %>">                        </td>
                    </tr>
                    <!--tr>
                      <td align="right" class="bgblue">SMTP Authentication </td>
                      <td class="bggrey">
                      	<input type="radio" name="smtp_enable" value="1" onclick="enable_smtp_auth()">Enabled  <input type="radio" name="smtp_enable" value="0" onclick="enable_smtp_auth()">Disabled 
                      </td>
                    </tr-->
                    <!--tr>
                      <td align="right" class="bgblue">Syslog
                        Server </td>
                      <td class="bggrey"><input type="text" id="log_server" name="log_server" size="16" maxlength="15"></td>
                    </tr-->
                    <tr>
                      <td align="right" valign="top" class="bgblue">To Email Address </td>
                      <td valign="top" class="bggrey"><input type=text id="log_email_recipien" name="log_email_recipien" size=30 maxlength=99 value="<% CmoGetCfg("log_email_recipien","none"); %>"></td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">&nbsp;</td>
                      <td valign="top" class="bggrey"><input type="button" value="Email Log Now" name="sendnow" onClick="check_smtp();"></td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue"> E-mail Logs</td>
                      <td valign="top" class="bggrey"><input type="radio" value=0 name="email_sch" onClick="email_sch_auth();">When log is full<br><br>
						 <input type="radio" value=1 name="email_sch" onClick="email_sch_auth();">
                         <select id="email_sch_day" name="email_sch_day">
                           <option value="1000000">Every Sunday</option>
                           <option value="0100000">Every Monday</option>
                           <option value="0010000">Every Tuesday</option>
                           <option value="0001000">Every Wednesday</option>
                           <option value="0000100">Every Thursday</option>
                           <option value="0000010">Every Friday</option>
                           <option value="0000001">Every Saturday</option>
                           <option value="1111111">Every Day</option>
                         </select>						
                         at 
						<select id="email_sch_time" name="email_sch_time">
							 <option value="1" selected>1</option>
							 <option value="2">2</option>
							 <option value="3">3</option>
							 <option value="4">4</option>
							 <option value="5">5</option>
							 <option value="6">6</option>
							 <option value="7">7</option>
							 <option value="8">8</option>
							 <option value="9">9</option>
							 <option value="10">10</option>
							 <option value="11">11</option>
							 <option value="12">12</option>
						 </select>
						 <select id="email_sch_ampm" name="email_sch_ampm">
							 <option value="0">AM</option>
							 <option value="1">PM</option></select>
					    </td>
					</tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue"> Syslog Server</td>
                      <td valign="top" class="bggrey"><input type=text id="sys_server" name="sys_server" size=30 maxlength=99></td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">Log
                        Type </td>
                      <td valign="top" class="bggrey">
                        <input type="checkbox" id="type1" name="type1" value="1">
                        System Activity<br>
                        <input type="checkbox" id="type2" name="type2" value="1">
                        Debug Information<br>
                        <input type="checkbox" id="type3" name="type3" value="1">
                        Attacks<br>
                        <input type="checkbox" id="type4" name="type4" value="1">
                        Dropped Packets<br>
                        <input type="checkbox" id="type5" name="type5" value="1">
                        Notice</td>
                    </tr>
                    
                    <tr>
                      <td align="right" valign="top" class="bgblue">&nbsp;</td>
                      <td height="2" class="bggrey2">
                      	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='log_setting.asp'">
						<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                      </td>
                    </tr>
                  </table>
                  </form>                
                <p>&nbsp;</p></td>
              <td background="bg2_r.gif"><img src="spacer.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td><img src="c2_bl.gif" width="10" height="10"></td>
              <td background="bg2_b.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td><img src="c2_br.gif" width="10" height="10"></td>
            </tr>
          </table></td>
        </tr>
      </table>      
      <br>
      <br></td>
    <td background="bg1_r.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="c1_bl.gif" width="21" height="20"></td>
    <td align="right" background="bg1_b.gif"><img src="copyright.gif" width="264" height="20"></td>
    <td><img src="c1_br.gif" width="21" height="20"></td>
  </tr>
</table>
</body>
</html>
