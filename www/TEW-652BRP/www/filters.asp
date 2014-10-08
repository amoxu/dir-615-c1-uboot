<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | MAC Filters</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 20;
	
	function loadSettings(){		
		set_checked("<% CmoGetCfg("mac_filter_type","none"); %>", get_by_name("mac_filter_type"));
	}
	
	function DataShow(){
		set_acl();
		for (var i=0; i<DataArray.length;i++){
			document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
			document.write("<td>"+ DataArray[i].Name +"</td>");
			document.write("<td>"+ DataArray[i].Mac_addr +"</td>");
			document.write("</tr>\n");
		}
	}
	
	function set_acl(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_mac;
			var k=i;
			if(i<10){
				k="0"+i;
			}
			temp_mac = (get_by_id("mac_filter_" + k).value).split("/");
			if (temp_mac.length > 1){
				if(temp_mac[1] != "name"){
					DataArray[DataArray.length++] = new Data(temp_mac[0],temp_mac[1],temp_mac[2], temp_mac[3], index);
					index++;
				}
			}
		}
	}
	
	//0/Name/00:00:00:00:00:00/Always
	function Data(enable,name, mac_addr, schedule, onList){
		this.Enable = enable;
		this.Name = name;
		this.Mac_addr = mac_addr;
		this.Schedule = schedule;
		this.OnList = onList;
	}
	
	function del_row(){
	  var index = parseInt(get_by_id("edit_row").value,10);
		var mac_filter_type = get_by_name("mac_filter_type");
	  if(confirm(addstr(msg[MSG16],"MAC filter"))){
			if(DataArray.length == "1"){
				if (mac_filter_type[1].checked || mac_filter_type[2].checked){
					alert("Apply setting failed. There must be at least one MAC address in the MAC Table. To delete the last MAC address in the MAC Table, please 'disable' the MAC Filter first. ");
					return false;
				}
				else{
		    	for(i=index ; i<DataArray.length-1 ;i++){
					DataArray[i].Enable = DataArray[i+1].Enable;
					DataArray[i].Name = DataArray[i+1].Name;
					DataArray[i].Mac_addr = DataArray[i+1].Mac_addr;
					DataArray[i].Schedule = DataArray[i+1].Schedule;
					DataArray[i].OnList = DataArray[i+1].OnList;
				}
			--DataArray.length;
			save_to_cfg();
			return true;
		    }
			}
			else{
				for(i=index ; i<DataArray.length-1 ;i++){
					DataArray[i].Enable = DataArray[i+1].Enable;
					DataArray[i].Name = DataArray[i+1].Name;
					DataArray[i].Mac_addr = DataArray[i+1].Mac_addr;
					DataArray[i].Schedule = DataArray[i+1].Schedule;
					DataArray[i].OnList = DataArray[i+1].OnList;
				}
				--DataArray.length;
				save_to_cfg();
				return true;
			}
		}
		else{
	      return false;
	  }
	}

    
  function edit_row(row){
  	var row_obj = get_by_id("table1").rows[row+1];
    var mac;
      
  	get_by_id("filter_name").value = get_row_data(row_obj, 0);    	
  	mac = get_row_data(row_obj, 1).split(":");
  	for (var i = 1; i < 7; i++){
  		get_by_id("mac" + i).value = mac[i-1];
  	}
      
    get_by_id("edit_row").value = row;
    get_by_id("add").disabled = true;
    get_by_id("update").disabled = false;
    get_by_id("del").disabled = false;
    change_color("table1", row+1);
  }
    
  function clear_row(){
    get_by_id("edit_row").value = "-1";
    change_color("table1", -1);
    location.href = "filters.asp";
  }
    
	function send_request(){
//		var filter_name = get_by_id("filter_name").value;
//		var mac_filter_type = get_by_name("mac_filter_type");
//		var mac = "";
//		if (mac_filter_type[1].checked || mac_filter_type[2].checked){
//			if (filter_name == ""){
//				alert("Please enter a MAC table name.");
//				return false;
//			}
//						
//			for (var i = 1; i < 7; i++){
//				mac += get_by_id("mac" + i).value;			
//				if (i < 6){
//					mac += ":";
//				}
//			}
//			if(mac == "00:00:00:00:00:00" || mac == ":::::"){
//				if (mac_filter_type[1].checked || mac_filter_type[2].checked ){
//					alert("Apply setting failed. There must be at least one MAC address in the MAC Table.");
//					return false;
//				}
//			}
//			if (!check_mac(mac)){					
//				alert(msg[MSG5]);
//				return false;
//			}
//
//			var chkmac1=parseInt(get_by_id("mac1").value,16);	
//			chkmac1%=2;
//			if (chkmac1 != 0){				
//					alert(" Mac address item 1 can't input the odd number ! ");
//					return false;
//			}
//		
//
//			var index = parseInt(get_by_id("edit_row").value,10);
//			//double name check
//			for(i=0;i<DataArray.length;i++){
//				if(DataArray[i].Name==get_by_id("filter_name").value){
//					if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
//						continue;
//					}else{
//						alert(addstr(msg[MSG41],"MAC name"));
//						return false;
//					}			
//				}
//				if(DataArray[i].Mac_addr==mac){
//					if(DataArray[i].Mac_addr != "" && index==(DataArray[i].OnList)){
//						continue;
//					}else{
//						alert(addstr(msg[MSG42],"MAC address"));
//						return false;
//					}			
//				}
//			}
		
			//save data ::edit
//			if(index > -1){
//				DataArray[index].Name = filter_name;
//				DataArray[index].Mac_addr = mac;
//			}else{//save add data
//				var max_num = DataArray.length;
//				if(parseInt(max_num,10)>(parseInt(rule_max_num-1,10))){
//					alert("The allowed number of static router is "+rule_max_num)
//					return false;
//				}
//				DataArray[DataArray.length++] = new Data(1,filter_name, mac, "Always", DataArray.length);
//			}
		var mac_filter_type = get_by_name("mac_filter_type");
		var mac = "";
		if(mac_filter_type[1].checked){			
			if(DataArray.length == 0){
				alert("MAC Filter settings will lockout all machines. This is not allowed.");
				return false;	
			}				
		}	
			save_to_cfg();
//			}
		send_submit("form1");
		}				
	
	function save_to_cfg(){
		for(k=0; k<rule_max_num; k++){
			var now_num = k;
			if(parseInt(k,10)<10){
				now_num = "0"+k;
			}
			var temp_st = "";
			if(k<DataArray.length){
				temp_st = DataArray[k].Enable+"/"+DataArray[k].Name +"/"+ DataArray[k].Mac_addr + "/" + DataArray[k].Schedule;
			}
			get_by_id("mac_filter_"+now_num).value = temp_st;
		}
	}
		function send_request_add(){
		var filter_name = get_by_id("filter_name").value;
		var mac_filter_type = get_by_name("mac_filter_type");
		var mac = "";
//		if (mac_filter_type[0].checked || mac_filter_type[1].checked || mac_filter_type[2].checked){
			if (filter_name == ""){
				alert("Please enter a MAC table name.");
				return false;
			}
						
			for (var i = 1; i < 7; i++){
				mac += get_by_id("mac" + i).value;			
				if (i < 6){
					mac += ":";
				}
			}
			if(mac == "00:00:00:00:00:00" || mac == ":::::"){
				if (mac_filter_type[1].checked || mac_filter_type[2].checked ){
					alert("Apply setting failed. There must be at least one MAC address in the MAC Table.");
					return false;
				}
			}
			if (!check_mac(mac)){					
					alert(msg[MSG5]);
					return false;
			}

			var chkmac1=parseInt(get_by_id("mac1").value,16);	
			chkmac1%=2;
			if (chkmac1 != 0){				
					alert(" Mac address item 1 can't input the odd number ! ");
					return false;
			}
		
		
			var index = parseInt(get_by_id("edit_row").value,10);
			//double name check
			for(i=0;i<DataArray.length;i++){
				if(DataArray[i].Name==get_by_id("filter_name").value){
					if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
						continue;
					}else{
						alert(addstr(msg[MSG41],"MAC name"));
						return false;
					}			
				}
				if(DataArray[i].Mac_addr==mac){
					if(DataArray[i].Mac_addr != "" && index==(DataArray[i].OnList)){
						continue;
					}else{
						alert(addstr(msg[MSG42],"MAC address"));
						return false;
					}			
				}
			}
		
			//save data ::edit
			if(index > -1){
				DataArray[index].Name = filter_name;
				DataArray[index].Mac_addr = mac;
			}else{//save add data
				var max_num = DataArray.length;
				if(parseInt(max_num,10)>(parseInt(rule_max_num-1,10))){
					alert("The allowed number of static router is "+rule_max_num)
					return false;
				}
				DataArray[DataArray.length++] = new Data(1,filter_name, mac, "Always", DataArray.length);
			}
			save_to_cfg();
//			}
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
          <td background="bg3.gif">
                      <table width="100%" border="0" cellpadding="3" cellspacing="0">
                        <tr>
                          <td width="85%" class="headerbg">Filter </td>
                          <td width="15%" class="headerbg"><a href="help_access.asp#access_user_group" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                        </tr>
                      </table>
                      <form id="form1" name="form1" method="post" action="apply.cgi">
                      	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                      	<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                      	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="filters.asp">
                      	<input type="hidden" id="reboot_type" name="reboot_type" value="all">
                      	
	                    <input type="hidden" id="mac_filter_00" name="mac_filter_00" value="<% CmoGetCfg("mac_filter_00","none"); %>">
		                <input type="hidden" id="mac_filter_01" name="mac_filter_01" value="<% CmoGetCfg("mac_filter_01","none"); %>">
		                <input type="hidden" id="mac_filter_02" name="mac_filter_02" value="<% CmoGetCfg("mac_filter_02","none"); %>">
		                <input type="hidden" id="mac_filter_03" name="mac_filter_03" value="<% CmoGetCfg("mac_filter_03","none"); %>">
		                <input type="hidden" id="mac_filter_04" name="mac_filter_04" value="<% CmoGetCfg("mac_filter_04","none"); %>">
		                <input type="hidden" id="mac_filter_05" name="mac_filter_05" value="<% CmoGetCfg("mac_filter_05","none"); %>">
		                <input type="hidden" id="mac_filter_06" name="mac_filter_06" value="<% CmoGetCfg("mac_filter_06","none"); %>">
		                <input type="hidden" id="mac_filter_07" name="mac_filter_07" value="<% CmoGetCfg("mac_filter_07","none"); %>">
		                <input type="hidden" id="mac_filter_08" name="mac_filter_08" value="<% CmoGetCfg("mac_filter_08","none"); %>">
		                <input type="hidden" id="mac_filter_09" name="mac_filter_09" value="<% CmoGetCfg("mac_filter_09","none"); %>">
		                <input type="hidden" id="mac_filter_10" name="mac_filter_10" value="<% CmoGetCfg("mac_filter_10","none"); %>">
		                <input type="hidden" id="mac_filter_11" name="mac_filter_11" value="<% CmoGetCfg("mac_filter_11","none"); %>">
		                <input type="hidden" id="mac_filter_12" name="mac_filter_12" value="<% CmoGetCfg("mac_filter_12","none"); %>">
		                <input type="hidden" id="mac_filter_13" name="mac_filter_13" value="<% CmoGetCfg("mac_filter_13","none"); %>">
		                <input type="hidden" id="mac_filter_14" name="mac_filter_14" value="<% CmoGetCfg("mac_filter_14","none"); %>">
		                <input type="hidden" id="mac_filter_15" name="mac_filter_15" value="<% CmoGetCfg("mac_filter_15","none"); %>">
		                <input type="hidden" id="mac_filter_16" name="mac_filter_16" value="<% CmoGetCfg("mac_filter_16","none"); %>">
		                <input type="hidden" id="mac_filter_17" name="mac_filter_17" value="<% CmoGetCfg("mac_filter_17","none"); %>">
		                <input type="hidden" id="mac_filter_18" name="mac_filter_18" value="<% CmoGetCfg("mac_filter_18","none"); %>">
		                <input type="hidden" id="mac_filter_19" name="mac_filter_19" value="<% CmoGetCfg("mac_filter_19","none"); %>">
                      
					<input type="hidden" id="edit_row" name="edit_row">
                      <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">

                        <tr>
                          <td align="right" valign="top" class="bgblue">Filters</td>
                          <td width="80%" class="bggrey">Filters are used to
                          allow or deny LAN users from accessing the Internet.
                            <br>
                            <br>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                              <tr>
                                <td width="5%">
                                  <input type="radio" name="filters" checked></td>
                                <td width="40%"><b><u>MAC Filters</u></b></td>
                                <td width="5%">&nbsp;</td>
                                <td width="50%">&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type=radio name="filters" onClick="location.href='domain_filter.asp'"></td>
                                <td colspan="2"><b>Domain/URL Blocking</b></td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type="radio" name="filters" onClick="location.href='protocol_filter.asp'"></td>
                                <td colspan="2"><b>Protocol/IP Filters</b></td>
                                <td>&nbsp;</td>
                              </tr>
                            </table>
                          </td></tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">MAC Filter</td>
                          <td class="bggrey"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                            <tr>
                                <td width="7%" valign="top"><input type="radio" value="disable" name="mac_filter_type"></td>
                                <td width="93%" valign="top"><font face="Arial" size="2">Disabled</font></td>
                            </tr>
                              
                              <tr>
                                <td colspan="2" valign="top"><img src="spacer.gif" width="10" height="5"></td>
                              </tr>
                              <tr>
                                <td valign="top"><input type="radio" value="list_allow" name="mac_filter_type"></td>
                                <td valign="top"><font face="Arial" size="2">Only <b>allow</b> computers with MAC address listed below to access the internet.</font></td>
                              </tr>
                              
                              <tr>
                                <td colspan="2" valign="top"><img src="spacer.gif" width="10" height="5"></td>
                              </tr>
                              <tr>
                                <td valign="top"><input type="radio" value="list_deny" name="mac_filter_type"></td>
                                <td valign="top"><font face="Arial" size="2">Only <b>deny</b> computers with MAC address listed below to access the internet.</font></td>
                              </tr>
														  <tr>
														   <td valign="top"><b>Note:</b></td>
															 <td valign="top"><b>Please add MAC address in the below MAC Table first then select "Only allow" or "Only deny", and click on "Apply".</b></td>
														  </tr>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">&nbsp;</td>
                          <td class="bggrey2">
						  	<input type="button" value="Apply" id="apply" name="apply" onClick="send_request()">
						  </td>
                        </tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">MAC
                          Table</td>
                          <td class="bggrey"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                            <tr>
                              <td width="22%" align="right"><font face="Arial" color="#000000" size="2"><b>Name:</b></font></td>
                              <td width="78%"><input type="text" id="filter_name" name="filter_name" size="32" maxlength="31"></td>
                            </tr>
                            <tr>
                              <td colspan="2"><img src="spacer.gif" width="10" height="5"></td>
                            </tr>
                            <tr>
                              <td align="right" nowrap><font face="Arial" color="#000000" size="2"><b>MAC
                          Address: </b></font></td>
                              <td><font face="Arial" size="2">
                                <input type="text" id="mac1" name="mac1" size="2" maxlength="2"> - 
								<input type="text" id="mac2" name="mac2" size="2" maxlength="2"> - 
								<input type="text" id="mac3" name="mac3" size="2" maxlength="2"> - 
								<input type="text" id="mac4" name="mac4" size="2" maxlength="2"> - 
								<input type="text" id="mac5" name="mac5" size="2" maxlength="2"> - 
								<input type="text" id="mac6" name="mac6" size="2" maxlength="2"></font></td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td align="right" valign="top" class="bgblue">&nbsp;</td>
                          <td class="bggrey2">
                          	<input type="button" value="Add" id="add" name="add" onClick="send_request_add()">		  	
														<input type="button" value="Update" id="update" name="update" onClick="send_request()" disabled>
														<input type="submit" value="Delete" id="del" name="del" onClick="return del_row()" disabled>
														<input type="button" value="Cancel" id="cancel" name="cancel"  onClick="clear_row()">
                          </td>
                        </tr>
                      </table>
                  </form>
                      <br>
                      <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" id="table1">
                      <tr align="center">
                        <td bgcolor="#C5CEDA"><b>Name</b></td>
                        <td bgcolor="#C5CEDA"><b>MAC Address</b></td>
                      </tr>
                      <script>DataShow();</script>
                      <!-- repeat name=show_mac_filter -->
                    </table>
                    <p>&nbsp;</p>
                    <p class="bluetextbold2">&nbsp;</p>
                    <p>&nbsp;</p></td>
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
</body>
</html>
