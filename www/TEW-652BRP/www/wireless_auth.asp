<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Wireless | Security</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		//wep_key_len-->0-->5,1-->13
		var wlan0_security= get_by_id("wlan0_security").value;
		set_checked("open",get_by_name("auth_type"));
		set_checked("psk",get_by_name("eap_type"));
		if(wlan0_security == "disable"){
			set_selectIndex(0,get_by_id("wep_type"));
		}else if(wlan0_security == "wep_open_64"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("open",get_by_name("auth_type"));
			set_selectIndex(5,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_open_128"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("open",get_by_name("auth_type"));
			set_selectIndex(13,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_share_64"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("share",get_by_name("auth_type"));
			set_selectIndex(5,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_share_128"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("share",get_by_name("auth_type"));
			set_selectIndex(13,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wpa_psk"){
			set_selectIndex(2,get_by_id("wep_type"));
			set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa_eap"){
			set_selectIndex(2,get_by_id("wep_type"));
			set_checked("eap",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2_psk"){
			set_selectIndex(3,get_by_id("wep_type"));
			set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2_eap"){
			set_selectIndex(3,get_by_id("wep_type"));
			set_checked("eap",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2auto_psk"){
			set_selectIndex(4,get_by_id("wep_type"));
			set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2auto_eap"){
			set_selectIndex(4,get_by_id("wep_type"));
			set_checked("eap",get_by_name("eap_type"));
		}
		
		
		
		set_selectIndex("<% CmoGetCfg("wlan0_wep_display","none"); %>", get_by_id("wlan0_wep_display"));
		set_checked("<% CmoGetCfg("wlan0_wep_default_key","none"); %>", get_by_name("wlan0_wep_default_key"));
		set_checked("<% CmoGetCfg("wlan0_psk_cipher_type","none"); %>", get_by_name("wlan0_psk_cipher_type"));

		var temp_r0 = get_by_id("wlan0_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		if(Dr0.length>1){
			get_by_id("radius_ip1").value=Dr0[0];
			get_by_id("radius_port1").value=Dr0[1];
			get_by_id("radius_pass1").value=Dr0[2];
		}
		
		var temp_r1 = get_by_id("wlan0_eap_radius_server_1").value;
		var Dr1 = temp_r1.split("/");
		if(Dr1.length>1){
			get_by_id("radius_ip2").value=Dr1[0];
			get_by_id("radius_port2").value=Dr1[1];
			get_by_id("radius_pass2").value=Dr1[2];
		}
		
		change_wep_key_fun();
		
		show_authentication();		
	}
	
	function change_wep_key_fun(){
		
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var key_type = get_by_id("wlan0_wep_display").value;
		
		get_by_id("key1_64_ascii").style.display = "none";
		get_by_id("key2_64_ascii").style.display = "none";
		get_by_id("key3_64_ascii").style.display = "none";
		get_by_id("key4_64_ascii").style.display = "none";
		get_by_id("key1_128_ascii").style.display = "none";
		get_by_id("key2_128_ascii").style.display = "none";
		get_by_id("key3_128_ascii").style.display = "none";
		get_by_id("key4_128_ascii").style.display = "none";
		get_by_id("key1_64_hex").style.display = "none";
		get_by_id("key2_64_hex").style.display = "none";
		get_by_id("key3_64_hex").style.display = "none";
		get_by_id("key4_64_hex").style.display = "none";
		get_by_id("key1_128_hex").style.display = "none";
		get_by_id("key2_128_hex").style.display = "none";
		get_by_id("key3_128_hex").style.display = "none";
		get_by_id("key4_128_hex").style.display = "none";
		
		get_by_id("key1_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		get_by_id("key2_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		get_by_id("key3_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		get_by_id("key4_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
	}
	
	function show_wpa_settings(){
		var eap_type = get_by_name("eap_type");
		
		get_by_id("show_wpa_psk").style.display = "none";
		get_by_id("show_wpa_eap").style.display = "none";
		
		if (eap_type[0].checked){
			get_by_id("show_wpa_psk").style.display = "";
		}else if (eap_type[1].checked){
			get_by_id("show_wpa_eap").style.display = "";
		}
	}
	
	function show_authentication(){
		var wep_type = get_by_id("wep_type");
		
		get_by_id("setting_wep").style.display = "none";
		get_by_id("setting_wpa").style.display = "none";
		
		if (wep_type.selectedIndex == 1){
			get_by_id("setting_wep").style.display = "";
		}else if (wep_type.selectedIndex > 1){
			get_by_id("setting_wpa").style.display = "";
			show_wpa_settings();
		}
	}
	
	function check_wpa_psk(){
		var psk1_value = get_by_id("wlan0_psk_pass_phrase").value;
		var psk2_value = get_by_id("wpapsk2").value;

		if (psk1_value != psk2_value){	// when the Passphrase does not match the Confirmed Passphrase
			alert(msg[MSG11]);
			return false;
		}else if (psk1_value.length < 8){	// when the length of the Passpharse is less than 8 characters
			alert(msg[MSG12]);
			
			return false;
		}else if (psk1_value.length > 64){
			alert(msg[MSG12]);
			get_by_id("wlan0_psk_pass_phrase").value = psk1_value.substring(0, 64);
		}
		else if((psk1_value.length == 64)||(psk2_value.length == 64)){
			if(!isHex(psk1_value)){
        alert("Passphrase types are ascii, characters can't over than 64");
       			return false;
    }
   		else if (!isHex(psk2_value)){
        alert("Confirm Passphrase types are ascii, characters can't over than 64");
        return false;
   		}
   	}
		return true;
	}

	
	function check_wpa_eap(){
		var ip1 = get_by_id("radius_ip1").value;
    	var ip2 = get_by_id("radius_ip2").value;
    	
    	var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
    	
    	var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
        var temp_radius1 = new raidus_obj(temp_ip1, get_by_id("radius_port1").value, get_by_id("radius_pass1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, get_by_id("radius_port2").value, get_by_id("radius_pass2").value);
        
        
        if (!check_radius(temp_radius1)){
    		return false;        	               
    	}else if (ip2 != "" && ip2 != "0.0.0.0"){
    		if (!check_radius(temp_radius2)){
    			return false;        	               
    		}
    	}	
    	
    	return true;	
	}
	
	function check_wpa_settings(){
		var eap_type = get_by_name("eap_type");
		
		if (eap_type[0].checked){
			return check_wpa_psk();
		}else if (eap_type[1].checked){
			return check_wpa_eap();
		}
	}
	
	function send_request(){
		var security_array = new Array("disable", "wep", "wpa", "wpa2","wpa2auto");
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var wep_type = get_by_id("wep_type");
		var is_submit = false;

		if (wep_type.selectedIndex == 0){
			get_by_id("wlan0_security").value = "disable";
			is_submit = true;
		}else if (wep_type.selectedIndex == 1){
			if (check_wep_key()){
				get_by_id("wlan0_security").value = "wep_"+ get_checked_value(get_by_name("auth_type")) +"_"+ key_num_array[key_length];
				send_key_value(key_num_array[key_length]);
				is_submit = true;
			}
			if (get_checked_value(get_by_name("auth_type"))== "share"){
				if (get_by_id("wps_enable").value==1)
				{
					if(confirm("The Shared Key cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
						get_by_id("wps_enable").value = 0;
					}else{
					is_submit = false;
					}
				}
			}
		}else if (wep_type.selectedIndex > 1){
				if (check_wpa_settings()){
					is_submit = true;
					get_by_id("wlan0_security").value = security_array[wep_type.selectedIndex] +"_"+ get_checked_value(get_by_name("eap_type"));
					//eap
					if(get_checked_value(get_by_name("eap_type")) == "eap"){
						var r_ip_0 = get_by_id("radius_ip1").value;
						var r_port_0 = get_by_id("radius_port1").value;
						var r_pass_0 = get_by_id("radius_pass1").value;
						var dat0 = r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
						get_by_id("wlan0_eap_radius_server_0").value = dat0;

						var r_ip_1 = get_by_id("radius_ip2").value;
						var r_port_1 = get_by_id("radius_port2").value;
						var r_pass_1 = get_by_id("radius_pass2").value;
						var dat1 = r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
						get_by_id("wlan0_eap_radius_server_1").value = dat1;
						if(confirm("The EAP Authentication cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
							get_by_id("wps_enable").value = 0;
						}else{
							is_submit = false;
						}
					}
					//check if cipher auto is checked, that will close wps function. 
					//if(get_checked_value(get_by_name("wlan0_psk_cipher_type")) == "both"){
					//	if(confirm("The Auto Cipher Type cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
					//		get_by_id("wps_enable").value = 0;
					//	}else{
					//		is_submit = false;
					//	}
				    //}
					}
					

		}else{
			get_by_id("asp_temp_37").value = get_by_id("wlan0_psk_pass_phrase").value;
		}
			
			get_by_id("wps_configured_mode").value = 5;
				
			if (is_submit){
			send_submit("form1");
			}

	}
	
	function send_key_value(key_length){
		var key_type = get_by_id("wlan0_wep_display").value;
		get_by_id("wlan0_wep"+ key_length +"_key_1").value = get_by_id("key1_"+ key_length +"_"+ key_type).value;
		get_by_id("wlan0_wep"+ key_length +"_key_2").value = get_by_id("key2_"+ key_length +"_"+ key_type).value;
		get_by_id("wlan0_wep"+ key_length +"_key_3").value = get_by_id("key3_"+ key_length +"_"+ key_type).value;
		get_by_id("wlan0_wep"+ key_length +"_key_4").value = get_by_id("key4_"+ key_length +"_"+ key_type).value;
		
		get_by_id("asp_temp_37").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_38").value = get_by_id("wlan0_wep"+ key_length +"_key_2").value;
		get_by_id("asp_temp_39").value = get_by_id("wlan0_wep"+ key_length +"_key_3").value;
		get_by_id("asp_temp_40").value = get_by_id("wlan0_wep"+ key_length +"_key_4").value;
		
	}
	function check_radio(){
	var tmp_wps_enable;
	tmp_wps_enable=get_by_id("wps_enable").value;
	
   for ( counter = 0; counter < document.getElementsByName("wlan0_wep_default_key").length; counter++ ) {
      if (tmp_wps_enable == 1)
      {
      	if (document.getElementsByName("wlan0_wep_default_key")[0].checked != true)
      	{
      		alert("You can't choose other key when WPS enable");
      		set_checked("1",get_by_name("wlan0_wep_default_key"));
	}      
      }
   }
}

</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_status_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_wizard_1.gif','but_help1_1.gif');loadSettings();">
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
              <td><a href="wireless_basic.asp"><img src="but_wireless_1.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                  <tr>
                    <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td width="87%"><a href="wireless_basic.asp" class="submenus"><b>Basic</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wireless_auth.asp" class="submenus"><b><u>Security</u></b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wireless_advanced.asp" class="submenus"><b>Advanced</b></a></td>
                  </tr>
				 <tr>
					<td align="right"><font color="#FFFFFF">&bull;</font></td>
					<td><a href="wlan_wps.asp" class="submenus"><b>WiFi Protected Setup</b></a></td>
				</tr>
              </table></td>
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
    <td width="85%" class="headerbg">Security</td>
    <td width="15%" class="headerbg"><a href="help_wlan.asp#wireless_WEP" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
  </tr>
</table>
					<form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                    <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless_auth.asp">
                    <input type="hidden" id="wlan0_security" name="wlan0_security" value="<% CmoGetCfg("wlan0_security","none"); %>">
                    <input type="hidden" id="wlan0_eap_radius_server_0" name="wlan0_eap_radius_server_0" value="<% CmoGetCfg("wlan0_eap_radius_server_0","none"); %>">
					<input type="hidden" id="wlan0_eap_radius_server_1" name="wlan0_eap_radius_server_1" value="<% CmoGetCfg("wlan0_eap_radius_server_1","none"); %>">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
                    <input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<% CmoGetCfg("wps_configured_mode","none"); %>">
                    <input type="hidden" name="wps_enable" id="wps_enable" value="<% CmoGetCfg("wps_enable","none"); %>">
                    <input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<% CmoGetCfg("asp_temp_37","hex"); %>">
                    <input type="hidden" id="asp_temp_38" name="asp_temp_38" value="<% CmoGetCfg("asp_temp_38","hex"); %>">
                    <input type="hidden" id="asp_temp_39" name="asp_temp_39" value="<% CmoGetCfg("asp_temp_39","hex"); %>">
                    <input type="hidden" id="asp_temp_40" name="asp_temp_40" value="<% CmoGetCfg("asp_temp_40","hex"); %>">
                    
                      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td width="30%" align="right" class="bgblue">Authentication Type</td>
                          <td width="70%" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">
                            <select id="wep_type" name="wep_type" onChange="show_authentication()">
                              <option value="0"> Disable </option>
                              <option value="1"> WEP </option>
                              <option value="2"> WPA </option>
                              <option value="3"> WPA2 </option>
							  <option value="4"> WPA-AUTO </option>                           
                            </select>
                          </font> </td>
                        </tr>
                        <tr id="setting_wep" style="display:none">
                          <td colspan="2" width="100%">
                          	<table width="100%" border="0" cellpadding="0" cellspacing="1">
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">WEP&nbsp;</font></td>
                                <td class="bggrey"><font face="Arial" size="2"><b>
                                  <input type=radio name="auth_type" value="open">
                                  Open System
                                  <input type=radio name="auth_type" value="share">
                                  Shared Key</b> </font></td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"> <font face="Arial">Mode&nbsp;</font></td>
                                <td width="70%" class="bggrey">
                                	<select id="wlan0_wep_display" name="wlan0_wep_display" onChange="change_wep_key_fun()">
                                    	<option value="hex">HEX</option>
                                    	<option value="ascii">ASCII</option>
                                  	</select>
                               	</td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">WEP Key&nbsp;</font></td>
                                <td width="70%" class="bggrey"><font face="Arial" size="2">
                                  <select size="1" name="wep_key_len" id="wep_key_len" onChange="change_wep_key_fun();">
                                    <option value="5">64-bit</option>
                                    <option value="13">128-bit</option>
                                  </select>
                                </font></td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 1&nbsp;</font></td>
                                <td width="70%" class="bggrey">
                                	<input type="radio" value="1" name="wlan0_wep_default_key" onclick="check_radio()">                    
	                    			<input type="text" id="key1_64_hex" name="key1_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>" style="display:none"><input type="text" id="key1_128_hex" name="key1_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>" style="display:none "><input type="text" id="key1_64_ascii" name="key1_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("wlan0_wep64_key_1","ascii"); %>" style="display:none "><input type="text" id="key1_128_ascii" name="key1_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("wlan0_wep128_key_1","ascii"); %>" style="display:none ">
									<input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1" value="<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>">
									<input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1" value="<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>">
	                    		</td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 2&nbsp;</font></td>
                                <td width="70%" class="bggrey">
                                	<input type="radio" value="2" name="wlan0_wep_default_key" onclick="check_radio()">                    
                                	<input type="text" id="key2_64_hex" name="key2_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("wlan0_wep64_key_2","hex"); %>" style="display:none "><input type="text" id="key2_128_hex" name="key2_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("wlan0_wep128_key_2","hex"); %>" style="display:none "><input type="text" id="key2_64_ascii" name="key2_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("wlan0_wep64_key_2","ascii"); %>" style="display:none "><input type="text" id="key2_128_ascii" name="key2_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("wlan0_wep128_key_2","ascii"); %>" style="display:none ">
									<input type="hidden" id="wlan0_wep64_key_2" name="wlan0_wep64_key_2" value="<% CmoGetCfg("wlan0_wep64_key_2","hex"); %>">
									<input type="hidden" id="wlan0_wep128_key_2" name="wlan0_wep128_key_2" value="<% CmoGetCfg("wlan0_wep128_key_2","hex"); %>">
	                    		</td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 3&nbsp;</font></td>
                                <td width="70%" class="bggrey">
                                	<input type="radio" value="3" name="wlan0_wep_default_key" onclick="check_radio()">                    
	                    			<input type="text" id="key3_64_hex" name="key3_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("wlan0_wep64_key_3","hex"); %>" style="display:none "><input type="text" id="key3_128_hex" name="key3_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("wlan0_wep128_key_3","hex"); %>" style="display:none "><input type="text" id="key3_64_ascii" name="key3_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("wlan0_wep64_key_3","ascii"); %>" style="display:none "><input type="text" id="key3_128_ascii" name="key3_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("wlan0_wep128_key_3","ascii"); %>" style="display:none ">
									<input type="hidden" id="wlan0_wep64_key_3" name="wlan0_wep64_key_3" value="<% CmoGetCfg("wlan0_wep64_key_3","hex"); %>">
									<input type="hidden" id="wlan0_wep128_key_3" name="wlan0_wep128_key_3" value="<% CmoGetCfg("wlan0_wep128_key_3","hex"); %>">
	                    		</td>
                              </tr>
                              <tr bgcolor="#CCCCCC">
                                <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 4&nbsp;</font></td>
                                <td width="70%" class="bggrey">
                                	<input type="radio" value="4" name="wlan0_wep_default_key" onclick="check_radio()">                    
	                    			<input type="text" id="key4_64_hex" name="key4_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("wlan0_wep64_key_4","hex"); %>" style="display:none "><input type="text" id="key4_128_hex" name="key4_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("wlan0_wep128_key_4","hex"); %>" style="display:none "><input type="text" id="key4_64_ascii" name="key4_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("wlan0_wep64_key_4","ascii"); %>" style="display:none "><input type="text" id="key4_128_ascii" name="key4_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("wlan0_wep128_key_4","ascii"); %>" style="display:none ">
									<input type="hidden" id="wlan0_wep64_key_4" name="wlan0_wep64_key_4" value="<% CmoGetCfg("wlan0_wep64_key_4","hex"); %>">
									<input type="hidden" id="wlan0_wep128_key_4" name="wlan0_wep128_key_4" value="<% CmoGetCfg("wlan0_wep128_key_4","hex"); %>">
	                    		</td>
                              </tr>
                          </table></td>
                        </tr>
                        <tr id="setting_wpa" style="display:none">
                        	<td colspan="2">
          						<table width="100%" border="0" cellpadding="0" cellspacing="1">
          							<tr>
                          				<td width="30%" align="right" class="bgblue">PSK / EAP</td>
                          				<td width="70%" class="bggrey"><font size="2"><b>
                            				<input name="eap_type" type="radio" value="psk" onClick="show_wpa_settings()">
                            				PSK
                            				<input name="eap_type" type="radio" value="eap" onClick="show_wpa_settings()">
                            				EAP </b></font>
                            			</td>
                        			</tr>
                        			<tr>
                          				<td width="30%" align="right" class="bgblue">Cipher Type</td>
                          				<td width="70%" class="bggrey"><font size="2"><b>
                            				<input name="wlan0_psk_cipher_type" type="radio" value="tkip">
                            				TKIP
                            				<input name="wlan0_psk_cipher_type" type="radio" value="aes">
                            				AES
                            				<input name="wlan0_psk_cipher_type" type="radio" value="both">
                            				Auto
                            				</b></font>
                            			</td>
                        			</tr>
                        			<tr id="show_wpa_psk" style="display:none">
                          				<td colspan="2">
                          					<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                              					<tr bgcolor="#CCCCCC">
                                					<td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Passphrase :</font></td>
                                					<td width="70%" class="bggrey"><input type="password" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" size="40" maxlength="64" value="<% CmoGetCfg("wlan0_psk_pass_phrase","none"); %>"></td>
                              					</tr>
                              					<tr bgcolor="#CCCCCC">
                                					<td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Confirmed Passphrase :</font></td>
                               					  <td width="70%" class="bggrey"><input type="password" name="wpapsk2" id="wpapsk2" size="40" maxlength="64" value="<% CmoGetCfg("wlan0_psk_pass_phrase","none"); %>">
                                					</td>
                              					</tr>
                          					</table>
                          				</td>
                        			</tr>
                        			<tr id="show_wpa_eap" style="display:none">
                          				<td colspan="2">
						  					<table width="100%" border="0" cellpadding="0" cellspacing="1">                              					
                              					<tr>
                                					<td width="34%" rowspan="3" align="right" valign="top" class="bgblue"> RADIUS Server 1</td>
                                					<td width="8%" height="2" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">IP</font></td>
                                					<td width="58%" height="2" bgcolor="#FFFFFF" class="bggrey"><input id="radius_ip1" name="radius_ip1" size="16" maxlength="15"></td>
                              					</tr>
                              					<tr>
                                					<td height="2" class="bggrey"><font face="Arial" size="2">Port</font></td>
                                					<td height="2" class="bggrey"><input type="text" id="radius_port1" name="radius_port1" size="5" maxlength="5"></td>
                              					</tr>
                              					<tr>
                                					<td height="2" nowrap class="bggrey"><font face="Arial" size="2">Shared Secret</font></td>
                                					<td height="2" class="bggrey"><input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64"></td>
                              					</tr>
                              					<tr>
                                					<td width="34%" rowspan="3" align="right" class="bgblue">RADIUS Server 2<br>(Optional)</td>
                                					<td width="8%" height="2" class="bggrey"><font face="Arial" size="2">IP</font></td>
                                					<td width="58%" height="2" class="bggrey"><input id="radius_ip2" name="radius_ip2" size="16" maxlength="15"></td>
                              					</tr>
                              					<tr>
                                					<td height="2" class="bggrey"><font face="Arial" size="2">Port</font></td>
                                					<td height="2" class="bggrey"><input type="text" id="radius_port2" name="radius_port2" size="5" maxlength="5"></td>
                              					</tr>
                              					<tr>
                                					<td height="2" nowrap class="bggrey"><font face="Arial" size="2">Shared Secret</font></td>
                                					<td height="2" class="bggrey"><input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64"></td>
                              					</tr>
                          					</table>
                          				</td>
                        			</tr>
                        		</table>
                        	</td>
                        </tr>
                        <tr>
                          <td colspan="2" class="bggrey2">						     
							<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='wireless_auth.asp'">
							<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                            <input type="button" value="Clear" name="clear" onClick="window.location='wireless_auth.asp'"></td>
                        </tr>
                      </table>
        				<input type="hidden" id="restore_wireless" name="restore_wireless"> 
                </form>                    <p>&nbsp;</p></td>
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