<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | Domain Blocking</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function loadSettings(){
		set_checked("<% CmoGetCfg("url_domain_filter_type","none"); %>", get_by_name("url_domain_filter_type"));
		
		tbox=get_by_id("blocked_domain_list");
		var tempkeyword;
		for(i=0;i<40;i++){
			var k = i;
			if(i<10){
				k="0"+k;
			}
			if(get_by_id("url_domain_filter_"+k).value.length>0){
				tempkeyword=decodeURIComponent(get_by_id("url_domain_filter_"+k).value)
				tbox.options[i]=new Option(tempkeyword,tempkeyword);
				get_by_id("url_domain_filter_"+k).value ="";
			}
		}
		
		show_table();
	}
	
	function enable_del_button(){
		if (get_by_id("blocked_domain_list").length > 0){
			if (get_by_id("blocked_domain_list").selectedIndex != "-1"){
			get_by_id("del_blocked").disabled = false;
		}
	}
	}
	
	function show_table(){
	
		var mode = get_by_name("url_domain_filter_type");
		var tbox=get_by_id("blocked_domain_list");
		var blocked_domain_list = get_by_id("blocked_domain_list");
		get_by_id("blocked_table").style.display = "none";
		get_by_id("blocked_table2").style.display = "none";
		if(!mode[0].checked){
			get_by_id("blocked_table").style.display = "";	
			get_by_id("blocked_table2").style.display = "";
			for(i=0;i < blocked_domain_list.length;i++){
			var k=i;
			if(k<10){
				k="0"+i;
			}
			get_by_id("url_domain_filter_"+k).value = get_by_id("blocked_domain_list").options[i].value;
		}
		}
	}
	
	function send_request(act){
		var mode = get_by_name("url_domain_filter_type");
		var blocked_domain = get_by_id("blocked_domain").value;
		var blocked_domain_list = get_by_id("blocked_domain_list");
		
		if (!mode[0].checked){
			if (blocked_domain != ""){
				for (var i = 0; i < blocked_domain_list.length; i++){
					if (blocked_domain == blocked_domain_list.options[i].value){
						alert(addstr(msg[MSG23],"domain"));
						get_by_id("blocked_domain").value="";
						return;
					}
				}
			}
		}
		
		if(act=="delete"){
			var del_select_index=get_by_id("blocked_domain_list").selectedIndex;
			var k=del_select_index;
			get_by_id("blocked_domain_list").options[get_by_id("blocked_domain_list").selectedIndex]=null;			
			get_by_id("del_blocked").disabled = true;			
			if(k<10){
				k="0"+del_select_index;
				}

			var tmp_index = del_select_index;
			for(i=del_select_index;i < blocked_domain_list.length;i++){
				tmp_index = i;
				if (tmp_index<10){
					tmp_index="0"+i;
				}
				get_by_id("url_domain_filter_"+tmp_index).value = get_by_id("blocked_domain_list").options[i].value;				
			}
			if (blocked_domain_list.length < 10){
				tmp_index="0"+blocked_domain_list.length;
			}
			get_by_id("url_domain_filter_"+tmp_index).value = "";	
			
		}else{
			var tbox=get_by_id("blocked_domain_list");
			var tbox_length=get_by_id("blocked_domain_list").length;
			if (get_by_id("blocked_domain").value != ""){
			tbox.options[tbox_length]=new Option(get_by_id("blocked_domain").value,get_by_id("blocked_domain").value);
			}
			else{
								 	alert("URL not allowed to enter the space.");
				 					return false;
			}
			get_by_id("blocked_domain").value ="";
		for(i=0;i < blocked_domain_list.length;i++){
			var k=i;
			if(k<10){
				k="0"+i;
			}
			get_by_id("url_domain_filter_"+k).value = get_by_id("blocked_domain_list").options[i].value;
		}
		}
	}
	
		function apply(){			
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
              <td><a href="filters.asp"><img src="but_access_1.gif" name="Image5" width="144" height="28" border="0" id="Image5" onMouseOver="MM_swapImage('Image5','','but_access_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                <tr>
                  <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td width="87%"><a href="filters.asp" class="submenus"><b><u>Filter </u></b></a></td>
                </tr>
               <!--<tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="inbound_filter.asp" class="submenus"><b>Inbound Filter </b></a></td>
                </tr>-->
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="virtual_server.asp" class="submenus"><b>Virtual Server </b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="special_ap.asp" class="submenus"><b>Special AP </b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="dmz.asp" class="submenus"><b>DMZ</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="firewall_setting.asp" class="submenus"><b>Firewall Settings</b></a></td>
                </tr>
              </table></td>
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
          <td height="400" valign="top" background="bg3.gif">
                      <table width="100%" border="0" cellpadding="3" cellspacing="0">
                        <tr>
                          <td width="85%" class="headerbg">Filter </td>
                          <td width="15%" class="headerbg"><a href="help_access.asp#access_domain_filter" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                        </tr>
                      </table>
                  <form id="form1" name="form1" method="post" action="apply.cgi">
                  	<input type="hidden" name="html_response_page" value="back.asp">
					<input type="hidden" name="html_response_message" value="Settings Saved">
					<input type="hidden" name="html_response_return_page" value="domain_filter.asp">
                  	<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
					<input type="hidden" id="url_domain_filter_00" name="url_domain_filter_00" value="<% CmoGetCfg("url_domain_filter_00","none"); %>">
					<input type="hidden" id="url_domain_filter_01" name="url_domain_filter_01" value="<% CmoGetCfg("url_domain_filter_01","none"); %>">
					<input type="hidden" id="url_domain_filter_02" name="url_domain_filter_02" value="<% CmoGetCfg("url_domain_filter_02","none"); %>">
					<input type="hidden" id="url_domain_filter_03" name="url_domain_filter_03" value="<% CmoGetCfg("url_domain_filter_03","none"); %>">
					<input type="hidden" id="url_domain_filter_04" name="url_domain_filter_04" value="<% CmoGetCfg("url_domain_filter_04","none"); %>">
					<input type="hidden" id="url_domain_filter_05" name="url_domain_filter_05" value="<% CmoGetCfg("url_domain_filter_05","none"); %>">
					<input type="hidden" id="url_domain_filter_06" name="url_domain_filter_06" value="<% CmoGetCfg("url_domain_filter_06","none"); %>">
					<input type="hidden" id="url_domain_filter_07" name="url_domain_filter_07" value="<% CmoGetCfg("url_domain_filter_07","none"); %>">
					<input type="hidden" id="url_domain_filter_08" name="url_domain_filter_08" value="<% CmoGetCfg("url_domain_filter_08","none"); %>">
					<input type="hidden" id="url_domain_filter_09" name="url_domain_filter_09" value="<% CmoGetCfg("url_domain_filter_09","none"); %>">
					<input type="hidden" id="url_domain_filter_10" name="url_domain_filter_10" value="<% CmoGetCfg("url_domain_filter_10","none"); %>">
					<input type="hidden" id="url_domain_filter_11" name="url_domain_filter_11" value="<% CmoGetCfg("url_domain_filter_11","none"); %>">
					<input type="hidden" id="url_domain_filter_12" name="url_domain_filter_12" value="<% CmoGetCfg("url_domain_filter_12","none"); %>">
					<input type="hidden" id="url_domain_filter_13" name="url_domain_filter_13" value="<% CmoGetCfg("url_domain_filter_13","none"); %>">
					<input type="hidden" id="url_domain_filter_14" name="url_domain_filter_14" value="<% CmoGetCfg("url_domain_filter_14","none"); %>">
					<input type="hidden" id="url_domain_filter_15" name="url_domain_filter_15" value="<% CmoGetCfg("url_domain_filter_15","none"); %>">
					<input type="hidden" id="url_domain_filter_16" name="url_domain_filter_16" value="<% CmoGetCfg("url_domain_filter_16","none"); %>">
					<input type="hidden" id="url_domain_filter_17" name="url_domain_filter_17" value="<% CmoGetCfg("url_domain_filter_17","none"); %>">
					<input type="hidden" id="url_domain_filter_18" name="url_domain_filter_18" value="<% CmoGetCfg("url_domain_filter_18","none"); %>">
					<input type="hidden" id="url_domain_filter_19" name="url_domain_filter_19" value="<% CmoGetCfg("url_domain_filter_19","none"); %>">
					<input type="hidden" id="url_domain_filter_20" name="url_domain_filter_20" value="<% CmoGetCfg("url_domain_filter_20","none"); %>">
					<input type="hidden" id="url_domain_filter_21" name="url_domain_filter_21" value="<% CmoGetCfg("url_domain_filter_21","none"); %>">
					<input type="hidden" id="url_domain_filter_22" name="url_domain_filter_22" value="<% CmoGetCfg("url_domain_filter_22","none"); %>">
					<input type="hidden" id="url_domain_filter_23" name="url_domain_filter_23" value="<% CmoGetCfg("url_domain_filter_23","none"); %>">
					<input type="hidden" id="url_domain_filter_24" name="url_domain_filter_24" value="<% CmoGetCfg("url_domain_filter_24","none"); %>">
					<input type="hidden" id="url_domain_filter_25" name="url_domain_filter_25" value="<% CmoGetCfg("url_domain_filter_25","none"); %>">
					<input type="hidden" id="url_domain_filter_26" name="url_domain_filter_26" value="<% CmoGetCfg("url_domain_filter_26","none"); %>">
					<input type="hidden" id="url_domain_filter_27" name="url_domain_filter_27" value="<% CmoGetCfg("url_domain_filter_27","none"); %>">
					<input type="hidden" id="url_domain_filter_28" name="url_domain_filter_28" value="<% CmoGetCfg("url_domain_filter_28","none"); %>">
					<input type="hidden" id="url_domain_filter_29" name="url_domain_filter_29" value="<% CmoGetCfg("url_domain_filter_29","none"); %>">
					<input type="hidden" id="url_domain_filter_30" name="url_domain_filter_30" value="<% CmoGetCfg("url_domain_filter_30","none"); %>">
					<input type="hidden" id="url_domain_filter_31" name="url_domain_filter_31" value="<% CmoGetCfg("url_domain_filter_31","none"); %>">
					<input type="hidden" id="url_domain_filter_32" name="url_domain_filter_32" value="<% CmoGetCfg("url_domain_filter_32","none"); %>">
					<input type="hidden" id="url_domain_filter_33" name="url_domain_filter_33" value="<% CmoGetCfg("url_domain_filter_33","none"); %>">
					<input type="hidden" id="url_domain_filter_34" name="url_domain_filter_34" value="<% CmoGetCfg("url_domain_filter_34","none"); %>">
					<input type="hidden" id="url_domain_filter_35" name="url_domain_filter_35" value="<% CmoGetCfg("url_domain_filter_35","none"); %>">
					<input type="hidden" id="url_domain_filter_36" name="url_domain_filter_36" value="<% CmoGetCfg("url_domain_filter_36","none"); %>">
					<input type="hidden" id="url_domain_filter_37" name="url_domain_filter_37" value="<% CmoGetCfg("url_domain_filter_37","none"); %>">
					<input type="hidden" id="url_domain_filter_38" name="url_domain_filter_38" value="<% CmoGetCfg("url_domain_filter_38","none"); %>">
					<input type="hidden" id="url_domain_filter_39" name="url_domain_filter_39" value="<% CmoGetCfg("url_domain_filter_39","none"); %>">
                  
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td align="right" valign="top" class="bgblue">Filters</td>
                          <td width="80%" class="bggrey">Filters are used to
                          allow or deny LAN users from accessing the Internet.
                            <br>
                            <br>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                              <tr>
                                <td width="5%"><input type="radio" name="filters" onClick="location.href='filters.asp'"></td>
                                <td width="40%"><b>MAC Filters</b></td>
                                <td width="5%">&nbsp;</td>
                                <td width="50%">&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type="radio" name="filters" checked></td>
                                <td colspan="2"><b><u>Domain/URL Blocking</u></b></td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type="radio" name="filters" onClick="location.href='protocol_filter.asp'"></td>
                                <td colspan="2"><b>Protocol/IP Filters</b></td>
                                <td>&nbsp;</td>
                              </tr>
                          </table></td></tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">Domain Blocking </td>
                          <td class="bggrey"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                            <tr>
                              <td width="7%" valign="top"><input type=radio name="url_domain_filter_type" value="disable" onClick="show_table()"></td>
                              <td width="93%" valign="top">Disabled</td>
                            </tr>
                            <tr>
                              <td colspan="2" valign="top"><img src="spacer.gif" width="10" height="5"></td>
                            </tr>
                            <tr>
                              <td valign="top"><input type=radio name="url_domain_filter_type" value="list_allow" onClick="show_table()"></td>
                              <td valign="top"><b>Allow</b> users to access all domains list.</td>
                            </tr>
                            <tr>
                              <td colspan="2" valign="top"><img src="spacer.gif" width="10" height="5"></td>
                            </tr>
                            <tr>
                              <td valign="top"><input type=radio name="url_domain_filter_type" value="list_deny" onClick="show_table()"></td>
                              <td valign="top"><b>Deny</b> users to access all domains list.</td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">&nbsp;</td>
                          <td class="bggrey"><span class="bggrey2">
                            <input type="submit" value="Apply" name="apply">
                          </span></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="blocked_table">
                          <td align="right" valign="top" class="bgblue">Domains List</td>
                          <td bgcolor="#FFFFFF" class="bggrey"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                            <tr>
                              <td width="84%" align="right"><input type=text id="blocked_domain" name="blocked_domain" size=32 maxlength=39></td>
                              <td width="16%">&nbsp;</td>
                            </tr>
                            <tr>
                              <td align="right">
                                <select id="blocked_domain_list" name="blocked_domain_list" size=5 onclick="enable_del_button();">
                                </select>
                              </td>
                              <td valign="top"><input type="button" value="Delete" id="del_blocked" name="del_blocked" onclick="send_request('delete');" disabled></td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="blocked_table2">
                          <td align="right" valign="top" class="bgblue">&nbsp;</td>
                          <td bgcolor="#FFFFFF" class="bggrey2"><span class="bggrey2">
                            <input type="button" value="Add" id="add2" name="add" onClick="send_request();">
                            <input type="button" name="cancel" value="Cancel" onClick="location.href='domain_filter.asp'">
                          </span></td>
                        </tr>
                    </table>
                    </p>
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
 