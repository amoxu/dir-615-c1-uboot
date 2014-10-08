<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
</head>
<script>
	function PageLoad(){
		
		set_checked(get_by_id("blank_status").value, get_by_name("start_wizard"));
		
	}
	function send_request(){
		get_by_id("blank_status").value = get_checked_value(get_by_name("start_wizard"));
		get_by_id("html_response_page").value = "wizard.asp";
		send_submit("form1");
	}
</script>
<body text="#000000" leftmargin="0" topmargin="0" onLoad="PageLoad();">
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
        <td width="86%" align="center">
          <form id="form1" name="form1" method="POST" action="apply.cgi">
          <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_redirect.asp">
          <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard.asp">
          <input type="hidden" id="reboot_type" name="reboot_type" value="none">
          <input type="hidden" id="blank_status" name="blank_status" value="<% CmoGetCfg("blank_status","none"); %>">
          <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
              <td bgcolor="#FFFFFF">
			  	<span class="bluetextbold">Step 1.</span>
				<span>Set your new password </span><br>                			
				<span class="bluetextbold">Step 2.</span>
				<span>Set LAN connection and DHCP Server </span><br>
                <span class="bluetextbold">Step 3.</span>
 				<span>Set internet connection</span><br>
               	<span class="bluetextbold">Step 4.</span>
				<span> Set wireless LAN connection</span><br>
				<span class="bluetextbold">Step 5.</span>
				<span>Restart</span><br>
		  	  </td>
            </tr>
            
            <tr>
              <td bgcolor="#FFFFFF"><p align="center">
                <input type="submit" value="Next &gt;" name="next">
                <input type="button" name="exit" value="Exit" onClick="exit_wizard()" style="width:50px">
                <br>
              </p>
                <p><font face="Arial" size="2pt"><b>Display wizard next time?</b>&nbsp;
                    <input type="radio" name="start_wizard" value="0">&nbsp;Yes&nbsp;
            		<input type="radio" name="start_wizard" value="1">&nbsp;No &nbsp;</font>
                  	<input type="button" value="update" name="update" style="width:50px" onClick="send_request();">
</p></td>
            </tr>
          </table>
          </form></td>
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
