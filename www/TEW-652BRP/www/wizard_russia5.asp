<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function send_request(){
   		get_by_id("asp_temp_23").value = "1"; //Russia pptp dynamic ip
		get_by_id("asp_temp_49").value = "1"; //Russia l2tp enable
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
                <td class="headerbg">Set Internet Access </td>
              </tr>
            </table>
              <form name="form1" id="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_russia5.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
				<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetCfg("asp_temp_49"); %>">
	  			<input type="hidden" id="asp_temp_23" name="asp_temp_23" value="<% CmoGetCfg("asp_temp_23"); %>">
	  			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="l2tp">
				
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Login</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <input type="text" id="asp_temp_24" name="asp_temp_24" size="30" maxlength="63" value="<% CmoGetCfg("asp_temp_24","none"); %>">
</font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Password</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <input type="password" id="asp_temp_25" name="asp_temp_25" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
</font></td>
                </tr>
              </table>
               <br><br><br><br><br><br>
               <input type="button" value="&lt; Back" id="back" name="back" onClick="window.location='wizard_russia1.asp'">
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
