<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
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
            <td width="86%" align="center">
<form style="width:100% " >
<table border=0 cellspacing=0 cellpadding=0 width="100%">
<tr>
<td height=10>
        <table border=0 width="100%" cellpadding=0>
          <tr> 
            <td width="11%" height="76"> 
              <div align="left"><b><font face="Arial" size="2">LAN1</font></b></div>
            </td>
            <td width="37%" height="76"> 
              <div align="center">
			  
                <input type="hidden" id="lan_link_00" name="lan_link_00" value="<%  CmoGetStatus("lan_port_status_00"); %>">
								<!-- insert name=link_stat_lan1 -->
								<script>
									if(get_by_id("lan_link_00").value == "connect"){
										document.write("<img src=W_link.gif width=200 height=20 border=0>");
									}else{
										document.write("<img src=W_nolink.gif width=200 height=20 border=0>");
									}
								</script>
                </div>
            </td>
            <td width="35%" height="76"> 
              <div align="center">
			  <input type="hidden" id="lan_port_speed_duplex_00" name="lan_port_speed_duplex_00" value="<%  CmoGetStatus("lan_port_speed_duplex_00"); %>">
								<script>
									var temp_data = get_by_id("lan_port_speed_duplex_00").value;
									var data = temp_data.split("|");
									if(get_by_id("lan_link_00").value == "connect"){
										document.write("<font face=\"Tahoma\" size=\"2\" color=\"#000000\"><strong>"+ data[0] +"Mbps "+ data[1] +" Duplex</strong></font>");
									}else{
										document.write("<font face=\"Tahoma\" size=\"2\" color=\"#000000\">Disconnected</font>");
									}
								
								</script>
                <!-- insert name=link_stat_txt_lan1 -->
                </div>
            </td>
          </tr>
          <tr> 
            <td height=20> 
              <div align="center"></div>
            </td>
            <td height=20> 
              <div align="center">
                <font face="Tahoma" size="2"><strong><!-- insert name=lan1_tx --></strong></font>
                </div>
            </td>
            <td height=20>&nbsp;</td>
          </tr>
          <tr> 
            <td height=20> 
              <div align="center"></div>
            </td>
            <td height=20>
              <div align="center">
                <font face="Tahoma" size="2"><strong><!-- insert name=lan1_rx --></strong></font>
                </div>
            </td>
            <td height=20>&nbsp;</td>
          </tr>
        </table>
</td>
</tr>
<tr>
      <td height=10 align=right><input type="button" name="exit" value="Exit" onClick="window.close()"> 
      </td>
</tr>
</table>
</form>          </td>
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
