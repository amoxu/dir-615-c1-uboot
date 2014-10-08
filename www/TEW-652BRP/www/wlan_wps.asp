<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
<title>TRENDNET | TEW-652BRP | Wireless | WPS</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">

	function onPageLoad(){
		set_checked("<% CmoGetCfg("wps_enable","none"); %>",get_by_name("wpsEnable"));
		set_checked("<% CmoGetCfg("wps_configured_mode","none"); %>",get_by_name("config"));
		
		disable_wps();
	}
		
	function _isNumeric(str) {
	    var i;
	    for(i = 0; i<str.length; i++) {
	        var c = str.substring(i, i+1);
	        if("0" <= c && c <= "9") {
	            continue;
	        }
	        return false;
	    }
	    return true;
	}
	
	function check_security(){
		var security_val = "<% CmoGetCfg("wlan0_security","none"); %>";
		var ssid_broadcast_val = "<% CmoGetCfg("wlan0_ssid_broadcast","none"); %>";
		if (security_val == "wpa_eap" || security_val == "wpa2_eap"){
			alert("WPS cannot work when EAP Authentication is used. You need go to Wireless/Security page to modify settings to make WPS take effect.");
			return false;
		}
		if (ssid_broadcast_val == "1"){
			alert("WPS cannot work when SSID Broadcast is disabled. You need go to Wireless/Basic page to modify settings to make WPS take effect.");
			return false;
		}	
	
	}
	
	function send_request_wps(){
		var security_val = "<% CmoGetCfg("wlan0_security","none"); %>";
		var ssid_broadcast_val = "<% CmoGetCfg("wlan0_ssid_broadcast","none"); %>";	
		var wlan_enable_val = "<% CmoGetCfg("wlan0_enable","none"); %>";
		var wps_enable = get_by_name("wpsEnable");
		var wep_key ="<% CmoGetCfg("wlan0_wep_default_key","none"); %>";
		if(wps_enable[0].checked){
			get_by_id("wps_enable").value = 1;
					if (security_val == "wpa_eap" || security_val == "wpa2_eap"){
						alert("WPS cannot work when EAP Authentication is used. You need go to Wireless/Security page to modify settings to make WPS take effect.");
						return false;
					}
					if (ssid_broadcast_val == "0"){
						alert("WPS cannot work when SSID Broadcast is disabled. You need go to Wireless/Basic page to modify settings to make WPS take effect.");
						return false;
					}	
					if (wlan_enable_val == "0"){
						alert("WPS cannot work when Wireless is disabled. You need go to Wireless/Basic page to modify settings to make WPS take effect.");
						return false;
					}	
					if ((security_val == "wep_share_64")||(security_val == "wep_share_128")){
						alert("WPS cannot work when WEP type is shared key. You need go to Wireless/Security page to modify settings to make WPS take effect.");
						return false;
					}
					if (wep_key != 1){
						
						alert("WPS cannot work when WEP KEY is not Key 1. You need go to Wireless/Security page to modify settings to make WPS take effect.");
						return false;
					}
					
		}else{
			get_by_id("wps_enable").value = 0;
			
		}
	
		return true;
		
	}


	function send_request_pin(){

		if((get_by_id("client_pin_number").value =="") || !_isNumeric(get_by_id("client_pin_number").value) || (get_by_id("client_pin_number").value.length != 8)){
			alert("Invalid PIN number.");
			return false;
		}
		get_by_id("wps_sta_enrollee_pin").value = get_by_id("client_pin_number").value;
		get_by_id("form2").submit();

	}

	function send_request_pbc(){
	
		get_by_id("form3").submit();
		
	}


	function disable_wps()
	{
	
		var config = get_by_name("config");
		//config[0].disabled = true;
		//config[1].disabled = true;
		
		var enable = get_by_name("wpsEnable");	
		get_by_id("client_pin_number").disabled = enable[1].checked;
		get_by_id("setPIN").disabled = enable[1].checked;	
		get_by_id("triggerPBC").disabled = enable[1].checked;
		
	}

</script>
</head>
<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');">
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
           <td><a href="wireless_auth.asp" class="submenus"><b>Security</b></a></td>
         </tr>
         <tr>
           <td align="right"><font color="#FFFFFF">&bull;</font></td>
           <td><a href="wireless_advanced.asp" class="submenus"><b>Advanced</b></a></td>
         </tr>
         <tr>
           <td align="right"><font color="#FFFFFF">&bull;</font></td>
           <td><a href="wlan_wps.asp" class="submenus"><b><u>WiFi Protected Setup</u></b></a></td>
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
 <td background="bg2_l.gif"><img src="spacer.gif" width="10" height="10"></td>
 <td height="400" valign="top" background="bg3.gif">
 <table width="100%" border="0" cellpadding="3" cellspacing="0">
 <tr>
 <td width="85%" class="headerbg">Wi-Fi Protected Setup</td>
 <td width="15%" class="headerbg"><a href="help_wlan.asp#wireless_wps" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
 </tr>
 </table>
 



<form id="form1" name="form1" method=POST action="apply.cgi">
<input type="hidden" name="html_response_page" value="back.asp">
<input type="hidden" name="html_response_message" value="The setting is saved.">
<input type="hidden" name="html_response_return_page" value="wlan_wps.asp">
<input type="hidden" name="wps_enable" id="wps_enable" value="<% CmoGetCfg("wps_enable","none"); %>">
<input type="hidden" name="wlan_enable" id="wlan_enable" value="<% CmoGetCfg("wlan0_enable","none"); %>">
  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
    <tr>
      <td align="right" class="bgblue"><font face="Arial">WPS</font></td>
      <td class="bggrey"><font face="Arial" size="2">
        <input type="radio" value="1" name="wpsEnable" onclick="disable_wps()">
Enabled&nbsp;
<input type="radio" value="0" name="wpsEnable" onclick="disable_wps()">
Disabled</font> &nbsp;&nbsp;
<input type="submit" name="apply" value="Apply" onClick="return send_request_wps()"></td>
    </tr>
  </table>
</form>
 <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
  <tr>
 <td align="right" class="bgblue"><font face="Arial">Status </font></td> 
 <td bgcolor="#FFFFFF" class="bggrey">
    <input type="radio" value="1" name="config" disabled>&nbsp;UnConfigured&nbsp;
	<input type="radio" value="5" name="config" disabled>Configured</td>
 </tr>
 <tr>
 <td align="right" class="bgblue"><font face="Arial">Self-PIN Number</font></td>
 <td bgcolor="#FFFFFF" class="bggrey">&nbsp;<% CmoGetStatus("wps_generate_default_pin"); %></td>
  </table>
<form id="form2" name="form2" method="post" action="set_sta_enrollee_pin.cgi">
   <input type="hidden" id="html_response_page" name="html_response_page" value="do_wps_save.asp">
   <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wlan_wps.asp">
   <input type="hidden" id="reboot_type" name="reboot_type" value="none">
   <input type="hidden" id="wps_sta_enrollee_pin" name="wps_sta_enrollee_pin" value="<% CmoGetCfg("wps_sta_enrollee_pin","none"); %>">
   <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
     <tr>
       <td align="right" class="bgblue"><font face="Arial">Client PIN Number</font></td>
       <td class="bggrey"><font face="Arial" size="2">
         <input id="client_pin_number" maxLength="8" size="12" name="client_pin_number">
         &nbsp;&nbsp;
         <input type="button" value="Start PIN" id="setPIN" name="setPIN" onClick="send_request_pin()">
       </font></td>
     </tr>
   </table>
 </form> 
<form id="form3" name="form3" method="post" action="virtual_push_button.cgi">
   <input type="hidden" id="html_response_page" name="html_response_page" value="wps_back.asp">
   <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wlan_wps.asp">
   <input type="hidden" id="reboot_type" name="reboot_type" value="none">
   <input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<% CmoGetCfg("wps_configured_mode","none"); %>">
   <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
     <tr>
       <td align="right" class="bgblue"><font face="Arial">Push Button Configuration</font></td>
       <td class="bggrey"><font face="Arial" size="2">
         <input type="button" value="Start PBC" id="triggerPBC" name="triggerPBC" onClick="send_request_pbc()">
</font></td>
     </tr>
   </table>
 </form> <br>
<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
<tr>
<td align="center" bgcolor="#C5CEDA" class="bgblue"><b>Authentication</b></td>
<td align="center" bgcolor="#C5CEDA" class="bgblue"><b>Encryption</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Key</b></td>
</tr>
 <script>
							var security= "<% CmoGetCfg("wlan0_security","none"); %>";
							var wep_default_key= "<% CmoGetCfg("wlan0_wep_default_key","none"); %>"; 
							var wep_display = "<% CmoGetCfg("wlan0_wep_display","none"); %>"; // hex or ascii
							var tmp_psk_cipher_type= "<% CmoGetCfg("wlan0_psk_cipher_type","none"); %>";
							var psk_pass_phrase= "<% CmoGetCfg("wlan0_psk_pass_phrase","none"); %>";
							
							if(tmp_psk_cipher_type =="tkip"){
								var psk_cipher_type= "TKIP"
							}else if(tmp_psk_cipher_type =="aes"){
								var psk_cipher_type= "AES"							
							}else if(tmp_psk_cipher_type =="both"){
								var psk_cipher_type= "TKIP|AES"							
							}						
							
							
							var wep64_key = "";
							var wep128_key = "";
							if(wep_default_key =="1"){
									if(wep_display =="hex"){  
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>";
									}else{
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_1","ascii"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_1","ascii"); %>";
									}
							}
							if(wep_default_key =="2"){
									if(wep_display =="hex"){  
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_2","hex"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_2","hex"); %>";
									}else{
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_2","ascii"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_2","ascii"); %>";
									}
							}
							if(wep_default_key =="3"){
									if(wep_display =="hex"){  
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_3","hex"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_3","hex"); %>";
									}else{
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_3","ascii"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_3","ascii"); %>";
									}
							}
							if(wep_default_key =="4"){
									if(wep_display =="hex"){  
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_4","hex"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_4","hex"); %>";
									}else{
										wep64_key = "<% CmoGetCfg("wlan0_wep64_key_4","ascii"); %>";
										wep128_key = "<% CmoGetCfg("wlan0_wep128_key_4","ascii"); %>";
									}
							}
																					
							if(security == "wep_open_64"){
							
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">OPEN</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">WEP</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ wep64_key +"</td>");
									document.write("</tr>");									
							}else if(security == "wep_open_128"){
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">OPEN</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">WEP</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ wep128_key +"</span></td>");
									document.write("</tr>");		
							}else if(security == "wpa_psk"){
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">WPA-PSK</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_cipher_type +"</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_pass_phrase +"</td>");
									document.write("</tr>");		
							}else if(security == "wpa2_psk"){
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">WPA2-PSK</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_cipher_type +"</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_pass_phrase +"</td>");
									document.write("</tr>");		
							}else if(security == "wpa2auto_psk"){
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">WPA2AUTO-PSK</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_cipher_type +"</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">"+ psk_pass_phrase +"</td>");
									document.write("</tr>");		
							}else if(security == "disable"){
									document.write("<tr bgcolor=\"#F0F0F0\">");
									document.write("<td width=\"36%\" height=\"25\" class=\"bggrey\">Disabled</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\">None</td>");
									document.write("<td width=\"40%\" height=\"25\" class=\"bggrey\"> - </td>");
									document.write("</tr>");		
							}							
					</script>			
</table>
 </td>
 <td background="bg2_r.gif"><p>&nbsp;</p>
   <p>&nbsp;</p>
   <p>&nbsp;</p>
   <p>&nbsp;</p>
   <p><img src="spacer.gif" width="10" height="10"></p></td>
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

<script>
onPageLoad();
</script>
</html>
