<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	
	function send_request(){
        var user_name = get_by_id("asp_temp_12").value;
		
		if (!check_pwd("asp_temp_13", "pwd2")){
			return false;
		}
	
		if (user_name == ""){
    		alert(msg[MSG51]);
			return false;
		}
		
	     if (get_by_id("asp_temp_13").value == "" || get_by_id("pwd2").value == ""){
		 	alert("A PPPoE password MUST be specified");
			return false;
		}
		
	
		send_submit("form1");
	}
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0">
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
                <td class="headerbg"><font size="4">Set PPPoE to
          obtain IP automatically IP</font></td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="pppoe">
	  			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="1">
	  			
                <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td width="140" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">User Name</font></td>
                    <td width="231" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                      <input type="text" id="asp_temp_12" name="asp_temp_12" size="30" maxlength="63" value="<% CmoGetCfg("asp_temp_12","none"); %>">
                    </font></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Password</font></td>
                    <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                      <input type="password" id="asp_temp_13" name="asp_temp_13" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
                    </font></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Verify Password</font></td>
                    <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                      <input type="password" id="pwd2" name="pwd2" size="30" maxlength="63" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
                    </font></td>
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
