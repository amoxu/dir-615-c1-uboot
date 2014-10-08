<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		var wan_mode = get_by_id("wan_type").value;
		var wan_pppoe_mode = get_by_id("wan_pppoe_dynamic_00").value;
		
		var rus_pppoe = get_by_id("wan_pppoe_russia_enable").value;
		var rus_pptp = get_by_id("wan_pptp_russia_enable").value;
		var rus_l2tp = get_by_id("wan_l2tp_russia_enable").value;
		
			if(wan_mode=="pppoe" && rus_pppoe =="1"){
				get_by_name("ConnType")[7].checked = true;
			}else if(wan_mode=="pptp" && rus_pptp =="1"){
				get_by_name("ConnType")[8].checked = true;
			}else if(wan_mode=="l2tp" && rus_l2tp =="1"){
				get_by_name("ConnType")[9].checked = true;
			}else if(wan_mode=="bigpond"){
				get_by_name("ConnType")[6].checked = true;
			}else if(wan_mode=="l2tp"){
				get_by_name("ConnType")[5].checked = true;
			}else if(wan_mode=="static"){
				get_by_name("ConnType")[1].checked = true;
			}else if(wan_mode=="dhcpc"){
				get_by_name("ConnType")[0].checked = true;
			}else if(wan_mode=="pppoe"){
				if(wan_pppoe_mode =="0"){
					get_by_name("ConnType")[3].checked = true;
				}else{
					get_by_name("ConnType")[2].checked = true;
				}
			}else if(wan_mode=="pptp"){
				get_by_name("ConnType")[4].checked = true;
			}
	}
	
	function send_request(){
		get_by_id("asp_temp_59").value = get_checked_value(get_by_name("ConnType"));
		if (get_by_id("asp_temp_59").value == "wizard5f.asp"){
			get_by_id("asp_temp_49").value = 0;
		}
		else if(get_by_id("asp_temp_59").value == "wizard5e.asp"){
			get_by_id("asp_temp_48").value = 0;
		}
		else if((get_by_id("asp_temp_59").value == "wizard5c.asp")||(get_by_id("asp_temp_59").value == "wizard5d.asp")){
			get_by_id("asp_temp_47").value = 0;
		}
		get_by_id("html_response_page").value = get_by_id("asp_temp_59").value;
		
		send_submit("form1");
	}
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
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
                <td class="headerbg">Select Internet Connection Type</td>
              </tr>
              <tr>
                <td><div align="justify" class="style1"><font face="Arial">Gather all information related to your Internet Connection before proceeding.  If necessary, contact your Internet Service Provider (ISP) for more information.
                </font></div></td>                  
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard5.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
          		<input type="hidden" id="asp_temp_47" name="asp_temp_47" value="<% CmoGetCfg("asp_temp_47","none"); %>">
          		<input type="hidden" id="asp_temp_48" name="asp_temp_48" value="<% CmoGetCfg("asp_temp_48","none"); %>">
          		<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetCfg("asp_temp_49","none"); %>">
          		<input type="hidden" id="asp_temp_59" name="asp_temp_59" value="<% CmoGetCfg("asp_temp_59","none"); %>">
          		<input type="hidden" id="asp_temp_60" name="asp_temp_60" value="<% CmoGetCfg("asp_temp_60","none"); %>">
          		<input type="hidden" id="wan_type" name="wan_type" value="<% CmoGetCfg("wan_proto","none"); %>">
          		<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>">
          		<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("wan_pppoe_russia_enable");%>">
          		<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
          		<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
          		
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5a.asp">
                    Obtain IP automatically (DHCP client)</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5b.asp">
                    Fixed IP address</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5c.asp">
                    PPPoE to obtain IP automatically</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5d.asp">
                    PPPoE with a fixed IP address</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5e.asp">
                    PPTP</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5f.asp">
                    L2TP</font></td>
                  </tr>
                  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5g.asp">
                    BigPond Cable</font></td>
                  </tr>
					<tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5h.asp">
                    Russia PPPoE</font></td>
                  </tr>
					<tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5i.asp">
                    Russia PPTP</font></td>
                  </tr>
				  <tr>
                    <td class="bggrey"><font>
                      <input type="radio" name="ConnType" value="wizard5j.asp">
                    Russia L2TP</font></td>
                  </tr>
                </table>
                <br>
                <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard3.asp'">
                <input type="button" value="Next &gt;" name="next" onclick="send_request();">
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
