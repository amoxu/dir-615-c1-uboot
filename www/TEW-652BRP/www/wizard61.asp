<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		//wep_key_len-->0-->5,1-->13
		var wlan0_security = get_by_id("asp_temp_52").value;
		set_checked("open",get_by_name("auth_type"));
		//set_checked("psk",get_by_name("eap_type"));
		if(wlan0_security == "disable"){
			set_selectIndex(0,get_by_id("wep_type"));
		}else if(wlan0_security == "wep_open_64"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("open",get_by_name("auth_type"));
			set_selectIndex(5,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_open_128"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("open",get_by_name("auth_type"));
			set_selectIndex(13,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_share_64"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("share",get_by_name("auth_type"));
			set_selectIndex(5,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wep_share_128"){
			set_selectIndex(1,get_by_id("wep_type"));
			set_checked("share",get_by_name("auth_type"));
			set_selectIndex(13,get_by_id("wep_key_len"));
		}else if(wlan0_security == "wpa_psk"){
			set_selectIndex(2,get_by_id("wep_type"));
			//set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa_eap"){
			set_selectIndex(2,get_by_id("wep_type"));
			//set_checked("eap",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2_psk"){
			set_selectIndex(3,get_by_id("wep_type"));
			//set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2_eap"){
			set_selectIndex(3,get_by_id("wep_type"));
			//set_checked("eap",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2auto_psk"){
			set_selectIndex(4,get_by_id("wep_type"));
			//set_checked("psk",get_by_name("eap_type"));
		}else if(wlan0_security == "wpa2auto_eap"){
			set_selectIndex(4,get_by_id("wep_type"));
			//set_checked("eap",get_by_name("eap_type"));
		}
				
		 set_selectIndex("<% CmoGetCfg("asp_temp_wep_display","none"); %>", get_by_id("wep_display"));
		/*set_checked("<% CmoGetCfg("wep_default_key","none"); %>", get_by_name("wep_default_key"));*/
		set_checked("1", get_by_name("wep_default_key"));
		set_checked("<% CmoGetCfg("asp_temp_55","none"); %>", get_by_name("psk_cipher_type"));

		/* //eap
		var temp_r0 = get_by_id("wlan0_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		if(Dr0.length>1){
			get_by_id("radius_ip1").value=Dr0[0];
			get_by_id("radius_port1").value=Dr0[1];
			get_by_id("radius_pass1").value=Dr0[2];
		}
		
		var temp_r1 = get_by_id("wlan0_eap_radius_server_1").value;
		var Dr1 = temp_r1.split("/");
		if(Dr1.length>1){
			get_by_id("radius_ip2").value=Dr1[0];
			get_by_id("radius_port2").value=Dr1[1];
			get_by_id("radius_pass2").value=Dr1[2];
		}
		*/
		change_wep_key_fun();
		
		show_authentication();
	}
	
	function change_wep_key_fun(){
		
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var key_type = get_by_id("wep_display").value;
				
		get_by_id("key1_64_ascii").style.display = "none";
		get_by_id("set_key1_64_ascii").style.display = "none";
		//get_by_id("key2_64_ascii").style.display = "none";
		//get_by_id("key3_64_ascii").style.display = "none";
		//get_by_id("key4_64_ascii").style.display = "none";
		get_by_id("key1_128_ascii").style.display = "none";
		get_by_id("set_key1_128_ascii").style.display = "none";
		//get_by_id("key2_128_ascii").style.display = "none";
		//get_by_id("key3_128_ascii").style.display = "none";
		//get_by_id("key4_128_ascii").style.display = "none";
		get_by_id("key1_64_hex").style.display = "none";
		get_by_id("set_key1_64_hex").style.display = "none";
		//get_by_id("key2_64_hex").style.display = "none";
		//get_by_id("key3_64_hex").style.display = "none";
		//get_by_id("key4_64_hex").style.display = "none";
		get_by_id("key1_128_hex").style.display = "none";
		get_by_id("set_key1_128_hex").style.display = "none";
		//get_by_id("key2_128_hex").style.display = "none";
		//get_by_id("key3_128_hex").style.display = "none";
		//get_by_id("key4_128_hex").style.display = "none";
		
		get_by_id("key1_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		get_by_id("set_key1_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		//get_by_id("key2_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		//get_by_id("key3_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
		//get_by_id("key4_"+ key_num_array[key_length] +"_"+ key_type).style.display = "";
	}
	
	function show_wpa_settings(){
		//var eap_type = get_by_name("eap_type");
		
		get_by_id("show_wpa_psk").style.display = "none";
		//get_by_id("show_wpa_eap").style.display = "none";
		
		//if (eap_type[0].checked){
			get_by_id("show_wpa_psk").style.display = "";
		//}else if (eap_type[1].checked){
			//get_by_id("show_wpa_eap").style.display = "";
		//}
	}
	
	function show_authentication(){
		var wep_type = get_by_id("wep_type");
		
		get_by_id("setting_wep").style.display = "none";
		get_by_id("setting_wpa").style.display = "none";
		
		if (wep_type.selectedIndex == 1){
			get_by_id("setting_wep").style.display = "";
		}else if (wep_type.selectedIndex > 1){
			get_by_id("setting_wpa").style.display = "";
			show_wpa_settings();
		}
	}

	function check_wpa_psk(){
		var psk1_value = get_by_id("wpapsk1").value;
		var psk2_value = get_by_id("wpapsk2").value;

		if (psk1_value != psk2_value){	// when the Passphrase does not match the Confirmed Passphrase
			alert(msg[MSG11]);
			return false;
		}else if (psk1_value.length < 8){	// when the length of the Passpharse is less than 8 characters
			alert(msg[MSG12]);
			
			return false;
		}else if (psk1_value.length > 64){
			alert(msg[MSG12]);
			get_by_id("wpapsk1").value = psk1_value.substring(0, 64);
		}
		get_by_id("asp_temp_56").value = get_by_id("wpapsk1").value;		
		return true;
	}
	
	/*
	function check_wpa_eap(){
		var ip1 = get_by_id("radius_ip1").value;
    	var ip2 = get_by_id("radius_ip2").value;
    	
    	var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
    	
    	var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
        var temp_radius1 = new raidus_obj(temp_ip1, get_by_id("radius_port1").value, get_by_id("radius_pass1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, get_by_id("radius_port2").value, get_by_id("radius_pass2").value);
        
        
        if (!check_radius(temp_radius1)){
    		return false;        	               
    	}else if (ip2 != "" && ip2 != "0.0.0.0"){
    		if (!check_radius(temp_radius2)){
    			return false;        	               
    		}
    	}	
    	
    	return true;	
	}
	*/
	
	function check_wpa_settings(){
		//var eap_type = get_by_name("eap_type");
		
		//if (eap_type[0].checked){
			return check_wpa_psk();
		//}else if (eap_type[1].checked){
			//return check_wpa_eap();
		//}
	}
	
	function get_wizard_length(){
    	var wep_key_len = get_by_id("wep_key_len");
    	var wep_key_type = get_by_id("wep_display"); 
    	    	 
		var length = parseInt(wep_key_len.value);
		
		if (wep_key_type.value == "hex"){
	    	length *= 2;
		}
		return length;
	}
	
	function check_wizard_wep_key(){            	                        	
		var length = get_wizard_length();	
		var wep_def_key = get_by_name("wep_default_key");
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var wep_key_type = get_by_id("wep_display").value;
		var key_len_msg;
	
		//for (var i = 1; i < 5; i++){	
		for (var i = 1; i < 2; i++){							
	    	var key = get_by_id("key" + i +"_"+ key_num_array[key_length] +"_"+ wep_key_type).value;

	    	if (wep_def_key[i-1].checked){
	        	if (key == ''){
	            	alert(msg[MSG10]);
		        	return false;
	        	}
	    	}
	    
	    	key_len_msg = get_key_len_msg(i);
	    	    
        	if (key != ''){
            	if (key.length < length){
                	alert(show_key_len_error(key_len_msg, length));
                	return false;
            	}else{
            		if (wep_key_type == "hex"){	// check the key is hex or not
	            		for (var j = 0; j < key.length; j++){
	            			if (!check_hex(key.substring(j, j+1))){
	            				alert(illegal_key_error[i-1]);
	            				return false;
	            			}
	            		}
	            	}
            	}
        	}           	  
		}                	                	
	
		return true;
	}
	
	function send_request(){
		var security_array = new Array("disable", "wep", "wpa", "wpa2","wpa2auto");
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var wep_type = get_by_id("wep_type");
		var is_submit = false;

		if (wep_type.selectedIndex == 0){//disable
			get_by_id("asp_temp_52").value = "disable";
			get_by_id("asp_temp_54").value="<% CmoGetCfg("wlan0_wep_default_key","none"); %>";
			is_submit = true;
		}else if (wep_type.selectedIndex == 1){//wep
			if (check_wizard_wep_key()){
				get_by_id("asp_temp_52").value = "wep_"+ get_checked_value(get_by_name("auth_type")) +"_"+ key_num_array[key_length];
				//get_by_id("wlan0_security").value = get_by_id("asp_temp_52").value;
				send_key_value(key_num_array[key_length]);
				get_by_id("asp_temp_wep_display").value = get_by_id("wep_display").value;
				get_by_id("asp_temp_54").value = "1";
				is_submit = true;
			}
			if (get_checked_value(get_by_name("auth_type"))== "share"){
				//wps_enable 
				if (get_by_id("asp_temp_51").value==1)
				{
					if(confirm("The Shared Key cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
						get_by_id("asp_temp_51").value = 0;
					}else{
						is_submit = false;
					}
				}
			}
			
		}else if (wep_type.selectedIndex > 1){//wpa
				if (check_wpa_settings()){
					is_submit = true;
					//get_by_id("asp_temp_52").value = security_array[wep_type.selectedIndex] +"_"+ pskget_checked_value(get_by_name("eap_type"));
					get_by_id("asp_temp_52").value = security_array[wep_type.selectedIndex] +"_"+ "psk";
					get_by_id("asp_temp_55").value = get_checked_value(get_by_name("psk_cipher_type"));
					get_by_id("asp_temp_54").value="<% CmoGetCfg("wlan0_wep_default_key","none"); %>";
					/* //eap
					if(get_checked_value(get_by_name("eap_type")) == "eap"){
						var r_ip_0 = get_by_id("radius_ip1").value;
						var r_port_0 = get_by_id("radius_port1").value;
						var r_pass_0 = get_by_id("radius_pass1").value;
						var dat0 = r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
						get_by_id("wlan0_eap_radius_server_0").value = dat0;

						var r_ip_1 = get_by_id("radius_ip2").value;
						var r_port_1 = get_by_id("radius_port2").value;
						var r_pass_1 = get_by_id("radius_pass2").value;
						var dat1 = r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
						get_by_id("wlan0_eap_radius_server_1").value = dat1;
						if(confirm("The EAP Authentication cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
							get_by_id("asp_temp_51").value = 0;
						}else{
							is_submit = false;
						}
						
					}
					*/
					//check if cipher auto is checked, that will close wps function. 
					//if(get_checked_value(get_by_name("asp_temp_55")) == "both"){
					//	if(confirm("The Auto Cipher Type cannot be supported by WPS. Use this configuration will cause WPS be disabled. Are you sure you want to continue with the new setting?")){
					//		get_by_id("asp_temp_51").value = 0;
					//	}else{
					//		is_submit = false;
					//	}
				    //}
				}				
		}else{
			send_key_value(key_num_array[key_length]);
		}
		
		if (get_by_id("asp_temp_52").value != "disable" ){
        	get_by_id("asp_temp_50").value = 5;
        } 
        else{
        	get_by_id("asp_temp_50").value = 1;
        }	          		
				
		if (is_submit){
			send_submit("form1");
		}
	}
	
	function send_key_value(key_length){
		var key_type = get_by_id("wep_display").value;
		
		//get_by_id("wlan0_wep"+ key_length +"_key_1").value = get_by_id("key1_"+ key_length +"_"+ key_type).value;
		//get_by_id("wlan0_wep"+ key_length +"_key_2").value = get_by_id("key2_"+ key_length +"_"+ key_type).value;
		//get_by_id("wlan0_wep"+ key_length +"_key_3").value = get_by_id("key3_"+ key_length +"_"+ key_type).value;
		//get_by_id("wlan0_wep"+ key_length +"_key_4").value = get_by_id("key4_"+ key_length +"_"+ key_type).value;
		//asp_temp_wep64_key_1 and asp_temp_wep128_key_1
		//alert("asp_temp_wep"+ key_length +"_key_1");
		get_by_id("asp_temp_wep"+ key_length +"_key_1").value = get_by_id("key1_"+ key_length +"_"+ key_type).value;
		//alert(get_by_id("asp_temp_wep"+ key_length +"_key_1").value);
		//get_by_id("asp_temp_wep"+ key_length +"_key_2").value = get_by_id("key2_"+ key_length +"_"+ key_type).value;
		//get_by_id("asp_temp_wep"+ key_length +"_key_3").value = get_by_id("key3_"+ key_length +"_"+ key_type).value;
		//get_by_id("asp_temp_wep"+ key_length +"_key_4").value = get_by_id("key4_"+ key_length +"_"+ key_type).value;
	}
	
	function check_radio(){
		var tmp_wps_enable = get_by_id("asp_temp_51").value;
	
   		for ( counter = 0; counter < document.getElementsByName("wep_default_key").length; counter++ ) {
      		if (tmp_wps_enable == 1)
      		{
      			if (document.getElementsByName("wep_default_key")[0].checked != true)
      			{
      				alert("You can't choose other key when WPS enable");
      				set_checked("1",get_by_name("wep_default_key"));
				}      
      		}
   		}
   	}
   		
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0">
<table width="459" height="324" border="0" cellpadding="0" cellspacing="0" bgcolor="334255">
    <tr>
      <td height="49"><img src="bg_wizard_2.gif" width="459" height="49"></td>
    </tr>
    <tr>
      <td valign="top" background="bg_wizard_3.gif"><table width="459" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="3"><img src="spacer.gif" width="30" height="10"></td>
          </tr>
          <tr>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
            <td width="86%" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="headerbg">Set Wireless Security</td>
              </tr>              
            </table>
              <form name="form1" id="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard7.asp">
	  			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard6.asp">
	  			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	  			<!-- wps_configured_mode -->
	  			<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<% CmoGetCfg("asp_temp_50","none"); %>">
				<!-- wps_enable -->
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("asp_temp_51","none"); %>">
				<!-- wlan0_security -->
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<% CmoGetCfg("asp_temp_52","none"); %>">
				<!--input type="hidden" id="wlan0_security" name="wlan0_security" value="<% CmoGetCfg("asp_temp_52","none"); %>"-->
				<!-- wlan0_wep_display -->
				<input type="hidden" id="asp_temp_wep_display" name="asp_temp_wep_display" value="<% CmoGetCfg("asp_temp_wep_display","none"); %>">
				<!-- wlan0_wep_default_key -->
				<input type="hidden" id="asp_temp_54" name="asp_temp_54" value="<% CmoGetCfg("asp_temp_54","none"); %>">
				<!-- wlan0_wep64_key_1 or wlan0_wep128_key_1 -->
				<input type="hidden" id="asp_temp_wep64_key_1" name="asp_temp_wep64_key_1" value="">
				<input type="hidden" id="asp_temp_wep128_key_1" name="asp_temp_wep128_key_1" value="">
				<!-- wlan0_psk_cipher_type -->
				<input type="hidden" id="asp_temp_55" name="asp_temp_55" value="<% CmoGetCfg("asp_temp_55","none"); %>">
				<!-- wlan0_psk_pass_phrase -->
				<input type="hidden" id="asp_temp_56" name="asp_temp_56" value="<% CmoGetCfg("asp_temp_56","none"); %>">
                
                
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                  <tr>
                     <td width="148" align="right" class="bgblue">Authentication Type</td>
                     <td width="251" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">
                     <select id="wep_type" name="wep_type" onChange="show_authentication()">
                     <option value="0"> Disable </option>
                     <option value="1"> WEP </option>
                     <option value="2"> WPA </option>
                     <option value="3"> WPA2 </option>
					 <option value="4"> WPA-AUTO </option>                           
                     </select>
                     </font></td>
                  </tr>
                  <tr id="setting_wep" style="display:none">
                     <td colspan="2">
                     <table width="100%" border="0" cellpadding="0" cellspacing="1">
                     <tr bgcolor="#CCCCCC">
                       <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">WEP&nbsp;</font></td>
                       <td width="70%" class="bggrey"><font face="Arial" size="2"><b>
                       <input type=radio name="auth_type" value="open">
                       Open System
                       <input type=radio name="auth_type" value="share">
                       Shared Key</b> </font></td>
                      </tr>
                      <tr bgcolor="#CCCCCC">
                        <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"> <font face="Arial">Mode&nbsp;</font></td>
                        <td width="70%" class="bggrey">
                       	<select id="wep_display" name="wep_display" onChange="change_wep_key_fun()">
                        <option value="hex">HEX</option>
                        <option value="ascii">ASCII</option>
                        </select>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC">
                        <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">WEP Key&nbsp;</font></td>
                        <td width="70%" class="bggrey"><font face="Arial" size="2">
                        <select size="1" name="wep_key_len" id="wep_key_len" onChange="change_wep_key_fun();">
                        <option value="5">64-bit</option>
						<option value="13">128-bit</option>						             
                        </select>
                      	</font></td>
                       </tr>
                       <tr bgcolor="#CCCCCC">
                         <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 1&nbsp;</font></td>
                         <td width="70%" class="bggrey">
                       	 <input type="radio" value="1" name="wep_default_key" onclick="check_radio()">                    
                         <input type="text" id="key1_64_hex" name="key1_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("asp_temp_wep64_key_1","hex"); %>" style="display:none "><font id="set_key1_64_hex" face="Arial" style="display:none ">(Maximum number of characters is 10)</font>
                         <input type="text" id="key1_128_hex" name="key1_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("asp_temp_wep128_key_1","hex"); %>" style="display:none "><font id="set_key1_128_hex" face="Arial" style="display:none ">(Maximum number of characters is 26)</font>
                         <input type="text" id="key1_64_ascii" name="key1_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("asp_temp_wep64_key_1","ascii"); %>" style="display:none "><font id="set_key1_64_ascii" face="Arial" style="display:none ">(Maximum number of characters is 5)</font>
                         <input type="text" id="key1_128_ascii" name="key1_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("asp_temp_wep128_key_1","ascii"); %>" style="display:none "><font id="set_key1_128_ascii" face="Arial" style="display:none ">(Maximum number of characters is 13)</font>
						 <!--input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1" value="<% CmoGetCfg("wlan0_wep64_key_1","hex"); %>"-->
						 <!--input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1" value="<% CmoGetCfg("wlan0_wep128_key_1","hex"); %>"-->
	                     </td>
                       </tr>
                       <tr bgcolor="#CCCCCC" style="display:none">
                         <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 2&nbsp;</font></td>
                         <td width="70%" class="bggrey">
                       	 <input type="radio" value="2" name="wep_default_key" onclick="check_radio()">                    
                         <input type="text" id="key2_64_hex" name="key2_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("asp_temp_wep64_key_2","hex"); %>" style="display:none "><input type="text" id="key2_128_hex" name="key2_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("asp_temp_wep128_key_2","hex"); %>" style="display:none "><input type="text" id="key2_64_ascii" name="key2_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("asp_temp_wep64_key_2","ascii"); %>" style="display:none "><input type="text" id="key2_128_ascii" name="key2_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("asp_temp_wep128_key_2","ascii"); %>" style="display:none ">
						 <!--input type="hidden" id="wlan0_wep64_key_2" name="wlan0_wep64_key_2" value="<% CmoGetCfg("wlan0_wep64_key_2","hex"); %>"-->
						 <!--input type="hidden" id="wlan0_wep128_key_2" name="wlan0_wep128_key_2" value="<% CmoGetCfg("wlan0_wep128_key_2","hex"); %>"-->
	                     </td>
                       </tr>
                       <tr bgcolor="#CCCCCC" style="display:none">
                         <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 3&nbsp;</font></td>
                         <td width="70%" class="bggrey">
                       	 <input type="radio" value="3" name="wep_default_key" onclick="check_radio()">                    
	                     <input type="text" id="key3_64_hex" name="key3_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("asp_temp_wep64_key_3","hex"); %>" style="display:none "><input type="text" id="key3_128_hex" name="key3_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("asp_temp_wep128_key_3","hex"); %>" style="display:none "><input type="text" id="key3_64_ascii" name="key3_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("asp_temp_wep64_key_3","ascii"); %>" style="display:none "><input type="text" id="key3_128_ascii" name="key3_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("asp_temp_wep128_key_3","ascii"); %>" style="display:none ">
						 <!--input type="hidden" id="wlan0_wep64_key_3" name="wlan0_wep64_key_3" value="<% CmoGetCfg("wlan0_wep64_key_3","hex"); %>"-->
						 <!--input type="hidden" id="wlan0_wep128_key_3" name="wlan0_wep128_key_3" value="<% CmoGetCfg("wlan0_wep128_key_3","hex"); %>"-->
	                     </td>
                       </tr>
                       <tr bgcolor="#CCCCCC" style="display:none">
                         <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Key 4&nbsp;</font></td>
                         <td width="70%" class="bggrey">
                         <input type="radio" value="4" name="wep_default_key" onclick="check_radio()">                    
	                     <input type="text" id="key4_64_hex" name="key4_64_hex" maxlength="10" size="15" value="<% CmoGetCfg("asp_temp_wep64_key_4","hex"); %>" style="display:none "><input type="text" id="key4_128_hex" name="key4_128_hex" maxlength="26" size="31" value="<% CmoGetCfg("asp_temp_wep128_key_4","hex"); %>" style="display:none "><input type="text" id="key4_64_ascii" name="key4_64_ascii" maxlength="5" size="10" value="<% CmoGetCfg("asp_temp_wep64_key_4","ascii"); %>" style="display:none "><input type="text" id="key4_128_ascii" name="key4_128_ascii" maxlength="13" size="18" value="<% CmoGetCfg("asp_temp_wep128_key_4","ascii"); %>" style="display:none ">
						 <!--input type="hidden" id="wlan0_wep64_key_4" name="wlan0_wep64_key_4" value="<% CmoGetCfg("wlan0_wep64_key_4","hex"); %>"-->
						 <!--input type="hidden" id="wlan0_wep128_key_4" name="wlan0_wep128_key_4" value="<% CmoGetCfg("wlan0_wep128_key_4","hex"); %>"-->
	                     </td>
                       </tr>
                     </table></td>
                  </tr>
                  <tr id="setting_wpa" style="display:none">
                      <td colspan="2">
          			  <table width="100%" border="0" cellpadding="0" cellspacing="1">
          				<!--tr>
                          	<td width="30%" align="right" class="bgblue">PSK / EAP</td>
                          	<td width="70%" class="bggrey"><font size="2"><b>
                            <input name="eap_type" type="radio" value="psk" onClick="show_wpa_settings()">
                            PSK
                            <input name="eap_type" type="radio" value="eap" onClick="show_wpa_settings()">
                            EAP </b></font>
                            </td>
                        </tr-->
                        <tr>
                          	<td width="30%" align="right" class="bgblue">Cipher Type</td>
                          	<td width="70%" class="bggrey"><font size="2"><b>
                            <input name="psk_cipher_type" type="radio" value="tkip">
                            TKIP
                            <input name="psk_cipher_type" type="radio" value="aes">
                            AES
                            <input name="psk_cipher_type" type="radio" value="both">
                            Auto
                            </b></font>
                            </td>
                        </tr>
                        <tr id="show_wpa_psk" style="display:none">
                          	<td colspan="2">
                          	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                            <tr bgcolor="#CCCCCC">
                            <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Passphrase :</font></td>
                            <td width="70%" class="bggrey"><input type="password" id="wpapsk1" name="wpapsk1" size="30" maxlength="64" value="<% CmoGetCfg("asp_temp_56","none"); %>"><font face="Arial">(Maximum number of characters is 40)</font></td>
                            </tr>
                            <tr bgcolor="#CCCCCC">
                            <td width="30%" align="right" bgcolor="#CCCCCC" class="bgblue"><font face="Arial">Confirmed Passphrase :</font></td>
                            <td width="70%" class="bggrey"><input type="password" name="wpapsk2" id="wpapsk2" size="30" maxlength="64" value="<% CmoGetCfg("asp_temp_56","none"); %>"><font face="Arial">(Maximum number of characters is 40)</font></td>
                            </tr>
                          	</table>
                          	</td>
                        </tr>
                        <!--tr id="show_wpa_eap" style="display:none">
                          	<td colspan="2">
						  	<table width="100%" border="0" cellpadding="0" cellspacing="1">                              					
                            <tr>
                            <td width="34%" rowspan="3" align="right" valign="top" class="bgblue"> RADIUS Server 1</td>
                            <td width="8%" height="2" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" size="2">IP</font></td>
                            <td width="58%" height="2" bgcolor="#FFFFFF" class="bggrey"><input id="radius_ip1" name="radius_ip1" size="16" maxlength="15"></td>
                            </tr>
                            <tr>
                            <td height="2" class="bggrey"><font face="Arial" size="2">Port</font></td>
                            <td height="2" class="bggrey"><input type="text" id="radius_port1" name="radius_port1" size="5" maxlength="5"></td>
                            </tr>
                            <tr>
                            <td height="2" nowrap class="bggrey"><font face="Arial" size="2">Shared Secret</font></td>
                            <td height="2" class="bggrey"><input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64"></td>
                            </tr>
                            <tr>
                            <td width="34%" rowspan="3" align="right" class="bgblue">RADIUS Server 2<br>(Optional)</td>
                            <td width="8%" height="2" class="bggrey"><font face="Arial" size="2">IP</font></td>
                            <td width="58%" height="2" class="bggrey"><input id="radius_ip2" name="radius_ip2" size="16" maxlength="15"></td>
                            </tr>
                            <tr>
                            <td height="2" class="bggrey"><font face="Arial" size="2">Port</font></td>
                            <td height="2" class="bggrey"><input type="text" id="radius_port2" name="radius_port2" size="5" maxlength="5"></td>
                            </tr>
                            <tr>
                            <td height="2" nowrap class="bggrey"><font face="Arial" size="2">Shared Secret</font></td>
                            <td height="2" class="bggrey"><input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64"></td>
                            </tr>
                          	</table>
                          	</td>
                        </tr-->
                      </table></td>
                  </tr>
                  
                </table>
                <p>
                  <input type="button" value="&lt; Back" name="back" onClick="window.location='wizard6.asp'">
                <input type="button" value="Next &gt;" name="next" onClick="send_request()">
                <input type="button" name="exit" value="Exit" onClick="exit_wizard()">
                </p>
              </form></td>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="14"><img src="bg_wizard_4.gif" width="459"></td>
    </tr>
  </table>
</body>
<script>
	loadSettings();	
</script>
</html>
