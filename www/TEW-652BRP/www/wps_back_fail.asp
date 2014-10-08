<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>TRENDNET | TEW-652BRP Utility </title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function back(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="status.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
		
	}
</script>

</head>
<body>
<table width="750" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21"><img src="c1_tl.gif" width="21" height="21"></td>
    <td width="708" background="bg1_t.gif"><img src="top_1.gif" width="390" height="21"></td>
    <td width="21"><img src="c1_tr.gif" width="21" height="21"></td>
  </tr>
  <tr>
    <td valign="top" background="bg1_l.gif"><img src="top_2.gif"width="21" height="69"></td>
    <td background="bg.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="13%"><img src="logo.gif" width="270" height="69"></td>
        <td width="87%" align="right"><img src="description.gif"></td>
      </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="78%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10"><img src="c2_tl.gif" width="10" height="10"></td>
              <td width="688" background="bg2_t.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td width="10"><img src="c2_tr.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td background="bg2_l.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td background="bg3.gif">
			  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td>
					<form id="form1" name="form1" method="post">
					<input type="hidden" id="html_response_page" name="html_response_page" value="wlan_wps.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="<% CmoGetCfg("html_response_message","none"); %>">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
					<input type="hidden" name="reboot_type" value="none">
						<TABLE align="center" width="100%" height="200">
						  <tr>
							<td>
							  <table width="70%" border="0" align="center">
									<tr>
									  <td height="100"><div id=box_header>

										  <div align="left">
										    <p align="center" class="box_msg">You have failed to add the wireless device to your wireless network within the given timeframe, please click on the button below to do it again.</p>
										    <p align="center">
                                              <input name="button" id="button" type=button class=button_submit value="Retry" onClick="back()">
                                            </p>
									    </div>
									  </div></td>
									</tr>
								</table>
							  </td>
							</tr>
						</table>
					</form>				  
				  </td>
                </tr>
              </table>
			</td>
              <td background="bg2_r.gif"></td>
            </tr>
            <tr>
              <td><img src="c2_bl.gif" width="10" height="10"></td>
              <td background="bg2_b.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td><img src="c2_br.gif" width="10" height="10"></td>
            </tr>
          </table></td>
        </tr>
      </table>      
      <br>
    <br></td>
    <td background="bg1_r.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="c1_bl.gif" width="21" height="20"></td>
    <td align="right" background="bg1_b.gif"><img src="copyright.gif" width="264" height="20"></td>
    <td><img src="c1_br.gif" width="21" height="20"></td>
  </tr>
</table>

</body>
</html>
