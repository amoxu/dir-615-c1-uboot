<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		set_checked("<% CmoGetCfg("asp_temp_43","none"); %>", get_by_name("asp_temp_43"));
	}
	
	function send_request(){
		var ip = get_by_id("asp_temp_41").value;
		var mask = get_by_id("asp_temp_42").value;
		var dhcp = get_by_name("asp_temp_43");
		var start_ip = get_by_id("asp_temp_44").value;
		var end_ip = get_by_id("asp_temp_45").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_start_ip_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var temp_end_ip_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
	
		if (!check_address(temp_ip_obj) || !check_mask(temp_mask_obj)){		
			return false;			
		}
		
		if (dhcp[0].checked){
			if (!check_address(temp_start_ip_obj) || !check_address(temp_end_ip_obj)){
				return false;
			}
			
			if (!check_domain(temp_ip_obj, temp_mask_obj, temp_start_ip_obj)){
				alert(addstr(msg[MSG2],"Start IP address"));
				return false;
			}
			
			if (!check_domain(temp_ip_obj, temp_mask_obj, temp_end_ip_obj)){
				alert(addstr(msg[MSG2],"End IP address"));
				return false;
			}
			
			if (!check_ip_order(temp_start_ip_obj, temp_end_ip_obj)){
				alert(msg[MSG4]);
				return false;
			}
		}
		
		send_submit("form1");
	}
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0" onLoad="loadSettings();">
<table width="459" height="324" border="0" cellpadding="0" cellspacing="0" bgcolor="334255">
    <tr>
      <td height="49"><img src="bg_wizard_2.gif" width="459" height="49"></td>
    </tr>
    <tr>
      <td valign="top" background="bg_wizard_3.gif"><table width="459" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="3"><img src="spacer.gif" width="30" height="10"></td>
          </tr>
          <tr>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
            <td width="86%" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="headerbg">Set LAN &amp; DHCP Server </td>
              </tr>
            </table>
              <form name="form1" id="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_russia1.asp">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard3.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">LAN IP Address</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_41" name="asp_temp_41" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_41","none"); %>">
                  </font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">LAN Subnet Mask</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_42" name="asp_temp_42" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_42","none"); %>">
                  </font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">DHCP Server</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="radio" name="asp_temp_43" value="1" onClick='disable_dhcp(get_by_name("asp_temp_43")[1].checked, get_by_id("asp_temp_44"), get_by_id("asp_temp_45"));'>
                    Enable
                    <input type="radio" name="asp_temp_43" value="0" onClick='disable_dhcp(get_by_name("asp_temp_43")[1].checked, get_by_id("asp_temp_44"), get_by_id("asp_temp_45"));'">
                    Disable</font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Range Start</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_44" name="asp_temp_44" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_44","none"); %>">
                  </font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Range End</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_45" name="asp_temp_45" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_45","none"); %>">
                  </font></td>
                </tr>
              </table>
               <br>
               <input type="button" value="&lt; Back" id="back" name="back" onClick="window.location='wizard2.asp'">
               <input type="button" value="Next &gt;" id="next" name="next" onClick="send_request()">
               <input type="button" id="exit" name="exit" value="Exit" onClick="exit_wizard()">
              
              </form>
            </td>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="14"><img src="bg_wizard_4.gif" width="459"></td>
    </tr>
</table>
</body>
</html>
