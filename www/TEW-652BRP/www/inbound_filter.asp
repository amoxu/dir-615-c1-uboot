<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | Protocol Filters</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 10;
	var DataArray = new Array();
	var DataArray_detail = new Array(10);
	function onPageLoad(){
		set_form_default_values("form1");
	}
	//name/action
	function Data(name, action, onList) 
	{
		this.Name = name;
		this.Action = action;
		this.Show_W = "";
		this.OnList = onList;
		var sActionW = "Allow"
		if(action =="deny"){
			sActionW = "Deny";
		}
		this.sAction = sActionW;
	}
	
	function Detail_Data(enable, ip_start, ip_end) 
	{
		this.Enable = enable;
		this.Ip_start = ip_start;
		this.Ip_end = ip_end;
	}
	
	function set_Inbound(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var temp_A;
			var temp_B;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], index);
					temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
					DataArray_detail[index] = new Array();
					var temp_ip_rang = 0;
					for(j=0;j<temp_A.length;j++){
						var temp_A_e = temp_A[j].split("/");
						var temp_A_ip = temp_A_e[1].split("-");
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_A_e[0], temp_A_ip[0], temp_A_ip[1]);
						temp_ip_rang++;
						if(temp_A_e[0] == "1"){
							var T_IP_R = temp_A_e[1];
							if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
					for(j=0;j<temp_B.length;j++){
						var temp_B_e = temp_B[j].split("/");
						var temp_B_ip = temp_B_e[1].split("-");
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_B_e[0], temp_B_ip[0], temp_B_ip[1]);
						temp_ip_rang++;
						if(temp_B_e[0] == "1"){
							var T_IP_R = temp_B_e[1];
							if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					index++;
				}
			}
		}
	}
	
	function edit_row(obj){
		get_by_id("edit").value = obj;
		get_by_id("ingress_filter_name").value = DataArray[obj].Name;
		set_selectIndex(DataArray[obj].Action, get_by_id("action_select"));
		for(j=0;j<DataArray_detail[obj].length;j++){
			set_checked(DataArray_detail[obj][j].Enable, get_by_id("entry_enable_"+j));
			get_by_id("ip_start_"+j).value = DataArray_detail[obj][j].Ip_start;
			get_by_id("ip_end_"+j).value = DataArray_detail[obj][j].Ip_end;
		}
		get_by_id("button1").value = "Update";
	}
	
	function del_row(obj){
		if(confirm("Are you sure you want to delete : " + DataArray[obj].Name)){
			delete_data(obj);
		}
	}
	
	function delete_data(num){
		for(i=num ; i<DataArray.length-1 ;i++){
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Action = DataArray[i+1].Action;
			DataArray[i].Show_W = DataArray[i+1].Show_W;
			DataArray[i].sAction = DataArray[i+1].sAction;
			DataArray[i].OnList = DataArray[i+1].OnList;
			for(j=0;j<DataArray_detail[i].length;j++){
				DataArray_detail[i][j].Enable = DataArray_detail[i+1][j].Enable;
				DataArray_detail[i][j].Ip_start = DataArray_detail[i+1][j].Ip_start;
				DataArray_detail[i][j].Ip_end = DataArray_detail[i+1][j].Ip_end;
			}
		}
		--DataArray.length;
		--DataArray_detail[DataArray.length].length;
		save_date();
	}
	
	function send_request(){
		if(get_by_id("ingress_filter_name").value.length > 0){
			if (!is_form_modified("form1") && !confirm(msg[45])) {
				return false;
			}
			var index = parseInt(get_by_id("edit").value,10);
			if(index > -1){
				if(!confirm("Are you sure you want to update : " + get_by_id("ingress_filter_name").value)){
					return false;
				}
				if((index < 0) && (DataArray.length >= rule_max_num)){
					alert("Inbound filter is must smaller than "+ rule_max_num);
					return false;
				}
			}
			for(var i = 0; i < DataArray.length; i++){
				if(DataArray[i].Name==get_by_id("ingress_filter_name").value){
					if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
						continue;
					}else{
						alert('Name "'+ get_by_id("ingress_filter_name").value +'" is already used!');
						return false;
					}			
				}
			}
			var is_checked = false;
			for(i=0;i<8;i++){
				var start_ip = get_by_id("ip_start_"+i).value;
				var end_ip = get_by_id("ip_end_"+i).value;
				if (!is_ipv4_valid(start_ip)) {
					alert("Invalid IP address: " + start_ip + ".");
					get_by_id("ip_start_"+i).select();
					get_by_id("ip_start_"+i).focus();
					return false;
				}
				
				if (!is_ipv4_valid(end_ip)) {
					alert("Invalid IP address: " + end_ip + ".");
					get_by_id("ip_end_"+i).select();
					get_by_id("ip_end_"+i).focus();
					return false;
				}

				if(get_by_id("entry_enable_"+i).checked){
					for(j=i+1;j<8;j++){
						if(get_by_id("entry_enable_"+j).checked && (start_ip == get_by_id("ip_start_"+j).value && end_ip == get_by_id("ip_end_"+j).value)){
							alert("This IP Rang '"+ start_ip +"-"+ end_ip +"' is duplicated.");
							return false;
						}
					}
					is_checked = true;
				}
			}
			if(!is_checked){
				alert("Enable at least one Source IP Rang for '"+ get_by_id("ingress_filter_name").value +"'.");
				return false;
			}
			if(index > -1){
				DataArray[index].Name = get_by_id("ingress_filter_name").value;
				DataArray[index].Action = get_by_id("action_select").value;
				for(j=0;j<DataArray_detail[index].length;j++){
					DataArray_detail[index][j].Enable = get_checked_value(get_by_id("entry_enable_"+j));
					DataArray_detail[index][j].Ip_start = get_by_id("ip_start_"+j).value;
					DataArray_detail[index][j].Ip_end = get_by_id("ip_end_"+j).value;
				}
			}else{
				var T_num = DataArray.length;
				DataArray[DataArray.length++] = new Data(get_by_id("ingress_filter_name").value, get_by_id("action_select").value, T_num);
				DataArray_detail[T_num] = new Array();
				for(i=0;i<8;i++){
					DataArray_detail[T_num][i] = new Detail_Data(get_checked_value(get_by_id("entry_enable_"+i)), get_by_id("ip_start_"+i).value, get_by_id("ip_end_"+i).value);
				}
			}
			save_date();
		}else{
			alert(msg[44]);
			return false;
		}
	}
	function save_date(){
		for(var i=0; i<rule_max_num; i++){
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			get_by_id("inbound_filter_name_" + k).value = "";
			get_by_id("inbound_filter_ip_"+ k +"_A").value = "";
			get_by_id("inbound_filter_ip_"+ k +"_B").value = "";
			if(i<DataArray.length){
				var temp_st = DataArray[i].Name +"/"+ DataArray[i].Action;
				var temp_A = "";
				var temp_B = "";
				for(j=0;j<5;j++){
					if(temp_A !=""){
						temp_A = temp_A + ",";
					}
					temp_A = temp_A + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				for(j=5;j<DataArray_detail[i].length;j++){
					if(temp_B !=""){
						temp_B = temp_B + ",";
					}
					temp_B = temp_B + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				get_by_id("inbound_filter_name_" + k).value = temp_st;
				get_by_id("inbound_filter_ip_"+ k +"_A").value = temp_A;
				get_by_id("inbound_filter_ip_"+ k +"_B").value = temp_B;
			}
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
</script>
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
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="inbound_filter.asp" class="submenus"><b>Inbound Filter </b></a></td>
                </tr>
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
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="inbound_filter.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                <input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<% CmoGetCfg("inbound_filter_name_00","none"); %>">
                <input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<% CmoGetCfg("inbound_filter_name_01","none"); %>">
                <input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<% CmoGetCfg("inbound_filter_name_02","none"); %>">
                <input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<% CmoGetCfg("inbound_filter_name_03","none"); %>">
                <input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<% CmoGetCfg("inbound_filter_name_04","none"); %>">
                <input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<% CmoGetCfg("inbound_filter_name_05","none"); %>">
                <input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<% CmoGetCfg("inbound_filter_name_06","none"); %>">
                <input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<% CmoGetCfg("inbound_filter_name_07","none"); %>">
                <input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<% CmoGetCfg("inbound_filter_name_08","none"); %>">
                <input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<% CmoGetCfg("inbound_filter_name_09","none"); %>">
                <input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<% CmoGetCfg("inbound_filter_name_10","none"); %>">
                <input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<% CmoGetCfg("inbound_filter_name_11","none"); %>">
                <input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<% CmoGetCfg("inbound_filter_name_12","none"); %>">
                <input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<% CmoGetCfg("inbound_filter_name_13","none"); %>">
                <input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<% CmoGetCfg("inbound_filter_name_14","none"); %>">
                <input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<% CmoGetCfg("inbound_filter_name_15","none"); %>">
                <input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<% CmoGetCfg("inbound_filter_name_16","none"); %>">
                <input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<% CmoGetCfg("inbound_filter_name_17","none"); %>">
                <input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<% CmoGetCfg("inbound_filter_name_18","none"); %>">
                <input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<% CmoGetCfg("inbound_filter_name_19","none"); %>">
                <input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<% CmoGetCfg("inbound_filter_name_20","none"); %>">
                <input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<% CmoGetCfg("inbound_filter_name_21","none"); %>">
                <input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<% CmoGetCfg("inbound_filter_name_22","none"); %>">
                <input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<% CmoGetCfg("inbound_filter_name_23","none"); %>">

                <input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<% CmoGetCfg("inbound_filter_ip_00_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<% CmoGetCfg("inbound_filter_ip_01_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<% CmoGetCfg("inbound_filter_ip_02_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<% CmoGetCfg("inbound_filter_ip_03_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<% CmoGetCfg("inbound_filter_ip_04_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<% CmoGetCfg("inbound_filter_ip_05_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<% CmoGetCfg("inbound_filter_ip_06_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<% CmoGetCfg("inbound_filter_ip_07_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<% CmoGetCfg("inbound_filter_ip_08_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<% CmoGetCfg("inbound_filter_ip_09_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<% CmoGetCfg("inbound_filter_ip_10_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<% CmoGetCfg("inbound_filter_ip_11_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<% CmoGetCfg("inbound_filter_ip_12_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<% CmoGetCfg("inbound_filter_ip_13_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<% CmoGetCfg("inbound_filter_ip_14_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<% CmoGetCfg("inbound_filter_ip_15_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<% CmoGetCfg("inbound_filter_ip_16_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<% CmoGetCfg("inbound_filter_ip_17_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<% CmoGetCfg("inbound_filter_ip_18_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<% CmoGetCfg("inbound_filter_ip_19_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<% CmoGetCfg("inbound_filter_ip_20_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<% CmoGetCfg("inbound_filter_ip_21_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<% CmoGetCfg("inbound_filter_ip_22_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<% CmoGetCfg("inbound_filter_ip_23_A","none"); %>">
                
                <input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<% CmoGetCfg("inbound_filter_ip_00_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<% CmoGetCfg("inbound_filter_ip_01_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<% CmoGetCfg("inbound_filter_ip_02_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<% CmoGetCfg("inbound_filter_ip_03_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<% CmoGetCfg("inbound_filter_ip_04_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<% CmoGetCfg("inbound_filter_ip_05_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<% CmoGetCfg("inbound_filter_ip_06_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<% CmoGetCfg("inbound_filter_ip_07_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<% CmoGetCfg("inbound_filter_ip_08_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<% CmoGetCfg("inbound_filter_ip_09_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<% CmoGetCfg("inbound_filter_ip_10_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<% CmoGetCfg("inbound_filter_ip_11_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<% CmoGetCfg("inbound_filter_ip_12_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<% CmoGetCfg("inbound_filter_ip_13_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<% CmoGetCfg("inbound_filter_ip_14_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<% CmoGetCfg("inbound_filter_ip_15_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<% CmoGetCfg("inbound_filter_ip_16_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<% CmoGetCfg("inbound_filter_ip_17_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<% CmoGetCfg("inbound_filter_ip_18_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<% CmoGetCfg("inbound_filter_ip_19_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<% CmoGetCfg("inbound_filter_ip_20_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<% CmoGetCfg("inbound_filter_ip_21_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<% CmoGetCfg("inbound_filter_ip_22_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<% CmoGetCfg("inbound_filter_ip_23_B","none"); %>">
                <input type="hidden" id="edit" name="edit" value="-1">
                    <br>                    
                      <table width="100%" height="12" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td width="220%" height="10" bgcolor="#FFFFFF" class="greybluebg">Edit protocol Filter in List</td>
                        </tr>
                      </table>
                  </form>
                    <table cellSpacing=1 cellPadding=2 width=100% border=0>
                      <tr>
                        <td height="30" align=right class="bgblue">Name </td>
                        <td class="bggrey">
                          <input name="ingress_filter_name" type="text" id="ingress_filter_name" size="20" maxlength="15">
                        </td>
                      </tr>
                      <tr>
                        <td height="33" align=right class="bgblue">Action</td>
                        <td class="bggrey">
                          <select name="action_select" id="action_select">
                            <option value="allow">Allow</option>
                            <option value="deny">Deny</option>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td height="33" align=right valign="top" class="bgblue">Remote IP Range</td>
                        <td class="bggrey">
                          <table cellSpacing=1 cellPadding=2 width=362 border=0>
                            <tr>
                              <td width="51" class="bggrey2">Enable</td>
                              <td width="120" class="bggrey2">Remote IP Start</td>
                              <td width="175" class="bggrey2">Remote IP End</td>
                            </tr>
                            <script>
						  			for(i=0;i<8;i++){
						  				document.write("<tr>")
						  				document.write("<td align=\"middle\"><input type=\"checkbox\" class=\"bggrey2\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
						  				document.write("<td class=\"bggrey\"><input id=\"ip_start_" + i + "\" name=\"ip_start_" + i + "\" size=\"15\"  maxlength=\"15\" value=\"0.0.0.0\"></td>")
						  				document.write("<td class=\"bggrey\"><input id=\"ip_end_" + i + "\" name=\"ip_end_" + i + "\" size=\"15\"  maxlength=\"15\" value=\"255.255.255.255\"></td>")
										document.write("</tr>")
						  			}
						  		</script>
                        </table></td>
                      </tr>
                      <tr>
                        <td class="bgblue"></td>
                        <td class="bggrey2">
                          <p>
                            <input type="button" id="button1" name="button1" class=button_submit value="Add" onClick="send_request();">
                            <input type="reset" id="button2" name="button2"class=button_submit value="Clear">
                          </p>
                        </td>
                      </tr>
                    </table>   
<br>                 
                    <table cellSpacing=1 cellPadding=3 width="100%" bgcolor="#FFFFFF" border=0>
                      <tr align="center" bgcolor="#FFFFFF">
                        <td align=middle width=20 bgcolor="#C5CEDA"><b>Name</b></td>
                        <td align=middle width=20 bgcolor="#C5CEDA"><b>Action</b></td>
                        <td width="255" bgcolor="#C5CEDA"><b>Remote IP Range</b></td>
                        <td align=middle width=20 bgcolor="#C5CEDA"><b>&nbsp;</b></td>
                        <td align=middle width=20 bgcolor="#C5CEDA"><b>&nbsp;</b></td>
                      </tr>
                      <script>
						set_Inbound();
						for(var i=0;i<DataArray.length;i++){
							document.write("<tr>")
							document.write("<td>"+ DataArray[i].Name +"</td>")
							document.write("<td>"+ DataArray[i].sAction +"</td>")
							document.write("<td>"+ DataArray[i].Show_W +"</td>")
							document.write("<td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.gif\" border=\"0\" alt=\"edit\"></a></td>")
							document.write("<td><a href=\"javascript:del_row(" + i +")\"><img src=\"delet.gif\"  border=\"0\" alt=\"delete\"></a></td>")
							document.write("</tr>")
						}
					  </script>
                    </table>                    <br>
                    <p>&nbsp;</p></td>
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
<script>
	onPageLoad();
</script>
</html>
