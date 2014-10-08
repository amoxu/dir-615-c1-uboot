<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | LAN &amp; DHCP Server</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 25;
	var resert_rule = rule_max_num;
	var DHCPL_DataArray = new Array();

	function loadSettings()
	{
		set_checked(get_by_id("dhcpd_enable").value,get_by_name("dhcp"))
		set_checked(get_by_id("dhcpd_reservation").value,get_by_name("reserved_enable"))
		set_selectIndex(get_by_id("dhcpd_lease_time").value, get_by_id("lease_time"));
		
		var reserved_enable = get_by_name("reserved_enable");
		var disable = 0;
		if (reserved_enable[1].checked)
		{
			disable=1; 
		}
		get_by_id("reserved_name").disabled = disable;
		get_by_id("reserved_ip").disabled = disable;
		get_by_id("reserved_mac").disabled = disable;
		get_by_id("add").disabled = disable;
		get_by_id("cancel2").disabled = disable;
		
	}	
	function disable_dhcp_server()
	{
		var dhcp = get_by_name("dhcp");
		var reserved_enable = get_by_name("reserved_enable");
		disable_dhcp(dhcp[1].checked, get_by_id("dhcpd_start"), get_by_id("dhcpd_end"));
		get_by_id("dhcpd_domain_name").disabled = dhcp[1].checked;
		get_by_id("lease_time").disabled = dhcp[1].checked; 
		
		//disable_static_dhcp();
	}
	
	function disable_static_dhcp()
	{
		var dhcp = get_by_name("dhcp");
		var reserved_enable = get_by_name("reserved_enable");
		var revdhcp = get_by_name("reserved_enable");
		var disable = 0;
		if (dhcp[1].checked || reserved_enable[1].checked)
			disable = 1;
		if (dhcp[1].checked && reserved_enable[0].checked){
			alert("You must be to select ' DHCP Server Enable' ");
			reserved_enable[1].checked=true;
			return ;
		}
		get_by_id("reserved_name").disabled = disable;
		get_by_id("reserved_ip").disabled = disable;
		get_by_id("reserved_mac").disabled = disable;
		get_by_id("add").disabled = disable;
		get_by_id("cancel2").disabled = disable;

		if (disable || get_by_id("edit").value == "-1") {
			get_by_id("update").disabled = true;
			get_by_id("delete").disabled = true;
			if (disable || get_by_id("reserved_name").value!=""){
				get_by_id("add").disabled = true;
			}
			else{
				get_by_id("add").disabled = false;
			}
		}
		else {	
			if (get_by_id("reserved_name").value==""){	
				get_by_id("update").disabled = true;
				get_by_id("delete").disabled = true;
				get_by_id("add").disabled=false;
			}
			else {		
				get_by_id("update").disabled = false;
				get_by_id("delete").disabled = false;		
				get_by_id("add").disabled=true;
			}
		}	
	}

	function Data(enable, name, ip, mac, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.IP = ip;
		this.MAC = mac;
		this.OnList = onList;
	}

	function DHCP_Data(name, ip, mac, Exp_time, onList) 
	{
		this.Name = name;
		this.IP = ip;
		this.MAC = mac;
		this.EXP_T = Exp_time;
		this.OnList = onList;
	}

	function clone_mac_action(){
		get_by_id("reserved_mac").value = get_by_id("mac_clone_addr").value;
	}

	function set_reservation()
	{
		var index = 1;
		for (var i = 0; i < rule_max_num; i++){
			var temp_dhcp;
			var k = i;
			if(parseInt(i) < 10){
				k = "0" + i;
			}
			temp_dhcp = (get_by_id("dhcpd_reserve_" + k).value).split("/");
			if (temp_dhcp.length > 1){
				if(temp_dhcp[1].length > 0){
					DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], temp_dhcp[3], index);
					index++;
				}
			}
		}
		get_by_id("max_row").value = index - 1;
	}

	function clear_reserved()
	{
		//get_by_id("reserved_enable").checked = false;
		get_by_id("reserved_name").value = "";
		get_by_id("reserved_ip").value = "";
		get_by_id("reserved_mac").value = "";
		get_by_id("edit").value = -1;
	}

	function set_reserved()
	{
		var idx = parseInt(get_by_id("reserved_list").selectedIndex);

		get_by_id("reserved_enable").checked = true;
		get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
		get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
		get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
	}

	function set_reserved_enable(idx)
	{
/*
	if(get_by_id("r_enable" + idx).checked){
		if(confirm("Do you want enable the DHCP Reservation entry for IP Address " + DataArray[idx].IP)){
			DataArray[idx].Enable = 1;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}
	}else{
		if(confirm("Do you want disable the DHCP Reservation entry for IP Address " + DataArray[idx].IP)){
			DataArray[idx].Enable = 0;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}
	}
*/
	}

	function edit_row(idx)
	{
		//if(DataArray[idx].Enable == 1)
			//get_by_id("reserved_enable").checked = true;
		//else
			//get_by_id("reserved_enable").checked = false;
    	var row_obj = get_by_id("table1").rows[idx];        
    	get_by_id("reserved_name").value = get_row_data(row_obj, 0);    	
    	get_by_id("reserved_ip").value = get_row_data(row_obj, 1);
    	get_by_id("reserved_mac").value = get_row_data(row_obj, 2);
		get_by_id("edit").value = idx;
        get_by_id("add").disabled = true;
        get_by_id("update").disabled = false;
        get_by_id("delete").disabled = false;
        change_color("table1", idx);
	}

	function delete_data()
	{
		var num = parseInt(get_by_id("del").value);
		var DataArray_length = parseInt(DataArray.length) - 1;

		for(var i = num ; i < DataArray_length; i++){
			DataArray[i].Enable = DataArray[i+1].Enable;
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].IP = DataArray[i+1].IP;
			DataArray[i].MAC = DataArray[i+1].MAC;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}
	
		DataArray[DataArray_length].Name = "";
		--DataArray_length;
		get_by_id("max_row").value = parseInt(DataArray_length);
		clear_reserved();
	}

	function delete_row()
	{
		var del_index = parseInt(get_by_id("del").value);
		var tb1 = get_by_id("table1");
		var DataArray_length = parseInt(DataArray.length) - 1;
		if (del_index >= DataArray_length){
			var oTr = tb1.deleteRow(del_index);
		}else{
			for(var i = del_index; i < DataArray_length; i++){
				var is_checked = "";
				if(parseInt(DataArray[i+1].Enable)){
					is_checked = " checked";
				}
				var edit = i + 1;
//				get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + edit + ")' " + is_enable + "></center>"
				get_by_id("table1").rows[i].cells[0].innerHTML = "<center>" + DataArray[edit].Name +"</center>"
				get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[edit].IP +"</center>"
				get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[edit].MAC +"</center>"
//				get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
//				get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
			}
			var oTr = tb1.deleteRow(DataArray_length);
		}
		delete_data();
	}

	function del_row(idx)
	{
   		var index = get_by_id("edit").value;
//		edit_row(index);
		if(confirm(msg[MSG48] + DataArray[index].IP)){
			get_by_id("del").value = index;
			delete_row();
			send_request();
		}
	}

	function update_DataArray()
	{
		var index = parseInt(get_by_id("edit").value);
		var insert = false;
		var is_enable = "0";

		if(index == "-1"){      //save
			if(get_by_id("max_row").value == rule_max_num){
				alert("Schedule rules is Full! Please Delete an Entry.");
			}else{
				index = parseInt(get_by_id("max_row").value) + 1;
				get_by_id("max_row").value = index;
				insert = true;
			}
		}

		//if(get_by_id("reserved_enable").checked){
			//is_enable = "1";
		//}else{
			//is_enable = "0";
		//}
	
		if(insert){
			DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, get_by_id("reserved_mac").value, index, index+1);			
		}else if (index != -1){
			DataArray[index].Enable = is_enable;
			DataArray[index].Name = get_by_id("reserved_name").value;
			DataArray[index].IP = get_by_id("reserved_ip").value;
			DataArray[index].MAC = get_by_id("reserved_mac").value;
			DataArray[index].OnList = index;
		}
	}

	function save_reserved()
	{
		var index = 0;
    	var ip = get_by_id("lan_ipaddr").value;
		var mask = get_by_id("lan_netmask").value;
		var reserved_name = get_by_id("reserved_name").value;
		var reserved_ip = get_by_id("reserved_ip").value;
		var reserved_mac = get_by_id("reserved_mac").value;
		var start_ip = get_by_id("dhcpd_start").value;
		var end_ip = get_by_id("dhcpd_end").value;
    	
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,"Reservation IP");
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");
    	
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
    	
		if(reserved_name == ""){
			alert(msg[MSG50]);
			return false;
		}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, "Reservation IP address")){
			return false;
		}else if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
			return false;
		}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
			alert(msg[MSG46]);
			return false;
		}else if (!check_mac(reserved_mac)){
			alert(msg[MSG47]);
			return false;
		}
		
		if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)){
			//alert(msg[BD_ALERT_8]);
			alert("Reserved IP address " + reserved_ip + " should be within the configured DHCP range.");	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
			return false;
		}
		//check same ip/mac start	
		for(m = 1; m < DataArray.length; m++){
			if(get_by_id("edit").value == "-1"){	//add
				if(reserved_name.length > 0){
					if((reserved_name == DataArray[m].Name)){
						alert("Reserved name '"+ reserved_name +"' is already used.");
						return false;
					}
				}
			}
			else{	//update
				var upraw = get_by_id("edit").value;
				//if the raw as self then don't check it
				if(parseInt(upraw,10) == m)
					continue;
			}	
			if(reserved_name.length > 0){
					if((reserved_name == DataArray[m].Name)){
						alert("Reserved name '"+ reserved_name +"' is already used.");
						return false;
					}
				}
			if(reserved_ip.length > 0){
				if((reserved_ip == DataArray[m].IP)){
					alert("Reserved IP Address '"+ reserved_ip +"' is already used.");
					return false;
				}
			}
			if(reserved_mac.length > 0){
				if((reserved_mac == DataArray[m].MAC)){
					alert("Reserved IP address for this MAC address '"+ reserved_mac +"' is already set.");
					return false;
				}
			}
		}		
		//check same ip/mac end
    	
		update_DataArray();
    	
		var is_enable = "";
		if(get_by_id("edit").value == "-1"){     //add
			var i = get_by_id("max_row").value;
			var tb1 = get_by_id("table1"); 
			var oTr = tb1.insertRow(-1);
			var oTd1 = oTr.insertCell(-1);
			var oTd2 = oTr.insertCell(-1);
			var oTd3 = oTr.insertCell(-1);
//			var oTd4 = oTr.insertCell(-1);
//			var oTd5 = oTr.insertCell(-1);
//			var oTd6 = oTr.insertCell(-1);
    	
			if(parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
//			oTd1.innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
			oTd1.innerHTML = "<center>" + DataArray[i].Name +"</center>"
			oTd2.innerHTML = "<center>" + DataArray[i].IP +"</center>"
			oTd3.innerHTML = "<center>" + DataArray[i].MAC +"</center>"
//			oTd5.innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
//			oTd6.innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
		}else{                                      //update		
			var i = parseInt(get_by_id("edit").value);
			if(parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
//			get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
			get_by_id("table1").rows[i].cells[0].innerHTML = "<center>" + DataArray[i].Name +"</center>"
			get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[i].IP +"</center>"
			get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[i].MAC +"</center>"
//			get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center>";
//			get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center>";
		}
		clear_reserved();
		send_request();	
	}

	function update_data()
	{
		var max_row = parseInt(get_by_id("max_row").value) + 1;
		for(var ii = 0; ii < rule_max_num; ii++){
			if (ii < 10){
				get_by_id("dhcpd_reserve_0" + ii).value = "";
			}else{
				get_by_id("dhcpd_reserve_" + ii).value = "";
			}
		}
		
		for(var ii = 1; ii < max_row; ii++){
			if(DataArray[ii].Name != ""){
				var dat = "1" +"/"+ DataArray[ii].Name +"/"+ DataArray[ii].IP +"/"+ DataArray[ii].MAC;
				if ((ii-1) < 10){
					get_by_id("dhcpd_reserve_0" + (ii-1)).value = dat;
				}else{
					get_by_id("dhcpd_reserve_" + (ii-1)).value = dat;
				}
			}
		}
	}

	function display_wizard(display)
	{
		if (!display){
			show_wizard('wizard.asp');
		}
	}

    function send_request()
    {    	
		var ip = get_by_id("lan_ipaddr").value;
		var mask = get_by_id("lan_netmask").value;
		var dhcp = get_by_name("dhcp");
		var start_ip = get_by_id("dhcpd_start").value;
		var end_ip = get_by_id("dhcpd_end").value;
		var reserved_enable = get_by_name("reserved_enable");
		var tmp_hostname = get_by_id("hostname").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_start_ip_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var temp_end_ip_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
		if(tmp_hostname == ""){
			alert("Please input a host name.");
			return false;
		}else{		
		if (check_DeviceName(tmp_hostname)){
			return false;
		}		
		}
		if (!check_mask(temp_mask_obj)){		
			return false;
		}		
		if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj)){		
			return false;
		}		
			
		if (dhcp[0].checked){
			if (!check_address(temp_start_ip_obj, temp_mask_obj) || !check_address(temp_end_ip_obj, temp_mask_obj)){
				return false;
			}
				
			if (!check_domain(temp_ip_obj, temp_mask_obj, temp_start_ip_obj)){
				alert(addstr(msg[MSG2],"Start IP address"));
				return false;
			}
				
			if (!check_domain(temp_ip_obj, temp_mask_obj, temp_end_ip_obj)){
				alert(addstr(msg[MSG2],"End IP address"));
				return false;
			}
				
			if (!check_ip_order(temp_start_ip_obj, temp_end_ip_obj)){
				alert(msg[MSG4]);
				return false;
			}
			get_by_id("dhcpd_enable").value = 1;
		}
		else if(!dhcp[0].checked)
			get_by_id("dhcpd_enable").value = 0;

		get_by_id("dhcpd_lease_time").value = get_by_id("lease_time").value;
		if ((ip_num(temp_ip_obj.addr) >= ip_num(temp_start_ip_obj.addr)) && (ip_num(temp_ip_obj.addr) <= ip_num(temp_end_ip_obj.addr)))
		{
			alert("LAN IP is conflicted with LAN IP range, please enter again.");
			return false;
		}
		if (reserved_enable[0].checked)
		{
			get_by_id("dhcpd_reservation").value = 1;			
		}
		else if (reserved_enable[1].checked)
		{
			get_by_id("dhcpd_reservation").value = 0;			
		}		
			
		update_data();
		send_submit("form1");
	}
	
	function set_dhcplist()
	{
		var index = 0;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
				index++;
			}
		}
	}
/*	
	function set_dhcplist()
	{
		var myData = get_by_id("dhcp_list").value.split(",");
		var index=1;
		for (var i=0 ; i<myData.length;i++){
			var temp_data = myData[i].split("/");
			if(temp_data.length > 1){
				DataArray[DataArray.length++] = new Data(temp_data[1],"LAN", temp_data[0], temp_data[2],index);
				index++;
			}
		}
	}
*/

	function DataShow()
	{
		set_reservation();
		var is_enable = "";
		for(i = 1; i < DataArray.length; i++){
			if(parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
			document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
			document.write("<td>"+ DataArray[i].Name +"</td>");
			document.write("<td>"+ DataArray[i].IP +"</td>");
			document.write("<td>"+ DataArray[i].MAC.toUpperCase() +"</td>");
			document.write("</tr>\n");
		}	
	}
	
	function check_dhcp_range()
	{
		var lan_ip = get_by_id("lan_ipaddr").value.split(".");
		var start_ip3 = get_by_id("dhcpd_start").value.split(".");
		var end_ip3 = get_by_id("dhcpd_end").value.split(".");
		var enrty_IP = lan_ip[2];		
		get_by_id("dhcpd_start").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + start_ip3[3];
		get_by_id("dhcpd_end").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + end_ip3[3];
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
              <td><a href="lan.asp"><img src="but_main_1.gif" name="Image2" width="144" height="28" border="0" id="Image2" onMouseOver="MM_swapImage('Image2','','but_main_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                <tr>
                  <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td width="87%"><a href="lan.asp" class="submenus"><b><u>LAN &amp; DHCP Server </u></b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="wan.asp" class="submenus"><b>WAN</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="password.asp" class="submenus"><b>Password</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="time.asp" class="submenus"><b>Time</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="ddns.asp" class="submenus"><b>Dynamic DNS </b></a></td>
                </tr>
              </table></td>
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
                      <td width="85%" class="headerbg">LAN &amp; DHCP Server</td>
                      <td width="15%" class="headerbg"><a href="help_main.asp#lanski_dhcp_server" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    </tr>
                  </table>
				  <form id="form1" name="form1" method="post" action="apply.cgi">
				  <input type="hidden" name="html_response_page" value="count_down.asp">
				  <input type="hidden" name="html_response_message" value="The setting is saved.">
				  <input type="hidden" name="html_response_return_page" value="lan.asp">
				  <input type="hidden" id="dhcpd_lease_time" name="dhcpd_lease_time" value="<% CmoGetCfg("dhcpd_lease_time","none"); %>">
				  <input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
				  <input type="hidden" id="reboot_type" name="reboot_type" value="shutdown">
      				<input type="hidden" id="del" name="del" value="-1">
	   			<input type="hidden" id="edit" name="edit" value="-1">
	   			<input type="hidden" id="max_row" name="max_row" value="-1">
	   			<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
				<input type="hidden" id="dhcpd_reserve_00" name="dhcpd_reserve_00" value="<% CmoGetCfg("dhcpd_reserve_00","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_01" name="dhcpd_reserve_01" value="<% CmoGetCfg("dhcpd_reserve_01","none"); %>">
				<input type="hidden" id="dhcpd_reserve_02" name="dhcpd_reserve_02" value="<% CmoGetCfg("dhcpd_reserve_02","none"); %>">		
				<input type="hidden" id="dhcpd_reserve_03" name="dhcpd_reserve_03" value="<% CmoGetCfg("dhcpd_reserve_03","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_04" name="dhcpd_reserve_04" value="<% CmoGetCfg("dhcpd_reserve_04","none"); %>">
				<input type="hidden" id="dhcpd_reserve_05" name="dhcpd_reserve_05" value="<% CmoGetCfg("dhcpd_reserve_05","none"); %>">
				<input type="hidden" id="dhcpd_reserve_06" name="dhcpd_reserve_06" value="<% CmoGetCfg("dhcpd_reserve_06","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_07" name="dhcpd_reserve_07" value="<% CmoGetCfg("dhcpd_reserve_07","none"); %>">
				<input type="hidden" id="dhcpd_reserve_08" name="dhcpd_reserve_08" value="<% CmoGetCfg("dhcpd_reserve_08","none"); %>">	
				<input type="hidden" id="dhcpd_reserve_09" name="dhcpd_reserve_09" value="<% CmoGetCfg("dhcpd_reserve_09","none"); %>">
				<input type="hidden" id="dhcpd_reserve_10" name="dhcpd_reserve_10" value="<% CmoGetCfg("dhcpd_reserve_10","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_11" name="dhcpd_reserve_11" value="<% CmoGetCfg("dhcpd_reserve_11","none"); %>">
				<input type="hidden" id="dhcpd_reserve_12" name="dhcpd_reserve_12" value="<% CmoGetCfg("dhcpd_reserve_12","none"); %>">		
				<input type="hidden" id="dhcpd_reserve_13" name="dhcpd_reserve_13" value="<% CmoGetCfg("dhcpd_reserve_13","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_14" name="dhcpd_reserve_14" value="<% CmoGetCfg("dhcpd_reserve_14","none"); %>">
				<input type="hidden" id="dhcpd_reserve_15" name="dhcpd_reserve_15" value="<% CmoGetCfg("dhcpd_reserve_15","none"); %>">
				<input type="hidden" id="dhcpd_reserve_16" name="dhcpd_reserve_16" value="<% CmoGetCfg("dhcpd_reserve_16","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_17" name="dhcpd_reserve_17" value="<% CmoGetCfg("dhcpd_reserve_17","none"); %>">
				<input type="hidden" id="dhcpd_reserve_18" name="dhcpd_reserve_18" value="<% CmoGetCfg("dhcpd_reserve_18","none"); %>">	
				<input type="hidden" id="dhcpd_reserve_19" name="dhcpd_reserve_19" value="<% CmoGetCfg("dhcpd_reserve_19","none"); %>">
				<input type="hidden" id="dhcpd_reserve_20" name="dhcpd_reserve_20" value="<% CmoGetCfg("dhcpd_reserve_20","none"); %>">
				<input type="hidden" id="dhcpd_reserve_21" name="dhcpd_reserve_21" value="<% CmoGetCfg("dhcpd_reserve_21","none"); %>">				
				<input type="hidden" id="dhcpd_reserve_22" name="dhcpd_reserve_22" value="<% CmoGetCfg("dhcpd_reserve_22","none"); %>">
				<input type="hidden" id="dhcpd_reserve_23" name="dhcpd_reserve_23" value="<% CmoGetCfg("dhcpd_reserve_23","none"); %>">	
				<input type="hidden" id="dhcpd_reserve_24" name="dhcpd_reserve_24" value="<% CmoGetCfg("dhcpd_reserve_24","none"); %>">	

                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td align="right" class="bgblue">Host Name </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                      <input type="text" id="hostname" name="hostname" size="20" maxlength="19" value="<% CmoGetCfg("hostname","none"); %>">
                     </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">IP Address </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey"> 
                       <input name="lan_ipaddr" type="text" id="lan_ipaddr" size="16" maxlength="15" onChange="check_dhcp_range()" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
                     </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Subnet Mask </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                        <input name="lan_netmask" type="text" id="lan_netmask" size="16" maxlength="15" value="<% CmoGetCfg("lan_netmask","none"); %>">
                     </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">DHCP Server </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                        <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("dhcpd_enable","none"); %>">
                        <input type="radio" name="dhcp" value="1" onClick="disable_dhcp_server()">
                        Enabled
                        <input type="radio" name="dhcp" value="0" onClick="disable_dhcp_server()">
                        Disabled</td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Start IP </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                       
                       <input type="text" id="dhcpd_start" name="dhcpd_start" size="16" maxlength="15" value="<% CmoGetCfg("dhcpd_start","none"); %>">
                     </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">End IP </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                       <input type="text" id="dhcpd_end" name="dhcpd_end" size="16" maxlength="15" value="<% CmoGetCfg("dhcpd_end","none"); %>">
                     </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Domain Name </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey">
                      <input name="dhcpd_domain_name" type="text" id="dhcpd_domain_name" size="40" maxlength="31" value="<% CmoGetCfg("dhcpd_domain_name","none"); %>">
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Lease
                        Time </td>
                      <td width="404" bgcolor="#FFFFFF" class="bggrey"><font color="#FFFFFF"  face=Arial size=2>
                        <select id="lease_time" name="lease_time" size=1>
                          <option value="60">1 Hour</option>
                          <option value="120">2 Hours</option>
                          <option value="180">3 Hours</option>
                          <option value="1440">1 Day</option>
                          <option value="2880">2 Days</option>
                          <option value="4320">3 Days</option>
                          <option value="10080">1 Week</option>
                        </select>
                      </font> </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Static DHCP</td>
					  <td width="404" bgcolor="#FFFFFF" class="bggrey">
                        <input type="hidden" id="dhcpd_reservation" name="dhcpd_reservation" value="<% CmoGetCfg("dhcpd_reservation","none"); %>">
                        <input type="radio" name="reserved_enable" value="1" onClick="disable_static_dhcp()" checked>Enabled
                        <input type="radio" name="reserved_enable" value="0" onClick="disable_static_dhcp()">Disabled
					  </td>
                    </tr>
                    <tr>
                      <td class="bgblue">&nbsp;</td>
                      <td bgcolor="#FFFFFF" class="bggrey2">
                      	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="window.location='lan.asp'">
						<input type="button" id="apply" name="apply" value="Apply" onClick="send_request()">
                      </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Name</td>
					  <td width="404" bgcolor="#FFFFFF" class="bggrey">
                       <input type=text id="reserved_name" name="reserved_name" size="20"></td>
					  
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">IP Address</td>
					  <td width="404" bgcolor="#FFFFFF" class="bggrey"><input type=text id="reserved_ip" name="reserved_ip" size="20" maxlength="15"></td>

                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Mac Address</td>
					  <td width="404" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="reserved_mac" name="reserved_mac" size="20" maxlength="19"></td>
                    </tr>
                    <tr>
                      <td class="bgblue">&nbsp;</td>
                      <td bgcolor="#FFFFFF" class="bggrey2">
					<input type="button" id="add" name="add" value="Add" onClick="save_reserved();">&nbsp;&nbsp;
					<input type="button" id="update" name="update" value="Update" onClick="save_reserved();" disabled>&nbsp;&nbsp;
					<input type="button" id="delete" name="delete" value="Delete" onClick="del_row();" disabled>&nbsp;&nbsp;
					<input type="button" id="cancel2" name="cancel2" value="Cancel" onClick="window.location='lan.asp'">
					</td>
					  </tr>					
                  <br>
                  </table>

                  <table width="100%" border="0" cellpadding="5" cellspacing="1">
                  <tr>
                      <td align="left"><b>Static DHCP List</b></td>
				  </tr>
			    </table>
                <table id="table1" width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td align="center" bgcolor="#C5CEDA"><b>Host Name</b></td>
                    <td align="center" bgcolor="#C5CEDA"><b>IP Address</b></td>
                    <td align="center" bgcolor="#C5CEDA"><b>MAC Address</b></td>
                  </tr>
	                    <script>DataShow();	</script>				  
                </table> </form>
                <table width="100%" border="0" cellpadding="5" cellspacing="1">
                  <tr>
                      <td align="left"><b>Dynamic DHCP List</b></td>
				  </tr>
                  </table>          
                <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                    <td align="center" bgcolor="#C5CEDA"><b>Host Name</b></td>
                    <td align="center" bgcolor="#C5CEDA"><b>IP Address</b></td>
                    <td align="center" bgcolor="#C5CEDA"><b>MAC Address</b></td>
                  </tr>
                  <script>
	                set_dhcplist();
					for(i=0;i<DHCPL_DataArray.length;i++){
						document.write("<tr bgcolor=\"#F0F0F0\" align=\"center\">"+
							  
							  "<td>"+ DHCPL_DataArray[i].Name +"</td>"+
							  "<td>"+ DHCPL_DataArray[i].IP +"</td>"+
							  "<td>"+ DHCPL_DataArray[i].MAC.toUpperCase() +"</td>"+
							  "</tr>");
					}
                  </script>
                </table>                
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
      </table></td>
    <td background="bg1_r.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="c1_bl.gif" width="21" height="20"></td>
    <td align="right" background="bg1_b.gif"><img src="copyright.gif" width="264" height="20"></td>
    <td><img src="c1_br.gif" width="21" height="20"></td>
  </tr>
</table>
<script>
    display_wizard(<% CmoGetCfg("blank_status","none"); %>);	
    loadSettings();
	disable_dhcp_server();
</script>
</body>
</html>
