<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Status | Log</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function to_first_page(){
		send_submit("form2");
	}
	
	function to_last_page(){
		send_submit("form3");
	}
	
	function to_next_page(){
		send_submit("form4");
	}
	
	function to_pre_page(){
		send_submit("form5");
	}
	
	function clear_log(){
		send_submit("form6");
	}
	
	function disable_log_button(){
		get_by_id("pre_page").disabled = false;
		get_by_id("next_page").disabled = false;
		get_by_id("first_page").disabled = false;
		get_by_id("last_page").disabled = false;
		
		if (get_by_id("current_page").value == "1"){
		    get_by_id("pre_page").disabled = true;
		}
		
		if (get_by_id("current_page").value == get_by_id("total_page").value){
		    get_by_id("next_page").disabled = true;
		}
	}

</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif')">
<table width="750" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21"><img src="c1_tl.gif" width="21" height="21"></td>
    <td width="708" background="bg1_t.gif"><img src="top_1.gif" width="390" height="21"></td>
    <td width="21"><img src="c1_tr.gif" width="21" height="21"></td>
  </tr>
  <tr>
    <td valign="top" background="bg1_l.gif"><img src="top_2.gif" width="21" height="69"></td>
    <td background="bg.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="13%"><img src="logo.gif" width="270" height="69"></td>
        <td width="87%" align="right"><img src="description.gif"></td>
      </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="20%" valign="top"><table width="56%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td><a href="lan.asp"><img src="but_main_0.gif" name="Image2" width="144" height="28" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','but_main_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="wireless_basic.asp"><img src="but_wireless_0.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a><a href="w_basic.asp"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="status.asp"><img src="but_status_1.gif" name="Image1" width="144" height="28" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','but_status_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                  <tr>
                    <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td width="87%"><a href="status.asp" class="submenus"><b>Device Information </b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="log.asp" class="submenus"><b><u>Log</u></b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="log_setting.asp" class="submenus"><b>Log Setting </b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="statistic.asp" class="submenus"><b>Statistic</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wla_conn.asp" class="submenus"><b>Wireless</b></a></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="static_routing.asp"><img src="but_routing_0.gif" name="Image4" width="144" height="28" border="0" id="Image4" onMouseOver="MM_swapImage('Image4','','but_routing_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="filters.asp"><img src="but_access_0.gif" name="Image5" width="144" height="28" border="0" id="Image5" onMouseOver="MM_swapImage('Image5','','but_access_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="remote_management.asp"><img src="but_management_0.gif" width="144" height="28" border="0" id="Image6" onMouseOver="MM_swapImage('Image6','','but_management_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="restart.asp"><img src="but_tools_0.gif" width="144" height="28" border="0" id="Image7" onMouseOver="MM_swapImage('Image7','','but_tools_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="#" onClick="show_wizard('wizard.asp')"><img src="but_wizard_0.gif" name="Image71" width="144" height="28" border="0" id="Image71" onMouseOver="MM_swapImage('Image71','','but_wizard_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="15" height="15"></td>
            </tr>
          </table></td>
          <td width="2%"><img src="spacer.gif" width="15" height="15"></td>
          <td width="78%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10"><img src="c2_tl.gif" width="10" height="10"></td>
              <td width="531" background="bg2_t.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td width="10"><img src="c2_tr.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td background="bg2_l.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td height="400" valign="top" background="bg3.gif"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                <tr>
                  <td width="85%" class="headerbg">Log</td>
                  <td width="15%" class="headerbg"><a href="help_status.asp#status_log" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                </tr>
              </table>
               <form id="form1" name="form1" method="post">
               <input type=hidden id="current_page" name="current_page" value="<% CmoGetStatus("log_current_page"); %>">
               <input type=hidden id="total_page" name="total_page" value="<% CmoGetStatus("log_total_page"); %>">
               <input type="hidden" name="total_log" id="total_log" value="<% CmoGetLog(); %>">
               
                         <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                           <tr>
                             <td>                                 
                              	<input type="button" id="first_page" name="first_page" value="First Page" onClick="to_first_page()">
        						<input type="button" id="last_page" name="last_page" value="Last Page" onClick="to_last_page()">
        						<input type="button" id="pre_page" name="pre_page" value="Previous Page" onClick="to_pre_page()">
        						<input type="button" id="next_page" name="next_page" value="Next Page" onClick="to_next_page()">
        						<input type="button" name="clear" value="Clear Log" onClick="clear_log()">
        						<input type="button" name="refresh" value="Refresh" onClick="location.href='log.asp'">
                              </td>
                           </tr>
                           <tr>
                             <td><font face="Tahoma" size="2">
                               Page:
                               <% CmoGetStatus("log_current_page"); %>/<% CmoGetStatus("log_total_page"); %>
                             </font></td>
                           </tr>
                           <tr>
                             <td><table width="100%" border="0" cellpadding="3" cellspacing="1">
                                 <tr>
                                   <td><font face="Arial, Helvetica, sans-serif" size="2">
                                     <!-- insert name=get_page_num -->
                                   </font></td>
                                 </tr>
                                 <tr>
                                   <td align="center" bgcolor="#C5CEDA"><b>Time</b></td>
                                   <td align="center" bgcolor="#C5CEDA"><b>Type</b></td>
                                   <td align="center" bgcolor="#C5CEDA"><b>Message</b></td>
                                 </tr>
                                 <script>
									var temp_entry = get_by_id("total_log").value.split("|syslog|");
									for (var i = 0; i < temp_entry.length; i++){
										var entry = temp_entry[i].split("|");
										if(entry.length > 1){
											document.write("<tr><td width=\"120\">" + entry[0] + "</td><td width=\"80\">" + entry[1] + "</td><td>" + entry[2] + "</td></tr>");
										}
									}
								</script>
                             </table></td>
                           </tr>
                         </table>
                </form>                       <p>&nbsp;</p></td>
              <td background="bg2_r.gif"><img src="spacer.gif" width="10" height="10"></td>
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
<form id="form2" name="form2" method="post" action="log_first_page.cgi"><input type="hidden" name="html_response_page" value="log.asp"><input type="hidden" name="html_response_return_page" value="log.asp"></form>
<form id="form3" name="form3" method="post" action="log_last_page.cgi"><input type="hidden" name="html_response_page" value="log.asp"><input type="hidden" name="html_response_return_page" value="log.asp"></form>
<form id="form4" name="form4" method="post" action="log_next_page.cgi"><input type="hidden" name="html_response_page" value="log.asp"><input type="hidden" name="html_response_return_page" value="log.asp"></form>
<form id="form5" name="form5" method="post" action="log_previous_page.cgi"><input type="hidden" name="html_response_page" value="log.asp"><input type="hidden" name="html_response_return_page" value="log.asp"></form>
<form id="form6" name="form6" method="post" action="log_clear_page.cgi"><input type="hidden" name="html_response_page" value="log.asp"><input type="hidden" name="html_response_return_page" value="log.asp"></form>
</body>
<script>
	disable_log_button();
</script>
</html>
