<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		set_checked("<% CmoGetCfg("asp_temp_34","none"); %>", get_by_name("asp_temp_34"));
		get_by_id("show_ssid").value = get_by_id("asp_temp_35").value;
	}
	
	function set_channel(){
		var channel_list = "<% CmoGetStatus("wlan0_channel_list"); %>";
		var current_channel = "<% CmoGetCfg("asp_temp_36","none"); %>";
		var ch = channel_list.split(",");
		var obj = get_by_id("asp_temp_36");
		var count = 0;
		
		for (var i = 0; i < ch.length; i++){			
			var oOption = document.createElement("OPTION");						
			oOption.text = ch[i];
			oOption.value = ch[i];				
			obj.options[count++] = oOption;
								
			if (ch[i] == current_channel){
				oOption.selected = true;
			}        		
		}
	}

	function send_request(){
		if (check_ssid("show_ssid")){
			get_by_id("asp_temp_35").value = get_by_id("show_ssid").value;
			if (get_by_id("asp_temp_35").value != "TRENDnet" ){
                   get_by_id("asp_temp_50").value = 5;
            }
            else{
            		get_by_id("asp_temp_50").value = 1;
            }	       
			send_submit("form1");
		}
	}
</script>
<style type="text/css">
<!--
.style3 {
	font-size: 12px;
	font-weight: bold;
}
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
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
            <td width="86%" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="headerbg">Set Wireless LAN Connection</td>
              </tr>
              <tr>
                <td><div align="justify" class="style3"><font face="Arial">SSID : Assign your network a unique SSID.Do not use anything that would be identifying like "Smith Family Network".Choose something that you would easily identify when searching for available wireless networks.<br>
  Channel : Most wireless access points and routers are defaulted to channel 6.  If you have a site survey tool that will display the channels you can plan your channel selection around neighboring access points to minimize interference from them.  If your site survey tool does not display the channel try using channels 1 or 11. </font></div></td>                  
              </tr>
            </table>
              <form name="form1" id="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard61.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard5.asp">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<% CmoGetCfg("asp_temp_35","none"); %>">
              	<!-- wps_configured_mode -->
	  			<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<% CmoGetCfg("asp_temp_50","none"); %>">
              	
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Wireless LAN</font></td>
                    <td width="235" class="bggrey"><font face="Arial">
                    <input type="radio" name="asp_temp_34" value="1">
                      Enable
                    <input type="radio" name="asp_temp_34" value="0">
                      Disable</font></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">SSID</font></td>
                    <td class="bggrey"><input type="text" id="show_ssid" name="show_ssid" size="20" maxlength="32"></td>
                  </tr>
                  <tr>
                    <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Channel </font></td>
                    <td class="bggrey"><select size="1" id="asp_temp_36" name="asp_temp_36"></select></td>
                  </tr>
                </table>
                <p>
                  <input type="button" value="&lt; Back" name="back" onClick="window.location='<% CmoGetCfg("asp_temp_59","none"); %>'" value="&lt; Back">
                <input type="button" value="Next &gt;" name="next" onClick="send_request()">
                <input type="button" name="exit" value="Exit" onClick="exit_wizard()">
                </p>
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
<script>
	loadSettings();
	set_channel();
</script>
</html>
