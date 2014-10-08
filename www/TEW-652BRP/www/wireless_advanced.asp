<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Wireless | Advanced</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		set_checked("<% CmoGetCfg("wlan0_dot11_mode","none"); %>",get_by_name("wlan0_dot11_mode"));
	}
		
	function check_perform(which_one){		
    	var obj;
    	var temp_obj;
    	
    	switch(which_one){
    		case 0 :
    			temp_obj = get_by_id("wlan0_beacon_interval");
    			var beacon_msg = replace_msg(check_num_msg, "Beacon interval", 25, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 25, 1000, false);
    			break;
    		case 1 :
    			temp_obj = get_by_id("wlan0_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, "RTS Threshold", 256, 2346);
    			obj = new varible_obj(temp_obj.value, rts_msg, 256, 2346, false);
    			break;
    		case 2 :
    			temp_obj = get_by_id("wlan0_fragmentation");
    			var frag_msg = replace_msg(check_num_msg, "Fragmentation", 1500, 2346);
    			obj = new varible_obj(temp_obj.value, frag_msg, 1500, 2346, true);
    			break;
    		case 3 :
    			temp_obj = get_by_id("wlan0_dtim");
    			var dtim_msg = replace_msg(check_num_msg, "DTIM interval",1 ,255);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 1, 255, false);
    			break;
    	}
    	
    	if (check_varible(obj)){
    		return true;
    	}else {
        	temp_obj.value = temp_obj.defaultValue;
        	return false;
    	}         
    }
	
	function send_request(){
		var is_submit = false;
    	
		for (var i = 0; i < 4; i++){
			is_submit = check_perform(i);
			
			if (!is_submit){			
				break;
    		} 
		}
	
		if (is_submit){
			send_submit("form1");
		}
	}
</SCRIPT>	
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');loadSettings();">
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
              <td><a href="wireless_basic.asp"><img src="but_wireless_1.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                  <tr>
                    <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td width="87%"><a href="wireless_basic.asp" class="submenus"><b>Basic</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wireless_auth.asp" class="submenus"><b>Security</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="wireless_advanced.asp" class="submenus"><b><u>Advanced</u></b></a></td>
                  </tr>
				<tr>
					<td align="right"><font color="#FFFFFF">&bull;</font></td>
					<td><a href="wlan_wps.asp" class="submenus"><b>WiFi Protected Setup</b></a></td>
				</tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="spacer.gif" width="8" height="8"></td>
            </tr>
            <tr>
              <td><a href="status.asp"><img src="but_status_0.gif" name="Image1" width="144" height="28" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','but_status_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
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
              <td background="bg2_l.gif"><img src="spacer.gif" width="10" height="10"></td><td height="400" valign="top" background="bg3.gif">
                      <table width="100%" border="0" cellpadding="3" cellspacing="0">
                        <tr>
                          <td width="85%" class="headerbg">Advanced</td>
                          <td width="15%" class="headerbg"><a href="help_wlan.asp#wireless_advanced" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                        </tr>
                      </table>
                  <form id="form1" name="form1" method="post" action="apply.cgi">
                  	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                    <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless_advanced.asp">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
                    
                    
                    
          <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td width="160" align="right" class="bgblue"><font face="Arial">Beacon 
                            Interval&nbsp;</font></td>
                          <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">
                            <input type="text" id="wlan0_beacon_interval" name="wlan0_beacon_interval"  size="5" maxlength="4" value="<% CmoGetCfg("wlan0_beacon_interval","none"); %>">
                            (default:100 msec, range:25~1000) </font></td>
                        </tr>
                        <tr>
                          <td width="160" align="right" class="bgblue"><font face="Arial">RTS 
                            Threshold&nbsp;</font></td>
                          <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">
                            <input type="text" id="wlan0_rts_threshold" name="wlan0_rts_threshold" size="5" maxlength="4" value="<% CmoGetCfg("wlan0_rts_threshold","none"); %>">
                            (default:2346, range: 256~2346)</font></td>
                        </tr>
                        <tr>
                          <td width="160" align="right" class="bgblue" ><font face="Arial">Fragmentation 
                            Threshold&nbsp;</font></td>
                          <td bgcolor="#FFFFFF" class="bggrey" ><font face="Arial" size="2">
                            <input type="text" id="wlan0_fragmentation" name="wlan0_fragmentation" size="5" maxlength="4" value="<% CmoGetCfg("wlan0_fragmentation","none"); %>">
                            
                            (default:2346, range: 1500~2346, even number only)</font></td>
                        </tr>
                        <tr>
                          <td width="160" align="right" class="bgblue"><font face="Arial">DTIM 
                            Interval&nbsp;</font></td>
                          <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">
                            <input type="text" id="wlan0_dtim" name="wlan0_dtim" size="5" maxlength="3" value="<% CmoGetCfg("wlan0_dtim","none"); %>">
                            (default:1, range: 1~255)</font></td>
                        </tr>
                        
                        <tr>
                          <td align="right" class="bgblue">&nbsp;</td>
                          <td bgcolor="#FFFFFF" class="bggrey2">
                          	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='wireless_advanced.asp'">
							<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                          </td>
                        </tr>
                    </table>
                  </form>
                    </td>
              <td height="400" valign="top" background="bg2_r.gif"><img src="spacer.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td><img src="c2_bl.gif" width="10" height="10"></td>
              <td background="bg2_b.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td><img src="c2_br.gif" width="10" height="10"></td>
            </tr>
          </table></td>
        </tr>
      </table>      
      <img src="spacer.gif" width="15" height="15"><br>
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
