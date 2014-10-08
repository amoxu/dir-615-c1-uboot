<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		set_checked("<% CmoGetCfg("asp_temp_43","none"); %>", get_by_name("asp_temp_43"));
	}
	
	function send_request(){
		
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
                <td class="headerbg">Set Fixed IP Address</td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_russia3.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">WAN IP Address</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <input type="text" id="asp_temp_19" name="asp_temp_19" size=16 maxlength=15 value="<% CmoGetCfg("asp_temp_19","none"); %>">
</font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">WAN Subnet Mask</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <input type="text" id="asp_temp_20" name="asp_temp_20" size=16 maxlength=15 value="<% CmoGetCfg("asp_temp_20","none"); %>">
</font></td>
                </tr>
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">WAN Gateway Address</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <input type="text" id="asp_temp_21" name="asp_temp_21" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_21","none"); %>">
</font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">DNS Server Address 1</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="wan_primary_dns" name="wan_primary_dns" size="16" maxlength="15" value="<% CmoGetCfg("wan_primary_dns","none"); %>">
                  </font></td>
                </tr>
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">DNS Server Address 2</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_41" name="asp_temp_41" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_41","none"); %>">
                  </font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">DNS Server Address 3</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                    <input type="text" id="asp_temp_42" name="asp_temp_42" size="16" maxlength="15" value="<% CmoGetCfg("asp_temp_42","none"); %>">
                  </font></td>
                </tr>
              </table>
               <br>
               <input type="button" value="&lt; Back" id="back" name="back" onClick="window.location='<% CmoGetCfg("html_response_return_page","none"); %>'">
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
