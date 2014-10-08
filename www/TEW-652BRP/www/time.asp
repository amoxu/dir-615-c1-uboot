<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | Time</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(is_true){
		var sel_time_zone = "<% CmoGetCfg("time_zone","none"); %>";
		var count_year = 0;
		var count_day = 0;
		var count_hour = 0;
		var count_min = 0;
		var count_sec = 0;
		var year= get_by_id("year");
		var day=get_by_id("day");
		var hour=get_by_id("hour");
		var min=get_by_id("min");
		var sec=get_by_id("sec");
		day.options.length = 0;
		var tmp_year = get_by_id("year").value;

		get_by_id("time_zone").selectedIndex = get_by_id("time_zone_area").value;

		set_selectIndex(get_by_id("ntp_client_enable").value, get_by_id("ntp_enable"));
		set_checked(get_by_id("time_daylight_saving_enable").value,get_by_name("daylight_enable"));

		set_selectIndex(get_by_id("saving_start_month").value, get_by_id("time_daylight_saving_start_month"));
		set_selectIndex(get_by_id("saving_start_week").value, get_by_id("time_daylight_saving_start_week"));
		set_selectIndex(get_by_id("saving_start_day_of_week").value, get_by_id("time_daylight_saving_start_day_of_week"));
		set_selectIndex(get_by_id("saving_end_month").value, get_by_id("time_daylight_saving_end_month"));
		set_selectIndex(get_by_id("saving_end_week").value, get_by_id("time_daylight_saving_end_week"));
		set_selectIndex(get_by_id("saving_end_day_of_week").value, get_by_id("time_daylight_saving_end_day_of_week"));

		disable_ntp_server();
		if(is_true){
			show_time();
		}
		for(var i=2007;i<=2037; i++)//year
				{					
					var year_option = document.createElement("option");	
										
		
					year_option.text = i;
					year_option.value = i;
					year.options[count_year++] = year_option;
				}
		for(var i=1;i<=31; i++)//day
				{					
			var mon = get_by_id("mon").value;
					var day_option = document.createElement("option");	
										
					if(i<10)
					{
						var temp_day=i;					
						day_option.text ="0"+temp_day;
					}
					else
					{
						day_option.text = i;
					}					
			if((mon=="1")||(mon=="3")||(mon=="5")||(mon=="7")||(mon=="8")||(mon=="10")||(mon=="12"))
			{					
					day_option.value = i;
					day.options[count_day++] = day_option;
			}
			else if(mon=="2")
			{
				if (tmp_year%4== 0)
				{
					if(i<30)
					{
						day_option.value = i;
						day.options[count_day++] = day_option;
					}
					else
						{
							break;
						}
				}
				else
				{
						if(i<30)
						{
							day_option.value = i;
							day.options[count_day++] = day_option;
						}
						else
						{
							break;
						}
				}
			}
			else
				{
					if(i<31)
					{
					day_option.value = i;
					day.options[count_day++] = day_option
				}
				}
		}
		for(var i=0;i<=23; i++)//hour
				{					
					var hour_option = document.createElement("option");		
					if(i<10)
					{
						var temp_hour=i;
						hour_option.text ="0"+temp_hour;
					}
					else
					{
						hour_option.text = i;
					}					

					hour_option.value = i;
					hour.options[count_hour++] = hour_option
				}
		for(var i=0;i<=59; i++)//min
				{					
					var min_option = document.createElement("option");	
					if(i<10)
					{
						var temp_min=i;
						
						min_option.text ="0"+temp_min;
					}
					else
					{
						min_option.text = i;
					}	
					min_option.value = i;
					min.options[count_min++] = min_option
				}
		for(var i=0;i<=59; i++)//sec
				{					
					var sec_option = document.createElement("option");						
					if(i<10)
					{
						var temp_sec=i;
						sec_option.text ="0"+temp_sec;
					}
					else
					{
						sec_option.text = i;
					}	
					sec_option.value = i;
					sec.options[count_sec++] = sec_option
				}
		show_time()		
	}
		
	function show_time(){
		var temp_time = get_by_id("system_time").value;
		var Dtime = temp_time.split("/");
		set_selectIndex(Dtime[0], get_by_id("year"));
		set_selectIndex(Dtime[1], get_by_id("mon"));
		set_selectIndex(Dtime[2], get_by_id("day"));
		set_selectIndex(parseInt(Dtime[3],10), get_by_id("hour"));
		set_selectIndex(parseInt(Dtime[4],10), get_by_id("min"));
		set_selectIndex(parseInt(Dtime[5],10), get_by_id("sec"));
	}
	
	function disable_ntp_server(){
		var is_disable = false;
		
		if (get_by_id("ntp_enable").selectedIndex > 0){
			is_disable = true;
		}
		get_by_id("ntp_server").disabled = is_disable;
		get_by_id("year").disabled = !is_disable;
		get_by_id("mon").disabled = !is_disable;
		get_by_id("day").disabled = !is_disable;
		get_by_id("hour").disabled = !is_disable;
		get_by_id("min").disabled = !is_disable;
		get_by_id("sec").disabled = !is_disable;
		get_by_id("set").disabled = !is_disable;
		get_by_name("daylight_enable")[0].disabled = is_disable;
		get_by_name("daylight_enable")[1].disabled = is_disable;
		show_daylight();
	}
	
	function show_daylight(){
		var daylight = get_by_name("daylight_enable")[0];
		var time_type = get_by_id("ntp_enable");
		var is_disable = true;
		
		if (daylight.checked && time_type.selectedIndex==0){
			is_disable = false;
		}
		
		get_by_id("time_daylight_saving_start_month").disabled = is_disable;
		get_by_id("time_daylight_saving_start_week").disabled = is_disable;
		get_by_id("time_daylight_saving_start_day_of_week").disabled = is_disable;
		get_by_id("time_daylight_saving_start_time").disabled = is_disable;
		get_by_id("time_daylight_saving_end_month").disabled = is_disable;
		get_by_id("time_daylight_saving_end_week").disabled = is_disable;		
		get_by_id("time_daylight_saving_end_day_of_week").disabled = is_disable;
		get_by_id("time_daylight_saving_end_time").disabled = is_disable;
	}
	
	function send_request(is_true){

		get_by_id("time_zone_area").value = document.getElementById("time_zone").selectedIndex;
		get_by_id("ntp_client_enable").value = get_select_value(get_by_id("ntp_enable"));
		var time_type = get_by_id("ntp_enable");
		if (time_type.selectedIndex== 1){
			var year = get_by_id("year").value;
			var mon = get_by_id("mon").value;
			var day = get_by_id("day").value;

			var hour = get_by_id("hour").value;
			var minu = get_by_id("min").value;
			var sec = get_by_id("sec").value;

			var dat =year +"/"+ mon +"/"+ day +"/"+ hour +"/"+ minu +"/"+ sec;
			get_by_id("system_time").value = dat;		
			
			get_by_id("apply_2nd_cgi_parameter").value = dat;
			get_by_id("apply_2nd_cgi").value = "system_time.cgi";	
		}else{
			if(get_by_id("ntp_server").value == ""){
				alert("Please enter NTP Server");
				return false;
			}
		}
		if(is_true){
			loadSettings(!is_true)
		}
		get_by_id("time_daylight_saving_enable").value = get_checked_value(get_by_name("daylight_enable"));
		send_submit("form1");
	}
function change_day(){
		var count_year = 0;
		var count_day = 0;
		var count_hour = 0;
		var count_min = 0;
		var count_sec = 0;
		var year= get_by_id("year");
		var day=get_by_id("day");
		var hour=get_by_id("hour");
		var min=get_by_id("min");
		var sec=get_by_id("sec");
		day.options.length = 0;
		var tmp_year = get_by_id("year").value;
		for(var i=1;i<=31; i++)//day
				{					
					var mon = get_by_id("mon").value;
					var day_option = document.createElement("option");	
										
					if(i<10)
					{
						var temp_day=i;					
						day_option.text ="0"+temp_day;
					}
					else
					{
						day_option.text = i;
					}
					if((mon=="1")||(mon=="3")||(mon=="5")||(mon=="7")||(mon=="8")||(mon=="10")||(mon=="12"))
					{					
							day_option.value = i;
							day.options[count_day++] = day_option
					}
					else if(mon=="2")
					{
						if (tmp_year%4==0)
						{
							if(i<30)
							{
								day_option.value = i;
								day.options[count_day++] = day_option
							}
						}
						else
							{
								if(i<29)
								{
									day_option.value = i;
									day.options[count_day++] = day_option
								}
							}
					}
					else
						{
							if(i<31)
							{
								day_option.value = i;
								day.options[count_day++] = day_option
							}
						else
							{
								break;
							}
						}
				}
	}
</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');loadSettings(true);">
<table width="750" border="0" cellpadding="0" cellspacing="0">
<input type="hidden" id="saving_start_month" name="saving_start_month" value="<% CmoGetCfg("time_daylight_saving_start_month","none"); %>">
<input type="hidden" id="saving_start_week" name="saving_start_week" value="<% CmoGetCfg("time_daylight_saving_start_week","none"); %>">
<input type="hidden" id="saving_start_day_of_week" name="saving_start_day_of_week" value="<% CmoGetCfg("time_daylight_saving_start_day_of_week","none"); %>">
<input type="hidden" id="saving_end_month" name="saving_end_month" value="<% CmoGetCfg("time_daylight_saving_end_month","none"); %>">
<input type="hidden" id="saving_end_week" name="saving_end_week" value="<% CmoGetCfg("time_daylight_saving_end_week","none"); %>">
<input type="hidden" id="saving_end_day_of_week" name="saving_end_day_of_week" value="<% CmoGetCfg("time_daylight_saving_end_day_of_week","none"); %>">
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
              <td><a href="lan.asp"><img src="but_main_1.gif" name="Image2" width="144" height="28" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','but_main_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                <tr>
                  <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td width="87%"><a href="lan.asp" class="submenus"><b>LAN &amp; DHCP Server </b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="wan.asp" class="submenus"><b>WAN</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="password.asp" class="submenus"><b>Password</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="time.asp" class="submenus"><b><u>Time</u></b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="ddns.asp" class="submenus"><b>Dynamic DNS </b></a></td>
                </tr>
              </table></td>
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
              <td><a href="status.asp"><img src="but_status_0.gif" name="Image1" width="144" height="28" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','but_status_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
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
              <td>&nbsp;</td>
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
              <td background="bg3.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="400">
                    <table width="100%" border="0" cellpadding="3" cellspacing="0">
                      <tr>
                        <td width="85%" class="headerbg">Time</td>
                        <td width="15%" class="headerbg"><a href="help_main.asp#main_time" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                      </tr>
                    </table>
                    <form id="form1" name="form1" method="post" action="apply.cgi">
                    <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                    <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="time.asp">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="application">
                    <input type="hidden" id="apply_2nd_cgi" name="apply_2nd_cgi" value="">
                    <input type="hidden" id="apply_2nd_cgi_parameter" name="apply_2nd_cgi_parameter" value="">
                    <input type="hidden" id="system_time" name="system_time" value="<% CmoGetStatus("system_time"); %>">
                    <input type="hidden" id="ntp_client_enable" name="ntp_client_enable" value="<% CmoGetCfg("ntp_client_enable","none"); %>">
                    <input type="hidden" id="time_daylight_saving_enable" name="time_daylight_saving_enable" value="<% CmoGetCfg("time_daylight_saving_enable","none"); %>">
                    <input type="hidden" id="time_daylight_saving_start_time" name="time_daylight_saving_start_time" value="0">
                    <input type="hidden" id="time_daylight_saving_end_time" name="time_daylight_saving_end_time" value="23">
                    <input type="hidden" id="time_zone_area" name="time_zone_area" value="<% CmoGetCfg("time_zone_area","none"); %>">
                      <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td align="right" class="bgblue">Local Time</td>
                          <td class="bggrey">
                          <script>
														var temp_entry ="<% CmoGetStatus("system_time"); %>";
														var entry = temp_entry.split("/");
														var v_mon="";
														if(entry[1]=="1"){
															v_mon = "Jan";
														}else if(entry[1]=="2"){
															v_mon = "Feb";
														}else if(entry[1]=="3"){
															v_mon = "Mar";
														}else if(entry[1]=="4"){
															v_mon = "Apr";
														}else if(entry[1]=="5"){
															v_mon = "May";
														}else if(entry[1]=="6"){
															v_mon = "Jun";
														}else if(entry[1]=="7"){
															v_mon = "Jul";
														}else if(entry[1]=="8"){
															v_mon = "Aug";
														}else if(entry[1]=="9"){
															v_mon = "Sep";
														}else if(entry[1]=="10"){
															v_mon = "Oct";
														}else if(entry[1]=="11"){
															v_mon = "Nov";
														}else if(entry[1]=="12"){
															v_mon = "Dec";
														}else{
															v_mon = "";
														}
																document.write(v_mon + "/" + entry[2] + "/" + entry[0] + " " + entry[3] + ":" + entry[4] + ":" + entry[5]);
							
													</script>
                          
                          
                          </td>
                        </tr>
                        <tr>
                          <td align="right" class="bgblue">Time Zone</td>
                          <td class="bggrey">
                              <select size="1" id="time_zone" name="time_zone">
<option value="-192">(GMT-12:00) Eniwetok, Kwajalein</option>
								 <option value="-176">(GMT-11:00) Midway Island, Samoa</option>
								 <option value="-160">(GMT-10:00) Hawaii</option>
								 <option value="-144">(GMT-09:00) Alaska</option>
								 <option value="-128">(GMT-08:00) Pacific Time (US/Canada), Tijuana</option>
								 <option value="-112">(GMT-07:00) Arizona</option>
								 <option value="-112">(GMT-07:00) Mountain Time (US/Canada)</option>
								 <option value="-96">(GMT-06:00) Central America</option>
								 <option value="-96">(GMT-06:00) Central Time (US/Canada)</option>
								 <option value="-96">(GMT-06:00) Mexico City</option>
								 <option value="-96">(GMT-06:00) Saskatchewan</option>
								 <option value="-80">(GMT-05:00) Bogota, Lima, Quito</option>
								 <option value="-80">(GMT-05:00) Eastern Time (US/Canada)</option>
								 <option value="-80">(GMT-05:00) Indiana (East)</option>
								 <option value="-64">(GMT-04:30) Caracas, Venezuela</option>
								 <option value="-64">(GMT-04:00) Atlantic Time (Canada)</option>
								 <option value="-64">(GMT-04:00) La Paz</option>
								 <option value="-64">(GMT-04:00) Santiago</option>
								 <option value="-48">(GMT-03:30) Newfoundland</option>
								 <option value="-48">(GMT-03:00) Brazilia</option>
								 <option value="-48">(GMT-03:00) Buenos Aires, Georgetown</option>
								 <option value="-48">(GMT-03:00) Greenland</option>
								 <option value="-32">(GMT-02:00) Mid-Atlantic</option>
								 <option value="-16">(GMT-01:00) Azores</option>
								 <option value="-16">(GMT-01:00) Cape Verde Is.</option>
								 <option value="0">(GMT) Casablanca, Monrovia</option>
								 <option value="0">(GMT) Greenwich Time: Dublin, Edinburgh, Lisbon, London</option>
								 <option value="16">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm</option>
								 <option value="16">(GMT+01:00) Belgrade, Brastislava, Ljubljana</option>
								 <option value="16">(GMT+01:00) Brussels, Copenhagen, Madrid, Paris</option>
								 <option value="16">(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb</option>
								 <option value="16">(GMT+01:00) Budapest, Vienna, Prague, Warsaw</option>
								 <option value="16">(GMT+01:00) West Central Africa</option>
								 <option value="32">(GMT+02:00) Athens, Istanbul, Minsk</option>
								 <option value="32">(GMT+02:00) Bucharest</option>
								 <option value="32">(GMT+02:00) Cairo</option>
								 <option value="32">(GMT+02:00) Harare, Pretoria</option>
								 <option value="32">(GMT+02:00) Helsinki, Riga, Tallinn</option>
								 <option value="32">(GMT+02:00) Jerusalem</option>
								 <option value="48">(GMT+03:00) Baghdad</option>
								 <option value="48">(GMT+03:00) Kuwait, Riyadh</option>
								 <option value="48">(GMT+03:00) Moscow, St. Petersburg, Volgograd</option>
								 <option value="48">(GMT+03:00) Nairobi</option>
								 <option value="48">(GMT+03:00) Tehran</option>
								 <option value="64">(GMT+04:00) Abu Dhabi, Muscat</option>
								 <option value="64">(GMT+04:00) Baku, Tbilisi, Yerevan</option>
								 <option value="72">(GMT+04:30) Kabul</option>
								 <option value="80">(GMT+05:00) Ekaterinburg</option>
								 <option value="80">(GMT+05:00) Islamabad, Karachi, Tashkent</option>
								 <option value="88">(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi</option>
								 <option value="92">(GMT+05:45) Kathmandu</option>
								 <option value="96">(GMT+06:00) Almaty, Novosibirsk</option>
								 <option value="96">(GMT+06:00) Astana, Dhaka</option>
								 <option value="96">(GMT+06:00) Sri Jayawardenepura</option>
								 <option value="104">(GMT+06:30) Rangoon</option>
								 <option value="112">(GMT+07:00) Bangkok, Hanoi, Jakarta</option>
								 <option value="112">(GMT+07:00) Krasnoyarsk</option>
								 <option value="128">(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi</option>
								 <option value="128">(GMT+08:00) Irkutsk, Ulaan Bataar</option>
								 <option value="128">(GMT+08:00) Kuala Lumpur, Singapore</option>
								 <option value="128">(GMT+08:00) Perth</option>
								 <option value="128">(GMT+08:00) Taipei</option>
								 <option value="144">(GMT+09:00) Osaka, Sapporo, Tokyo</option>
								 <option value="144">(GMT+09:00) Seoul</option>
								 <option value="144">(GMT+09:00) Yakutsk</option>
								 <option value="152">(GMT+09:30) Adelaide</option>
								 <option value="152">(GMT+09:30) Darwin</option>
								 <option value="160">(GMT+10:00) Brisbane</option>
								 <option value="160">(GMT+10:00) Canberra, Melbourne, Sydney</option>
								 <option value="160">(GMT+10:00) Guam, Port Moresby</option>
								 <option value="160">(GMT+10:00) Hobart</option>
								 <option value="160">(GMT+10:00) Vladivostok</option>
								 <option value="176">(GMT+11:00) Magadan, Solomon Is., New Caledonia</option>
								 <option value="192">(GMT+12:00) Auckland, Wellington</option>
								 <option value="192">(GMT+12:00) Fiji, Kamchatka, Marshall Is.</option>
								 <option value="208">(GMT+13:00) Nuku'alofa, Tonga</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td height="24" align="right" class="bgblue">Synchronize the<br>
                            clock with</td>
                          <td class="bggrey">
                              <select id="ntp_enable" name="ntp_enable" size="1" onChange="disable_ntp_server();">
                              <option value="1">Automatic</option>
                              <option value="0">Manual</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td height="24" align="right" class="bgblue">Default NTP server</td>
                          <td class="bggrey"><input type="text" id="ntp_server" name="ntp_server" size="70" maxlength="60" value="<% CmoGetCfg("ntp_server","none"); %>"></td>
                        </tr>
                        <tr>
                          <td height=17 rowspan=2 align="right" valign=center class="bgblue">Set the time</td>
                          <td class="bggrey">Year
                            <select id="year" name="year" size=1>


			                </select>
                            Month
                            <select id="mon" name="mon" size=1 onclick="change_day()">
                              <option value=1>Jan</option>
                              <option value=2>Feb</option>
                              <option value=3>Mar</option>
                              <option value=4>Apr</option>
                              <option value=5>May</option>
                              <option value=6>Jun</option>
                              <option value=7>Jul</option>
                              <option value=8>Aug</option>
                              <option value=9>Sep</option>
                              <option value=10>Oct</option>
                              <option value=11>Nov</option>
                              <option value=12>Dec</option>
                            </select>
                            Day
                            <select id="day" name="day" size=1>
                              
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td class="bggrey">Hour
                            <select id="hour" name="hour" size=1>
                                
                              </select>
                            Minute
                            <select id="min" name="min" size=1>
                              
                            </select>
                            Second
                            <select id="sec" name="sec" size=1>
                             
                            </select>
                            <input type="button" id="set" name="set" value="Set Time" onClick="send_request(true)">
                          </td>
                        </tr>
                        <tr>
                          <td height=26 align="right" class="bgblue">Daylight Saving</td>
                          <td class="bggrey">
                            <input type="radio" name="daylight_enable" value="1" onClick="show_daylight();">
                            Enabled
                            <input type="radio" name="daylight_enable" value="0" onClick="show_daylight();">
                            Disabled<br>
                            Start
                            <select id="time_daylight_saving_start_month" name="time_daylight_saving_start_month" size=1>
                              <option value=1>Jan</option>
                              <option value=2>Feb</option>
                              <option value=3>Mar</option>
                              <option value=4>Apr</option>
                              <option value=5>May</option>
                              <option value=6>Jun</option>
                              <option value=7>Jul</option>
                              <option value=8>Aug</option>
                              <option value=9>Sep</option>
                              <option value=10>Oct</option>
                              <option value=11>Nov</option>
                              <option value=12>Dec</option>
                            </select>
                            <select id="time_daylight_saving_start_week" name="time_daylight_saving_start_week" size=1>
                              <option value="1">1st</option>
                              <option value="2">2nd</option>
                              <option value="3">3rd</option>
                              <option value="4">4th</option>
                              <option value="5">5th</option>
                              <option value="6">6th</option>
                            </select>
                            <select name="time_daylight_saving_start_day_of_week" id="time_daylight_saving_start_day_of_week" size=1>
                            	<option value="1">Sun</option>
                            	<option value="2">Mon</option>
                            	<option value="3">Tue</option>
                                <option value="4">Wed</option>
                                <option value="5">Thu</option>
                                <option value="6">Fri</option>
                                <option value="7">Sat</option>
                            </select>
                            End
                            <select id="time_daylight_saving_end_month" name="time_daylight_saving_end_month" size=1>
                              <option value=1>Jan</option>
                              <option value=2>Feb</option>
                              <option value=3>Mar</option>
                              <option value=4>Apr</option>
                              <option value=5>May</option>
                              <option value=6>Jun</option>
                              <option value=7>Jul</option>
                              <option value=8>Aug</option>
                              <option value=9>Sep</option>
                              <option value=10>Oct</option>
                              <option value=11>Nov</option>
                              <option value=12>Dec</option>
                            </select>
                            <select id="time_daylight_saving_end_week" name="time_daylight_saving_end_week" style="WIDTH: 50px">
                              <option value="1">1st</option>
                              <option value="2">2nd</option>
                              <option value="3">3rd</option>
                              <option value="4">4th</option>
                              <option value="5">5th</option>
                              <option value="6">6th</option>
                            </select>
                            <select name="time_daylight_saving_end_day_of_week" id="time_daylight_saving_end_day_of_week" style="WIDTH: 50px">
                            	<option value=1>Sun</option>
                            	<option value=2>Mon</option>
                            	<option value=3>Tue</option>
                            	<option value=4>Wed</option>
                            	<option value=5>Thu</option>
                            	<option value=6>Fri</option>
                            	<option value=7>Sat</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td align="right" class="bgblue">&nbsp;</td>
                          <td class="bggrey2">
                          	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='time.asp'">
							<input type="button" id="apply" name="apply" value="Apply" onClick="send_request(false)">
                          </td>
                        </tr>
                      </table>
                      <p>&nbsp;</p>
                      </form>
                    <p>&nbsp;</p></td>
                </tr>
              </table>
                </td>
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
      <img src="spacer.gif" width="15" height="15"><br>
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
