<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | WAN</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		set_selectIndex("<% CmoGetCfg("wan_bigpond_auth","none"); %>",get_by_id("wan_bigpond_auth"));
		set_mac(get_by_id("wan_mac").value, ":");
	}
	
	function clone_mac_action(){
		set_mac(get_by_id("mac_clone_addr").value, ":");
	}
	
	
	function send_request(){		
		var mac = "";		
		
		for (var i = 1; i < 7; i++){
			mac += get_by_id("mac" + i).value;			
			if (i < 6){
				mac += ":";
			}
		}
        if (!check_mac(mac) || mac == "00:00:00:00:00:00" || mac == ":::::"){
			alert(msg[MSG5]);
				return false;
			}
		if (!check_pwd("wan_bigpond_password", "pwd2")){
				return false;
		}
		var chkmac1=parseInt(get_by_id("mac1").value,16);	
		chkmac1%=2;
		if (chkmac1 != 0){				
				alert(" Mac address item 1 can't input the odd number ! ");
				return false;
		}
		get_by_id("wan_mac").value= mac;		
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
              <td><a href="w_basic.asp"><img src="but_wireless_0.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
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
                  	<input type="hidden" id="wan_specify_dns" name="wan_specify_dns"  value="<% CmoGetCfg("wan_specify_dns","none"); %>">
                  	<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
                  	<input type="hidden" id="wan_mac" name="wan_mac" value="<% CmoGetCfg("wan_mac","none"); %>">
                  	<input type="hidden" id="wan_proto" name="wan_proto" value="bigpond">
                  	<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
				    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
				    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td align="right" class="bgblue">Connection Type </td>
                      <td colspan="3" class="bggrey">
                      	<select size="1" id="conn_type" name="conn_type" onChange="change_wan_html(this.selectedIndex)">
                          <option value="0">DHCP Client or Fixed IP</option>
                          <option value="1">PPPoE</option>
                          <option value="2">PPTP</option>
                          <option value="3">L2TP</option>
                          <option value="4" selected>BigPond Cable</option>
                          <option value="5">Russia PPPoE</option>
                          <option value="6">Russia PPTP</option>
						  <option value="7">Russia L2TP</option>
                        </select></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> User Name </td>
                      <td valign=top class="bggrey"><input type=text id="wan_bigpond_username" name="wan_bigpond_username" size="30" maxlength="63" value="<% CmoGetCfg("wan_bigpond_username","none"); %>"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> Password </td>
                      <td class="bggrey"><input type=password id="wan_bigpond_password" name="wan_bigpond_password" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> Retype Password </td>
                      <td class="bggrey"><input type="password" id="pwd2" name="pwd2" size="30" maxlength="63"  value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> Auth Server </td>
                      <td class="bggrey">
                      	<select id="wan_bigpond_auth" name="wan_bigpond_auth">
                          <option value="sm-server">sm-server</option>
                          <option value="dce-server">dce-server</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> Login Server IP </td>
                      <td class="bggrey" >
                        <input type=text id="wan_bigpond_server" name="wan_bigpond_server" size=30 maxlength=63 value="<% CmoGetCfg("wan_bigpond_server","none"); %>">
                        (optional) </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue"> MAC Address </td>
                      <td class="bggrey">
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
						<input type="text" id="mac6" name="mac6" size="2" maxlength="2">
                        (optional)
                        <input type="button" value="Clone MAC Address" name="clone" onClick="clone_mac_action()"></td>
                    <tr>
                      <td align="right" class="bgblue">&nbsp;</td>
                      <td class="bggrey2">
                      	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='wan_bigpond.asp'">
						<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                      </td>
                    </table>
                  <p>                
                  </p>
                  <p>&nbsp;  </p>
                </form>                </td>
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
