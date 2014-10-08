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
		if(dat[0] !="0.0.0.0" && get_by_id("wan_l2tp_ipaddr").value == "0.0.0.0"){
			get_by_id("wan_l2tp_ipaddr").value = dat[0];
		}
		if(dat[1] !="0.0.0.0" && get_by_id("wan_l2tp_netmask").value == "0.0.0.0"){
			get_by_id("wan_l2tp_netmask").value = dat[1];
		}
		
		set_checked("<% CmoGetCfg("wan_l2tp_dynamic","none"); %>",get_by_name("wan_l2tp_dynamic"));
		set_checked("<% CmoGetCfg("wan_l2tp_connect_mode","none"); %>",get_by_name("wan_l2tp_connect_mode"));
		//set_checked("<% CmoGetCfg("support_l2tp_mppe"); %>",get_by_id("l2tp_mppe"));
		disable_static_address_L2TP_Russia_L2TP(get_by_name("wan_l2tp_dynamic"), get_by_id("wan_l2tp_ipaddr"), get_by_id("wan_l2tp_netmask"), get_by_id("wan_l2tp_gateway"), get_by_id("wan_primary_dns"));
		check_connectmode();
	}
	
	function send_request(){
		var wan_type = get_by_name("wan_l2tp_dynamic");
		var ip = get_by_id("wan_l2tp_ipaddr").value;		
		var mask = get_by_id("wan_l2tp_netmask").value;
		var gateway = get_by_id("wan_l2tp_gateway").value;	
		var dns = get_by_id("wan_primary_dns").value;	
		var idle_time = get_by_id("wan_l2tp_max_idle_time").value;	    	
    var mtu = get_by_id("wan_l2tp_mtu").value;
        
    var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
		var dns_server_msg = replace_msg(all_ip_addr_msg,"DNS Server");
    var max_idle_msg = replace_msg(check_num_msg, "Idle Time", 0, 999);
    var mtu_msg = replace_msg(check_num_msg, " MTU", 200, 1500);
        
        
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns_obj = new addr_obj(dns.split("."), dns_server_msg, false, false);
		var temp_idle = new varible_obj(idle_time, max_idle_msg, 0, 9999, false);
    var temp_mtu = new varible_obj(mtu, mtu_msg, 200, 1500, false);
        
    var user_name = get_by_id("wan_l2tp_username").value;
        
		if (wan_type[1].checked){
			if (!check_address(temp_ip_obj)){
				return false;
			}
		}
		
		if (dns != "" && dns != "0.0.0.0"){
			if (!check_address(temp_dns_obj)){
				return false;
			}
		}
		
		if(get_by_id("wan_l2tp_server_ip").value == ""){
    		alert(msg[MSG40]);
    		return false;
	     }
		
		if (!check_pwd("wan_l2tp_password", "pwd2")){
			return false;
		}
		
		if (user_name == ""){
    		alert(msg[MSG51]);
			return false;
		}
		
	     if (get_by_id("wan_l2tp_password").value == "" || get_by_id("pwd2").value == ""){
		 	alert("A L2TP password MUST be specified");
			return false;
		}
		
		if (wan_type[0].checked) //Set dynamic IP
		{
			if (dns != "" && dns != "0.0.0.0"){
				get_by_id("wan_specify_dns").value = 1;
			}
			else
				get_by_id("wan_specify_dns").value = 0;			
		}	
		else					//Set static IP
			get_by_id("wan_specify_dns").value = 1;

		
		if (!check_varible(temp_idle)){
    		return false;
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
    	
    	get_by_id("wan_l2tp_russia_enable").value = "1";
    	get_by_id("asp_temp_60").value = "rus_l2tp";
    	
//		if(get_by_id("l2tp_mppe").checked == false){
//			get_by_id("support_l2tp_mppe").value = 0;
//		}else{
//			get_by_id("support_l2tp_mppe").value = 1;
//		}
		
		send_submit("form1");
	}
	
	function check_connectmode(){
		var conn_mode = get_by_name("wan_l2tp_connect_mode");
		var idle_time = get_by_id("wan_l2tp_max_idle_time");
	
		if(conn_mode[2].checked == true){
			idle_time.disabled = false;
		}else{
			idle_time.disabled = true;
		}
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
              <td height="400" valign="top" background="bg3.gif">
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
                  	<input type="hidden" id="wan_specify_dns" name="wan_specify_dns"  value="<% CmoGetCfg("wan_specify_dns","none"); %>">
                  	<input type="hidden" id="wan_proto" name="wan_proto" value="l2tp">
				  	<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
					<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
					<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
                    <input type="hidden" id="asp_temp_60" name="asp_temp_60" value="<% CmoGetCfg("asp_temp_60","none"); %>">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="wan"> 
                   <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                     <tr>
                       <td align="right" valign="top" class="bgblue">Connection
                         Type</td>
                       <td class="bggrey">
					      <select size="1" id="conn_type" name="conn_type" onChange="change_wan_html(this.selectedIndex)">
                           <option value="0">DHCP Client or Fixed IP</option>
                           <option value="1">PPPoE</option>
                           <option value="2">PPTP</option>
                           <option value="3">L2TP</option>
                           <option value="4">BigPond Cable</option>
						   <option value="5">Russia PPPoE</option>
                           <option value="6">Russia PPTP</option>
						   <option value="7" selected>Russia L2TP</option>
                         </select>
                           <br>
                           <br>
                           <input type="radio" value="1" name="wan_l2tp_dynamic" onClick='disable_static_address_L2TP_Russia_L2TP(get_by_name("wan_l2tp_dynamic"), get_by_id("wan_l2tp_ipaddr"), get_by_id("wan_l2tp_netmask"), get_by_id("wan_l2tp_gateway"), get_by_id("wan_primary_dns"))'><b>Dynamic IP</b>&nbsp;&nbsp;&nbsp;
                           <input type="radio" value="0" name="wan_l2tp_dynamic" onClick='disable_static_address_L2TP_Russia_L2TP(get_by_name("wan_l2tp_dynamic"), get_by_id("wan_l2tp_ipaddr"), get_by_id("wan_l2tp_netmask"), get_by_id("wan_l2tp_gateway"), get_by_id("wan_primary_dns"))'><b>Static IP</b>
                       </td>
                     </tr>
                   </table>
                   <table width="100%" height="301" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                     <tr>
                       <td align="right" class="bgblue">IP
                         Address</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type=text id="wan_l2tp_ipaddr" name="wan_l2tp_ipaddr"  size="16" maxlength="15" value="<% CmoGetCfg("wan_l2tp_ipaddr","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">Subnet
                         Mask</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type=text id="wan_l2tp_netmask" name="wan_l2tp_netmask" size="16" maxlength="15" value="<% CmoGetCfg("wan_l2tp_netmask","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">Gateway</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input name="wan_l2tp_gateway" type=text id="wan_l2tp_gateway" size="16" maxlength="15" value="<% CmoGetCfg("wan_l2tp_gateway","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">DNS</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input name="wan_primary_dns" type=text id="wan_primary_dns" size="16" maxlength="15" value="<% CmoGetCfg("wan_primary_dns","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">Server
                         IP </td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type=text id="wan_l2tp_server_ip" name="wan_l2tp_server_ip" size=30 maxlength=63 value="<% CmoGetCfg("wan_l2tp_server_ip","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">L2TP
                         Account</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type=text id="wan_l2tp_username" name="wan_l2tp_username" size="30" maxlength="63" value="<% CmoGetCfg("wan_l2tp_username","none"); %>"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">L2TP
                         Password</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type=password id="wan_l2tp_password"  name="wan_l2tp_password" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                     </tr>
                     <tr>
                       <td align="right" class="bgblue">L2TP
                         Retype password</td>
                       <td bgcolor="#FFFFFF" class="bggrey"><input type="password" id="pwd2" name="pwd2" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                     </tr>
                     <tr>
                      <td align="right" class="bgblue"> Auto-reconnect </td>
                      <td colspan="3" class="bggrey">
                        <input type=radio name="wan_l2tp_connect_mode" value="always_on" onClick="check_connectmode()">
                        Always-on
                        <input type=radio name="wan_l2tp_connect_mode" value="manual" onClick="check_connectmode()">
                        Manual
                        <input type=radio name="wan_l2tp_connect_mode" value="on_demand" onClick="check_connectmode()">
                        Connect-on Demand</td>
                    </tr>
                     <tr>
                       <td align="right" class="bgblue">Idle Time Out</td>
                       <td bgcolor="#FFFFFF" class="bggrey">
                         <input type=text id="wan_l2tp_max_idle_time" name="wan_l2tp_max_idle_time" size="4" maxlength="4" value="<% CmoGetCfg("wan_l2tp_max_idle_time","none"); %>">
                         Minutes</td>
                     </tr>
                     <tr>
                      <td align="right" class="bgblue">MTU </td>
                      <td bgcolor="#FFFFFF" class="bggrey"><input type=text id="wan_l2tp_mtu" name="wan_l2tp_mtu" maxlength="4" size="4" value="<% CmoGetCfg("wan_l2tp_mtu","none"); %>"></td>
                    </tr>
					<tr>
                       <td align="right" class="bgblue">&nbsp;</td>
                       <td bgcolor="#FFFFFF" class="bggrey2">
                       	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='wan_russia_l2tp.asp'">
						<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                       </td>
                     </tr>
                   </table>

                   
                </form>                 <p>&nbsp;</p></td>
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
