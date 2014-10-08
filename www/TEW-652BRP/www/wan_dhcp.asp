<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | WAN</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	
	function loadSettings(){
		var dat = get_by_id("wan_curr_ipaddr").value.split("/");
		if(dat[0] !="0.0.0.0" && get_by_id("wan_static_ipaddr").value == "0.0.0.0"){
			get_by_id("wan_static_ipaddr").value = dat[0];
		}
		if(dat[1] !="0.0.0.0" && get_by_id("wan_static_netmask").value == "0.0.0.0"){
			get_by_id("wan_static_netmask").value = dat[1];
		}
		
		if(dat[2] !="0.0.0.0" && get_by_id("wan_static_gateway").value == "0.0.0.0"){
			get_by_id("wan_static_gateway").value = dat[2];
		}
		if(get_by_id("wan_proto").value != "dhcpc" && get_by_id("wan_proto").value !="static"){
			get_by_name("wan_type")[0].checked = true;
		}else{
			set_checked(get_by_id("wan_proto").value, get_by_name("wan_type"));
		}
		
		set_mac(get_by_id("wan_mac").value, ":");
		
		disable_dhcp_static_address(get_by_name("wan_type"), get_by_id("wan_static_ipaddr"), get_by_id("wan_static_netmask"), get_by_id("wan_static_gateway"));
	}
	
	function clone_mac_action(){
		set_mac(get_by_id("mac_clone_addr").value, ":");
	}
	
	function send_request(){
		var wan_type = get_by_name("wan_type");
		var ip = get_by_id("wan_static_ipaddr").value;		
		var mask = get_by_id("wan_static_netmask").value;
		var gateway = get_by_id("wan_static_gateway").value;
		var dns1 = get_by_id("wan_primary_dns").value;
		var dns2 = get_by_id("wan_secondary_dns").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
		var dns1_addr_msg = replace_msg(all_ip_addr_msg,"DNS Server 1");
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,"DNS Server 2");
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
		var mac = "";
		var chkmac1=get_by_id("mac1").value;
		var temp_chkmac_first_char=chkmac1.substring(0,1);
		var temp_chkmac_first_char2=chkmac1.substring(2,1);
		var temp_chkmac_first_char3=temp_chkmac_first_char2.toLowerCase();
		var tmp_value;
		
		if (wan_type[1].checked){
			if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
				return false;
			}		
			
			if (!check_address(temp_dns1_obj)){
				return false;
			}							
				}
			else{
			if (dns1 != "" && dns1 != "0.0.0.0"){
				if (!check_address(temp_dns1_obj)){
					return false;
				}
			}
			else{
				get_by_id("wan_primary_dns").value="0.0.0.0";
			}
		}
		
		if (dns2 != "" && dns2 != "0.0.0.0"){
			if (!check_address(temp_dns2_obj)){
				return false;
			}
		}
		else{
			get_by_id("wan_secondary_dns").value="0.0.0.0";
		}
		
		for (var i = 1; i < 7; i++){
			mac += get_by_id("mac" + i).value;
			if (i < 6){
				mac += ":";
			}
		}
		if (!check_mac(mac) || mac == "00:00:00:00:00:00" || mac == ":::::"){
			if (!check_mac(mac)){
				alert(msg[MSG5]);
				return false;
			}
		}
		var chkmac1=parseInt(get_by_id("mac1").value,16);	
		chkmac1%=2;
		if (chkmac1 != 0){				
				alert(" Mac address item 1 can't input the odd number ! ");
				return false;
		}
		
			if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
				get_by_id("wan_specify_dns").value = 0;
			}else{
				get_by_id("wan_specify_dns").value = 1;
			}		
			get_by_id("wan_mac").value= mac;		
			get_by_id("wan_proto").value = get_checked_value(get_by_name("wan_type"));		
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
                  <td><a href="wan.asp" class="submenus"><b><u>WAN</u></b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="password.asp" class="submenus"><b>Password</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="time.asp" class="submenus"><b>Time</b></a></td>
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
              <td background="bg3.gif">
                   <table width="100%" border="0" cellpadding="3" cellspacing="0">
                     <tr>
                       <td width="85%" class="headerbg">WAN</td>
                       <td width="15%" class="headerbg"><a href="help_main.asp#main_wan" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                     </tr>
                   </table>
                  <form id="form1" name="form1" method="post" action="apply.cgi">
                  <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                  <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                  <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan.asp">
                  <input type="hidden" id="wan_curr_ipaddr" name="wan_curr_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
                  <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
                  <input type="hidden" id="wan_specify_dns" name="wan_specify_dns"  value="<% CmoGetCfg("wan_specify_dns","none"); %>">
                  <input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("wan_proto","none"); %>">
                  <input type="hidden" id="wan_mac" name="wan_mac" value="<% CmoGetCfg("wan_mac","none"); %>">
                  <input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
				    			<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
                  <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
                  <input type="hidden" id="reboot_type" name="reboot_type" value="wan"> 
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td width="150" height="24" align="right" class="bgblue"><font face="Arial">Connection Type </font></td>
                      <td height="24" colspan="3" bgcolor="#FFFFFF" class="bggrey"> 
                       <select size="1" id="conn_type" name="conn_type" onChange="change_wan_html(this.selectedIndex)">
                          <option value="0" selected>DHCP Client or Fixed IP</option>
                          <option value="1">PPPoE</option>
                          <option value="2">PPTP</option>
                          <option value="3">L2TP</option>
                          <option value="4">BigPond Cable</option>
                          <option value="5">Russia PPPoE</option>
                          <option value="6">Russia PPTP</option>
						  <option value="7">Russia L2TP</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td width="150" rowspan="4" align="right" valign="top" class="bgblue">WAN
                        IP </td>
                      <td colspan="3" bgcolor="#FFFFFF" class="bggrey">
                        <input type="radio" value="dhcpc" name="wan_type" onClick='disable_dhcp_static_address(get_by_name("wan_type"), get_by_id("wan_static_ipaddr"), get_by_id("wan_static_netmask"), get_by_id("wan_static_gateway"))'>
                        Obtain IP Automatically </td>
                      </tr>
                    <tr>
                      <td width="100" rowspan="3" valign="top" nowrap class="bggrey"><font face="Arial" size="2">
                        <input type="radio" value="static" name="wan_type" onClick='disable_dhcp_static_address(get_by_name("wan_type"), get_by_id("wan_static_ipaddr"), get_by_id("wan_static_netmask"), get_by_id("wan_static_gateway"))'>
                        Specify IP </font></td>
                      <td width="96" bgcolor="#EEEEEE">IP Address </td>
                      <td width="138" class="bggrey"><input type="text" id="wan_static_ipaddr" name="wan_static_ipaddr" size="16" maxlength="15" value="<% CmoGetCfg("wan_static_ipaddr","none"); %>"></td>
                    </tr>
                    <tr>
                      <td width="96" bgcolor="#EEEEEE">Subnet Mask </td>
                      <td width="138" class="bggrey"><input type="text" id="wan_static_netmask" name="wan_static_netmask" size="16" maxlength="15" value="<% CmoGetCfg("wan_static_netmask","none"); %>"></td>
                    </tr>
                    <tr>
                      <td nowrap bgcolor="#EEEEEE">Default Gateway </td>
                      <td width="138" class="bggrey"><input type="text" id="wan_static_gateway" name="wan_static_gateway" size="16" maxlength="15" value="<% CmoGetCfg("wan_static_gateway","none"); %>"></td>
                    </tr>
                    <tr>
                      <td width="150" height="2" align="right" class="bgblue">DNS
                        1</td>
                      <td height="2" colspan="3" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="wan_primary_dns" name="wan_primary_dns" size="16" maxlength="15" value="<% CmoGetCfg("wan_primary_dns","none"); %>"></td>
                    </tr>
                    <tr>
                      <td width="150" align="right" class="bgblue">DNS
                        2</td>
                      <td colspan="3" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="wan_secondary_dns" name="wan_secondary_dns" size="16" maxlength="15" value="<% CmoGetCfg("wan_secondary_dns","none"); %>"></td>
                    </tr>
                    <tr>
                      <td width="150" align="right" class="bgblue">MAC Address</td>
                      <td colspan="3" bgcolor="#FFFFFF" class="bggrey">
                        <input type="text" id="mac1" name="mac1" size="2" maxlength="2">
						-
						<input type="text" id="mac2" name="mac2" size="2" maxlength="2">
						-
						<input type="text" id="mac3" name="mac3" size="2" maxlength="2">
						-
						<input type="text" id="mac4" name="mac4" size="2" maxlength="2">
						-
						<input type="text" id="mac5" name="mac5" size="2" maxlength="2">
						-
						<input type="text" id="mac6" name="mac6" size="2" maxlength="2">&nbsp;&nbsp;<br>
                        <input type="button" value="Clone MAC Address" name="clone" onClick="clone_mac_action()"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"><span class="bgblue">MTU</span></td>
                      <td colspan="3" bgcolor="#FFFFFF" class="bggrey">   <input type=text id="wan_mtu" name="wan_mtu" maxlength="4" size="4" value="<% CmoGetCfg("wan_mtu","none"); %>"> 	
                      </td>
                    <tr>
                      <td align="right" class="bgblue">&nbsp;</td>
                      <td colspan="3" bgcolor="#FFFFFF" class="bggrey2">
                      	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='wan_dhcp.asp'">
						<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                      </td>
                    </tr>
                  </table>
                   <p>&nbsp;</p>
                  </form>                
                </td>
              <td height="400" valign="top" background="bg2_r.gif"><img src="spacer.gif" width="10" height="10"></td>
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
