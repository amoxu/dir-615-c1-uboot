<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public.js"></script>
</head>
<body text="#000000" leftmargin="0" topmargin="0">
	<form id="form1" name="form1" method="POST" action="apply.cgi">
	  	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard1.asp">
	  	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard.asp">
	  	<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	
	  	<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<% CmoGetCfg("admin_password","none"); %>">
		<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<% CmoGetCfg("time_zone","none"); %>">
		<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<% CmoGetCfg("wan_proto","none"); %>">
		<!-- lan-->
		<input type="hidden" id="asp_temp_41" name="asp_temp_41" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
		<input type="hidden" id="asp_temp_42" name="asp_temp_42" value="<% CmoGetCfg("lan_netmask","none"); %>">
		<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("dhcpd_enable","none"); %>">								
		<input type="hidden" id="asp_temp_44" name="asp_temp_44" value="<% CmoGetCfg("dhcpd_start","none"); %>">
		<input type="hidden" id="asp_temp_45" name="asp_temp_45" value="<% CmoGetCfg("dhcpd_end","none"); %>">
		
		
		<!-- dhcp -->
		<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<% CmoGetCfg("wan_mac","none"); %>">
		<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<% CmoGetCfg("hostname","none"); %>">
										
		<!-- static ip -->
		<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<% CmoGetCfg("wan_static_ipaddr","none"); %>">
		<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<% CmoGetCfg("wan_static_netmask","none"); %>">
		<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<% CmoGetCfg("wan_static_gateway","none"); %>">
		<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<% CmoGetCfg("wan_specify_dns","none"); %>">
		<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<% CmoGetCfg("wan_primary_dns","none"); %>">
		<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<% CmoGetCfg("wan_secondary_dns","none"); %>">
		
		<!-- pppoe -->
		<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>">
		<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<% CmoGetCfg("wan_pppoe_username_00","none"); %>">
		<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<% CmoGetCfg("wan_pppoe_password_00","none"); %>">
		<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("wan_pppoe_service_00","none"); %>">				
		<input type="hidden" id="asp_temp_46" name="asp_temp_46" value="<% CmoGetCfg("wan_pppoe_netmask_00","none"); %>">
		<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("wan_pppoe_ipaddr_00","none"); %>">
		
		<!-- pptp -->
		<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<% CmoGetCfg("wan_pptp_dynamic","none"); %>">
		<input type="hidden" id="asp_temp_17" name="asp_temp_17" value="<% CmoGetCfg("wan_pptp_username","none"); %>">
		<input type="hidden" id="asp_temp_18" name="asp_temp_18" value="<% CmoGetCfg("wan_pptp_password","none"); %>">				
		<input type="hidden" id="asp_temp_19" name="asp_temp_19" value="<% CmoGetCfg("wan_pptp_ipaddr","none"); %>">
		<input type="hidden" id="asp_temp_20" name="asp_temp_20" value="<% CmoGetCfg("wan_pptp_netmask","none"); %>">
		<input type="hidden" id="asp_temp_21" name="asp_temp_21" value="<% CmoGetCfg("wan_pptp_gateway","none"); %>">
		<input type="hidden" id="asp_temp_22" name="asp_temp_22" value="<% CmoGetCfg("wan_pptp_server_ip","none"); %>">
		
		<!-- l2tp -->
		<input type="hidden" id="asp_temp_23" name="asp_temp_23" value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>">
		<input type="hidden" id="asp_temp_24" name="asp_temp_24" value="<% CmoGetCfg("wan_l2tp_username","none"); %>">
		<input type="hidden" id="asp_temp_25" name="asp_temp_25" value="<% CmoGetCfg("wan_l2tp_password","none"); %>">								
		<input type="hidden" id="asp_temp_26" name="asp_temp_26" value="<% CmoGetCfg("wan_l2tp_ipaddr","none"); %>">
		<input type="hidden" id="asp_temp_27" name="asp_temp_27" value="<% CmoGetCfg("wan_l2tp_netmask","none"); %>">
		<input type="hidden" id="asp_temp_28" name="asp_temp_28" value="<% CmoGetCfg("wan_l2tp_gateway","none"); %>">
		<input type="hidden" id="asp_temp_29" name="asp_temp_29" value="<% CmoGetCfg("wan_l2tp_server_ip","none"); %>">
		
		<!-- bigpond -->				
		<input type="hidden" id="asp_temp_30" name="asp_temp_30" value="<% CmoGetCfg("wan_bigpond_username","none"); %>">
		<input type="hidden" id="asp_temp_31" name="asp_temp_31" value="<% CmoGetCfg("wan_bigpond_password","none"); %>">
		<input type="hidden" id="asp_temp_32" name="asp_temp_32" value="<% CmoGetCfg("wan_bigpond_auth","none"); %>">				
		<input type="hidden" id="asp_temp_33" name="asp_temp_33" value="<% CmoGetCfg("wan_bigpond_server","none"); %>">
		
		<!-- wireless -->
		<input type="hidden" id="asp_temp_34" name="asp_temp_34" value="<% CmoGetCfg("wlan0_enable","none"); %>">
		<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<% CmoGetCfg("wlan0_ssid","none"); %>">
		<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="<% CmoGetCfg("wlan0_channel","none"); %>">
		<!-- wireless security -->
		<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<% CmoGetCfg("wps_configured_mode","none"); %>">
		<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("wps_enable","none"); %>">
		<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<% CmoGetCfg("wlan0_security","none"); %>">
		<input type="hidden" id="asp_temp_wep_display" name="asp_temp_wep_display" value="<% CmoGetCfg("wlan0_wep_display","none"); %>">
		<input type="hidden" id="asp_temp_54" name="asp_temp_54" value="<% CmoGetCfg("wlan0_wep_default_key","none"); %>">
		<input type="hidden" id="asp_temp_55" name="asp_temp_55" value="<% CmoGetCfg("wlan0_psk_cipher_type","none"); %>">
		<input type="hidden" id="asp_temp_56" name="asp_temp_56" value="<% CmoGetCfg("wlan0_psk_pass_phrase","none"); %>">
				
		<!-- other -->
		<input type="hidden" id="asp_temp_59" name="asp_temp_59" value="wizard5a.asp">
		<input type="hidden" id="asp_temp_47" name="asp_temp_47" value="<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>">
	    <input type="hidden" id="asp_temp_48" name="asp_temp_48" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
    	<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
    	<script>
		var wlan_security = get_by_id("asp_temp_52").value;
		var wep_display = get_by_id("asp_temp_wep_display").value;
		// wlan0_wep64_key_1 and wlan0_wep128_key_1
		if(wlan_security == "wep_open_64" || wlan_security == "wep_share_64" || wlan_security == "wep_open_128" || wlan_security == "wep_share_128"){			
			if(wep_display == "hex"){
				document.write("<input type=\"hidden\" id=\"asp_temp_wep64_key_1\" name=\"asp_temp_wep64_key_1\" value=\"<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>\">");
				document.write("<input type=\"hidden\" id=\"asp_temp_wep128_key_1\" name=\"asp_temp_wep128_key_1\" value=\"<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>\">");		
			}else{
				document.write("<input type=\"hidden\" id=\"asp_temp_wep64_key_1\" name=\"asp_temp_wep64_key_1\" value=\"<% CmoGetCfg("wlan0_wep64_key_1","ascii"); %>\">");							
				document.write("<input type=\"hidden\" id=\"asp_temp_wep128_key_1\" name=\"asp_temp_wep128_key_1\" value=\"<% CmoGetCfg("wlan0_wep128_key_1","ascii"); %>\">");	
			}
		}	
		else{
			if(wep_display == "hex"){
				document.write("<input type=\"hidden\" id=\"asp_temp_wep64_key_1\" name=\"asp_temp_wep64_key_1\" value=\"<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>\">");
				document.write("<input type=\"hidden\" id=\"asp_temp_wep128_key_1\" name=\"asp_temp_wep128_key_1\" value=\"<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>\">");		
			}else{
				document.write("<input type=\"hidden\" id=\"asp_temp_wep64_key_1\" name=\"asp_temp_wep64_key_1\" value=\"<% CmoGetCfg("wlan0_wep64_key_1","ascii"); %>\">");
				document.write("<input type=\"hidden\" id=\"asp_temp_wep128_key_1\" name=\"asp_temp_wep128_key_1\" value=\"<% CmoGetCfg("wlan0_wep128_key_1","ascii"); %>\">");								
			}
		}						
		</script>
    	
	</form>
<script>
send_submit("form1");
</script>
</body>
</html>
