<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		set_mac(get_by_id("asp_temp_03").value, ":");
	}
	function send_request(){
		var mac = "";
		
		for (var i = 1; i < 7; i++){
			mac += get_by_id("mac" + i).value;
			
			if (i < 6){
				mac += ":";
			}
		}
		
		if ((mac != "00:00:00:00:00:00") && (mac != ":::::")){
			if (!check_mac(mac)){
				alert(msg[MSG5]);
				return false;
			}
		}
		
		get_by_id("asp_temp_03").value= mac;
		
		send_submit("form1");
	}
	
	function clone_mac_action(){
		set_mac(get_by_id("mac_clone_addr").value, ":");
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
                <td class="headerbg">Set Dynamic
          IP Address</td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard6.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="dhcpc">
	  			
              	<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
              	<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<% CmoGetCfg("asp_temp_03","none"); %>">
              	
                <table width=100% border=0 cellpadding=3 cellspacing="1" bgcolor=#FFFFFF>
                  <tr>
                    <td width=76 height=19 nowrap bgcolor=#C5CEDA><b><font face="Arial, Helvetica, sans-serif" size="2">Host
                      Name</font></b></td>
                    <td width=303 height=19 bgcolor=#FFFFFF class="bggrey"><font face=Arial size=2>
                      <input type="text" id="asp_temp_04" name="asp_temp_04" size="40" maxlength="39" value="<% CmoGetCfg("asp_temp_04","none"); %>">
                      (optional)</font></td>
                  </tr>
                  <tr>
                    <td height=29 valign=middle bgcolor=#C5CEDA><b><font face="Arial" size="2">MAC</font></b></td>
                    <td width=303 height=29 bgcolor=#FFFFFF class="bggrey"><font face=Arial size=2>
                      <input type=text id="mac1" name="mac1" size="2" maxlength="2">
		              -
		              <input type=text id="mac2" name="mac2" size="2" maxlength="2">
		              -
		              <input type=text id="mac3" name="mac3" size="2" maxlength="2">
		              -
		              <input type=text id="mac4" name="mac4" size="2" maxlength="2">
		              -
		              <input type=text id="mac5" name="mac5" size="2" maxlength="2">
		              -
		              <input type=text id="mac6" name="mac6" size="2" maxlength="2">
                      (optional)</font><font face="Arial, Helvetica, sans-serif" size=2><br>
                      </font><font face=Arial size=2>
                      <input type="button" value="Clone MAC Address" name="clone" onClick="clone_mac_action();">
                      </font></td>
                  </tr>
                  <tr bgcolor=#FFFFFF>
                    <td height=26 bgcolor=#C5CEDA>&nbsp;</td>
                    <td width=303 height=30 bgcolor=#FFFFFF class="bggrey">&nbsp;</td>
                  </tr>
                </table>
                <p>
                  <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard5.asp'">
                  <input type="button" value="Next &gt;" name="next" onClick="send_request();">
                  <input type="button" name="exit" value="Exit" onClick=exit_wizard()>
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
