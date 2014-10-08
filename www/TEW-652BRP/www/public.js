var subnet_mask = new Array(0, 128, 192, 224, 240, 248, 252, 254, 255);
var key_num_array = new Array("64", "128");

function addr_obj(addr, e_msg, allow_zero, is_network){	
	this.addr = addr;
	this.e_msg = e_msg;
	this.allow_zero = allow_zero;			
	this.is_network = is_network;
}

function varible_obj(var_value, e_msg, min, max, is_even){	
	this.var_value = var_value;
	this.e_msg = e_msg;
	this.min = min;
	this.max = max;		
	this.is_even = is_even;		
}

function raidus_obj(ip, port, secret){	
	this.ip = ip;
	this.port = port;
	this.secret = secret;
}

function change_color(table_name, row){
    var obj = get_by_id(table_name);
    for (var i = 1; i < obj.rows.length; i++){
        if (row == i){
            obj.rows[i].style.backgroundColor = "#FFFF00";
        }else{
            obj.rows[i].style.backgroundColor = "#F0F0F0";
        }
    }       
}

function change_wan_html(which_wan){
    var html_file;
    
    switch(which_wan){
		case 0 :
	    	html_file = "wan_dhcp.asp";
	    	break;
		case 1 :	    
	    	html_file = "wan_poe.asp";
	    	break;
		case 2 :
	    	html_file = "wan_pptp.asp";
	    	break;
	    case 3 :
	    	html_file = "wan_l2tp.asp";
	    	break;
	    case 4 :
	    	html_file = "wan_bigpond.asp";
	    	break;
	    case 5 :
	    	html_file = "wan_russia_poe.asp";
	    	break;
	    case 6 :
	    	html_file = "wan_russia_pptp.asp";
	    	break;
	    case 7 :
	    	html_file = "wan_russia_l2tp.asp";
	    	break;
	}
	
	location.href = html_file;
}

function check_address(my_obj, mask_obj, ip_obj){
	var count_zero = 0;
	var count_bcast = 0;
	var ip = my_obj.addr;
	var mask;
					
	if (my_obj.addr.length == 4){
		// check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x)
		if((my_obj.addr[0] == "127") || ((my_obj.addr[0] >= 224) && (my_obj.addr[0] <= 239))){
			alert(my_obj.e_msg[MULTICASE_IP_ERROR]);
			return false;
		}
		// check the ip is "0.0.0.0" or not										
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;
			}								
		}
	
		if (!my_obj.allow_zero && count_zero == 4){	// if the ip is not allowed to be 0.0.0.0
			alert(my_obj.e_msg[ZERO_IP]);			// but we check the ip is 0.0.0.0
			return false;
		}else if (count_zero != 4){		// when IP is not 0.0.0.0, checking range. Otherwise no need to check		
					count_zero = 0;					
				
			if (check_address.arguments.length >= 2 && mask_obj != null){
				mask = mask_obj.addr;
			}else{
				mask = new Array(255,255,255,0);
						}
						
			for(var i = 0; i < ip.length; i++){
				
				if (check_address.arguments.length == 3 && ip_obj != null){
					if (!check_current_range(i, my_obj, ip_obj.addr, mask)){
							return false;
						}
				}else{					
					if (!check_ip_range(i, my_obj, mask)){
						return false;
						}
						}
					}										
							
			for (var i = 0; i < 4; i++){	// check the IP address is a network address or a broadcast address																							
				if (((~mask[i] + 256) & ip[i]) == 0){	// (~mask[i] + 256) = reverse mask[i]
					count_zero++;						
				}
				
				if ((mask[i] | ip[i]) == 255){
					count_bcast++;
					}							
				}
		
			if ((count_zero == 4 && !my_obj.is_network) || (count_bcast == 4)){
				alert(my_obj.e_msg[INVALID_IP]);			
				return false;
			}
		}
	}else{	// if the length of ip is not correct, show invalid ip msg
		alert(my_obj.e_msg[INVALID_IP]);
		return false;		
	}		
	
	return true;		
}

function check_current_range(order, my_obj, checking_ip, mask){
	var which_ip = (my_obj.addr[order]).split(" ");
	var start, end;

	if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
		alert(my_obj.e_msg[FIRST_IP_ERROR + order]);
		return false;
	}
	
	if (order == 0){				// the checking range of 1st address
		start = 1;	
	}else{
		start = 0;				
	}
	
	if (mask[order] != 255){				
		if (parseInt(checking_ip[order]) >= 0 && parseInt(checking_ip[order]) <= 255){	
			end = (~mask[order]+256);				
			start = mask[order] & checking_ip[order];	
			end += start;
		
			if (end > 255){
				end = 255;
			}
		}else{
			end = 255;
		}
	}else{
		end = 255;
	}
	
	if (order == 3){
		if ((mask[0] == 255) && (mask[1] == 255) && (mask[2] == 255)){
			start += 1;
			end -= 1;
		}else{		
			if (((mask[0] | (~my_obj.addr[0]+256)) == 255) && ((mask[1] | (~my_obj.addr[1]+256)) == 255) && ((mask[2] | (~my_obj.addr[2]+256)) == 255)){
				start += 1;
			}
			
			if (((mask[0] | my_obj.addr[0]) == 255) && ((mask[1] | my_obj.addr[1]) == 255) && ((mask[2] | my_obj.addr[2]) == 255)){			
				end -= 1;
			}	
		}	
	}
		
	if (parseInt(which_ip) < start || parseInt(which_ip) > end){			
		alert(my_obj.e_msg[FIRST_RANGE_ERROR + order] + " " + start + " ~ " + end + ".");		
		return false;
	}
	
	return true;
}

function check_domain(ip, mask, gateway){
	var temp_ip = ip.addr;
	var temp_mask = mask.addr;
	var temp_gateway = gateway.addr;
	var temp_str = "";
	
	for (var i = 0; i < 4; i++){
		temp_str += temp_gateway[i];
		
		if (i < 3){
			temp_str += ".";
		}
	}
	
	if (gateway.allow_zero && (temp_str == "0.0.0.0" || temp_str == "...")){
		return true;
	}
	
	for (var i = 0; i < temp_ip.length - 1; i++){
		if ((temp_ip[i] & temp_mask[i]) != (temp_gateway[i] & temp_mask[i])){				
			return false;		// when not in the same subnet mask, return false		
		}
	}

	return true;
}

function check_ip_order(start_ip, end_ip){
	var temp_start_ip = start_ip.addr;
	var temp_end_ip = end_ip.addr;
	
	var total1 = 0;
	var total2 = 0;
    if(temp_start_ip.length > 1){
    	total1 += parseInt(temp_start_ip[3],10);
    	total1 += parseInt(temp_start_ip[2],10)*256;
    	total1 += parseInt(temp_start_ip[1],10)*256*256;
    	total1 += parseInt(temp_start_ip[0],10)*256*256*256;
    }
    
    if(temp_end_ip.length > 1){
   		total2 += parseInt(temp_end_ip[3],10);
	    total2 += parseInt(temp_end_ip[2],10)*256;
	    total2 += parseInt(temp_end_ip[1],10)*256*256;
	    total2 += parseInt(temp_end_ip[0],10)*256*256*256;
	}
    if(total1 > total2)
        return false;
    return true;
}

function check_resip_order(reserved_ip,start_ip, end_ip){
	var temp_start_ip = start_ip.addr;
	var temp_end_ip = end_ip.addr;
	var temp_res_ip = reserved_ip.addr;
	var total1 = ip_num(temp_start_ip);
	var total2 = ip_num(temp_end_ip);
    var total3 = ip_num(temp_res_ip);
    if(total1 <= total3 && total3 <= total2)
        return false;
	return true;
}


function check_ip_range(order, my_obj, mask){
	var which_ip = (my_obj.addr[order]).split(" ");			
	var start, end;
				
	if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
		alert(my_obj.e_msg[FIRST_IP_ERROR + order]);
		return false;
	}

	if (order == 0){				// the checking range of 1st address
		start = 1;	
	}else{
		start = 0;				
	}
		
	if (mask[order] != 255){		
		if (parseInt(which_ip) >= 0 && parseInt(which_ip) <= 255){	
			end = (~mask[order]+256);				
			start = mask[order] & which_ip;	
			end += start;
		
			if (end > 255){
				end = 255;
			}
		}else{
			end = 255;
		}
	}else{
		end = 255;
	}
	
	
	if (order == 3){
		if ((mask[0] == 255) && (mask[1] == 255) && (mask[2] == 255)){
			start += 1;
			end -= 1;
		}else{								
			if (((mask[0] | (~my_obj.addr[0]+256)) == 255) && ((mask[1] | (~my_obj.addr[1]+256)) == 255) && ((mask[2] | (~my_obj.addr[2]+256)) == 255)){
				start += 1;
			}
			
			if (((mask[0] | my_obj.addr[0]) == 255) && ((mask[1] | my_obj.addr[1]) == 255) && ((mask[2] | my_obj.addr[2]) == 255)){			
				end -= 1;
			}				
		}
	}
		
	if (parseInt(which_ip) < start || parseInt(which_ip) > end){
		if ((mask[0] > 255) || (mask[1] > 255) || (mask[2] > 255))
		{
		}
		else
		{
			start=parseInt(start)-parseInt(which_ip);
			end = parseInt(end)-parseInt(which_ip);
		alert(my_obj.e_msg[FIRST_RANGE_ERROR + order] + " " + start + " ~ " + end + ".");		
		return false;
	}
	}
					
	return true;
}

function check_hex(data){	
	data = data.toUpperCase();
	if (!(data >= 'A' && data <= 'F') && !(data >= '0' && data <= '9')){	
		return false;
	}	
	return true;
}

function check_lan_setting(ip, mask, gateway){				
	
	 if (!check_mask(mask)){
		return false;   // when subnet mask is not in the subnet mask range
	}else if (!check_address(ip, mask)){
		return false;		// when ip is invalid
	}else if (!check_address(gateway, mask, ip)){
		return false;	// when gateway is invalid
	}else if (!check_domain(ip, mask, gateway)){		// check if the ip and the gateway are in the same subnet mask or not					
		alert(msg[MSG7]);
		return false;
	}
	return true;
}

function check_mac(mac){
    var temp_mac = mac.split(":");
    var error = true;
    if (temp_mac.length == 6){
	    //if(temp_mac[0] != "00"){
	    	//return false;
	    //}
	    for (var i = 0; i < 6; i++){        
	        var temp_str = temp_mac[i];
	        
	        if (temp_str == ""){
	            error = false;
	        }else{        	
	            if (!check_hex(temp_str.substring(0,1)) || !check_hex(temp_str.substring(1))){
	                error = false;
	            }
	        }
	        
	        if (!error){
	            break;
	        }
	    }
	}else{
		error = false;
	}
    return error;
}

function check_mask(my_mask){
	var temp_mask = my_mask.addr;							
	
	if (temp_mask.length == 4){
		for (var i = 0; i < temp_mask.length; i++){	
			var which_ip = temp_mask[i].split(" ");
			var mask = parseInt(temp_mask[i]);
			var in_range = false;
			var j = 0;
			
			if (isNaN(which_ip) || which_ip == "" || which_ip.length > 1 || (which_ip[0].length > 1 && which_ip[0].substring(0,1) == "0")){	// if the address is invalid
				alert(my_mask.e_msg[FIRST_IP_ERROR + i]);
				return false;
			}
			
			if (i == 0){	// when it's 1st address
				j = 1;		// the 1st address can't be 0
			}
			
			for (; j < subnet_mask.length; j++){			
				if (mask == subnet_mask[j]){
					in_range = true;
					break;											
				}else{
					in_range = false;
				}
			}	
			
			if (!in_range){
				alert(my_mask.e_msg[FIRST_RANGE_ERROR + i]);
				return false;
			}	
												
			if (i != 0 && mask != 0){ // when not the 1st range and the value is not 0
				if (parseInt(temp_mask[i-1]) != 255){  // check the previous value is 255 or not
					alert(my_mask.e_msg[INVALID_IP]);
					return false;
				}
			}					
			
			if (i == 3 && parseInt(mask) == 255){	// when the last mask address is 255
				alert(my_mask.e_msg[INVALID_IP]);
				return false;
			}				
		}
	}else{
		alert(my_mask.e_msg[INVALID_IP]);
		return false;
	}
	
	return true;
}

function check_network_address(my_obj, mask_obj){
	var count_zero = 0;
	var ip = my_obj.addr;
	var mask;
	var allow_cast = false;

	if (my_obj.addr.length == 4){
		// check the ip is not multicast IP (127.x.x.x && 224.x.x.x ~ 239.x.x.x)
		if(my_obj.addr[0] == "127"){
			alert(my_obj.e_msg[MULTICASE_IP_ERROR]);
			return false;
		}
		
		// check the ip is "0.0.0.0" or not
		for(var i = 0; i < ip.length; i++){
			if (ip[i] == "0"){
				count_zero++;			
			}				
		}

		if (!my_obj.allow_zero && count_zero == 4){	// if the ip is not allowed to be 0.0.0.0
			alert(my_obj.e_msg[ZERO_IP]);			// but we check the ip is 0.0.0.0
			return false;
		}else if (count_zero != 4){		// when IP is not 0.0.0.0, checking range. Otherwise no need to check				
				mask = mask_obj.addr;
				for(var i = 0; i < mask.length; i++){
					if (mask[i] != "255"){
					if (ip[i] != (mask[i] & ip[i])){
						alert(my_obj.e_msg[FIRST_RANGE_ERROR + i] + (mask[i] & ip[i]));
						return false;
					}
				}
			}
		}
	}else{	// if the length of ip is not correct, show invalid ip msg
		alert(my_obj.e_msg[INVALID_IP]);
		return false;
	}

	return true;
}

function ip_num(IP_array){
	var total1 = 0;
	if(IP_array.length > 1){
   		total1 += parseInt(IP_array[3],10);
	    total1 += parseInt(IP_array[2],10)*256;
	    total1 += parseInt(IP_array[1],10)*256*256;
	    total1 += parseInt(IP_array[0],10)*256*256*256;
	}
	return total1;
}

function check_LAN_ip(LAN_IP, CHK_IP, obj_name){
	if(ip_num(LAN_IP) == ip_num(CHK_IP)){
		alert(addstr(msg[THE_SAME_LAN_IP], obj_name));
		return false;
	}
	return true;
}


function check_pwd(pwd1, pwd2){
	if (get_by_id(pwd1).value != get_by_id(pwd2).value){
		 alert(msg[MSG1]);
		 return false;
	}
	return true;
}

function check_port(port){
    var temp_port = port.split(" ");
    
    if (isNaN(port) || port == "" || temp_port.length > 1 
    		|| (parseInt(port) < 1 || parseInt(port) > 65535)){
        return false;
    }
    return true;
}

function check_port_order(start_port, end_port){
		
	var total1 = 0;
	var total2 = 0;
    
    total1 += parseInt(start_port,10);
    total2 += parseInt(end_port,10);	
	
    if(total1 > total2)
        return false;
    return true;
}

function check_radius(radius){	
	if (!check_address(radius.ip)){
		return false;
	}else if (!check_port(radius.port)){        
        alert(radius.ip.e_msg[RADIUS_SERVER_PORT_ERROR]);
        return false;
    }else if (radius.secret == ""){
        alert(radius.ip.e_msg[RADIUS_SERVER_SECRET_ERROR]);
        return false;               
	}
	
	return true;
}

function check_ssid(id){
	if (get_by_id(id).value == ""){
	    alert(msg[MSG6]);
	    return false;
	}
	return true;        
}

function pi(val){
    return parseInt(val,10);
}

function check_varible(obj){
	var temp_obj = (obj.var_value).split(" ");
	
	if (temp_obj == "" || temp_obj.length > 1){	
		alert(obj.e_msg[EMPTY_VARIBLE_ERROR]);
		return false;
	}else if (isNaN(obj.var_value)){
		alert(obj.e_msg[INVALID_VARIBLE_ERROR]);
		return false;
	}else if (parseInt(obj.var_value) < obj.min || parseInt(obj.var_value) > obj.max){
		alert(obj.e_msg[VARIBLE_RANGE_ERROR]);
		return false;
	}else if (obj.is_even && (parseInt(obj.var_value) % 2 != 0)){
		alert(obj.e_msg[EVEN_NUMBER_ERROR]);
		return false;
	}
	return true;
}

function check_wep_key(){            	                        	
	var length = get_length();	
	var wep_def_key = get_by_name("wlan0_wep_default_key");
	var key_length = get_by_id("wep_key_len").selectedIndex;
	var wep_key_type = get_by_id("wlan0_wep_display").value;
	var key_len_msg;
	
	for (var i = 1; i < 5; i++){					
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

function disable_dhcp(is_checked, start_obj, end_obj){
	start_obj.disabled = is_checked;
	end_obj.disabled = is_checked;
}

function disable_idle_time(){
	var auto_recon = get_by_name("auto_recon");
	
	get_by_id("idle_time").disabled = !auto_recon[2].checked;
}

function disable_dhcp_static_address(wan_type, obj1, obj2, obj3){
	obj1.disabled = wan_type[0].checked;
	obj2.disabled = wan_type[0].checked;
	obj3.disabled = wan_type[0].checked;
}

function disable_static_address(wan_type, obj1, obj2, obj3){
	obj1.disabled = wan_type[0].checked;
	obj2.disabled = wan_type[0].checked;
	obj3.disabled = wan_type[0].checked;

}
function disable_static_address_PPTP_Russia_PPTP(wan_type, obj1, obj2, obj3,obj4){
	obj1.disabled = wan_type[0].checked;
	obj2.disabled = wan_type[0].checked;
	obj3.disabled = wan_type[0].checked;
	obj4.disabled = 0;
}
function disable_static_address_L2TP_Russia_L2TP(wan_type, obj1, obj2, obj3,obj4){
	obj1.disabled = wan_type[0].checked;
	obj2.disabled = wan_type[0].checked;
	obj3.disabled = wan_type[0].checked;
	obj4.disabled = 0;
}
function disable_ip_address(wan_type, ip_obj){
	ip_obj.disabled = wan_type[0].checked;
}
		
	
function exit_wizard(){
    //if (confirm(msg[MSG0])){
		var error_msg = "Quit setup wizard and discard settings?";
	if (confirm(error_msg)){
        window.close();
    }
}

function get_by_id(id){
	with(document){
		return getElementById(id);
	}
}

function get_by_name(name){
	with(document){
		return getElementsByName(name);
	}
}

function get_key_len_msg(which_key){
	switch(which_key){
    	case 1 :
    		return key1_len_error;    		
    	case 2 :
    		return key2_len_error;    		
    	case 3 :
    		return key3_len_error;    		
    	case 4 :
    		return key4_len_error;    
	}
}

function get_length(){
    var wep_key_len = get_by_id("wep_key_len");
    var wep_key_type = get_by_id("wlan0_wep_display");       
	var length = parseInt(wep_key_len.value);
		
	if (wep_key_type.value == "hex"){
	    length *= 2;
	}
	return length;
}

function get_row_data(obj, index){
	
    try {
    	return obj.cells[index].childNodes[0].data;
    }catch(e) {
        return ("");
    }
}

function send_submit(which_form){
	get_by_id(which_form).submit();
}

function show_key_len_error(key_len_msg, length){
	switch(length){
		case 5 :
			return key_len_msg[0];
		case 13 :
			return key_len_msg[1];
		case 10 :
			return key_len_msg[2];
		case 26:
			return key_len_msg[3];			
	}
}

function show_words(word){	
	with(document){
		return write(word);
	}
}

function show_wizard(name){
	window.open(name,"Wizard","width=800,height=460")
}

function disable_all_items(){
	var input_objs = document.getElementsByTagName("input");
	var select_objs = document.getElementsByTagName("select");
	
	if (input_objs != null){				
		for (var i = 0; i < input_objs.length; i++){			
			input_objs[i].disabled = true;					
		}
	}	
	
	if (select_objs != null){				
		for (var i = 0; i < select_objs.length; i++){			
			select_objs[i].disabled = true;					
		}
	}
}

function enable_all_items(){
	var input_objs = document.getElementsByTagName("input");
	var select_objs = document.getElementsByTagName("select");
	
	if (input_objs != null){				
		for (var i = 0; i < input_objs.length; i++){			
			input_objs[i].disabled = false;					
		}
	}	
	
	if (select_objs != null){				
		for (var i = 0; i < select_objs.length; i++){			
			select_objs[i].disabled = false;					
		}
	}
}

/*
 * is_form_modified
 *	Check if a form's current values differ from saved values in custom attribute.
 *	Function skips elements with attribute: 'modified'= 'ignore'. 
 */
function is_form_modified(form_id)
{
	var df = document.forms[form_id];
	if (!df) {
		return false;
	}
	if (df.getAttribute('modified') == "true") {
		return true;
	}
	if (df.getAttribute('saved') != "true") {
		return false;
	}
	for (var i = 0, k = df.elements.length; i < k; i++) {
		var obj = df.elements[i];
		if (obj.getAttribute('modified') == 'ignore') {
			continue;
		}
		var name = obj.tagName.toLowerCase();
		if (name == 'input') {
			var type = obj.type.toLowerCase();
			if (((type == 'text') || (type == 'textarea') || (type == 'password') || (type == 'hidden')) &&
					!are_values_equal(obj.getAttribute('default'), obj.value)) {
				return true;
			} else if (((type == 'checkbox') || (type == 'radio')) && !are_values_equal(obj.getAttribute('default'), obj.checked)) {
				return true;
			}
		} else if (name == 'select') {
			var opt = obj.options;
			for (var j = 0; j < opt.length; j++) {
				if (!are_values_equal(opt[j].getAttribute('default'), opt[j].selected)) {
					return true;
				}
			}
		}
	}
	return false;
}

/*
 * set_form_default_values
 *	Save a form's current values to a custom attribute.
 */
function set_form_default_values(form_id)
{
	var df = document.forms[form_id];
	if (!df) {
		return;
	}
	for (var i = 0, k = df.elements.length; i < k; i++) {
		var obj = df.elements[i];
		if (obj.getAttribute('modified') == 'ignore') {
			continue;
		}
		var name = obj.tagName.toLowerCase();
		if (name == 'input') {
			var type = obj.type.toLowerCase();
			if ((type == 'text') || (type == 'textarea') || (type == 'password') || (type == 'hidden')) {
				obj.setAttribute('default', obj.value);
				/* Workaround for FF error when calling focus() from an input text element. */
				if (type == 'text') {
					obj.setAttribute('autocomplete', 'off');
				}
			} else if ((type == 'checkbox') || (type == 'radio')) {
				obj.setAttribute('default', obj.checked);
			}
		} else if (name == 'select') {
			var opt = obj.options;
			for (var j = 0; j < opt.length; j++) {
				opt[j].setAttribute('default', opt[j].selected);
			}
		}
	}
	df.setAttribute('saved', "true");
}


/*
 * are_values_equal()
 *	Compare values of types boolean, string and number. The types may be different.
 *	Returns true if values are equal.
 */
function are_values_equal(val1, val2)
{
	/* Make sure we can handle these values. */
	switch (typeof(val1)) {
	case 'boolean':
	case 'string':
	case 'number':
		break;
	default:
		// alert("are_values_equal does not handle the type '" + typeof(val1) + "' of val1 '" + val1 + "'.");
		return false;
	}

	switch (typeof(val2)) {
	case 'boolean':
		switch (typeof(val1)) {
		case 'boolean':
			return (val1 == val2);
		case 'string':
			if (val2) {
				return (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on");
			} else {
				return (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off");
			}
			break;
		case 'number':
			return (val1 == val2 * 1);
		}
		break;
	case 'string':
		switch (typeof(val1)) {
		case 'boolean':
			if (val1) {
				return (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on");
			} else {
				return (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off");
			}
			break;
		case 'string':
			if (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on") {
				return (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on");
			}
			if (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off") {
				return (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off");
			}
			return (val2 == val1);
		case 'number':
			if (val2 == "1" || val2.toLowerCase() == "true" || val2.toLowerCase() == "on") {
				return (val1 == 1);
			}
			if (val2 == "0" || val2.toLowerCase() == "false" || val2.toLowerCase() == "off") {
				return (val1 === 0);
			}
			return (val2 == val1 + "");
		}
		break;
	case 'number':
		switch (typeof(val1)) {
		case 'boolean':
			return (val1 * 1 == val2);
		case 'string':
			if (val1 == "1" || val1.toLowerCase() == "true" || val1.toLowerCase() == "on") {
				return (val2 == 1);
			}
			if (val1 == "0" || val1.toLowerCase() == "false" || val1.toLowerCase() == "off") {
				return (val2 === 0);
			}
			return (val1 == val2 + "");
		case 'number':
			return (val2 == val1);
		}
		break;
	default:
		return false;
	}
}

function jump_if(){
	for (var i = 0; i < document.forms.length; i++) {
		if (is_form_modified(document.forms[i].id)) {
			if (!confirm ("There is unsaved data on this page. Do you want to abandon it?\n" +
					  "If not, press Cancel and then click Save Settings.\n" +
					  "If so, press Ok.")) {
				return false;
			}
		}
	}
	return true;
}


function set_selectIndex(which_value, obj){
    for (var pp=0; pp<obj.options.length; pp++){
        if (which_value == obj.options[pp].value){
            obj.selectedIndex = pp;
            break;
        }
    }
}

function get_select_value(obj){
	return obj.options[obj.selectedIndex].value
}

function set_checked(which_value, obj){
	if(obj.length > 1){
		for(var pp=0;pp<obj.length;pp++){
			if(obj[pp].value == which_value){
				obj[pp].checked = true;
			}
		}
	}else{
		obj.checked = false;
		if(obj.value == which_value){
			obj.checked = true;
		}
	}
}

function get_checked_value(obj){
	if(obj.length > 1){
		for(pp=0;pp<obj.length;pp++){
			if(obj[pp].checked){
				return obj[pp].value;
			}
		}
	}else{
		if(obj.checked){
			return obj.value;
		}else{
			return 0;
		}
	}
}

function set_mac_list(parameter){
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){		
			if(parameter == "mac"){
				document.write("<option value='" + temp_data[2] + "'>" + temp_data[0] + " (" + temp_data[2] + " )" + "</option>");		
			}else if(parameter == "ip"){
				document.write("<option value='" + temp_data[1] + "'>" + temp_data[0] + " (" + temp_data[1] + " )" + "</option>");		
			}else{
				document.write("<option value='" + temp_data[2] + "'>" + temp_data[0] + "</option>");
			}
		}
	}
}


function set_mac(mac, sp_w){
	var temp_mac = mac.split(sp_w);
	for (var i = 0; i < 6; i++){
		var obj = get_by_id("mac" + (i+1));
		obj.value = temp_mac[i];
	}
}

function addstr(input_msg)
{
	var last_msg = "";
	var str_location;
	var temp_str_1 = "";
	var temp_str_2 = "";
	var str_num = 0;
	temp_str_1 = addstr.arguments[0];
	while(1)
	{
		str_location = temp_str_1.indexOf("%s");
		if(str_location >= 0)
		{
			str_num++;
			temp_str_2 = temp_str_1.substring(0,str_location);
			last_msg += temp_str_2 + addstr.arguments[str_num];
			temp_str_1 = temp_str_1.substring(str_location+2,temp_str_1.length);
			continue;
		}
		if(str_location < 0)
		{
			last_msg += temp_str_1;
			break;
		}
	}
	return last_msg;
}

function replace_msg(obj_S){
	obj_D = new Array();
	for (i=0;i<obj_S.length;i++){
		obj_D[i] = addstr(obj_S[i], replace_msg.arguments[1]);
		obj_D[i] = obj_D[i].replace("%1n", replace_msg.arguments[2]);
		obj_D[i] = obj_D[i].replace("%2n", replace_msg.arguments[3]);
	}
	return obj_D;
}

function Find_word(strOrg,strFind){
	var index = 0;
	index = strOrg.indexOf(strFind,index);
	if (index > -1){
		return true;
	}
	return false;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

/*
 * is_ipv4_valid
 *	Check is an IP address dotted string is valid.
 */
function is_ipv4_valid(ipaddr)
{
	var ip = ipv4_to_bytearray(ipaddr);
	if (ip === 0) {
		return false;
	}
	return true;
}

/*
 * ipv4_to_bytearray
 *	Convert an IPv4 address dotted string to a byte array
 */
function ipv4_to_bytearray(ipaddr)
{
	var ip = ipaddr + "";
	var got = ip.match (/^\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*[.]\s*(\d{1,3})\s*$/);
	if (!got) {
		return 0;
	}
	var a = [];
	var q = 0;
	for (var i = 1; i <= 4; i++) {
		q = parseInt(got[i],10);
		if (q < 0 || q > 255) {
			return 0;
		}
		a[i-1] = q;
	}
	return a;
}
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
function isHex(str) {
    var i;
    for(i = 0; i<str.length; i++) {
        var c = str.substring(i, i+1);
        if(("0" <= c && c <= "9") || ("a" <= c && c <= "f") || ("A" <= c && c <= "F")) {
            continue;
        }
        return false;
    }
    return true;
}
function check_DeviceName(tmp_hostName){
	var i;
	var error =false;
	var tmp_count=0;
	
	if (tmp_hostName.length <= 63){
		var tmp_stringlength = tmp_hostName.length - 1
    for(i = 0; i<tmp_hostName.length; i++) {	    	
      var c = tmp_hostName.substring(i,i+1);
      if (("0" <= c && c <= "9")){
				tmp_count=tmp_count+1;
			}
			if((("0" <= c && c <= "9") || ("a" <= c && c <= "z") || ("A" <= c && c <= "Z")||(i!=0 && c=="-")&&(i!=tmp_stringlength && c=="-"))&&(tmp_count != tmp_hostName.length)) {        	          
         continue;
      }
      else{
		   	alert(msg[MSG54]);
      	error= true;
      	return error;
      }
    }       
  }
  else{
  	alert(msg[MSG53]);
    error= true;
  	return error;
  }
}