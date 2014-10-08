<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | Special AP</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 20;
	
	function DataShow(){
		set_application();
		for (var i=0; i<DataArray.length;i++){
			var port_word = DataArray[i].Protocol + " "+ DataArray[i].Private_port +"/"+ DataArray[i].Pubic_port;
			var enable_name = "enable"+i;
			var trigger_word = DataArray[i].Trigger_protocol;
			var Pubic_word = DataArray[i].Pubic_port;
			var trigger_port = DataArray[i].Trigger_port;
			
			if(trigger_word == "Any"){
				trigger_word = "*";
			}
			if(Pubic_word == "Any"){
				Pubic_word = "*";
			}
			
	        var port = trigger_port.split("-");
        	if (port.length <= 1){
        		DataArray[i].Trigger_port = port[0]+"-"+port[0];
        	}
		
			document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
			document.write("<td><input type=\"checkbox\" id=\""+ enable_name +"\" name=\""+ enable_name +"\" value=\"1\"></td>");
			document.write("<td>"+ DataArray[i].Name +"</td>");
			document.write("<td>"+ DataArray[i].Trigger_protocol +" "+ DataArray[i].Trigger_port +"</td>");
			document.write("<td>"+ DataArray[i].Protocol +" "+ DataArray[i].Pubic_port +"</td>");
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
	
	function set_application(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_pf;
			var k=i;
			if(i<10){
				k="0"+i;
			}
			temp_pf = (get_by_id("application_" + k).value).split("/");
			if (temp_pf.length > 1){
				if(temp_pf[1].length > 0){
					DataArray[DataArray.length++] = new Data(temp_pf[0], temp_pf[1], temp_pf[2], temp_pf[3], temp_pf[4], temp_pf[5], temp_pf[6], temp_pf[7], index);
					index++;
				}
			}
		}
	}
	
	//1/app1/192.168.0.100/UDP/2000-2012/UDP/2000-2006/Always
	function Data(enable, name, lanip, trigger_protocol, trigger_port, protocol, public_port, schedule, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.LANIP = lanip;
		this.Trigger_protocol = trigger_protocol;
		this.Trigger_port = trigger_port;
		this.Protocol = protocol;
		this.Pubic_port = public_port;
		this.Schedule = schedule;
		this.OnList = onList;
	}
	
	function del_row(){
        var index = parseInt(get_by_id("edit_row").value,10);
        if(confirm(addstr(msg[MSG16],"special ap"))){
        	for(i=index ; i<DataArray.length-1 ;i++){
				DataArray[i].Enable = DataArray[i+1].Enable;
				DataArray[i].Name = DataArray[i+1].Name;
				DataArray[i].LANIP = DataArray[i+1].LANIP;
				DataArray[i].Trigger_protocol = DataArray[i+1].Trigger_protocol;
				DataArray[i].Trigger_port = DataArray[i+1].Trigger_port;
				DataArray[i].Protocol = DataArray[i+1].Protocol;
				DataArray[i].Pubic_port = DataArray[i+1].Pubic_port;
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
        var temp_data1, temp_data2;
        var port;
        
        if (get_by_id("enable" + row).checked){
        	enable[0].checked = true;
        }else{
        	enable[1].checked = true;
        }
        get_by_id("special_name").value = get_row_data(row_obj, 1);
        
        temp_data1 = get_row_data(row_obj, 2).split(" ");
        set_selectIndex(DataArray[row].Trigger_protocol, get_by_id("trigger_protocol"));
        port = temp_data1[1].split("-");
        get_by_id("start_port").value = port[0];        
        if (port.length > 1){
        	get_by_id("end_port").value = port[1];
        }else{
        	get_by_id("end_port").value = port[0];
        }
        
        temp_data2 = get_row_data(row_obj, 3).split(" ");
        set_selectIndex(DataArray[row].Protocol, get_by_id("incoming_protocol"));
        get_by_id("incoming_port").value = temp_data2[1];
            	    	    	        
        get_by_id("edit_row").value = row;
        get_by_id("add").disabled = true;
        get_by_id("update").disabled = false;
        get_by_id("del").disabled = false;
        change_color("table1", row+1);
    }
    
    function clear_row(){
        get_by_id("edit_row").value = "-1";
        change_color("table1", -1);
        location.href = "special_ap.asp";
    }
    
	function send_request(){		
		var special_name = get_by_id("special_name").value;
		var start_port = get_by_id("start_port").value;
		var end_port = get_by_id("end_port").value;
		var incoming_port_all = get_by_id("incoming_port").value;
		var incoming_port = get_by_id("incoming_port").value.split(",");
		var index;
			
		if (special_name == ""){
			alert(msg[MSG18]);
			return false;
		}
				
		if (!check_port(start_port)){
			alert(msg[MSG30]);	
			return false;
		}
				
		if (!check_port(end_port)){
			alert(msg[MSG30]);	
			return false;
		}
		
		if(incoming_port_all == ""){
			alert(msg[MSG31]);	
			return false;
		}
			
		for (index = 0; index < incoming_port.length; index++){
			var port = incoming_port[index].split("-");
			
			if (index == 5){
				break;
			}
			
			get_by_id("port" + (index+1) + "1").value = port[0];  				
			if (port.length > 1){
				get_by_id("port" + (index+1) + "2").value = port[1];
			}else{
				get_by_id("port" + (index+1) + "2").value = port[0];
			}
		}
			
		for (; index < 5; index++){
			get_by_id("port" + (index+1) + "1").value = "";
			get_by_id("port" + (index+1) + "2").value = "";
		}
					
		for (var i = 1; i < 6; i++){
			var temp_port1 = get_by_id("port" + i + "1").value;
			var temp_port2 = get_by_id("port" + i + "2").value;
			
			if (temp_port1 != ""){
				if (!check_port(temp_port1)){
	 				alert(msg[MSG31]);
	 				return false;
	 			}
			}
			
			if (temp_port2 != ""){
				if (!check_port(temp_port2)){
	 				alert(msg[MSG31]);
	 				return false;
	 			}
			}				
		}
		
		var index_num = parseInt(get_by_id("edit_row").value,10);
		//double name check
		for(i=0;i<DataArray.length;i++){
			if(DataArray[i].Name==get_by_id("special_name").value){
				if(DataArray[i].Name != "" && index_num==(DataArray[i].OnList)){
					continue;
				}else{
					alert(addstr(msg[MSG41],"Special AP name"));
					return false;
				}			
			}
			
			if(DataArray[i].Trigger_protocol == get_by_id("trigger_protocol").value){
				var in_port_start = pi(get_by_id("start_port").value);
				var in_port_end = pi(get_by_id("end_port").value);
				var in_port_array = DataArray[i].Trigger_port.split("-");
				
				if (((in_port_start >= in_port_array[0]) && (in_port_start <= in_port_array[1])) || 
		            ((in_port_end >= in_port_array[0]) && (in_port_end <= in_port_array[1])) ||
		            ((in_port_array[0] >= in_port_start) && (in_port_array[0] <= in_port_end)) ||
		            ((in_port_array[1] >= in_port_start) && (in_port_array[1] <= in_port_end))
					){
					
					if(index_num==(DataArray[i].OnList)){
						continue;
					}else{		// if add a new port forwarding
						alert(addstr(msg[MSG28],"Trigger "));		
						return false;
					}
				}
			}
			
			
			if(DataArray[i].Protocol == get_by_id("incoming_protocol").value){
				if(DataArray[i].Pubic_port==get_by_id("incoming_port").value){
					if(index_num==(DataArray[i].OnList)){
						continue;
					}else{		// if add a new name
						alert(addstr(msg[MSG28],"Incoming "));		
						return false;
					}
				}
			}
		}

		//save data ::edit
		if(index_num > -1){
			DataArray[index_num].Enable = get_checked_value(get_by_name("enable"));
			DataArray[index_num].Name = special_name;
			DataArray[index_num].Trigger_protocol = get_by_id("trigger_protocol").value;
			if(start_port == end_port){
				DataArray[index_num].Trigger_port = start_port;
			}else{
				DataArray[index_num].Trigger_port = start_port +"-"+ end_port;
			}
			DataArray[index_num].Protocol = get_by_id("incoming_protocol").value;
			DataArray[index_num].Pubic_port = incoming_port;
		}else{   //save add data
			var max_num = DataArray.length;
			if(parseInt(max_num,10)> rule_max_num){
				alert("The allowed number of static router is "+ rule_max_num)
				return false;
			}
			
			if(start_port == end_port){
				DataArray[DataArray.length++] = new Data(get_checked_value(get_by_name("enable")),special_name, "Any", get_by_id("trigger_protocol").value, start_port, get_by_id("incoming_protocol").value, incoming_port, "Always", DataArray.length);
			}else{
				DataArray[DataArray.length++] = new Data(get_checked_value(get_by_name("enable")),special_name, "Any", get_by_id("trigger_protocol").value, start_port +"-"+ end_port, get_by_id("incoming_protocol").value, incoming_port, "Always", DataArray.length);
			}
		}
		save_to_cfg();
		get_by_id("reboot_type").value = "filter";
    	return true;
	
    	return true;
	}

	function save_to_cfg(){
		for(k=0; k<rule_max_num; k++){
			var now_num = k;
			if(parseInt(k,10)<10){
				now_num = "0"+k;
			}
			var temp_vs ="";
			var tmp_trigger="";
			var data="";
			if(k<DataArray.length){
				tmp_trigger=DataArray[k].Trigger_port.split("-");
				if(tmp_trigger[0]==tmp_trigger[1]){
					data=tmp_trigger[0];
				}else{
					data=DataArray[k].Trigger_port;
				}	
				temp_vs = DataArray[k].Enable +"/"+ DataArray[k].Name + "/" + DataArray[k].LANIP
					+ "/" + DataArray[k].Trigger_protocol + "/" + data
					+ "/" + DataArray[k].Protocol + "/" + DataArray[k].Pubic_port
					+ "/" + DataArray[k].Schedule;
			}
			get_by_id("application_"+now_num).value = temp_vs;
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
                  <td width="87%"><a href="filters.asp" class="submenus"><b>Filter </b></a></td>
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
                  <td><a href="special_ap.asp" class="submenus"><b><u>Special AP </u></b></a></td>
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
                          <td width="85%" class="headerbg">Special AP </td>
                          <td width="15%" class="headerbg"><a href="help_access.asp#access_special_ap" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                        </tr>
                      </table>
                  		<form id="form1" name="form1" method="post" action="apply.cgi">
                  		<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
	                    <input type="hidden" id="html_response_message" name="html_response_message" value="Settings Saved.">
	                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="special_ap.asp">
	                    <input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                  		
                  		<input type="hidden" id="application_00" name="application_00" value="<% CmoGetCfg("application_00","none"); %>">
		                <input type="hidden" id="application_01" name="application_01" value="<% CmoGetCfg("application_01","none"); %>">
		                <input type="hidden" id="application_02" name="application_02" value="<% CmoGetCfg("application_02","none"); %>">
		                <input type="hidden" id="application_03" name="application_03" value="<% CmoGetCfg("application_03","none"); %>">
		                <input type="hidden" id="application_04" name="application_04" value="<% CmoGetCfg("application_04","none"); %>">
		                <input type="hidden" id="application_05" name="application_05" value="<% CmoGetCfg("application_05","none"); %>">
		                <input type="hidden" id="application_06" name="application_06" value="<% CmoGetCfg("application_06","none"); %>">
		                <input type="hidden" id="application_07" name="application_07" value="<% CmoGetCfg("application_07","none"); %>">
		                <input type="hidden" id="application_08" name="application_08" value="<% CmoGetCfg("application_08","none"); %>">
		                <input type="hidden" id="application_09" name="application_09" value="<% CmoGetCfg("application_09","none"); %>">
		                <input type="hidden" id="application_10" name="application_10" value="<% CmoGetCfg("application_10","none"); %>">
		                <input type="hidden" id="application_11" name="application_11" value="<% CmoGetCfg("application_11","none"); %>">
		                <input type="hidden" id="application_12" name="application_12" value="<% CmoGetCfg("application_12","none"); %>">
		                <input type="hidden" id="application_13" name="application_13" value="<% CmoGetCfg("application_13","none"); %>">
		                <input type="hidden" id="application_14" name="application_14" value="<% CmoGetCfg("application_14","none"); %>">
		                <input type="hidden" id="application_15" name="application_15" value="<% CmoGetCfg("application_15","none"); %>">
		                <input type="hidden" id="application_16" name="application_16" value="<% CmoGetCfg("application_16","none"); %>">
		                <input type="hidden" id="application_17" name="application_17" value="<% CmoGetCfg("application_17","none"); %>">
		                <input type="hidden" id="application_18" name="application_18" value="<% CmoGetCfg("application_18","none"); %>">
		                <input type="hidden" id="application_19" name="application_19" value="<% CmoGetCfg("application_19","none"); %>">
                  		
  						<input type="hidden" id="edit_row" name="edit_row">
                      <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td width="150" align="right" class="bgblue">Enable</td>
                          <td colspan="2" bgcolor="#FFFFFF" class="bggrey">
                            <input type="radio" name="enable" value="1">
                            Enabled
                            <input type="radio" name="enable" value="0" checked>
                            Disabled </td>
                        </tr>
                        <tr>
                          <td align="right" class="bgblue">Name</td>
                          <td colspan="2" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="special_name" name="special_name" size="32" maxlength="31"></td>
                        </tr>
                        <tr>
                          <td rowspan="2" align="right" class="bgblue">Trigger</td>
                          <td height="19" nowrap class="bggrey">Protocol</td>
                          <td width="275" height="19" bgcolor="#FFFFFF" class="bggrey"> 
                           <select size="1" id="trigger_protocol" name="trigger_protocol">
                            <option value="TCP">TCP</option>
                            <option value="UDP">UDP</option>                           
                            <option value="Any">*</option>
                            </select></td>
                        </tr>
                        <tr>
                          <td nowrap class="bggrey">Port
                            Range</td>
                          <td width="275" class="bggrey">
                            <input type="text" id="start_port" name="start_port" size="6" maxlength="5">
                            -
                            <input type="text" id="end_port" name="end_port" size="6" maxlength="5"></td>
                        </tr>
                        <tr>
                          <td rowspan="2" align="right" valign="top" class="bgblue">Incoming</td>
                          <td nowrap class="bggrey">Protocol</td>
                          <td width="275" bgcolor="#FFFFFF" class="bggrey">
                          	<select size="1" id="incoming_protocol" name="incoming_protocol">
                            	<option value="TCP">TCP</option>
                            	<option value="UDP">UDP</option>                            
                            	<option value="Any">*</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td height="2" nowrap class="bggrey">Port</td>
                          <td width="275" height="2" class="bggrey">
                          	  <input type="text" id="incoming_port" name="incoming_port" size="30" maxlength="60">
				              <input type=hidden id="port11" name="port11">
				              <input type=hidden id="port12" name="port12">
				              <input type=hidden id="port21" name="port21">
				              <input type=hidden id="port22" name="port22">
				              <input type=hidden id="port31" name="port31">
				              <input type=hidden id="port32" name="port32">
				              <input type=hidden id="port41" name="port41">
				              <input type=hidden id="port42" name="port42">
				              <input type=hidden id="port51" name="port51">
				              <input type=hidden id="port52" name="port52">
                          </td>
                        </tr>
                        <tr>
                          <td align="right" class="bgblue">&nbsp;</td>
                          <td height="2" colspan="2" nowrap class="bggrey2">
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
                      <tr align="center">
                        <td bgcolor="#C5CEDA"><b><font color="#FFFFFF"></font></b></td>
                        <td bgcolor="#C5CEDA"><b>Name</b></td>
                        <td bgcolor="#C5CEDA"><b>Trigger Port Range</b></td>
                        <td bgcolor="#C5CEDA"><b>Incoming Port</b></td>
                      </tr>
                      <script>DataShow();</script>
                    </table>                    
                </td>
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
