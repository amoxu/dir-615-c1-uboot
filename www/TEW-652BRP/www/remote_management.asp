<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Management | Remote Management</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
			
	function loadSettings(){				
		set_checked("<% CmoGetCfg("remote_http_management_enable","none"); %>", get_by_name("remote_http_management_enable"));
		var ipadd_range_array = get_by_id("remote_http_management_ipaddr_range").value.split("-");
		get_by_id("http_ip1").value = ipadd_range_array[0];
		if(ipadd_range_array.length>1){
			get_by_id("http_ip2").value = ipadd_range_array[1];
		}
		
		set_checked("<% CmoGetCfg("wan_port_ping_response_enable","none"); %>", get_by_name("wan_port_ping_response_enable"));
		set_checked("<% CmoGetCfg("upnp_enable","none"); %>", get_by_name("upnp_enable"));
		set_checked("<% CmoGetCfg("l2tp_pass_through","none"); %>", get_by_name("l2tp_pass_through"));
		set_checked("<% CmoGetCfg("pptp_pass_through","none"); %>", get_by_name("pptp_pass_through"));
		set_checked("<% CmoGetCfg("multicast_stream_enable","none"); %>", get_by_name("multicast_stream_enable"));
		set_checked("<% CmoGetCfg("remote_http_management_enable","none"); %>", get_by_name("remote_http_management_enable"));
				
	}
	
	function send_request(){
		var http_port = get_by_id("remote_http_management_port").value;
		var temp_enable = get_by_id("remote_http_management_enable").value;
		var http_ip1 = get_by_id("http_ip1").value;
		var http_ip2 = get_by_id("http_ip2").value;
		var temp_http_ip1 = new addr_obj(http_ip1.split("."), http_form_ip_addr_msg, false, false);
		var temp_http_ip2 = new addr_obj(http_ip2.split("."), http_to_ip_addr_msg, false, false);
		var vs_rule_max = 20;
		var ipaddr_range_word = http_ip1;
		//check virtual server public port and remote management port conflict problem
			for(var i = 0; i < vs_rule_max; i++){
				if(get_by_id("vs_rule_" + i).value != ""){
					var vs_rule = (get_by_id("vs_rule_" + i).value).split("/");
					if(vs_rule[0] == "1" && http_port == vs_rule[3]){
						alert("Remote Management HTTP port conflict with Virtual Server Public port.");		
						return false;
					}
				}
			}
		
		
		if (!check_port(http_port)){
			alert(msg[MSG25]);	
			return false;
		}
		
		if (temp_enable !=0){
			if ((http_ip1 != "*")&&((http_ip1 != "")&&(http_ip1 != "0.0.0.0"))){
			if (!check_address(temp_http_ip1)){
				return false;
			}	
		}
			else{
				get_by_id("http_ip1").value ="*";
				ipaddr_range_word="*";
				get_by_id("remote_http_management_enable").value=0;
			}
		
			if ((http_ip2 != "")&&(http_ip2 != "0.0.0.0")){
			if (!check_address(temp_http_ip2)){
				return false;
			}
		}
			else{
				get_by_id("http_ip2").value="";
			}
			if ((http_ip1 != "*")&&((http_ip1 != "")&&(http_ip1 != "0.0.0.0")&&(http_ip2 != "")&&(http_ip2 != "0.0.0.0"))){
		if (!check_ip_order(temp_http_ip1,temp_http_ip2)){
		alert(msg[MSG4]);
		return false;
		}
				else{
					ipaddr_range_word = ipaddr_range_word +"-"+ http_ip2;
				}
			}
		}
//		if (http_ip1 != "*"){
//			if (!check_address(temp_http_ip1)){
//				return false;
//			}	
//		}
//		
//		if (http_ip2 != ""){
//			if (!check_address(temp_http_ip2)){
//				return false;
//			}else{
//				ipaddr_range_word = ipaddr_range_word +"-"+ http_ip2;
//			}
//		}
//		if (!check_ip_order(temp_http_ip1,temp_http_ip2)){
//		alert(msg[MSG4]);
//		return false;
//		}
		get_by_id("remote_http_management_ipaddr_range").value = ipaddr_range_word; 
		
		send_submit("form1");
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
              <td><a href="wireless_basic.asp"><img src="but_wireless_0.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a><a href="w_basic.asp"></a></td>
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
              <td><a href="remote_management.asp"><img src="but_management_1.gif" name="Image6" width="144" height="28" border="0" id="Image6" onMouseOver="MM_swapImage('Image6','','but_management_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                  <tr>
                    <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td width="87%" nowrap><a href="remote_management.asp" class="submenus"><b><u>Remote Management </u></b></a></td>
                  </tr>
              </table></td>
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
              <td height="400" valign="top" background="bg3.gif">
                   <table width="100%" border="0" cellpadding="3" cellspacing="0">
                     <tr>
                       <td width="85%" class="headerbg">Remote Management </td>
                       <td width="15%" class="headerbg"><a href="help_manage.asp#Management_RemMan" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                     </tr>
                   </table>
                  <form id="form1" name="form1" method="post" action="apply.cgi">
                  	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                    <input type="hidden" id="html_response_message" name="html_response_message" value="Settings Saved.">
                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="remote_management.asp">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="all">
                  
                  	<input type="hidden" id="remote_http_management_ipaddr_range" name="remote_http_management_ipaddr_range" value="<% CmoGetCfg("remote_http_management_ipaddr_range","none"); %>">
                    <input type="hidden" id="remote_http_management_enable" name="remote_http_management_enable" value="<% CmoGetCfg("remote_http_management_enable","none"); %>">
                    <input type="hidden" id="vs_rule_0" name="vs_rule_0" value="<% CmoGetCfg("vs_rule_00","none"); %>">
	                <input type="hidden" id="vs_rule_1" name="vs_rule_1" value="<% CmoGetCfg("vs_rule_01","none"); %>">
	                <input type="hidden" id="vs_rule_2" name="vs_rule_2" value="<% CmoGetCfg("vs_rule_02","none"); %>">
	                <input type="hidden" id="vs_rule_3" name="vs_rule_3" value="<% CmoGetCfg("vs_rule_03","none"); %>">
	                <input type="hidden" id="vs_rule_4" name="vs_rule_4" value="<% CmoGetCfg("vs_rule_04","none"); %>">
	                <input type="hidden" id="vs_rule_5" name="vs_rule_5" value="<% CmoGetCfg("vs_rule_05","none"); %>">
	                <input type="hidden" id="vs_rule_6" name="vs_rule_6" value="<% CmoGetCfg("vs_rule_06","none"); %>">
	                <input type="hidden" id="vs_rule_7" name="vs_rule_7" value="<% CmoGetCfg("vs_rule_07","none"); %>">
	                <input type="hidden" id="vs_rule_8" name="vs_rule_8" value="<% CmoGetCfg("vs_rule_08","none"); %>">
	                <input type="hidden" id="vs_rule_9" name="vs_rule_9" value="<% CmoGetCfg("vs_rule_09","none"); %>">
	                <input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<% CmoGetCfg("vs_rule_10","none"); %>">
	                <input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<% CmoGetCfg("vs_rule_11","none"); %>">
	                <input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<% CmoGetCfg("vs_rule_12","none"); %>">
	                <input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<% CmoGetCfg("vs_rule_13","none"); %>">
	                <input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<% CmoGetCfg("vs_rule_14","none"); %>">
	                <input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<% CmoGetCfg("vs_rule_15","none"); %>">
	                <input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<% CmoGetCfg("vs_rule_16","none"); %>">
	                <input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<% CmoGetCfg("vs_rule_17","none"); %>">
	                <input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<% CmoGetCfg("vs_rule_18","none"); %>">
	                <input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<% CmoGetCfg("vs_rule_19","none"); %>">
	                
	              	
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td width="150"  rowspan="3" align="right" valign="top" class="bgblue">HTTP</td>
                      <td class="bggrey"><font face="Arial" size="2">
                        <input type="radio" value="1" name="remote_http_management_enable">
                        </font><font face="Arial" size="2">Enabled</font>
                        <input type="radio" value="0" name="remote_http_management_enable">
                          Disabled</td>
                    </tr>
                    <tr>
                      <td class="bggrey"><font face="Arial">Port:</font><font face="Arial">
                        <input type="text" id="remote_http_management_port" name="remote_http_management_port" size="6" maxlength="5" value="<% CmoGetCfg("remote_http_management_port","none"); %>">
                      </font></td>
                      </tr>
                    <tr>
                      <td class="bggrey"><font face="Arial">Remote IP Range:<br>
						</font>From&nbsp;
						<input type="text" id="http_ip1" name="http_ip1" size="16" maxlength="15">
                        &nbsp;To&nbsp;
                        <input type="text" id="http_ip2" name="http_ip2" size="16" maxlength="15"></td>
                      </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">Allow
                        to Ping WAN Port</td>
                      <td class="bggrey"><font face="Arial" size="2">
                        <input type="radio" value="1" name="wan_port_ping_response_enable">
                        </font><font face="Arial" size="2">Enabled</font><font face="Arial" size="2">
                        <input type="radio" value="0" name="wan_port_ping_response_enable">
                          Disabled</font></td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">UPNP Enable</td>
                      <td class="bggrey">
                        <input type="radio" value="1" name="upnp_enable">
                        Enabled
                        <input type="radio" value="0" name="upnp_enable">
                        Disabled </td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">PPTP&nbsp;</td>
                      <td class="bggrey">
                        <input type="radio" value="1" name="pptp_pass_through">
                        Enabled
                        <input type="radio" value="0" name="pptp_pass_through">
                        Disabled </td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">L2TP&nbsp;</td>
                      <td class="bggrey">
                        <input type="radio" value="1" name="l2tp_pass_through">
    Enabled
    <input type="radio" value="0" name="l2tp_pass_through">
    Disabled </td>
                    </tr>
                    <tr>
                      <td align="right" valign="top" class="bgblue">Multicast Streams&nbsp;</td>
                      <td height="23" class="bggrey">
                        <input type="radio" value="1" name="multicast_stream_enable">
                          Enabled&nbsp;&nbsp;&nbsp;
                        <input type="radio" value="0" name="multicast_stream_enable">
                        Disabled</td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue" >&nbsp;</td>
                      <td class="bggrey2" >
                        <input type="button" value="Cancel" name="cancel" onClick="window.location.href='remote_management.asp'">
                        <input type="button" value="Apply" name="apply" onClick="send_request()"></td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
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
