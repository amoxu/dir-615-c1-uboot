<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script type="text/JavaScript">
	var submit_button_flag = 0;
	function send_request(){
		if (check_pwd("pwd1", "pwd2")){
			get_by_id("asp_temp_00").value = get_by_id("pwd1").value;
			send_submit("form1");
			
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				return true;
			}else{
				return false;
			}
		}
	}
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
}
.style2 {font-size: 12px}
-->
</style>
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
            <td width="7%"><img src="spacer.gif" width="30%" height="60"></td>
            <td width="86%" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="headerbg">Set Password</td>
              </tr>
              <tr>
                <td><div align="justify" class="style1">
                  <div align="justify" class="style2"><font face="Arial">Note:This is the password for managing the Router.This does not secure your wireless network.
                  </font></div>
                </div></td>                  
              </tr>
            </table>
            <form id="form1" name="form1" method="post" action="apply.cgi">
          		<input type="hidden" id="html_response_page" name="html_response_page" value="wizard3.asp">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard1.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
          		<input type="hidden" id="asp_temp_00" name="asp_temp_00">
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                
                <tr>
                  <td width="144" align="right" class="bgblue">Password</td>
                  <td width="235" class="bggrey"><font face="Arial">
                    <input type="password" id="pwd1" name="pwd1" size="20" maxlength="15" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
					(Maximum number of characters is 15)
                  </font></td>
                </tr>
                <tr>
                  <td width="144" align="right" class="bgblue">Verify Password</td>
                  <td width="235" class="bggrey"><font face="Arial">
                    <input type="password" id="pwd2" name="pwd2" size="20" maxlength="15" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
					(Maximum number of characters is 15)
                  </font></td>
                </tr>
              </table>

              <br>
              <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard.asp'">
              <input type="button" value="Next &gt;" name="next" onClick="send_request()">
              <input type="button" name="exit" value="Exit" onClick="exit_wizard()">
              
            </form></td>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="14"><img src="bg_wizard_4.gif" width="459"></td>
    </tr>
</table>
<div align="center"></div>
</body>
</html>
