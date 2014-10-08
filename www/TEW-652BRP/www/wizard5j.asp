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
		if(dat[0] !="0.0.0.0" && get_by_id("asp_temp_26").value == "0.0.0.0"){
			get_by_id("asp_temp_26").value = dat[0];
		}
		if(dat[1] !="0.0.0.0" && get_by_id("asp_temp_27").value == "0.0.0.0"){
			get_by_id("asp_temp_27").value = dat[1];
		}
		
		set_checked("<% CmoGetCfg("wan_l2tp_dynamic","none"); %>",get_by_name("l2tp_enable"));
		disable_dhcp_static_address(get_by_name("l2tp_enable"), get_by_id("asp_temp_26"), get_by_id("asp_temp_27"), get_by_id("asp_temp_28"));
	}
	
	
	function send_request(){		
		var ip = get_by_id("asp_temp_26").value;	
		var mask = get_by_id("asp_temp_27").value;
		var gateway = get_by_id("asp_temp_28").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		
        var user_name = get_by_id("asp_temp_24").value;
		
		if (get_by_name("l2tp_enable")[1].checked){	
			if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
				return false;
			}
		}
		if(get_by_id("asp_temp_29").value == ""){
    		alert(msg[MSG40]);
    		return false;
	     }
		
		if (get_by_name("l2tp_enable")[1].checked){
       		get_by_id("asp_temp_23").value = "0";
       		
       	}else{
       		get_by_id("asp_temp_23").value = "1";
       	}
	
		if (!check_pwd("asp_temp_25", "pwd2")){
			return false;
		}
		
		if (user_name == ""){
    		alert(msg[MSG51]);
			return false;
		}
		
	     if (get_by_id("asp_temp_25").value == "" || get_by_id("pwd2").value == ""){
		 	alert("A L2TP password MUST be specified");
			return false;
		}
		
		get_by_id("asp_temp_49").value = "1";
		
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
                <td class="headerbg">Set Russia L2TP Client</td>
              </tr>
            </table>
             <form id="form1" name="form1" method="post" action="apply.cgi">
             	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
	  			<input type="hidden" id="wan_curr_ipaddr" name="wan_curr_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="l2tp">
				<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetStatus("asp_temp_49"); %>">
	  			<input type="hidden" id="asp_temp_23" name="asp_temp_23" value="<% CmoGetStatus("asp_temp_23"); %>">
	  			<input type="hidden" id="wan_l2tp_dynamic00" name="wan_l2tp_dynamic00"  value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>">
	  			
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue">&nbsp;</td>
                    <td class="bggrey"><font face="Arial">
                      <input type="radio" name="l2tp_enable" value="1" onClick='disable_dhcp_static_address(get_by_name("l2tp_enable"), get_by_id("asp_temp_26"), get_by_id("asp_temp_27"), get_by_id("asp_temp_28"))'>
                    </font>Dynamic IP&nbsp;<font face="Arial">
                    <input type="radio" name="l2tp_enable" value="0" onClick='disable_dhcp_static_address(get_by_name("l2tp_enable"), get_by_id("asp_temp_26"), get_by_id("asp_temp_27"), get_by_id("asp_temp_28"))'>
                    </font>Static IP</td>
                  </tr>
                  <tr>
                    <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">My IP</font></td>
                    <td width="235" class="bggrey"><input type="text" id="asp_temp_26" name="asp_temp_26" size=16 maxlength=15 value="<% CmoGetCfg("asp_temp_26","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Subnet Mask</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_27" name="asp_temp_27" size=16 maxlength=15 value="<% CmoGetCfg("asp_temp_27","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">GateWay</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_28" name="asp_temp_28" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_28","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Server IP</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_29" name="asp_temp_29" size=30 maxlength=63 value="<% CmoGetCfg("asp_temp_29","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">L2TP Account</font></td>
                    <td class="bggrey"><input type="text" id="asp_temp_24" name="asp_temp_24" size="30" maxlength="63" value="<% CmoGetCfg("asp_temp_24","none"); %>"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue">L2TP Password</td>
                    <td class="bggrey"><input type="password" id="asp_temp_25" name="asp_temp_25" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue">Retype Password</td>
                    <td class="bggrey"><input type="password" id="pwd2" name="pwd2" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG"></td>
                  </tr>
                </table>
                <p>
                  <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard5.asp'">
                <input type="button" value="Next &gt;" name="next" onClick="send_request()">
                <input type="button" name="exit" value="Exit" onClick="exit_wizard()">
                </p>
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
