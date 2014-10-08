<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | Dynamic DNS</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		var sel_ddns_type = "<% CmoGetCfg("ddns_type","none"); %>";
		set_selectIndex(sel_ddns_type, get_by_id("ddns_type"));
		set_checked("<% CmoGetCfg("ddns_enable","none"); %>", get_by_name("ddns_enable"));
		check_ap_mode();
	}
	
	function check_ap_mode(){
		var is_ap_mode = "1";
		
		if (is_ap_mode == "0"){
			disable_all_items();		
		}
	}
	
	function send_request(){
                var ddns = get_by_name("ddns_enable");
		if(ddns[0].checked)
			get_by_id("ddns_sync_interval").value = 576;
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
                  <td><a href="wan.asp" class="submenus"><b>WAN</b></a></td>
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
                  <td><a href="ddns.asp" class="submenus"><b><u>Dynamic DNS</u></b></a></td>
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
                      <td width="85%" class="headerbg">Dynamic DNS </td>
                      <td width="15%" class="headerbg"><a href="help_main.asp#main_ddns" target="_blank"><img src="but_help1_0.gif" name="Image81" width="69" height="28" border="0" id="Image81" onMouseOver="MM_swapImage('Image81','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    </tr>
                  </table>
				  <form id="form1" name="form1" method="post" action="apply.cgi">
				  <input type="hidden" name="html_response_page" value="back.asp">
				  <input type="hidden" name="html_response_message" value="The setting is saved.">
				  <input type="hidden" name="html_response_return_page" value="ddns.asp">
                                  <input type="hidden" id="ddns_sync_interval" name="ddns_sync_interval" value="<% CmoGetCfg("ddns_sync_interval","none"); %>"> 
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    
                    <tr>
                      <td width="160" align="right" class="bgblue">DDNS</td>
                      <td class="bggrey">
                        <input type=radio name="ddns_enable" value="1">
                        Enabled
                        <input type=radio name="ddns_enable" value="0">
                        Disabled </td>
                    </tr>
                    <tr>
                      <td width="160" align="right" class="bgblue">Server Address</td>
                      <td class="bggrey">
                      	<select id="ddns_type" name="ddns_type" size="1">
                          <option value="DynDns.org">DynDns.com</option>
                          <option value="EasyDns.com">EasyDns.com</option>
                          <option value="dynupdate.no-ip.com">No-IP.com</option>
                        </select></td>
                    </tr>
                    <tr>
                      <td width="160" align="right" class="bgblue">Host Name</td>
                      <td class="bggrey"><input type="text" id="ddns_hostname" name="ddns_hostname" size="40" maxlength="60" value="<% CmoGetCfg("ddns_hostname","none"); %>"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">User Name</td>
                      <td class="bggrey"><input type="text" id="ddns_username" name="ddns_username" size="40" maxlength="60" value="<% CmoGetCfg("ddns_username","none"); %>"></td>
                    </tr>
                    <tr>
                      <td height="26" align="right" class="bgblue">Password</td>
                      <td height="26" class="bggrey"><input type="password" id="ddns_password" name="ddns_password" size="40" maxlength="40" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                    </tr>
                    <tr>
                      <td height="26" align="right" class="bgblue">&nbsp;</td>
                      <td height="26" class="bggrey2">
                      	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='ddns.asp'">
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
