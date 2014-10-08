<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Status | Device Information</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function show_wan_table(){
		var is_ap_mode = "1";
		var dhcp_enable = get_by_id("dhcpd_enable").value;
		var dhcpc_enable = "";
		var dhcp_word = "Disabled";
		if(dhcp_enable==1){
			dhcp_word = "Enabled";
		}
		if (is_ap_mode == "0"){ //ap mode
			get_by_id("wan_table").style.display = "none";
			get_by_id("dhcp_table").innerHTML = "DHCP Client";
			get_by_id("dhcp_display").innerHTML = dhcpc_enable;
		}else{ //router mode
			get_by_id("wan_table").style.display = "";
			get_by_id("dhcp_table").innerHTML = "DHCP Server";
			get_by_id("dhcp_display").innerHTML = dhcp_word;
		}
		
		//wireless word
		var wireless_enable = get_by_id("wlan0_enable").value;
		var wire_word = "802.11n AP Disable";
		if (wireless_enable == 1){
			wire_word = "802.11n AP Enable";
		}
		get_by_id("wireless_display").innerHTML = wire_word;
		
	}
	
		
	function dhcp_renew(){
		get_by_id("renew").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form2");
		}
	}
	
	function dhcp_release(){		
		get_by_id("release").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form3");
		}
	}
	
	function pppoe_connect(){
		get_by_id("connect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form4");
		}
	}
	
	function pppoe_disconnect(){
		get_by_id("disconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form5");
		}
	}
	
	function pptp_connect(){
		get_by_id("pptpconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form6");
		}
	}
	
	function pptp_disconnect(){
		get_by_id("pptpdisconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form7");
		}
	}
	
	function l2tp_connect(){
		get_by_id("l2tpconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form8");
		}
	}
	
	function l2tp_disconnect(){
		get_by_id("l2tpdisconnect").disabled = "true"
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form9");
		}
	}
	
	function bigpond_connect(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form10");
		}
	}
	
	function bigpond_disconnect(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form11");
		}
	}
	
	function padout(number)
		{
			return (number < 10) ? '0' + number : number;
	}

 var wTimesec, wan_time;
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	function caculate_time(){
	
		var wTime = wTimesec;
		var days = Math.floor(wTime / 86400);
			wTime %= 86400;
			var hours = Math.floor(wTime / 3600);
			wTime %= 3600;
			var mins = Math.floor(wTime / 60);
			wTime %= 60;

			wan_time = days + " " + 
				((days <= 1) 
					? "Day"
					: "Days")
				+ ", ";
			wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
		
	}

	function get_wan_time(){
		wTimesec = <% CmoGetStatus("lan_uptime"); %>;
		if(wTimesec == 0){
			wan_time = "N/A";
		}else{
			caculate_time();
		}
	}

	function WTime(){
		get_by_id("show_uptime").innerHTML = wan_time;
		if(wTimesec != 0){
			wTimesec++;
			caculate_time();
		}
		setTimeout('WTime()', 1000);
	}
	function do_renew_result(){	
		get_by_id("renew_result").style.display="";
		get_by_id("iframe_result").src="st_device_chk.asp";	
	}
	function set_iface_info(){
		var dat= get_by_id("wan_current_ipaddr").value.split("/");
		var position;
		if ((get_by_id("wan_proto").value == "pppoe" && get_by_id("wan_pppoe_russia_enable").value == "1") 
			||(get_by_id("wan_proto").value == "pptp" && get_by_id("wan_pptp_russia_enable").value == "1")
			||(get_by_id("wan_proto").value == "l2tp" && get_by_id("wan_l2tp_russia_enable").value == "1"))
			{
				if(dat[0] == "0.0.0.0"){
					dat = get_by_id("russia_wan_phy_ipaddr").value.split("/");
			}
			}
			get_by_id("wan_ip").innerHTML = dat[0];
			get_by_id("wan_netmask").innerHTML = dat[1];
			get_by_id("wan_gateway").innerHTML = dat[2];			
					  	
		if(dat[3] !="" && dat[3] !="0.0.0.0" && dat[4] !="" && dat[4] !="0.0.0.0"){
			get_by_id("wan_dns1").innerHTML = dat[3];
			get_by_id("wan_dns2").innerHTML = "," + dat[4];
		}else if(dat[3] !="" && dat[3] !="0.0.0.0"){
			get_by_id("wan_dns1").innerHTML = dat[3];
		}else if(dat[4] !="" && dat[4] !="0.0.0.0"){
			get_by_id("wan_dns2").innerHTML = dat[4];
		}else{
			get_by_id("wan_dns1").innerHTML = "0.0.0.0";
			get_by_id("wan_dns2").innerHTML = "";
		}						
	}				  
						  
	function xmldoc(){ 
	var init_status=get_by_id("connection_type").innerHTML;
	var position;
	position = get_by_id("connection_type");
	if (init_status == "")
	{
		if(get_by_id("wan_proto").value == "static"){
			position.innerHTML = "Fixed IP";
		}else if(get_by_id("wan_proto").value == "dhcpc"){
			position.innerHTML = "DHCP Client " +  " <input type=\"button\" value=\"DHCP Release\" id=\"release\" name=\"release\" onClick=\"dhcp_release()\">&nbsp;<input type=\"button\" value=\"DHCP Renew\" name=\"renew\" id=\"renew\" onClick=\"dhcp_renew()\">";		
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value != "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPPoE Disconnected " + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPPoE Disconnected " + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value != "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPTP Disconnected " + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value != "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "L2TP Disconnected " + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else if(get_by_id("wan_proto").value == "bigpond"){
			position.innerHTML = "Bigpond Client Disconnected " +  " <input type=\"button\" value=\"Bigpond Login\" name=\"bpalogin\" id=\"bpalogin\" onClick=\"bigpond_connect()\">&nbsp;<input type=\"button\" value=\"Bigpond Logout\" name=\"bpalogout\" id=\"bpalogout\" onClick=\"bigpond_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPTP Disconnected " + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia L2TP Disconnected " + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else{
			alert("connect type none");
		}
		get_by_id("wan_ip").innerHTML = "0.0.0.0";
		get_by_id("wan_netmask").innerHTML = "0.0.0.0";
		get_by_id("wan_gateway").innerHTML = "0.0.0.0";
		get_by_id("wan_dns1").innerHTML = "0.0.0.0";
		get_by_id("wan_dns2").innerHTML = " ";

	}


	if (xmlhttp.readyState == 4 && xmlhttp.status == 200){ 
		var dns1; 
		var dns2;
		//wan status		
		var fix_or_dynamic_ip ="";
		con_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue; 
	
		if(get_by_id("wan_proto").value == "static"){
			position.innerHTML = "Fixed IP";
		}else if(get_by_id("wan_proto").value == "dhcpc"){
			position.innerHTML = "DHCP Client " + con_status + " <input type=\"button\" value=\"DHCP Release\" id=\"release\" name=\"release\" onClick=\"dhcp_release()\">&nbsp;<input type=\"button\" value=\"DHCP Renew\" name=\"renew\" id=\"renew\" onClick=\"dhcp_renew()\">";		
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value != "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPPoE "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPPoE "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value != "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPTP "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value != "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "L2TP "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else if(get_by_id("wan_proto").value == "bigpond"){
			position.innerHTML = "Bigpond Client " + con_status + " <input type=\"button\" value=\"Bigpond Login\" id=\"bpalogin\" name=\"bpalogin\" onClick=\"bigpond_connect()\">&nbsp;<input type=\"button\" value=\"Bigpond Logout\" name=\"bpalogout\" id=\"bpalogout\" onClick=\"bigpond_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPTP "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia L2TP "+ fix_or_dynamic_ip + con_status + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else{
			alert("connect type none");
		}

		//Check is wan current IP or russia phyical IP:2008/08/27 GraceYang
		var dat = get_by_id("wan_current_ipaddr").value.split("/");
				if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1"))
			{	
					if(dat[0] == "0.0.0.0")
					{
					var temp_russia_wan_phy_ipaddr = get_by_id("russia_wan_phy_ipaddr").value.split("/");
					get_by_id("wan_ip").innerHTML = temp_russia_wan_phy_ipaddr[0];
					get_by_id("wan_netmask").innerHTML = temp_russia_wan_phy_ipaddr[1];
					get_by_id("wan_gateway").innerHTML = temp_russia_wan_phy_ipaddr[2];			
					get_by_id("wan_dns1").innerHTML = temp_russia_wan_phy_ipaddr[3];
						if(temp_russia_wan_phy_ipaddr[4])
						get_by_id("wan_dns2").innerHTML = ","+temp_russia_wan_phy_ipaddr[4];
					else
						get_by_id("wan_dns2").innerHTML = "";
			}
				else{
						var temp_wan_current_ipaddr = get_by_id("wan_current_ipaddr").value.split("/");
						get_by_id("wan_ip").innerHTML = temp_wan_current_ipaddr[0];
						get_by_id("wan_netmask").innerHTML = temp_wan_current_ipaddr[1];
						get_by_id("wan_gateway").innerHTML = temp_wan_current_ipaddr[2];			
						get_by_id("wan_dns1").innerHTML = temp_wan_current_ipaddr[3];
						if(temp_wan_current_ipaddr[4])
						get_by_id("wan_dns2").innerHTML = ","+temp_wan_current_ipaddr[4];
						else
						get_by_id("wan_dns2").innerHTML = "";
					
			}
					}
						
			if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1"))
					{
					if(dat[0] == "0.0.0.0")
					{       get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_ip")[0].firstChild.nodeValue; 	
							get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_netmask")[0].firstChild.nodeValue;		
							get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_default_gateway")[0].firstChild.nodeValue;
							dns1 =  get_by_id("wan_dns1");
							dns1_value =xmlhttp.responseXML.getElementsByTagName("phy_wan_primary_dns")[0].firstChild.nodeValue;
							dns2 =  get_by_id("wan_dns2");
							dns2_value =xmlhttp.responseXML.getElementsByTagName("phy_wan_secondary_dns")[0].firstChild.nodeValue;						
							//alert("0dns1"+dns1_value);
							//alert("0dns2"+dns2_value);
							if (dns1_value == "(null)" ){
								dns1_value=" ";
								dns1.innerHTML = dns1_value;
							}else{
								dns1.innerHTML = dns1_value;
			}
							if (dns2_value == "(null)" ){
								dns2_value=" ";
								dns2.innerHTML = dns2_value;
							}else{
								dns2.innerHTML = dns2_value;
			}
							//alert("0dns11"+dns1_value);
							//alert("0dns21"+dns2_value);
							if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = ","+dns2_value ;
							}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
								dns1.innerHTML = dns1_value;
								dns2.innerHTML = " ";
							}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
								dns2.innerHTML = dns2_value;
							}else{
								dns1.innerHTML = "0.0.0.0";
								dns2.innerHTML = " ";
							}
						}else{
					get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue; 	
					get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;		
					get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
							dns1 =  get_by_id("wan_dns1");
							dns1_value =xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
							dns2 =  get_by_id("wan_dns2");
							dns2_value =xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
							//alert("1dns1"+dns1_value);
							//alert("1dns2"+dns2_value);
							if (dns1_value == "(null)" ){
								dns1_value=" ";
								dns1.innerHTML = dns1_value;
							}else{
								dns1.innerHTML = dns1_value;
							}
							if (dns2_value == "(null)" ){
								dns2_value=" ";
								dns2.innerHTML = dns2_value;
							}else{
								dns2.innerHTML = dns2_value;
							}
							//alert("1dns11"+dns1_value);
							//alert("1dns21"+dns2_value);
							if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = ","+dns2_value ;
							}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
								dns1.innerHTML = dns1_value;
								dns2.innerHTML = " ";
							}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
								dns2.innerHTML = dns2_value;
							}else{
								dns1.innerHTML = "0.0.0.0";
								dns2.innerHTML = " ";
							}
						}
					}else{
							get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue; 	
							get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;		
							get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
					dns1 =  get_by_id("wan_dns1");
					dns1_value =xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
					dns2 =  get_by_id("wan_dns2");
					dns2_value =xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
					//alert("3dns1"+dns1_value);
					//alert("4dns2"+dns2_value);	
							if (dns1_value == "(null)" ){
						dns1_value=" ";
					dns1.innerHTML = dns1_value;
							}else{
							dns1.innerHTML = dns1_value;
					}
							if (dns2_value == "(null)" ){
						dns2_value=" ";
						dns2.innerHTML = dns2_value;
							}else{
							dns2.innerHTML = dns2_value;
					}
					//alert("3dns11"+dns1_value);
					//alert("3dns21"+dns2_value);	
					if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
						dns1.innerHTML = dns1_value ;
						dns2.innerHTML = ","+dns2_value ;
					}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
						dns1.innerHTML = dns1_value;
						dns2.innerHTML = " ";
					}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
						dns2.innerHTML = dns2_value;
				}else{
						dns1.innerHTML = "0.0.0.0";
						dns2.innerHTML = " ";
				}		
			}

		//wlan status
			position =  get_by_id("wlan_channel");
			value = xmlhttp.responseXML.getElementsByTagName("wlan_channel")[0].firstChild.nodeValue;
		if(value !="(null)" )
			position.innerHTML = value;
		else
			position.innerHTML = " ";
	}
}
	
	function get_File() {
		xmlhttp = createRequest(); 
		var url;
		var lan_ip="<% CmoGetCfg("lan_ipaddr","none"); %>";
		var temp_cURL = document.URL.split("/");
		var mURL = temp_cURL[2];
		if(xmlhttp){
			if(mURL == lan_ip){
						url="http://"+lan_ip+"/device.xml=device_status";
				}else{
						url="http://"+mURL+"/device.xml=device_status";
				}
			
		xmlhttp.onreadystatechange = xmldoc; 
		xmlhttp.open("GET", url, true); 
		xmlhttp.send(null); 
		}
		setTimeout("get_File()",3000);
	}
	
	
	function createRequest() {
		var XMLhttpObject = null;
		try {
			XMLhttpObject = new XMLHttpRequest();
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {
			return null;
		}
		}
	}
		return XMLhttpObject;
	}			  
						  
</script>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif');show_wan_table();">
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
              <td><a href="status.asp"><img src="but_status_1.gif" name="Image1" width="144" height="28" border="0" id="Image1" onMouseOver="MM_swapImage('Image1','','but_status_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellpadding="2" class="submenubg">
                <tr>
                  <td width="13%" align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td width="87%"><a href="status.asp" class="submenus"><b><u>Device Information</u> </b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="log.asp" class="submenus"><b>Log</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="log_setting.asp" class="submenus"><b>Log Setting </b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="statistic.asp" class="submenus"><b>Statistic</b></a></td>
                </tr>
                <tr>
                  <td align="right"><font color="#FFFFFF">&bull;</font></td>
                  <td><a href="wla_conn.asp" class="submenus"><b>Wireless</b></a></td>
                </tr>
              </table></td>
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
          </table>
          <td width="2%"><img src="spacer.gif" width="15" height="15"></td>
          <td width="78%" valign="top">
          	<table width="100%" border="0" cellpadding="0" cellspacing="0">
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
                      <td width="85%" class="headerbg">Device Information </td>
                      <td width="15%" class="headerbg"><a href="help_status.asp#status_device_info" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    </tr>
                  </table>
                    <form id="form1" name="form1" method="post" action="status.cgi">
                    <input type="hidden" name="html_response_page" value="back.asp">
                    <input type="hidden" name="html_response_message" value="The setting is saved.">
                    <input type="hidden" name="html_response_return_page" value="status.asp">
                    
                    <input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
                    <input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("wan_proto","none"); %>">
                    <input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>">
                    <input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<% CmoGetCfg("wan_pptp_dynamic","none"); %>">
                    <input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>">
                    <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("dhcpd_enable","none"); %>">
                    <input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<% CmoGetCfg("wlan0_enable","none"); %>">
                    <input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>">
				    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
				    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
                    <input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<% CmoGetStatus("wan_pptp_ipaddr"); %>"> 
                    <input type="hidden" id="russia_wan_phy_ipaddr" name="russia_wan_phy_ipaddr" value="<% CmoGetStatus("russia_wan_phy_ipaddr"); %>">
                    
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td colspan="2" bgcolor="#FFFFFF"><span class="bluetextbold3">Firmware Version:
                            <% CmoGetStatus("version"); %>.<% CmoGetStatus("build"); %>
                            </span></td>
                        </tr>
						<td colspan="1" bgcolor="#FFFFFF"><span class="bluetextbold3">router up time :&nbsp;&nbsp;<span id="show_uptime"></span></span></td>
                    </table>
                      <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF" id="wan_table">                       
                        <tr>
                          <td colspan="2" class="greybluebg">WAN</td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">MAC
                            Address</td>
                          <td width="78%" class="bggrey"><font face="Arial"  size="2">
                            <% CmoGetCfg("wan_mac","none"); %>
                          </font> </td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Connection</td>
                          <td width="78%" class="bggrey"><span id="connection_type"></span>
                          <span id="network_status"></span>
                          
                          

                        <tr>
                          <td width="22%" align="right" class="bgblue">IP</td>
                          <td width="78%" class="bggrey">
                          <span id="wan_ip"></span>                          
                          </td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Subnet Mask</td>
                          <td width="78%" class="bggrey">
                          <span id="wan_netmask"></span>
                          </td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Default Gateway</td>
                          <td width="78%" class="bggrey">
                          <span id="wan_gateway"></span>
                          </td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">DNS</td>
                          <td width="78%" class="bggrey">
                          <span id="wan_dns1"></span>
                          <span id="wan_dns2">&nbsp;</span>
                          </td>
                        </tr>
                      </table>
                      
                      <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td colspan="2" class="greybluebg">Wireless</td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Connection</td>
                          <td width="78%" class="bggrey"><font face="Arial" size="2">
                            <span id="wireless_display"></span>
                          </font> </td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">SSID</td>
                          <td width="78%" class="bggrey"><% CmoGetCfg("wlan0_ssid","none"); %></td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Channel</td>
                          <td width="78%" class="bggrey"><span id="wlan_channel"></span></td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Authentication</td>
                          <td width="78%" class="bggrey">
                          	 <script>
								var security= "<% CmoGetCfg("wlan0_security","none"); %>";
                          		if(security == "wep_open_64"){
									document.write("WEP");
								}else if(security == "wep_open_128"){
									document.write("WEP");		
								}else if(security == "wep_share_64"){
									document.write("WEP");		
								}else if(security == "wep_share_128"){
									document.write("WEP");		
								}else if(security == "wpa_psk"){
									document.write("WPA-PSK");		
								}else if(security == "wpa2_psk"){
									document.write("WPA2-PSK");			
								}else if(security == "wpa2auto_psk"){
									document.write("WPA|AUTO-PSK");			
								}else if(security == "wpa_eap"){
									document.write("WPA-EAP");			
								}else if(security == "wpa2_eap"){
									document.write("WPA2-EAP");			
								}else if(security == "wpa2auto_eap"){
									document.write("WPA|AUTO-EAP");			
								}else if(security == "disable"){
										document.write("Disable");		
							}		
                          
                            </script>
                          
                          </td>
                        </tr>
                      </table>
                      <table width="100%" height="128" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                        <tr>
                          <td colspan="2" class="greybluebg">LAN</td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">MAC
                            Address</td>
                          <td width="78%" class="bggrey"><% CmoGetCfg("lan_mac","none"); %></td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">IP
                            Address</td>
                          <td width="78%" class="bggrey"><% CmoGetCfg("lan_ipaddr","none"); %></td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">Subnet Mask</td>
                          <td width="78%" class="bggrey"><% CmoGetCfg("lan_netmask","none"); %></td>
                        </tr>
                        <tr>
                          <td width="22%" align="right" class="bgblue">
						  	<span id="dhcp_table"> DHCP Server</span>
						  </td>
                          <td width="78%" class="bggrey">
                            <span id="dhcp_display"></span>&nbsp; <a href="lan.asp">DHCP Table</a></td>
                        </tr>
                      </table>
                    </form>
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
      <img src="spacer.gif" width="15" height="15"><br>
	</td>
    <td background="bg1_r.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="c1_bl.gif" width="21" height="20"></td>
    <td align="right" background="bg1_b.gif"><img src="copyright.gif" width="264" height="20"></td>
    <td><img src="c1_br.gif" width="21" height="20"></td>
  </tr>
</table>
<form id="form2" name="form2" method="post" action="dhcp_renew.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form3" name="form3" method="post" action="dhcp_release.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form4" name="form4" method="post" action="pppoe_00_connect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form5" name="form5" method="post" action="pppoe_00_disconnect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form6" name="form6" method="post" action="pptp_connect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form7" name="form7" method="post" action="pptp_disconnect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form8" name="form8" method="post" action="l2tp_connect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form9" name="form9" method="post" action="l2tp_disconnect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form10" name="form10" method="post" action="bigpond_connect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
<form id="form11" name="form11" method="post" action="bigpond_disconnect.cgi"><input type="hidden" name="html_response_page" value="status.asp"><input type="hidden" name="html_response_return_page" value="status.asp"></form>
</body>
<script>
	get_wan_time();
	WTime();
	//set_iface_info();
	get_File();
	//setTimeout('do_renew_result();',2000);
</script>
</html>
