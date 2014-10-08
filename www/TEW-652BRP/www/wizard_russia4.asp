<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
	}
	
	function send_request(){
		var conn_type = get_select_value(get_by_id("ConnType"));
		get_by_id("asp_temp_59").value = conn_type;
		get_by_id("html_response_page").value = conn_type;
		get_by_id("asp_temp_48").value = "0"; //Russia pptp disable

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
                <td class="headerbg">Set Internet Connection </td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_russia4.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="asp_temp_59" name="asp_temp_59" value="<% CmoGetCfg("asp_temp_59"); %>">				
	  			<input type="hidden" id="asp_temp_48" name="asp_temp_48" value="<% CmoGetCfg("asp_temp_48"); %>">				
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue">WAN type</td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                  <font face="Arial" color="#000000"><font face="Arial" color="#000000">
                  <select id="ConnType" name="ConnType">
                    <option value="wizard5a.asp">obtain ip automatically (DHCP client)</option>
                    <option value="wizard5b.asp">Fixed IP address</option>
                    <option value="wizard5c.asp">PPPoE to obtain ip automatically</option>
                    <option value="wizard5d.asp">PPPoE with a fixed IP address</option>
                    <option value="wizard5e.asp">PPTP</option>
                    <option value="wizard5f.asp">L2TP</option>
                    <option value="wizard5g.asp">BigPond Cable</option>
                    <option value="wizard5h.asp">Russia PPPoE</option>
                    <option value="wizard5i.asp">Russia PPTP</option>
		    <option value="wizard5j.asp">Russia L2TP</option>
                  </select>
                  </font></font> </font>
                  </font></td>
                </tr>
              </table>
               <br>
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
