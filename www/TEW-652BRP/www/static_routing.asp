<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Routing | Static</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 40;
	function loadsetting()
	{
		var temp_wan_poto=get_by_id("wan_proto").value;
		var temp_wan_pptp_russia_enable=get_by_id("wan_pptp_russia_enable").value;
		var temp_wan_l2tp_russia_enable=get_by_id("wan_l2tp_russia_enable").value;
		var temp_wan_pppoe_russia_enable=get_by_id("wan_pppoe_russia_enable").value;
		var temp_russia_wan_phy_ipaddr=get_by_id("russia_wan_phy_ipaddr").value;
		var temp_interface_list="LAN,WAN,WAN_PHY";
		var interface_list = temp_interface_list.split(",");
		var count = 0;
		var obj=get_by_id("iface");
		
		if ((temp_wan_poto == "pptp")||(temp_wan_poto == "pppoe")||(temp_wan_poto == "l2tp"))
		{
			if((temp_wan_pptp_russia_enable == "1")||(temp_wan_pppoe_russia_enable == "1")||(temp_wan_l2tp_russia_enable == "1"))
			{
				for(var i=0;i<interface_list.length; i++)
				{
					var ooption = document.createElement("option");						
					ooption.text = interface_list[i];
					ooption.value = interface_list[i];
					obj.options[count++] = ooption;
				}
			}
			else
			{
				for(var i=0;i<interface_list.length-1; i++)
				{
					var ooption = document.createElement("option");						
					ooption.text = interface_list[i];
					ooption.value = interface_list[i];
					obj.options[count++] = ooption;
				}
			}			
		}
		else
		{
			for(var i=0;i<interface_list.length-1; i++)
			{
				var ooption = document.createElement("option");						
				ooption.text = interface_list[i];
				ooption.value = interface_list[i];
				obj.options[count++] = ooption;
			}
		}
	}
	function DataShow(){
		set_routes();
		for (var i=0; i<DataArray.length;i++)
		{
			if (i<26)
			{
				document.write("<tr bgcolor=\"#F0F0F0\" onClick=\"edit_row("+ i +")\">");
				document.write("<td>"+ DataArray[i].Ip_addr +"</td>");
				document.write("<td>"+ DataArray[i].Net_mask +"</td>");
				document.write("<td>"+ DataArray[i].Gateway +"</td>");
				document.write("<td>"+ DataArray[i].Interface +"</td>");
				document.write("<td>"+ DataArray[i].Metric +"</td>");
				document.write("</tr>\n");
			}
		}
	}
	
	//0/name/192.168.31.0/255.255.255.0/192.168.31.1/192.168.31.1/20
	function Data(enable, name, ip_addr, net_mask, gateway, interface, metric, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr
		this.Net_mask = net_mask
		this.Gateway = gateway
		this.Interface = interface;
		this.Metric = metric;
		this.OnList = onList;
	}
	
	function set_routes(){
		var index = 1;
		for (var i=0;i<rule_max_num;i++){
			var temp_st;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("static_routing_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[1] != "name"){
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3],temp_st[4],temp_st[5],temp_st[6],index);
					index++;
				}
			}
		}
	}
	
	function del_row(){
        var index = parseInt(get_by_id("edit_row").value,10);
        if(confirm(addstr(msg[MSG16],"routing"))){
        	for(i=index ; i<DataArray.length-1 ;i++){
				DataArray[i].Enable = DataArray[i+1].Enable;
				DataArray[i].Name = DataArray[i+1].Name;
				DataArray[i].Ip_addr = DataArray[i+1].Ip_addr;
				DataArray[i].Net_mask = DataArray[i+1].Net_mask;
				DataArray[i].Gateway = DataArray[i+1].Gateway;
				DataArray[i].Interface = DataArray[i+1].Interface;
				DataArray[i].Metric = DataArray[i+1].Metric;
				DataArray[i].OnList = DataArray[i+1].OnList;
			}
			--DataArray.length;
			save_to_cfg();
			get_by_id("reboot_type").value = "all";
			return true;
        }
        return false;
    }
    
    function edit_row(row){
    	var row_obj = get_by_id("table1").rows[row+1];
        
    	get_by_id("ip").value = get_row_data(row_obj, 0);    	
    	get_by_id("mask").value = get_row_data(row_obj, 1);
    	get_by_id("gateway").value = get_row_data(row_obj, 2);
    	
    	if (get_row_data(row_obj, 3) == "LAN"){
    		get_by_id("iface").selectedIndex = 0;
    	}else if (get_row_data(row_obj, 3) == "WAN"){
    		get_by_id("iface").selectedIndex = 1;
    	}else if (get_row_data(row_obj, 3) == "WAN_PHY"){
    		get_by_id("iface").selectedIndex = 2;
    	}
    	
        get_by_id("metric").value = get_row_data(row_obj, 4);
        
        get_by_id("edit_row").value = row;
        get_by_id("add").disabled = true;
        get_by_id("update").disabled = false;
        get_by_id("del").disabled = false;
        change_color("table1", row+1);
    }
    
    function clear_row(){
        get_by_id("edit_row").value = "-1";
        change_color("table1", -1);
        location.href = "static_routing.asp";
    }
    
	function send_request(){
		var temp_wan_poto=get_by_id("wan_proto").value;
		var temp_wan_pptp_russia_enable=get_by_id("wan_pptp_russia_enable").value;
		var temp_wan_l2tp_russia_enable=get_by_id("wan_l2tp_russia_enable").value;
		var temp_wan_pppoe_russia_enable=get_by_id("wan_pppoe_russia_enable").value;
		var dat= get_by_id("russia_wan_phy_ipaddr").value.split("/");
		var ip = get_by_id("ip").value;		
		var mask = get_by_id("mask").value;
		var gateway = get_by_id("gateway").value;
		var	lan_ip=get_by_id("lan_ipaddr").value;
		var	lan_mask=get_by_id("lan_netmask").value;
		var metric = get_by_id("metric").value;
		
		var network_addr_msg = replace_msg(all_ip_addr_msg,"Network Address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		if (!get_by_id("iface").value=="LAN"){
			ip_addr_msg[MULTICASE_IP_ERROR] = "The IP address can't allow enter loopback IP or multicase IP ( 127.x.x.x ).";
		}
		var temp_ip_obj = new addr_obj(ip.split("."), network_addr_msg, false, true);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, true);
		
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), network_addr_msg, false, true);
		var temp_lan_mask_obj = new addr_obj(lan_mask.split("."), subnet_mask_msg, false, false);
				
		var temp_metric = new varible_obj(metric, metric_msg, 1, 15, false);
		var index = parseInt(get_by_id("edit_row").value,10);
		
		
		if (get_by_id("iface").value=="LAN"){
			// check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x)
			if((temp_ip_obj.addr[0] == "127") || ((temp_ip_obj.addr[0] >= 224) && (temp_ip_obj.addr[0] <= 239))){
				alert(temp_ip_obj.e_msg[MULTICASE_IP_ERROR]);
				return false;
			}
		}
// Don't check subnet and ip		
//		if (!check_mask(temp_mask_obj)){
//			return false;		// when subnet mask is not in the subnet mask range
//		}else if (!check_network_address(temp_ip_obj, temp_mask_obj)){
//			return false;   // when ip is invalid
//		}		
		if (!check_address(temp_gateway_obj)){
			return false;	// when gateway is invalid
		}
	
		if (!check_varible(temp_metric)){
    		return false;
    	}
    	
//    	
//    	if (get_by_id("iface").value=="LAN")
//    	{
//				var lan_ip_addr_msg = replace_msg(all_ip_addr_msg,"LAN IP address");
//				var temp_lan_ip_obj = new addr_obj(get_by_id("cur_ipaddr").value.split("."), lan_ip_addr_msg, false, true);
//				var temp_lan_mask_obj = new addr_obj(get_by_id("cur_netmask").value.split("."), subnet_mask_msg, false, false);
//
//				if(ip_num(temp_lan_ip_obj.addr) == ip_num(temp_ip_obj.addr))
//				{
//					alert(addstr(msg[MSG43],"Network Address"));
//					return false;
//				}
//				
//				if (!check_domain(temp_lan_ip_obj, temp_lan_mask_obj, temp_gateway_obj))
//				{		// check if the ip and the gateway are in the same subnet mask or not
//					alert(msg[MSG7]);
//					return false;
//				}
//			
//				if(ip_num(temp_lan_ip_obj.addr) == ip_num(temp_gateway_obj.addr))
//				{
//					alert(addstr(msg[MSG43],"Gateway Address "));
//					return false;
//				}
//				
//		}
//		if (get_by_id("iface").value=="WAN")
//    	{
//    		var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,"WAN IP address");
//			var wan_current= get_by_id("wan_current_ipaddr_00").value.split("/");
//			var gw_val = wan_current[2];
//			var msk_val = wan_current[1];
//
//			var temp_wan_gateway_obj= new addr_obj(wan_current[2].split("."), gateway_msg, false, true);
//			var temp_wan_mask_obj= new addr_obj(wan_current[1].split("."), gateway_msg, false, true);
//
//				if (!check_domain(temp_gateway_obj, temp_wan_mask_obj, temp_wan_gateway_obj))
//				{		// check if the ip and the gateway are in the same subnet mask or not
//					alert(msg[MSG7]);
//					return false;
//				}	
//		}
//		else if(get_by_id("iface").value=="WAN_PHY")
//		{
//    	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,"WAN IP address");
//			var wan_current= get_by_id("russia_wan_phy_ipaddr").value.split("/");
//			var gw_val = wan_current[2];
//			var msk_val = wan_current[1];
//			var ip_val = wan_current[0];
//			
//			var temp_wan_gateway_obj= new addr_obj(wan_current[2].split("."), gateway_msg, false, true);
//			var temp_wan_mask_obj= new addr_obj(wan_current[1].split("."), gateway_msg, false, true);			
//			var temp_wan_ip_obj= new addr_obj(wan_current[0].split("."), gateway_msg, false, true);
//			var temp_wan_pptp_gateway=get_by_id("wan_pptp_gateway").value
//			var temp_wan_pptp_netmask=get_by_id("wan_pptp_netmask").value
//			var temp_wan_pptp_dynamic=get_by_id("wan_pptp_dynamic").value
//
//			
//			if (temp_wan_pptp_dynamic == "1")
//			{
//				if (ip_val == "0.0.0.0")
//				{
//					alert("The IP address can not be zero.")
//					return false;   // when ip is invalid
//				}
//			}
//
//							
//				if (!check_domain(temp_gateway_obj, temp_wan_mask_obj, temp_wan_ip_obj))
//				{		// check if the ip and the gateway are in the same subnet mask or not
//					alert(msg[MSG7]);
//					return false;
//				}			
//		}	
    	//save data ::edit
		if(index > -1){
			DataArray[index].Ip_addr = ip;
			DataArray[index].Net_mask = mask;
			DataArray[index].Gateway = gateway;
			DataArray[index].Interface = get_by_id("iface").value;
			DataArray[index].Metric = metric;
		}else{//save add data
			var max_num = DataArray.length;
			if(parseInt(max_num,10)>39){
				alert("The allowed number of static router is 40")
				return false;
			}
			
			DataArray[DataArray.length++] = new Data(1,DataArray.length, ip, mask, gateway, get_by_id("iface").value, metric, DataArray.length);
		}
		save_to_cfg();
		get_by_id("reboot_type").value = "all";
    	return true;
	}

	function save_to_cfg(){
		var temp_st = "";
		for(k=0; k<40; k++){
			var now_num = k;
			if(parseInt(k,10)<10){
				now_num = "0"+k;
			}
			temp_st = "0/name/192.168.31.0/255.255.255.0/192.168.31.1/192.168.31.1/20";
			if(k<DataArray.length){
				temp_st = DataArray[k].Enable +"/"+ DataArray[k].Name + "/" + DataArray[k].Ip_addr
				+ "/" + DataArray[k].Net_mask + "/" + DataArray[k].Gateway
				+ "/" + DataArray[k].Interface + "/" + DataArray[k].Metric;
			}
			get_by_id("static_routing_"+now_num).value = temp_st;
		}
	}
</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');loadsetting();">
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
              <td><a href="static_routing.asp"><img src="but_routing_1.gif" name="Image4" width="144" height="28" border="0" id="Image4" onMouseOver="MM_swapImage('Image4','','but_routing_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                <tr>
                  <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td width="87%"><a href="static_routing.asp" class="submenus"><b><u>Static</u></b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="dynamic_routing.asp" class="submenus"><b>Dynamic</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="routing_table.asp" class="submenus"><b>Routing Table </b></a></td>
                </tr>
                
              </table></td>
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
                      <td width="85%" class="headerbg">Static</td>
                      <td width="15%" class="headerbg"><a href="help_routing.asp#routing_static" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    </tr>
                  </table>
                  <form id="form1" name="form1" method="post" action="apply.cgi">
                  	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                	<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
                	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="static_routing.asp">
                	<input type="hidden" id="reboot_type" name="reboot_type" value="none">
                	<input type="hidden" id="cur_ipaddr" name="cur_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
                	<input type="hidden" id="cur_netmask" name="cur_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>">
                	<input type="hidden" id="wan_poto_type" name="wan_poto_type" value="<% CmoGetCfg("wan_poto","none"); %>">
                	
                	<!-- New Variable -->
					<input type="hidden" id="static_routing_00" name="static_routing_00" value="<% CmoGetCfg("static_routing_00","none"); %>">
					<script>
						
					</script>	
					<input type="hidden" id="static_routing_01" name="static_routing_01" value="<% CmoGetCfg("static_routing_01","none"); %>">
					<input type="hidden" id="static_routing_02" name="static_routing_02" value="<% CmoGetCfg("static_routing_02","none"); %>">
					<input type="hidden" id="static_routing_03" name="static_routing_03" value="<% CmoGetCfg("static_routing_03","none"); %>">
					<input type="hidden" id="static_routing_04" name="static_routing_04" value="<% CmoGetCfg("static_routing_04","none"); %>">
					<input type="hidden" id="static_routing_05" name="static_routing_05" value="<% CmoGetCfg("static_routing_05","none"); %>">
					<input type="hidden" id="static_routing_06" name="static_routing_06" value="<% CmoGetCfg("static_routing_06","none"); %>">
					<input type="hidden" id="static_routing_07" name="static_routing_07" value="<% CmoGetCfg("static_routing_07","none"); %>">
					<input type="hidden" id="static_routing_08" name="static_routing_08" value="<% CmoGetCfg("static_routing_08","none"); %>">
					<input type="hidden" id="static_routing_09" name="static_routing_09" value="<% CmoGetCfg("static_routing_09","none"); %>">
					<input type="hidden" id="static_routing_10" name="static_routing_10" value="<% CmoGetCfg("static_routing_10","none"); %>">
					<input type="hidden" id="static_routing_11" name="static_routing_11" value="<% CmoGetCfg("static_routing_11","none"); %>">
					<input type="hidden" id="static_routing_12" name="static_routing_12" value="<% CmoGetCfg("static_routing_12","none"); %>">
					<input type="hidden" id="static_routing_13" name="static_routing_13" value="<% CmoGetCfg("static_routing_13","none"); %>">
					<input type="hidden" id="static_routing_14" name="static_routing_14" value="<% CmoGetCfg("static_routing_14","none"); %>">
					<input type="hidden" id="static_routing_15" name="static_routing_15" value="<% CmoGetCfg("static_routing_15","none"); %>">
					<input type="hidden" id="static_routing_16" name="static_routing_16" value="<% CmoGetCfg("static_routing_16","none"); %>">
					<input type="hidden" id="static_routing_17" name="static_routing_17" value="<% CmoGetCfg("static_routing_17","none"); %>">
					<input type="hidden" id="static_routing_18" name="static_routing_18" value="<% CmoGetCfg("static_routing_18","none"); %>">
					<input type="hidden" id="static_routing_19" name="static_routing_19" value="<% CmoGetCfg("static_routing_19","none"); %>">
					<input type="hidden" id="static_routing_20" name="static_routing_20" value="<% CmoGetCfg("static_routing_20","none"); %>">
					<input type="hidden" id="static_routing_21" name="static_routing_21" value="<% CmoGetCfg("static_routing_21","none"); %>">
					<input type="hidden" id="static_routing_22" name="static_routing_22" value="<% CmoGetCfg("static_routing_22","none"); %>">
					<input type="hidden" id="static_routing_23" name="static_routing_23" value="<% CmoGetCfg("static_routing_23","none"); %>">
					<input type="hidden" id="static_routing_24" name="static_routing_24" value="<% CmoGetCfg("static_routing_24","none"); %>">
					<input type="hidden" id="static_routing_25" name="static_routing_25" value="<% CmoGetCfg("static_routing_25","none"); %>">
					<input type="hidden" id="static_routing_26" name="static_routing_26" value="<% CmoGetCfg("static_routing_26","none"); %>">
					<input type="hidden" id="static_routing_27" name="static_routing_27" value="<% CmoGetCfg("static_routing_27","none"); %>">
					<input type="hidden" id="static_routing_28" name="static_routing_28" value="<% CmoGetCfg("static_routing_28","none"); %>">
					<input type="hidden" id="static_routing_29" name="static_routing_29" value="<% CmoGetCfg("static_routing_29","none"); %>">
					<input type="hidden" id="static_routing_30" name="static_routing_30" value="<% CmoGetCfg("static_routing_30","none"); %>">
					<input type="hidden" id="static_routing_31" name="static_routing_31" value="<% CmoGetCfg("static_routing_31","none"); %>">
					<input type="hidden" id="static_routing_32" name="static_routing_32" value="<% CmoGetCfg("static_routing_32","none"); %>">
					<input type="hidden" id="static_routing_33" name="static_routing_33" value="<% CmoGetCfg("static_routing_33","none"); %>">
					<input type="hidden" id="static_routing_34" name="static_routing_34" value="<% CmoGetCfg("static_routing_34","none"); %>">
					<input type="hidden" id="static_routing_35" name="static_routing_35" value="<% CmoGetCfg("static_routing_35","none"); %>">
					<input type="hidden" id="static_routing_36" name="static_routing_36" value="<% CmoGetCfg("static_routing_36","none"); %>">
					<input type="hidden" id="static_routing_37" name="static_routing_37" value="<% CmoGetCfg("static_routing_37","none"); %>">
					<input type="hidden" id="static_routing_38" name="static_routing_38" value="<% CmoGetCfg("static_routing_38","none"); %>">
					<input type="hidden" id="static_routing_39" name="static_routing_39" value="<% CmoGetCfg("static_routing_39","none"); %>">
					<input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("wan_proto","none"); %>">					
					<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
					<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>">
					<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
					<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
					<input type="hidden" id="lan_netmask" name="lan_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>">
          <input type="hidden" id="russia_wan_phy_ipaddr" name="russia_wan_phy_ipaddr" value="<% CmoGetStatus("russia_wan_phy_ipaddr"); %>"> 
          <input type="hidden" id="wan_current_ipaddr_00" name="wan_current_ipaddr_00" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>"> 
          <input type="hidden" id="wan_pptp_netmask" name="wan_pptp_netmask" value="<% CmoGetCfg("wan_pptp_netmask","none"); %>"> 
          <input type="hidden" id="wan_pptp_gateway" name="wan_pptp_gateway" value="<% CmoGetCfg("wan_pptp_gateway","none"); %>"> 
					<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<% CmoGetCfg("wan_pptp_dynamic","none"); %>"> 
					<input type="hidden" id="wan_l2tp_netmask" name="wan_l2tp_netmask" value="<% CmoGetCfg("wan_l2tp_netmask","none"); %>"> 
					<input type="hidden" id="wan_l2tp_gateway" name="wan_l2tp_gateway" value="<% CmoGetCfg("wan_l2tp_gateway","none"); %>"> 
					<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>"> 
					
					<input type="hidden" id="wan_pppoe_netmask_00" name="wan_pppoe_netmask_00" value="<% CmoGetCfg("wan_pppoe_netmask_00","none"); %>"> 
          <input type="hidden" id="wan_pppoe_gateway_00" name="wan_pppoe_gateway_00" value="<% CmoGetCfg("wan_pppoe_gateway_00","none"); %>"> 
					<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>"> 
               	
                    <input type="hidden" id="edit_row" name="edit_row">
                  <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                    <tr>
                      <td align="right" class="bgblue">Network Address</td>
                      <td class="bggrey"><input type="text" id="ip" name="ip" size="16" maxlength="15"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Network Mask</td>
                      <td class="bggrey"><input type="text" id="mask" name="mask" size="16" maxlength="15"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Gateway Address</td>
                      <td class="bggrey"><input type="text" id="gateway" name="gateway" size="16" maxlength="15"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Interface</td>
                      <td class="bggrey"> 
                       <select size="1" id="iface" name="iface">
                     	</select>
                       </td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">Metric</td>
                      <td class="bggrey"><input type="text" id="metric" name="metric" size="3" maxlength="2"></td>
                    </tr>
                    <tr>
                      <td align="right" class="bgblue">&nbsp;</td>
                      <td class="bggrey2">
                      	<input type="submit" id="add" name="add" value="Add" onClick="return send_request()">			  	
						<input type="submit" id="update" name="update" value="Update" onClick="return send_request()" disabled>
						<input type="submit" id="del" name="del" value="Delete" onClick="return del_row()" disabled>
						<input type="button" id="cancel" name="cancel" value="Cancel" onClick="clear_row()">
                      </td>
                    </tr>
                  </table>
                  </form>                
			      <br>
			      <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" id="table1">
                    <tr>
                      <td height="22" align="center" bgcolor="#C5CEDA"><b>Network
                        Address</b></td>
                      <td height="22" align="center" bgcolor="#C5CEDA"><b>Mask</b></td>
                      <td height="22" align="center" bgcolor="#C5CEDA"><b>Gateway</b></td>
                      <td height="22" align="center" bgcolor="#C5CEDA"><b>Interface</b></td>
                      <td height="22" align="center" bgcolor="#C5CEDA"><b>Metric</b></td>
                    </tr>
                    <script>DataShow();</script>
                  </table></td>
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
