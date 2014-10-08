<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | Virtual Server</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 20;
	
	function DataShow(){
		set_vs();
		for (var i=0; i<DataArray.length;i++){
			var port_word = DataArray[i].Protocol + " "+ DataArray[i].Private_port +"/"+ DataArray[i].Pubic_port;
			var enable_name = "enable"+i;
			document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
			document.write("<td><input type=\"checkbox\" id=\""+ enable_name +"\" name=\""+ enable_name +"\" value=\"1\"></td>");
			document.write("<td>"+ DataArray[i].Name +"</td>");
			document.write("<td>"+ port_word +"</td>");
			document.write("<td>"+ DataArray[i].LANIP +"</td>");
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
	
	function set_vs(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_vs;
			var k=i;
			if(i<10){
				k="0"+i;
			}
			temp_vs = (get_by_id("vs_rule_" + k).value).split("/");
			if (temp_vs.length > 1){
				if((temp_vs[1] != "name") && (temp_vs[1].length > 0)){
					DataArray[DataArray.length++] = new Data(temp_vs[0],temp_vs[1], temp_vs[2], temp_vs[3], temp_vs[4], temp_vs[5], temp_vs[6], index);
					index++;
				}
			}
		}
	}
	
	//0/HTTP/TCP/80/80/192.168.0.100/Always
	function Data(enable, name, protocol, public_port, private_port, lanip, schedule, onList){
		this.Enable = enable;
		this.Name = name;
		this.Protocol = protocol;
		this.Pubic_port = public_port;
		this.Private_port = private_port;
		this.LANIP = lanip;
		this.Schedule = schedule;
		this.OnList = onList;
	}
	
	
	function del_row(row){
        var index = parseInt(get_by_id("edit_row").value,10);
        if(confirm(addstr(msg[MSG16],"virtual server"))){
        	for(i=index ; i<DataArray.length-1 ;i++){
				DataArray[i].Enable = DataArray[i+1].Enable;
				DataArray[i].Name = DataArray[i+1].Name;
				DataArray[i].Protocol = DataArray[i+1].Protocol;
				DataArray[i].Pubic_port = DataArray[i+1].Pubic_port;
				DataArray[i].Private_port = DataArray[i+1].Private_port;
				DataArray[i].LANIP = DataArray[i+1].LANIP;
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
        var temp_data;
        var port;
        
        if (get_by_id("enable" + row).checked){
        	enable[0].checked = true;
        }else{
        	enable[1].checked = true;
        }
        get_by_id("server_name").value = get_row_data(row_obj, 1);
        
        temp_data = get_row_data(row_obj, 2).split(" ");
        set_selectIndex(temp_data[0], get_by_id("protocol"));

        port = temp_data[1].split("/");
        get_by_id("private_port").value = port[0];        
        get_by_id("public_port").value = port[1];
        
        get_by_id("ip").value = get_row_data(row_obj, 3);
            	    	    	        
        get_by_id("edit_row").value = row;
        get_by_id("add").disabled = true;
        get_by_id("update").disabled = false;
        get_by_id("del").disabled = false;
        change_color("table1", row+1);
    }
    
    function clear_row(){
        get_by_id("edit_row").value = "-1";
        change_color("table1", -1);
        location.href = "virtual_server.asp";
    }
    
	function send_request(){		
		var server_name = get_by_id("server_name").value;
		var private_port = get_by_id("private_port").value;
		var public_port = get_by_id("public_port").value;
		var remote_enable = get_by_id("remote_http_management_enable").value;
		var temp_enable = get_checked_value(get_by_name("enable"));		
		var http_port = get_by_id("remote_http_management_port").value;
		var ip = get_by_id("ip").value;		
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"LAN Server");
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		
		var temp_LAN_ip_obj = new addr_obj(get_by_id("cur_ipaddr").value.split("."), all_ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(get_by_id("cur_netmask").value.split("."), subnet_mask_msg, false, false);
		
		
		if (remote_enable == "1" && public_port == http_port){
			alert("Public port conflict with Remote Management HTTP port.");
			return false;
		}
		
		if (server_name == ""){
			alert(msg[MSG18]);
			return false;
		}
				
		if (!check_port(private_port)){
			alert(msg[MSG26]);	
			return false;
		}
				
		if (!check_port(public_port)){
			alert(msg[MSG27]);	
			return false;
		}
		 if((temp_enable == 1)&&((ip != "")&&(ip != "0.0.0.0"))){
		if(ip_num(temp_LAN_ip_obj.addr) == ip_num(temp_ip_obj.addr)){
			alert(addstr(msg[MSG43],"LAN Server"));
			return false;
		}
		
		if (!check_address(temp_ip_obj)){
			return false;
		}
		
		if (!check_domain(temp_LAN_ip_obj, temp_mask_obj, temp_ip_obj)){
			alert(addstr(msg[MSG3],"LAN Server"));
			return false;
		}
		}
		else{
			get_by_id("enable").value = "0";
			get_by_id("ip").value = "0.0.0.0";
			ip = "0.0.0.0";
		}
		
		var index = parseInt(get_by_id("edit_row").value,10);
		//double name check
		for(i=0;i<DataArray.length;i++){
			if(DataArray[i].Name==get_by_id("server_name").value){
				if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
					continue;
				}else{
					alert(addstr(msg[MSG41],"Virtual Server name"));
					return false;
				}			
			}
			if(DataArray[i].Protocol == get_by_id("protocol").value){
				if(DataArray[i].Pubic_port==get_by_id("public_port").value){
					if(index==(DataArray[i].OnList)){
						continue;
					}else{		// if add a new name
						alert(addstr(msg[MSG28],"Public "));		
						return false;
					}
				}
			}
		}
		
		//save data ::edit
		if(index > -1){
			DataArray[index].Enable = get_checked_value(get_by_name("enable"));
			DataArray[index].Name = server_name;
			DataArray[index].Protocol = get_by_id("protocol").value;
			DataArray[index].Pubic_port = public_port;
			DataArray[index].Private_port = private_port;
			DataArray[index].LANIP = ip;
		}else{//save add data
			var max_num = DataArray.length;
			if(parseInt(max_num,10)>39){
				alert("The allowed number of static router is 40")
				return false;
			}
			DataArray[DataArray.length++] = new Data(get_checked_value(get_by_name("enable")),server_name, get_by_id("protocol").value, public_port, private_port, ip, "Always", DataArray.length);
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
			var temp_vs = "";
			if(k<DataArray.length){
				temp_vs = DataArray[k].Enable +"/"+ DataArray[k].Name + "/" + DataArray[k].Protocol
					+ "/" + DataArray[k].Pubic_port + "/" + DataArray[k].Private_port
					+ "/" + DataArray[k].LANIP + "/" + DataArray[k].Schedule;
			}
			get_by_id("vs_rule_"+now_num).value = temp_vs;
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
              <td><a href="wireless_basic.asp"><img src="but_wireless_0.gif" name="Image3" width="144" height="28" border="0" id="Image3" onMouseOver="MM_swapImage('Image3','','but_wireless_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
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
                  <td><a href="virtual_server.asp" class="submenus"><b><u>Virtual Server </u></b></a></td>
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
              <td background="bg3.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                
                <tr>
                  <td height="400">
                  	<form id="form1" name="form1" method="post" action="apply.cgi">
                  	<input type="hidden" name="html_response_page" value="back.asp">
					<input type="hidden" name="html_response_message" value="The setting is saved.">
					<input type="hidden" name="html_response_return_page" value="virtual_server.asp">
					<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
					
					<input type="hidden" id="cur_ipaddr" name="cur_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
                	<input type="hidden" id="cur_netmask" name="cur_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>">
					
					<input type="hidden" id="vs_rule_00" name="vs_rule_00" value="<% CmoGetCfg("vs_rule_00","none"); %>">
	                <input type="hidden" id="vs_rule_01" name="vs_rule_01" value="<% CmoGetCfg("vs_rule_01","none"); %>">
	                <input type="hidden" id="vs_rule_02" name="vs_rule_02" value="<% CmoGetCfg("vs_rule_02","none"); %>">
	                <input type="hidden" id="vs_rule_03" name="vs_rule_03" value="<% CmoGetCfg("vs_rule_03","none"); %>">
	                <input type="hidden" id="vs_rule_04" name="vs_rule_04" value="<% CmoGetCfg("vs_rule_04","none"); %>">
	                <input type="hidden" id="vs_rule_05" name="vs_rule_05" value="<% CmoGetCfg("vs_rule_05","none"); %>">
	                <input type="hidden" id="vs_rule_06" name="vs_rule_06" value="<% CmoGetCfg("vs_rule_06","none"); %>">
	                <input type="hidden" id="vs_rule_07" name="vs_rule_07" value="<% CmoGetCfg("vs_rule_07","none"); %>">
	                <input type="hidden" id="vs_rule_08" name="vs_rule_08" value="<% CmoGetCfg("vs_rule_08","none"); %>">
	                <input type="hidden" id="vs_rule_09" name="vs_rule_09" value="<% CmoGetCfg("vs_rule_09","none"); %>">
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
	                <input type="hidden" id="remote_http_management_enable" name="remote_http_management_enable" value="<% CmoGetCfg("remote_http_management_enable","none"); %>">
	                <input type="hidden" id="remote_http_management_port" name="remote_http_management_port" value="<% CmoGetCfg("remote_http_management_port","none"); %>">
                  		
					
    				<input type="hidden" id="edit_row" name="edit_row">
                    <table width="100%" border="0" cellpadding="3" cellspacing="0">
                      <tr>
                        <td width="85%" class="headerbg">Virtual Server </td>
                        <td width="15%" class="headerbg"><a href="help_access.asp#access_virtual_server" target="_blank"><img src="but_help1_0.gif" name="Image8" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                      </tr>
                    </table>
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                      <tr>
                        <td width="160" align="right" class="bgblue">Enable</td>
                        <td width="455" class="bggrey">
                          <input type="radio" name="enable" value="1">
                          Enable
                          <input type="radio" name="enable" value="0" checked>
                          Disabled</td>
                      </tr>
                      <tr>
                        <td width="160" align="right" class="bgblue">Name</td>
                        <td width="455" class="bggrey"><input type="text" id="server_name" name="server_name" size="32" maxlength="31"></td>
                      </tr>
                      <tr>
                        <td width=160 height=2 align="right" class="bgblue">Protocol</td>
                        <td height=25colspan=3 class="bggrey">
                        	<select size="1" id="protocol" name="protocol">
                            	<option value="TCP">TCP</option>
                            	<option value="UDP">UDP</option>
                            	<option value="Both">Both</option>
                          	</select>
                     	</td>
                      </tr>
                      <tr>
                        <td width=160 height=2 align="right" class="bgblue">Private Port&nbsp;</td>
                        <td height=2 class="bggrey"><input type="text" id="private_port" name="private_port" size="6" maxlength="5"></td>
                      </tr>
                      <tr>
                        <td width="160" align="right" class="bgblue">Public Port&nbsp;</td>
                        <td width="455" class="bggrey"><input type="text" id="public_port" name="public_port" size="6" maxlength="5"></td>
                      </tr>
                      <tr>
                        <td width="160" align="right" class="bgblue">LAN Server</td>
                        <td width="455" class="bggrey"><input type="text" id="ip" name="ip" size="16" maxlength="15"></td>
                      </tr>
                      <tr>
                        <td align="right" class="bgblue">&nbsp;</td>
                        <td class="bggrey2">
                        	<input type="submit" value="Add" id="add" name="add" onClick="return send_request()">		  	
							<input type="submit" value="Update" id="update" name="update" onClick="return send_request()" disabled>
							<input type="submit" value="Delete" id="del" name="del" onClick="return del_row()" disabled>
							<input type="button" name="cancel" value="Cancel" onClick="clear_row()">
                        </td>
                      </tr>
                    </table>
                    </form>
                    <br>
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF" id="table1">
                      <tr align="center" bgcolor="#C5CEDA">
                        <td><b><font></font></b></td>
                        <td><b>Name</b></td>
                        <td><b>Protocol</b></td>
                        <td><b>LAN Server</b></td>
                      </tr>
                      <script>DataShow();</script>
                    </table>
                    <p>&nbsp;</p></td>
                </tr>
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
