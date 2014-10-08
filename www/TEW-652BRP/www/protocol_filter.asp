<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | Protocol Filters</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 20;
	
	function DataShow(){
		set_blockservice();
		for (var i=0; i<DataArray.length;i++){
			var port_word = DataArray[i].Start_port;
			var protocol_word = DataArray[i].Protocol;
						
						
//			if(DataArray[i].End_port >= DataArray[i].Start_port){
				port_word = port_word +"-"+ DataArray[i].End_port;
//			}
			
			var port_IP = DataArray[i].Start_ip;
			if(ip_num(DataArray[i].End_ip.split(".")) >= ip_num(DataArray[i].Start_ip.split("."))){
				port_IP = port_IP +"-"+ DataArray[i].End_ip;
			}
			
			
			var enable_name = "enable"+i;
			document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
			document.write("<td align=\"center\"><input type=\"checkbox\" id=\""+ enable_name +"\" name=\""+ enable_name +"\" value=\"1\"></td>");
			document.write("<td>"+ DataArray[i].Name +"</td>");
			document.write("<td>"+ DataArray[i].Protocol +"</td>");
			document.write("<td>"+ port_word +"</td>");
			document.write("<td>"+ port_IP +"</td>");
			
			document.write("</tr>\n");
			check_box_enabled(i);
		}
	}
	
	function check_box_enabled(num){
		var array_num = num;
		get_by_id("enable"+num).checked = false;
		get_by_id("enable"+num).disabled = true;
		if(parseInt(DataArray[array_num].Enable,10)==1){
			get_by_id("enable"+num).checked = true;
		}
	}
	
	function set_blockservice(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var k=i;
			if(i<10){
				k="0"+i;
			}
			var temp_pf = get_by_id("block_service_" + k).value.split("/");
			if (temp_pf.length > 1){
				if(temp_pf[1].length > 0){
					DataArray[DataArray.length++] = new Data(temp_pf[0],temp_pf[1], temp_pf[2], temp_pf[3],temp_pf[4],temp_pf[5],temp_pf[6],temp_pf[7],index);
					index++;
				}
			}
		}
	}
	
	//0/name/both/0/0/0.0.0.0/0.0.0.0/always
	function Data(enable, name, protocol, start_port, end_port, start_ip, end_ip, schedule, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Protocol = protocol;
		this.Start_port = start_port;
		this.End_port = end_port;
		this.Start_ip = start_ip;
		this.End_ip = end_ip;
		this.Schedule = schedule;
		this.OnList = onList ;
	}
		
 	function del_row(){
        var index = parseInt(get_by_id("edit_row").value,10);
        if(confirm(addstr(msg[MSG16],"protocol filter"))){
        	for(i=index ; i<DataArray.length-1 ;i++){
				DataArray[i].Enable = DataArray[i+1].Enable;
				DataArray[i].Name = DataArray[i+1].Name;
				DataArray[i].Protocol = DataArray[i+1].Protocol;
				DataArray[i].Start_port = DataArray[i+1].Start_port;
				DataArray[i].End_port = DataArray[i+1].End_port;
				DataArray[i].Start_ip = DataArray[i+1].Start_ip;
				DataArray[i].End_ip = DataArray[i+1].End_ip;
				DataArray[i].Schedule = DataArray[i+1].Schedule;
				DataArray[i].OnList = DataArray[i+1].OnList;
			}
			--DataArray.length;
			save_to_cfg();
			get_by_id("reboot_type").value = "filter";
			return true;
        }
        return false;
    }
   
    function edit_row(row){
    	var row_obj = get_by_id("table1").rows[row+1];        
        var enable = get_by_name("enable");
        var port;
        var ip_range;
        
        if (get_by_id("enable" + row).checked){
        	enable[0].checked = true;
        }else{
        	enable[1].checked = true;
        }
        get_by_id("protocol_name").value = get_row_data(row_obj, 1);
        temp_data = get_row_data(row_obj, 2).split(" ");
        set_selectIndex(temp_data[0], get_by_id("protocol"));
        
        port = get_row_data(row_obj, 3).split("-");
        get_by_id("start_port").value = port[0];
        if (port.length > 1){
        	get_by_id("end_port").value = port[1];
        }else{
        	get_by_id("end_port").value = "";
        }
        
        ip_range = get_row_data(row_obj, 4).split("-");
        get_by_id("start_ip").value = ip_range[0];
        if (ip_range.length > 1){
        	get_by_id("end_ip").value = ip_range[1];
        }else{
        	get_by_id("end_ip").value = "";
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
        location.href = "protocol_filter.asp";
    }
    
	function send_request(){		
		var protocol_name = get_by_id("protocol_name").value;
		var start_port = get_by_id("start_port").value;
		var end_port = get_by_id("end_port").value;
		var start_ip = get_by_id("start_ip").value;
		var end_ip = get_by_id("end_ip").value;
		var temp_enable = get_checked_value(get_by_name("enable"));
		
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"start IP address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"end IP address");
		
		var temp_start_ip_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var temp_end_ip_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
		
		var temp_LAN_ip_obj = new addr_obj(get_by_id("cur_ipaddr").value.split("."), all_ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(get_by_id("cur_netmask").value.split("."), subnet_mask_msg, false, false);
				
		if (protocol_name == ""){
			alert(msg[MSG18]);
			return false;
		}
		
		if (!check_port(start_port)){
			alert(msg[MSG25]);	
			return false;
		}
			
		if (!check_port(end_port)){
				alert(msg[MSG25]);	
				return false;
		}
		
		if (parseInt(end_port) < parseInt(start_port)){
			alert("The second field of port range can not be smaller than first field ");
			return false;
		}
		
		if ((temp_enable == 1)&&((start_ip != "")&&(start_ip != "0.0.0.0"))&&((end_ip != "")&&(end_ip != "0.0.0.0"))){
		if (!check_address(temp_start_ip_obj)){
			return false;
		}
		
		if (!check_domain(temp_LAN_ip_obj, temp_mask_obj, temp_start_ip_obj)){
			alert(addstr(msg[MSG3], "start IP address"));
			return false;
		}
		
		if (end_ip != ""){
			if (!check_address(temp_end_ip_obj)){
				return false;
			}
			
			if (!check_domain(temp_LAN_ip_obj, temp_mask_obj, temp_end_ip_obj)){
				alert(addstr(msg[MSG3],"End IP address"));
				return false;
			}
		}
					
		if (!check_ip_order(temp_start_ip_obj, temp_end_ip_obj)){
			alert(msg[MSG4]);
			return false;
		}
		}
		else{ 
			get_by_id("enable").value = "0";
			get_by_id("end_ip").value="0.0.0.0";
			get_by_id("start_ip").value="0.0.0.0";
			start_ip= "0.0.0.0";
			end_ip= "0.0.0.0";
		}
		
		var index = parseInt(get_by_id("edit_row").value,10);
		//double name check
		for(i=0;i<DataArray.length;i++){
			if(DataArray[i].Name==get_by_id("protocol_name").value){
				if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
					continue;
				}else{
					alert(addstr(msg[MSG41],"Filter name"));
					return false;
				}			
			}
			
			if(DataArray[i].Protocol == get_by_id("protocol").value){
				var port_start = parseInt(get_by_id("start_port").value);
				var port_end = parseInt(get_by_id("end_port").value);
				if (((port_start >= DataArray[i].Start_port) && (port_start <= DataArray[i].End_port)) || 
		            ((port_end >= DataArray[i].Start_port) && (port_end <= DataArray[i].End_port)) || 
		            ((DataArray[i].Start_port >= port_start) && (DataArray[i].Start_port <= port_end)) || 
		            ((DataArray[i].End_port >= port_start) && (DataArray[i].End_port <= port_end))){
		            if(index==(DataArray[i].OnList)){
		            	continue;
					}else{		// if add a new port forwarding
						alert(addstr(msg[MSG28],""));	
						return false;
					}
				}
			}
		}
		
		//save data ::edit
		if(index > -1){
			DataArray[index].Enable = get_checked_value(get_by_name("enable"));
			DataArray[index].Name = protocol_name;
			DataArray[index].Protocol = get_by_id("protocol").value;
			DataArray[index].Start_port = start_port;
			DataArray[index].End_port = end_port;
			DataArray[index].Start_ip = start_ip;
			DataArray[index].End_ip = end_ip;
		}else{//save add data
			var max_num = DataArray.length;
			if(parseInt(max_num,10)>rule_max_num){
				alert("The allowed number of static router is "+ rule_max_num)
				return false;
			}
			DataArray[DataArray.length++] = new Data(get_checked_value(get_by_name("enable")), protocol_name, get_by_id("protocol").value, start_port, end_port, start_ip, end_ip, "Always", DataArray.length);
		}
		save_to_cfg();
		get_by_id("reboot_type").value = "filter";
    	return true;
	}

	function save_to_cfg(){
		for(k=0; k<rule_max_num; k++){
			var now_num = k;
			if(parseInt(k,10)<10){
				now_num = "0"+k;
			}
			var temp_block = "";
			if(k<DataArray.length){
				temp_block = DataArray[k].Enable +"/"+ DataArray[k].Name + "/" + DataArray[k].Protocol
					+ "/" + DataArray[k].Start_port + "/" + DataArray[k].End_port
					+ "/" + DataArray[k].Start_ip +"/"+ DataArray[k].End_ip + "/" + DataArray[k].Schedule;
			}
			get_by_id("block_service_"+now_num).value = temp_block;
		}
	}
</SCRIPT>
</head>
<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');">
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
                          <td class="headerbg">Filter </td>
                          <td width="74%" class="headerbg"><div align="right"><a href="help_access.asp#access_protocol_filter" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></div></td>
                        </tr>
                      </table>
				  <form id="form1" name="form1" method="post" action="apply.cgi">
				  	<input type="hidden" name="html_response_page" value="back.asp">
					<input type="hidden" name="html_response_message" value="Settings Saved">
					<input type="hidden" name="html_response_return_page" value="protocol_filter.asp">
                  	<input type="hidden" id="reboot_type" name="reboot_type" value="none">
                  	
                  	<input type="hidden" id="cur_ipaddr" name="cur_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
                	<input type="hidden" id="cur_netmask" name="cur_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>">
				  
				  	<input type="hidden" id="block_service_00" name="block_service_00" value="<% CmoGetCfg("block_service_00","none"); %>">
					<input type="hidden" id="block_service_01" name="block_service_01" value="<% CmoGetCfg("block_service_01","none"); %>">
					<input type="hidden" id="block_service_02" name="block_service_02" value="<% CmoGetCfg("block_service_02","none"); %>">
					<input type="hidden" id="block_service_03" name="block_service_03" value="<% CmoGetCfg("block_service_03","none"); %>">
					<input type="hidden" id="block_service_04" name="block_service_04" value="<% CmoGetCfg("block_service_04","none"); %>">
					<input type="hidden" id="block_service_05" name="block_service_05" value="<% CmoGetCfg("block_service_05","none"); %>">
					<input type="hidden" id="block_service_06" name="block_service_06" value="<% CmoGetCfg("block_service_06","none"); %>">
					<input type="hidden" id="block_service_07" name="block_service_07" value="<% CmoGetCfg("block_service_07","none"); %>">
					<input type="hidden" id="block_service_08" name="block_service_08" value="<% CmoGetCfg("block_service_08","none"); %>">
					<input type="hidden" id="block_service_09" name="block_service_09" value="<% CmoGetCfg("block_service_09","none"); %>">
					<input type="hidden" id="block_service_10" name="block_service_10" value="<% CmoGetCfg("block_service_10","none"); %>">
					<input type="hidden" id="block_service_11" name="block_service_11" value="<% CmoGetCfg("block_service_11","none"); %>">
					<input type="hidden" id="block_service_12" name="block_service_12" value="<% CmoGetCfg("block_service_12","none"); %>">
					<input type="hidden" id="block_service_13" name="block_service_13" value="<% CmoGetCfg("block_service_13","none"); %>">
					<input type="hidden" id="block_service_14" name="block_service_14" value="<% CmoGetCfg("block_service_14","none"); %>">
					<input type="hidden" id="block_service_15" name="block_service_15" value="<% CmoGetCfg("block_service_15","none"); %>">
					<input type="hidden" id="block_service_16" name="block_service_16" value="<% CmoGetCfg("block_service_16","none"); %>">
					<input type="hidden" id="block_service_17" name="block_service_17" value="<% CmoGetCfg("block_service_17","none"); %>">
					<input type="hidden" id="block_service_18" name="block_service_18" value="<% CmoGetCfg("block_service_18","none"); %>">
					<input type="hidden" id="block_service_19" name="block_service_19" value="<% CmoGetCfg("block_service_19","none"); %>">
				  
				  <input type="hidden" id="edit_row" name="edit_row">
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td align="right" valign="top" bgcolor="#FFFFFF" class="bgblue">Filters</td>
                          <td width="80%" valign="top" bgcolor="#FFFFFF" class="bggrey">Filters are used to
                          allow or deny LAN users from accessing the Internet.
                            <br>
                            <br>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                              <tr>
                                <td width="5%"><input type=radio name=filters value=0 onClick="location.href='filters.asp'"></td>
                                <td width="40%"><b>MAC Filters</b></td>
                                <td width="5%">&nbsp;</td>
                                <td width="50%">&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type=radio name="filters" onClick="location.href='domain_filter.asp'"></td>
                                <td colspan="2"><b>Domain/URL Blocking</b></td>
                                <td>&nbsp;</td>
                              </tr>
                              <tr>
                                <td><input type="radio" name="filters" checked></td>
                                <td colspan="2"><b><u>Protocol/IP Filters</u></b></td>
                                <td>&nbsp;</td>
                              </tr>
                          </table>                          </td>
                        </tr>
                    </table>                 
                    <br>                    
                      <table width="100%" height="137" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td height="10" colspan="2" bgcolor="#FFFFFF" class="greybluebg">Edit protocol Filter in List</td>
                        </tr>
                        <tr>
                          <td width="140" height="10" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Enable</font></td>
                          <td width="80%" class="bggrey"><font face="Arial">
                          <input type="radio" name="enable" value="1">
                          </font><font face="Arial" color="#000000">Enable</font><font face="Arial">
                          <input type="radio" name="enable" value="0">
                            Disabled</font></td>
                        </tr>
                        <tr>
                          <td width="140" height="10" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Name</font></td>
                          <td class="bggrey"><input type="text" id="protocol_name" name="protocol_name" size="32" maxlength="31"></td>
                        </tr>
                        <tr>
                          <td width="140" height="10" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Protocol</font></td>
                          <td class="bggrey"><font face="Arial">
                          <select size="1" id="protocol" name="protocol">
                            <option value="TCP">TCP</option>
                            <option value="UDP">UDP</option>
                            <option value="Any">*</option>
                          </select>
                          </font></td>
                        </tr>
                        <tr>
                          <td width="140" height="10" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Port </font></td>
                          <td class="bggrey"><font face="Arial">
                          <input type="text" id="start_port" name="start_port" size="6" maxlength="5">
                            -
                          <input type="text" id="end_port" name="end_port" size="6" maxlength="5">
                          </font></td>
                        </tr>
                        <tr>
                          <td width="140" height="10" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">IP Range </font></td>
                          <td class="bggrey"><font face="Arial">
                          <input type="text" id="start_ip" name="start_ip" size="16" maxlength="15">
                            -
                          <input type="text" id="end_ip" name="end_ip" size="16" maxlength="15">
                          </font></td>
                        </tr>
                        <tr>
                          <td height="10" align="right" bgcolor="#FFFFFF" class="bgblue">&nbsp;</td>
                          <td bgcolor="#FFFFFF" class="bggrey2">
                          	<input type="submit" value="Add" id="add" name="add" onClick="return send_request()">		  	
							<input type="submit" value="Update" id="update" name="update" onClick="return send_request()" disabled>
							<input type="submit" value="Delete" id="del" name="del" onClick="return del_row()" disabled>
							<input type="button" name="cancel" value="Cancel" onClick="clear_row()">
                          </td>
                        </tr>
                      </table>
                  </form>
                    <br>
                    <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" id="table1">
                      <tr align="center" bgcolor="#FFFFFF">
                        <td width="40" bgcolor="#C5CEDA">&nbsp;</td>
                        <td width="130" bgcolor="#C5CEDA"><b>Name</b></td>
                        <td width="110" bgcolor="#C5CEDA"><b>Protocol</b></td>
                        <td width="130" bgcolor="#C5CEDA"><b>Port Range</b></td>
                        <td width="300" bgcolor="#C5CEDA"><b>IP Range</b></td>
                      </tr>
                      <script>DataShow();</script>
                  </table><p>&nbsp;</p></td>
              <td height="400" background="bg2_r.gif"><img src="spacer.gif" width="10" height="10"></td>
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
