<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		var dat = get_by_id("wan_curr_ipaddr").value.split("/");
		if(dat[0] !="0.0.0.0" && get_by_id("asp_temp_05").value == "0.0.0.0"){
			get_by_id("asp_temp_05").value = dat[0];
		}
		if(dat[1] !="0.0.0.0" && get_by_id("asp_temp_06").value == "0.0.0.0"){
			get_by_id("asp_temp_06").value = dat[1];
		}
	}
	
	function send_request(){
		var ip = get_by_id("asp_temp_05").value;		
		var mask = get_by_id("asp_temp_06").value;
		var gateway = get_by_id("asp_temp_07").value;
		var dns1 = get_by_id("asp_temp_09").value;
		var dns2 = get_by_id("asp_temp_10").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
		var dns1_addr_msg = replace_msg(all_ip_addr_msg,"DNS Server 1");
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,"DNS Server 2");
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
		
		if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
			return false;
		}
			
		if (!check_address(temp_dns1_obj)){
			return false;
		}		
		
		if (dns2 != "" && dns2 != "0.0.0.0"){
			if (!check_address(temp_dns2_obj)){
				return false;
			}
		}
		
		if((get_by_id("asp_temp_09").value =="" || get_by_id("asp_temp_09").value =="0.0.0.0")&& (get_by_id("asp_temp_10").value =="" || get_by_id("asp_temp_10").value =="0.0.0.0")){
			get_by_id("asp_temp_08").value = 0;
		}else{
			get_by_id("asp_temp_08").value = 1;
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
                <td class="headerbg">Set Fixed IP
          Address</td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="wan_curr_ipaddr" name="wan_curr_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
	  			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="static">
	  			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<% CmoGetCfg("asp_temp_08","none"); %>">
	  			
	  			
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial" color="#000000">WAN IP Address</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_05" name="asp_temp_05" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_05","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial" color="#000000">WAN Subnet Mask</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_06" name="asp_temp_06" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_06","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial" color="#000000">WAN Gateway Address</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_07" name="asp_temp_07" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_07","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial" color="#000000">DNS Server Address
                    1 </font></td>
                    <td class="bggrey"><font face="Arial">
                    <input type="text" id="asp_temp_09" name="asp_temp_09" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_09","none"); %>">
                    </font></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial" color="#000000">DNS Server Address
                    2 </font></td>
                    <td class="bggrey"><font face="Arial">
                    <input type="text" id="asp_temp_10" name="asp_temp_10" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_10","none"); %>">
                    </font></td>
                  </tr>
                </table>
                <br>
                <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard5.asp'">
                <input type="button" value="Next &gt;" name="next" onClick="send_request()">
                <input type="button" name="exit" value="Exit" onClick="exit_wizard()">
                
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
