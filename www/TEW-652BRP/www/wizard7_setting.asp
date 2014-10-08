<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public.js"></script>
</head>
<body text="#000000" leftmargin="0" topmargin="0">
<form id="form1" name="form1" method="post" action="apply.cgi">
	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_close.asp">
	<input type="hidden" id="html_response_message" name="html_response_message" value="Save and reboot now ...... ">
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
	<input type="hidden" id="reboot_type" name="reboot_type" value="all">

	<input type="hidden" id="admin_password" name="admin_password" value="<% CmoGetCfg("asp_temp_00","none"); %>">
	<input type="hidden" id="time_zone" name="time_zone" value="<% CmoGetCfg("asp_temp_01","none"); %>">
	<input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("asp_temp_02","none"); %>">
	
	<!-- lan -->
	<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<% CmoGetCfg("asp_temp_41","none"); %>">
	<input type="hidden" id="lan_netmask" name="lan_netmask" value="<% CmoGetCfg("asp_temp_42","none"); %>">
	<input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("asp_temp_43","none"); %>">
	<input type="hidden" id="dhcpd_start" name="dhcpd_start" value="<% CmoGetCfg("asp_temp_44","none"); %>">
	<input type="hidden" id="dhcpd_end" name="dhcpd_end" value="<% CmoGetCfg("asp_temp_45","none"); %>">

	
	<!-- wireless -->
	<input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<% CmoGetCfg("asp_temp_34","none"); %>">
	<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="<% CmoGetCfg("asp_temp_35","none"); %>">
	<input type="hidden" id="wlan0_channel" name="wlan0_channel" value="<% CmoGetCfg("asp_temp_36","none"); %>">
	
	<!-- wireless security -->
	<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<% CmoGetCfg("asp_temp_50","none"); %>">
	<input type="hidden" id="wps_enable" name="wps_enable" value="<% CmoGetCfg("asp_temp_51","none"); %>">
	<input type="hidden" id="wlan0_security" name="wlan0_security" value="<% CmoGetCfg("asp_temp_52","none"); %>">
	<input type="hidden" id="wlan0_wep_display" name="wlan0_wep_display" value="<% CmoGetCfg("asp_temp_wep_display","none"); %>">
	<input type="hidden" id="wlan0_wep_default_key" name="wlan0_wep_default_key" value="<% CmoGetCfg("asp_temp_54","none"); %>">
	<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<% CmoGetCfg("asp_temp_55","none"); %>">
	<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<% CmoGetCfg("asp_temp_56","none"); %>">

	<!-- other -->
	<input type="hidden" id="asp_temp_59" name="asp_temp_59" value="">
	<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("asp_temp_47","none"); %>">
	<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("asp_temp_48","none"); %>">
	<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("asp_temp_49","none"); %>">
    
	<script>
		var wan_type = get_by_id("wan_proto").value;
		var russia_poe_type = get_by_id("wan_pppoe_russia_enable").value;
		var russia_pptp_type = get_by_id("wan_pptp_russia_enable").value;
		var russia_l2tp_type = get_by_id("wan_l2tp_russia_enable").value;
		var wlan_security = get_by_id("wlan0_security").value;
		
		if (wan_type == "dhcpc"){ // dhcp
			document.write("<input type=\"hidden\" id=\"wan_mac\" name=\"wan_mac\" value=\"<% CmoGetCfg("asp_temp_03","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"hostname\" name=\"hostname\" value=\"<% CmoGetCfg("asp_temp_04","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}else if (wan_type == "static"){ //static ip 
			document.write("<input type=\"hidden\" id=\"wan_static_ipaddr\" name=\"wan_static_ipaddr\" value=\"<% CmoGetCfg("asp_temp_05","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_static_netmask\" name=\"wan_static_netmask\" value=\"<% CmoGetCfg("asp_temp_06","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_static_gateway\" name=\"wan_static_gateway\" value=\"<% CmoGetCfg("asp_temp_07","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_specify_dns\" name=\"wan_specify_dns\" value=\"<% CmoGetCfg("asp_temp_08","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_primary_dns\" name=\"wan_primary_dns\" value=\"<% CmoGetCfg("asp_temp_09","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_secondary_dns\" name=\"wan_secondary_dns\" value=\"<% CmoGetCfg("asp_temp_10","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}else if (wan_type == "pppoe" && russia_poe_type =="1"){	//russia pppoe
			document.write("<input type=\"hidden\" id=\"wan_pppoe_dynamic_00\" name=\"wan_pppoe_dynamic_00\" value=\"<% CmoGetCfg("asp_temp_11","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_username_00\" name=\"wan_pppoe_username_00\" value=\"<% CmoGetCfg("asp_temp_12","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_password_00\" name=\"wan_pppoe_password_00\" value=\"<% CmoGetCfg("asp_temp_13","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_service_00\" name=\"wan_pppoe_service_00\" value=\"<% CmoGetCfg("asp_temp_14","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_ipaddr_00\" name=\"wan_pppoe_ipaddr_00\" value=\"<% CmoGetCfg("asp_temp_15","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_netmask_00\" name=\"wan_pppoe_netmask_00\" value=\"<% CmoGetCfg("asp_temp_46","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"<% CmoGetCfg("asp_temp_47","none"); %>\">");				
		    document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}else if (wan_type == "pptp"  && russia_pptp_type =="1"){	//russia pptp
			document.write("<input type=\"hidden\" id=\"wan_pptp_dynamic\" name=\"wan_pptp_dynamic\" value=\"<% CmoGetCfg("asp_temp_16","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_username\" name=\"wan_pptp_username\" value=\"<% CmoGetCfg("asp_temp_17","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_password\" name=\"wan_pptp_password\" value=\"<% CmoGetCfg("asp_temp_18","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_ipaddr\" name=\"wan_pptp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_19","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_netmask\" name=\"wan_pptp_netmask\" value=\"<% CmoGetCfg("asp_temp_20","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_gateway\" name=\"wan_pptp_gateway\" value=\"<% CmoGetCfg("asp_temp_21","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_server_ip\" name=\"wan_pptp_server_ip\" value=\"<% CmoGetCfg("asp_temp_22","none"); %>\">");	
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"<% CmoGetCfg("asp_temp_48","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");				
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");				
		}else if (wan_type == "l2tp"  && russia_l2tp_type =="1"){	//russia l2tp
			document.write("<input type=\"hidden\" id=\"wan_l2tp_dynamic\" name=\"wan_l2tp_dynamic\" value=\"<% CmoGetCfg("asp_temp_23","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_username\" name=\"wan_l2tp_username\" value=\"<% CmoGetCfg("asp_temp_24","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_password\" name=\"wan_l2tp_password\" value=\"<% CmoGetCfg("asp_temp_25","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_ipaddr\" name=\"wan_l2tp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_26","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_netmask\" name=\"wan_l2tp_netmask\" value=\"<% CmoGetCfg("asp_temp_27","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_gateway\" name=\"wan_l2tp_gateway\" value=\"<% CmoGetCfg("asp_temp_28","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_server_ip\" name=\"wan_l2tp_server_ip\" value=\"<% CmoGetCfg("asp_temp_29","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"<% CmoGetCfg("asp_temp_49","none"); %>\">");				
		}else if (wan_type == "pppoe"){ //pppoe
			document.write("<input type=\"hidden\" id=\"wan_pppoe_dynamic_00\" name=\"wan_pppoe_dynamic_00\" value=\"<% CmoGetCfg("asp_temp_11","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_username_00\" name=\"wan_pppoe_username_00\" value=\"<% CmoGetCfg("asp_temp_12","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_password_00\" name=\"wan_pppoe_password_00\" value=\"<% CmoGetCfg("asp_temp_13","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_service_00\" name=\"wan_pppoe_service_00\" value=\"<% CmoGetCfg("asp_temp_14","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_ipaddr_00\" name=\"wan_pppoe_ipaddr_00\" value=\"<% CmoGetCfg("asp_temp_15","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_netmask_00\" name=\"wan_pppoe_netmask_00\" value=\"<% CmoGetCfg("asp_temp_46","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}else if (wan_type == "pptp"){	//pptp
			document.write("<input type=\"hidden\" id=\"wan_pptp_dynamic\" name=\"wan_pptp_dynamic\" value=\"<% CmoGetCfg("asp_temp_16","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_username\" name=\"wan_pptp_username\" value=\"<% CmoGetCfg("asp_temp_17","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_password\" name=\"wan_pptp_password\" value=\"<% CmoGetCfg("asp_temp_18","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_ipaddr\" name=\"wan_pptp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_19","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_netmask\" name=\"wan_pptp_netmask\" value=\"<% CmoGetCfg("asp_temp_20","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_gateway\" name=\"wan_pptp_gateway\" value=\"<% CmoGetCfg("asp_temp_21","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_server_ip\" name=\"wan_pptp_server_ip\" value=\"<% CmoGetCfg("asp_temp_22","none"); %>\">");	
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");					
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");					
		}else if (wan_type == "l2tp"){	//l2tp
			document.write("<input type=\"hidden\" id=\"wan_l2tp_dynamic\" name=\"wan_l2tp_dynamic\" value=\"<% CmoGetCfg("asp_temp_23","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_username\" name=\"wan_l2tp_username\" value=\"<% CmoGetCfg("asp_temp_24","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_password\" name=\"wan_l2tp_password\" value=\"<% CmoGetCfg("asp_temp_25","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_ipaddr\" name=\"wan_l2tp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_26","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_netmask\" name=\"wan_l2tp_netmask\" value=\"<% CmoGetCfg("asp_temp_27","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_gateway\" name=\"wan_l2tp_gateway\" value=\"<% CmoGetCfg("asp_temp_28","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_server_ip\" name=\"wan_l2tp_server_ip\" value=\"<% CmoGetCfg("asp_temp_29","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}else if (wan_type == "bigpond"){	// bigpond
			document.write("<input type=\"hidden\" id=\"wan_bigpond_username\" name=\"wan_bigpond_username\" value=\"<% CmoGetCfg("asp_temp_30","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_bigpond_password\" name=\"wan_bigpond_password\" value=\"<% CmoGetCfg("asp_temp_31","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_bigpond_auth\" name=\"wan_bigpond_auth\" value=\"<% CmoGetCfg("asp_temp_32","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_bigpond_server\" name=\"wan_bigpond_server\" value=\"<% CmoGetCfg("asp_temp_33","none"); %>\">");
			document.write("<input type=\"hidden\" id=\"wan_pptp_russia_enable\" name=\"wan_pptp_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_pppoe_russia_enable\" name=\"wan_pppoe_russia_enable\" value=\"0\">");
			document.write("<input type=\"hidden\" id=\"wan_l2tp_russia_enable\" name=\"wan_l2tp_russia_enable\" value=\"0\">");
		}
		
		// wlan0_wep64_key_1 and wlan0_wep128_key_1
		if(wlan_security == "wep_open_64" || wlan_security == "wep_share_64"){			
			document.write("<input type=\"hidden\" id=\"wlan0_wep64_key_1\" name=\"wlan0_wep64_key_1\" value=\"<% CmoGetCfg("asp_temp_wep64_key_1","none"); %>\">");			
		}	
		else if(wlan_security == "wep_open_128" || wlan_security == "wep_share_128"){
			document.write("<input type=\"hidden\" id=\"wlan0_wep128_key_1\" name=\"wlan0_wep128_key_1\" value=\"<% CmoGetCfg("asp_temp_wep128_key_1","none"); %>\">");			
		}
					
	</script>
</form>
<script>
send_submit("form1");
</script>
</body>
</html>
