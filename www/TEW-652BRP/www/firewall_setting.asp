<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Access | firewall_settings</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 30;

	function check_box_enabled(num){
		var array_num = num;
		get_by_id("enable"+num).checked = false;
		get_by_id("enable"+num).disabled = true;
		if(parseInt(DataArray[array_num].Enable,10)==1){
			get_by_id("enable"+num).checked = true;
		}
	}
	
	function check_proto(){
		var is_disable = false;		
		if (get_by_id("proto").value == "ICMP" || get_by_id("proto").value == "Any"){
			is_disable = true;			
		}		
		get_by_id("dest_port_start").disabled = is_disable;
		get_by_id("dest_port_end").disabled = is_disable;
	}	
	
	//enable/name/src_iface/protocol/src_ip_start/src_ip_end/dst_iface/dest_ip_start/dest_ip_end/dest_port_start/dest_port_end/schedule/action
	//1/Allow to Ping WAN port/WAN/ICMP/*/*/WAN/*/*/*/*/Never/Allow
	//firewall_rule_03=1/test1/LAN/TCP/*/*/WAN/*/*/3000/3000/Always/Deny	 
	function Data(enable, name, iface_src, proto, src_ip_start, src_ip_end, iface_dest, dest_ip_start, dest_ip_end, dest_port_start, dest_port_end, schedule, action, onList){
		this.Enable = enable;
		this.Name = name;
		this.Iface_src = iface_src;
		this.Proto = proto;
		this.Src_ip_start = src_ip_start;
		this.Src_ip_end = src_ip_end;
		this.Iface_dest = iface_dest;
		this.Dest_ip_start = dest_ip_start;
		this.Dest_ip_end = dest_ip_end;
		this.Dest_port_start = dest_port_start;
		this.Dest_port_end = dest_port_end;
		this.Schedule = schedule;
		this.Action = action;
		this.OnList = onList;
	}
	
function TempData(enable, name, iface_src, proto, src_ip_start, src_ip_end, iface_dest, dest_ip_start, dest_ip_end, dest_port_start, dest_port_end, schedule, action, onList){
		this.Enable = enable;
		this.Name = name;
		this.Iface_src = iface_src;
		this.Proto = proto;
		this.Src_ip_start = src_ip_start;
		this.Src_ip_end = src_ip_end;
		this.Iface_dest = iface_dest;
		this.Dest_ip_start = dest_ip_start;
		this.Dest_ip_end = dest_ip_end;
		this.Dest_port_start = dest_port_start;
		this.Dest_port_end = dest_port_end;
		this.Schedule = schedule;
		this.Action = action;
		this.OnList = onList;
	}	
	
	function set_firewall(){
		var index = 0;
		var tmp_check = get_by_id("wan_port_ping_response_enable").value;
		for (var i = 0; i < rule_max_num; i++){
			var temp_fr;
			var k=i;
			if(i<10){
				k="0"+i;
			}
			temp_fr = (get_by_id("firewall_rule_" + k).value).split("/");
			if (temp_fr.length > 1){
				if((temp_fr[1] != "name") && (temp_fr[1].length > 0)){
					if( i!=0){
						DataArray[DataArray.length++] = new Data(temp_fr[0], temp_fr[1], temp_fr[2], temp_fr[3], temp_fr[4], temp_fr[5], temp_fr[6], temp_fr[7],temp_fr[8],temp_fr[9],temp_fr[10],temp_fr[11],temp_fr[12], index);				    	
				    }
				    else{
				    	DataArray[DataArray.length++] = new Data(tmp_check, temp_fr[1], temp_fr[2], temp_fr[3], temp_fr[4], temp_fr[5], temp_fr[6], temp_fr[7],temp_fr[8],temp_fr[9],temp_fr[10],temp_fr[11],temp_fr[12], index);				    	
				    }				    	
				    get_by_id("temp_row").value=index;	
					index++;
				}
			}
		}
	}
	
	function DataShow(){		
		set_firewall();
		for (var i = 0; i<DataArray.length;i++){		
			var enable_name = "enable"+i;
			var Iface_src = DataArray[i].Iface_src;
		  	var Iface_dest = DataArray[i].Iface_dest;
			var src_ip_end = DataArray[i].Src_ip_end;
			var src_ip_start = DataArray[i].Src_ip_start;
			var dest_ip_end = DataArray[i].Dest_ip_end;
			var dest_ip_start = DataArray[i].Dest_ip_start;
			var proto = DataArray[i].Proto;
			var dest_port_start = DataArray[i].Dest_port_start;
			var dest_port_end = DataArray[i].Dest_port_end;				  		
		  		
			if(src_ip_end == src_ip_start){
				src_ip_end = "";
			}			
			if(dest_ip_end == dest_ip_start){
				dest_ip_end = "";
			}				
			tmp_proto = proto;	
			if(dest_port_end == dest_port_start){
				dest_port_end = "";
			}					
			
			//row start
			document.write("<tr bgcolor=#F0F0F0 onClick=\"edit_row("+ i +")\">");
			//enable		
			if (DataArray[i].Enable == "0"){
				document.write("<td><input type=\"checkbox\" id=\""+ enable_name +"\" disabled name=\""+ enable_name +"\" value=\"0\"></td>");
			}
			else{
				document.write("<td><input type=\"checkbox\" id=\""+ enable_name +"\" disabled checked name=\""+ enable_name +"\" value=\"1\"></td>");
        	}        		    	
	    	//action
	    	if (DataArray[i].Action == "Allow"){
				document.write("<td> Allow </td>");
			}
			else{
				document.write("<td> Deny </td>");
			}
			//name
			document.write("<td>"+ DataArray[i].Name +"</td>");
			//src iface and ip
			if ((src_ip_start == "*")&&(src_ip_end == "*")){// start_ip = "*" end_ip = "*"
				document.write("<td>"+ Iface_src +",*"+"</td>");
			}
			else if (src_ip_end == "" ){// start_ip = end_ip 
				document.write("<td>"+ Iface_src +","+ src_ip_start +"</td>");
			}
			else{
				document.write("<td>"+ Iface_src +","+ src_ip_start +"-"+ src_ip_end +"</td>");
			}
			//det iface and ip
			if ((dest_ip_start == "*")&&(dest_ip_end == "*")){ // start_ip = "*" end_ip = "*"
				document.write("<td>"+ Iface_dest +",*"+"</td>");
			}
			else if (dest_ip_end == ""){ // start_ip = end_ip 
				document.write("<td>"+ Iface_dest +","+ dest_ip_start + "</td>");
			}
			else{
      			document.write("<td>"+ Iface_dest +","+ dest_ip_start + "-"+ dest_ip_end +"</td>");
			}	
			//dst proto and port		
			if ( dest_port_start == "*" ){
				document.write("<td>"+ tmp_proto +",*</td>");
			}
			else{
				document.write("<td>"+ tmp_proto +","+ DataArray[i].Dest_port_start +","+ DataArray[i].Dest_port_end +"</td>");				
			}											
			document.write("</tr>");			
			//row end
			check_box_enabled(i);			
		}
		
	}
	
	//update     
    function edit_row(row){
    	//var row_obj = get_by_id("table1").rows[row+1];        
        var enable = get_by_name("enable");
        var taction = get_by_name("action");       	
		var tmp_row = get_by_id("temp_row").value;
		        
        //alert("row"+row+"temp_row"+tmp_row);
        enable[0].disabled = false;
   	 		enable[1].disabled = false;
   	 		taction[0].disabled = false;   
      	taction[1].disabled = false;
      	get_by_id("name").disabled = false;        
				get_by_id("src_ip_start").disabled = false;
        get_by_id("src_ip_end").disabled = false;
        get_by_id("dest_ip_start").disabled = false;
        get_by_id("dest_ip_end").disabled = false;
        get_by_id("dest_port_start").disabled = false;
        get_by_id("dest_port_end").disabled = false;
        get_by_id("iface_src").disabled = false;
        get_by_id("iface_dest").disabled = false;
        get_by_id("proto").disabled = false;  
        if (row < 3){
        	if (DataArray[row].Enable == "0"){
        		enable[1].checked = true;
        	}else{
        		enable[0].checked = true;
   	 		}	
   	 		enable[0].disabled = true;
   	 		enable[1].disabled = true;	
			if (DataArray[row].Action == "Allow"){
        		taction[0].checked = true;
        	}else{
        		taction[1].checked = true;
      		} 
      		taction[0].disabled = true;   
      		taction[1].disabled = true;  	
        	get_by_id("name").value = DataArray[row].Name;
        	get_by_id("name").disabled = true;        
					get_by_id("src_ip_start").value = DataArray[row].Src_ip_start;
					get_by_id("src_ip_start").disabled = true;
        	get_by_id("src_ip_end").value = DataArray[row].Src_ip_end;
        	get_by_id("src_ip_end").disabled = true;
        	get_by_id("dest_ip_start").value = DataArray[row].Dest_ip_start;
        	get_by_id("dest_ip_start").disabled = true;
        	get_by_id("dest_ip_end").value = DataArray[row].Dest_ip_end;
        	get_by_id("dest_ip_end").disabled = true;
        	get_by_id("dest_port_start").value = DataArray[row].Dest_port_start;
        	get_by_id("dest_port_start").disabled = true;
        	get_by_id("dest_port_end").value = DataArray[row].Dest_port_end;
        	get_by_id("dest_port_end").disabled = true;
        	set_selectIndex(DataArray[row].Iface_src, get_by_id("iface_src"));
        	get_by_id("iface_src").disabled = true;
        	set_selectIndex(DataArray[row].Iface_dest, get_by_id("iface_dest"));
        	get_by_id("iface_dest").disabled = true;
        	set_selectIndex(DataArray[row].Proto, get_by_id("proto"));
        	get_by_id("proto").disabled = true;
        }
        else{
        	if (DataArray[row].Enable == "0"){
        		enable[1].checked = true;
        	}else{
        		enable[0].checked = true;
   	 		}   	 				
			if (DataArray[row].Action == "Allow"){
        		taction[0].checked = true;
        	}else{
        		taction[1].checked = true;
      		}     		  	
        	get_by_id("name").value = DataArray[row].Name;
        	get_by_id("src_ip_start").value = DataArray[row].Src_ip_start;
					get_by_id("src_ip_end").value = DataArray[row].Src_ip_end;
        	get_by_id("dest_ip_start").value = DataArray[row].Dest_ip_start;
        	get_by_id("dest_ip_end").value = DataArray[row].Dest_ip_end;
        	get_by_id("dest_port_start").value = DataArray[row].Dest_port_start;
        	get_by_id("dest_port_end").value = DataArray[row].Dest_port_end;
        	set_selectIndex(DataArray[row].Iface_src, get_by_id("iface_src"));
        	set_selectIndex(DataArray[row].Iface_dest, get_by_id("iface_dest"));
        	set_selectIndex(DataArray[row].Proto, get_by_id("proto"));        	
        }			      		
        	    	    	    	        
        get_by_id("edit_row").value = row;
        get_by_id("add").disabled = false;
        get_by_id("update").disabled = false;
        get_by_id("del").disabled = false;
        get_by_id("cancel").disabled=false;        
        get_by_id("up").disabled = false;
				get_by_id("down").disabled = false;
				get_by_id("priority").disabled = false;        

        if (row < 3){
        	get_by_id("add").disabled = true;        	
        	get_by_id("update").disabled = true;
        	get_by_id("del").disabled = true;
        	get_by_id("cancel").disabled=false;
					get_by_id("up").disabled = true;
					get_by_id("down").disabled = true;        	
        	get_by_id("priority").disabled = true;
		}
		else
		{
			if (row >= tmp_row)//can't down
			{
				get_by_id("add").disabled = true;
		       	get_by_id("update").disabled = false;
		       	get_by_id("del").disabled = false;
		       	get_by_id("cancel").disabled=false;
		    if (row >3){
				get_by_id("up").disabled = false;
				get_by_id("priority").disabled = false;
				}
				else{
					get_by_id("up").disabled = true;
					get_by_id("priority").disabled = true;
				}
				get_by_id("down").disabled = true;	       		
	       		
			}
			else
			{
				if (row == 3)//can't up
				{
					get_by_id("add").disabled = true;
					get_by_id("update").disabled = false;
					get_by_id("del").disabled = false;
					get_by_id("cancel").disabled=false;
					get_by_id("up").disabled = true;
					get_by_id("down").disabled = false;
					get_by_id("priority").disabled = false;		       		
				}
				else
				{
					get_by_id("add").disabled = true;
					get_by_id("update").disabled = false;
					get_by_id("del").disabled = false;
					get_by_id("cancel").disabled=false;
					get_by_id("up").disabled = false;
					get_by_id("down").disabled = false;
					get_by_id("priority").disabled = false;	
				}
			}
			check_proto();
		}		
        change_color("table1", row+1);	
    }
	
	//del
	function del_row(){
        var index = parseInt(get_by_id("edit_row").value,10);
        if(confirm(addstr(msg[MSG16],"firewall"))){
        	for(i = index ; i < DataArray.length-1 ;i++){
				DataArray[i].Enable = DataArray[i+1].Enable;
				DataArray[i].Name = DataArray[i+1].Name;
				DataArray[i].Iface_src = DataArray[i+1].Iface_src;
				DataArray[i].Proto = DataArray[i+1].Proto;
				DataArray[i].Src_ip_start = DataArray[i+1].Src_ip_start;
				DataArray[i].Src_ip_end = DataArray[i+1].Src_ip_end;
				DataArray[i].Iface_dest = DataArray[i+1].Iface_dest;
				DataArray[i].Dest_ip_start = DataArray[i+1].Dest_ip_start;
				DataArray[i].Dest_ip_end = DataArray[i+1].Dest_ip_end;
				DataArray[i].Dest_port_start = DataArray[i+1].Dest_port_start;
				DataArray[i].Dest_port_end = DataArray[i+1].Dest_port_end;
				DataArray[i].Schedule = DataArray[i+1].Schedule;
				DataArray[i].Action = DataArray[i+1].Action;
				DataArray[i].OnList = DataArray[i+1].OnList;
			}
			--DataArray.length;
			save_to_cfg();
			get_by_id("reboot_type").value = "filter";
			return true;
        }
        return false;
    }    
    
    //cancel
    function clear_row(){
        get_by_id("edit_row").value = "-1";
        change_color("table1", -1);
        location.href = "firewall_setting.asp";
    }
    
    //up off=-1, down off=1
    function change_priority(off){
		var row = parseInt(get_by_id("edit_row").value);
		var obj = get_by_id("table1");
		var index = row + off;
		var new_row = obj.rows[index+1];
		var self_row = obj.rows[row+1];
		var temp_rule_list = DataArray[row];
		var data = temp_rule_list
		var tmp_check;
		var tmp_result;
		var tmp_check2;
		var tmp_result2;
		var temp_data;
		var TempDataArray = new Array();
				
		if (index < 0 || index >= rule_max_num){
			return;
		}		
		
			for(var k=0;k<DataArray.length;k++){
				TempDataArray[k] = new TempData(DataArray[k].Enable,DataArray[k].Name,DataArray[k].Iface_src,+
																			  DataArray[k].Proto,DataArray[k].Src_ip_start,DataArray[k].Src_ip_end,+
																			  DataArray[k].Iface_dest,DataArray[k].Dest_ip_start,+
																			  DataArray[k].Dest_ip_end,DataArray[k].Dest_port_start,+
																			  DataArray[k].Dest_port_end,DataArray[k].Schedule,DataArray[k].Action,DataArray[k].OnList);				    	
			}				
			
			
		
		for (var i = 0; i < new_row.cells.length; i++){
				temp_data = new_row.cells[i].childNodes[0].data
			if (i == 0){
					if (off == -1){					
						var check1 = TempDataArray[row-1].Enable;
						TempDataArray[row].Enable=check1;
						
						TempDataArray[row-1].Enable=DataArray[row].Enable;
						TempDataArray[row-1].Name = DataArray[row].Name;
						TempDataArray[row-1].Iface_src = DataArray[row].Iface_src;
						TempDataArray[row-1].Proto = DataArray[row].Proto;
						TempDataArray[row-1].Src_ip_start = DataArray[row].Src_ip_start;
						TempDataArray[row-1].Src_ip_end = DataArray[row].Src_ip_end;
						TempDataArray[row-1].Iface_dest = DataArray[row].Iface_dest;
						TempDataArray[row-1].Dest_ip_start = DataArray[row].Dest_ip_start;
						TempDataArray[row-1].Dest_ip_end = DataArray[row].Dest_ip_end;
						TempDataArray[row-1].Dest_port_start = DataArray[row].Dest_port_start;
						TempDataArray[row-1].Dest_port_end = DataArray[row].Dest_port_end;
						TempDataArray[row-1].Schedule = DataArray[row].Schedule;
						TempDataArray[row-1].Action = DataArray[row].Action;
						
						DataArray[row].Enable=DataArray[row-1].Enable;
						DataArray[row].Name = DataArray[row-1].Name;
						DataArray[row].Iface_src = DataArray[row-1].Iface_src;
						DataArray[row].Proto = DataArray[row-1].Proto;
						DataArray[row].Src_ip_start = DataArray[row-1].Src_ip_start;
						DataArray[row].Src_ip_end = DataArray[row-1].Src_ip_end;
						DataArray[row].Iface_dest = DataArray[row-1].Iface_dest;
						DataArray[row].Dest_ip_start = DataArray[row-1].Dest_ip_start;
						DataArray[row].Dest_ip_end = DataArray[row-1].Dest_ip_end;
						DataArray[row].Dest_port_start = DataArray[row-1].Dest_port_start;
						DataArray[row].Dest_port_end = DataArray[row-1].Dest_port_end;
						DataArray[row].Schedule = DataArray[row-1].Schedule;
						DataArray[row].Action = DataArray[row-1].Action;

						DataArray[row-1].Enable=TempDataArray[row-1].Enable;
						DataArray[row-1].Name = TempDataArray[row-1].Name;
						DataArray[row-1].Iface_src = TempDataArray[row-1].Iface_src;
						DataArray[row-1].Proto = TempDataArray[row-1].Proto;
						DataArray[row-1].Src_ip_start = TempDataArray[row-1].Src_ip_start;
						DataArray[row-1].Src_ip_end = TempDataArray[row-1].Src_ip_end;
						DataArray[row-1].Iface_dest = TempDataArray[row-1].Iface_dest;
						DataArray[row-1].Dest_ip_start = TempDataArray[row-1].Dest_ip_start;
						DataArray[row-1].Dest_ip_end = TempDataArray[row-1].Dest_ip_end;
						DataArray[row-1].Dest_port_start = TempDataArray[row-1].Dest_port_start;
						DataArray[row-1].Dest_port_end = TempDataArray[row-1].Dest_port_end;
						DataArray[row-1].Schedule = TempDataArray[row-1].Schedule;
						DataArray[row-1].Action = TempDataArray[row-1].Action;
					
						if (TempDataArray[row].Enable == 0){
							tmp_result=false;
					}
						else{
							tmp_result=true;
					}						
						if (TempDataArray[row-1].Enable == 0){
							tmp_result2=false;
				}	
						else{
							tmp_result2=true;
					}
						
						get_by_id("enable"+(row-1)).checked = tmp_result2;
						get_by_id("enable"+row).checked = tmp_result;
						
						
					}
					else{
						var check1 = TempDataArray[row+1].Enable;

						TempDataArray[row].Enable=check1;
						TempDataArray[row+1].Enable=DataArray[row].Enable;
						TempDataArray[row+1].Name = DataArray[row].Name;
						TempDataArray[row+1].Iface_src = DataArray[row].Iface_src;
						TempDataArray[row+1].Proto = DataArray[row].Proto;
						TempDataArray[row+1].Src_ip_start = DataArray[row].Src_ip_start;
						TempDataArray[row+1].Src_ip_end = DataArray[row].Src_ip_end;
						TempDataArray[row+1].Iface_dest = DataArray[row].Iface_dest;
						TempDataArray[row+1].Dest_ip_start = DataArray[row].Dest_ip_start;
						TempDataArray[row+1].Dest_ip_end = DataArray[row].Dest_ip_end;
						TempDataArray[row+1].Dest_port_start = DataArray[row].Dest_port_start;
						TempDataArray[row+1].Dest_port_end = DataArray[row].Dest_port_end;
						TempDataArray[row+1].Schedule = DataArray[row].Schedule;
						TempDataArray[row+1].Action = DataArray[row].Action;
												
						DataArray[row].Enable=DataArray[row+1].Enable;
						DataArray[row].Name = DataArray[row+1].Name;
						DataArray[row].Iface_src = DataArray[row+1].Iface_src;
						DataArray[row].Proto = DataArray[row+1].Proto;
						DataArray[row].Src_ip_start = DataArray[row+1].Src_ip_start;
						DataArray[row].Src_ip_end = DataArray[row+1].Src_ip_end;
						DataArray[row].Iface_dest = DataArray[row+1].Iface_dest;
						DataArray[row].Dest_ip_start = DataArray[row+1].Dest_ip_start;
						DataArray[row].Dest_ip_end = DataArray[row+1].Dest_ip_end;
						DataArray[row].Dest_port_start = DataArray[row+1].Dest_port_start;
						DataArray[row].Dest_port_end = DataArray[row+1].Dest_port_end;
						DataArray[row].Schedule = DataArray[row+1].Schedule;
						DataArray[row].Action = DataArray[row+1].Action;

						DataArray[row+1].Enable=TempDataArray[row+1].Enable;
						DataArray[row+1].Name = TempDataArray[row+1].Name;
						DataArray[row+1].Iface_src = TempDataArray[row+1].Iface_src;
						DataArray[row+1].Proto = TempDataArray[row+1].Proto;
						DataArray[row+1].Src_ip_start = TempDataArray[row+1].Src_ip_start;
						DataArray[row+1].Src_ip_end = TempDataArray[row+1].Src_ip_end;
						DataArray[row+1].Iface_dest = TempDataArray[row+1].Iface_dest;
						DataArray[row+1].Dest_ip_start = TempDataArray[row+1].Dest_ip_start;
						DataArray[row+1].Dest_ip_end = TempDataArray[row+1].Dest_ip_end;
						DataArray[row+1].Dest_port_start = TempDataArray[row+1].Dest_port_start;
						DataArray[row+1].Dest_port_end = TempDataArray[row+1].Dest_port_end;
						DataArray[row+1].Schedule = TempDataArray[row+1].Schedule;
						DataArray[row+1].Action = TempDataArray[row+1].Action;						
						
						if (TempDataArray[row].Enable == 0){
							tmp_result=false;
					}
						else{
							tmp_result=true;
				}
						if (TempDataArray[row+1].Enable == 0){
							tmp_result2=false;
			}
			else{
							tmp_result2=true;
			}	
						get_by_id("enable"+row).checked = tmp_result;
						get_by_id("enable"+(row+1)).checked = tmp_result2;
		}
        }
				new_row.cells[i].childNodes[0].data = self_row.cells[i].childNodes[0].data;
				self_row.cells[i].childNodes[0].data = temp_data;
    }
		edit_row(index);		
	}
				
	//add,update and update priority
	function send_request(){		
		var firewall_name = get_by_id("name").value;
		var src_ip_start = get_by_id("src_ip_start").value;
		var src_ip_end = get_by_id("src_ip_end").value;
		var dest_ip_start = get_by_id("dest_ip_start").value;
		var dest_ip_end = get_by_id("dest_ip_end").value;		
		var dest_port_start = get_by_id("dest_port_start").value;
		var dest_port_end = get_by_id("dest_port_end").value;
		var iface_src = get_by_id("iface_src").value;
		var iface_dest = get_by_id("iface_dest").value;
		var proto = get_by_id("proto").value;
		var enable = get_checked_value(get_by_name("enable"));
		var ip = get_by_id("lan_ipaddr").value;
		var mask = get_by_id("lan_netmask").value;
   	var ip_addr_msg = replace_msg(all_ip_addr_msg,"Lan IP address");
   	
    var temp_src_ip1 = new addr_obj(src_ip_start.split("."), src_start_ip_msg, false, false);
		var temp_src_ip2 = new addr_obj(src_ip_end.split("."), src_end_ip_msg, true, false);
		var temp_dst_ip1 = new addr_obj(dest_ip_start.split("."), dst_start_ip_msg, false, false);
		var temp_dst_ip2 = new addr_obj(dest_ip_end.split("."), dst_end_ip_msg, true, false);
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		//var dat= get_by_id("wan_current_ipaddr").value.split("/");
		//var wan_ipaddr = dat[0];
		//var wan_mask = dat[1];
		//var wan_ipaddr_msg = replace_msg(all_ip_addr_msg,"Wan IP address");
		//var temp_wan_ip_obj = new addr_obj(wan_ipaddr.split("."), wan_ipaddr_msg, false, false);
		//var temp_wan_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
        
		
		var index = parseInt(get_by_id("edit_row").value,10);
		if ((enable !=0)&&(enable !=1))
		{
			alert("Please select enable type. ");
			return false;
		}
		if (firewall_name == ""){
			alert("Please input firewall name");
			return false;
		}
		if ((get_by_id("edit_row").value == "0")||(get_by_id("edit_row").value == "1")||(get_by_id("edit_row").value == "2"))
		{	
			alert("This row is unable to change");
			clear_row();
			return false;
		}		
				
     if (iface_src == iface_dest ){
			alert("The Source Interface same as Destination Interface is not a valid setting." )
			return false;
		}		
		//src_ip	
		if (src_ip_start != "*"){
			if(src_ip_end == "*"){
				src_ip_end = src_ip_start;
				var temp_src_ip2 = new addr_obj(src_ip_end.split("."), src_end_ip_msg, true, false);
			}	
		}		
		if (src_ip_start != "*"){
			if (!check_address(temp_src_ip1)){
				return false;
			}
		}			
		if (src_ip_end != "*"){
			if (!check_address(temp_src_ip2)){
				return false;
			}
		}
		if(src_ip_start != "*" && src_ip_end != "*"){
			if (iface_src == "LAN"){
				if (!check_domain(temp_ip_obj, temp_mask_obj, temp_src_ip1)){
					alert(addstr(msg[MSG2],"Source start IP address"));
					return false;
				}
				if (!check_domain(temp_ip_obj, temp_mask_obj, temp_src_ip2)){
					alert(addstr(msg[MSG2],"Source end IP address"));
					return false;
				}
				if (!check_ip_order(temp_src_ip1, temp_src_ip2)){
					alert(msg[MSG4]);
					return false;
				}
			}
			else{
				//if (!check_domain(temp_wan_ip_obj, temp_wan_mask_obj, temp_src_ip1)){
					//alert(addstr(msg[MSG2],"Source start IP address"));
					//return false;
				//}
				//if (!check_domain(temp_wan_ip_obj, temp_wan_mask_obj, temp_src_ip2)){
					//alert(addstr(msg[MSG2],"Source end IP address"));
					//return false;
				//}
				if (!check_ip_order(temp_src_ip1, temp_src_ip2)){
					alert(msg[MSG4]);
					return false;
				}
			}
		}
		//dest_ip
		if (dest_ip_start != "*"){
			if(dest_ip_end == "*"){
				dest_ip_end = dest_ip_start;
				var temp_dst_ip2 = new addr_obj(dest_ip_end.split("."), dst_end_ip_msg, true, false);
			}	
		}		
		if (dest_ip_start != "*"){
			if (!check_address(temp_dst_ip1)){
				return false;
			}
		}			
		if (dest_ip_end != "*"){
			if (!check_address(temp_dst_ip2)){
				return false;
			}
		}
		if (dest_ip_start != "*" && dest_ip_end != "*"){
			if (iface_dest == "LAN"){
			if (!check_ip_order(temp_dst_ip1, temp_dst_ip2)){
				alert(msg[MSG4]);
				return false;
			}
				if (!check_domain(temp_ip_obj, temp_mask_obj, temp_dst_ip1)){
						alert(addstr(msg[MSG2],"Destination start IP address"));
						return false;
				}
				if (!check_domain(temp_ip_obj, temp_mask_obj, temp_dst_ip2)){
						alert(addstr(msg[MSG2],"Destination end IP address"));
						return false;
				}
			}
			else{
				//if (!check_domain(temp_wan_ip_obj, temp_wan_mask_obj, temp_dst_ip1)){
					//alert(addstr(msg[MSG2],"Destination start IP address"));
					//return false;
				//}
				//if (!check_domain(temp_wan_ip_obj, temp_wan_mask_obj, temp_dst_ip2)){
					//alert(addstr(msg[MSG2],"Destination end IP address"));
					//return false;
				//}
				if (!check_ip_order(temp_dst_ip1, temp_dst_ip2)){
					alert(msg[MSG4]);
					return false;
				}
			}
		}
		//dest_port	
        if (proto == "TCP" || proto == "UDP"){
			if (dest_port_start != "*"){
				if (dest_port_end == "*"){
					dest_port_end = dest_port_start;
				}	
			}	
			if (dest_port_start != "*"){
				if (!check_port(dest_port_start)){
					alert(msg[MSG25]);
					return false;
				}
			}	
			if (dest_port_end != "*"){
				if (!check_port(dest_port_end)){
					alert(msg[MSG25]);
					return false;
				}
			}
			if (dest_port_start != "*" && dest_port_end != "*"){
				if (!check_port_order(dest_port_start, dest_port_end)){
					alert(msg[MSG52]);
					return false;
				}		
			}	
		}
		else{
			if (dest_port_start != "*"){
				dest_port_start = "*";
			}	
			if (dest_port_end != "*"){
				dest_port_end = "*";
			}			
		}	
		//save data update,update priority 
		if(index > -1){
			DataArray[index].Enable = get_checked_value(get_by_name("enable"));
			DataArray[index].Action = get_checked_value(get_by_name("action"));
			DataArray[index].Name = firewall_name;
			DataArray[index].Iface_src = iface_src;
			DataArray[index].Src_ip_start = src_ip_start;
			DataArray[index].Src_ip_end = src_ip_end;
			DataArray[index].Iface_dest = iface_dest;
			DataArray[index].Dest_ip_start = dest_ip_start;
			DataArray[index].Dest_ip_end = dest_ip_end;			
			DataArray[index].Proto = proto;
			DataArray[index].Dest_port_start = dest_port_start;
			DataArray[index].Dest_port_end = dest_port_end;	
			DataArray[index].schedule = "Always";
			
		}else{//save data add
			var max_num = DataArray.length;						
			if(parseInt(max_num,10)> rule_max_num){
				alert("The allowed number of firewall rule is "+ rule_max_num)
				return false;
			}
			//double name check
			for(i=0;i<DataArray.length;i++){
			if(DataArray[i].Name == get_by_id("name").value){
					alert(addstr(msg[MSG41],"firewall name"));
					return false;				
				}			
			}			
				DataArray[DataArray.length++] = new Data(get_checked_value(get_by_name("enable")),firewall_name, iface_src, proto, src_ip_start, src_ip_end, iface_dest, dest_ip_start ,dest_ip_end ,dest_port_start,dest_port_end,"Always", get_checked_value(get_by_name("action")),DataArray.length);
			}					
		save_to_cfg();
		get_by_id("reboot_type").value = "filter";
    	return true;
	}
	
	function save_to_cfg(){
		for(var k = 0; k < rule_max_num; k++){
			var now_num = k;
			var temp_fr = "";
			if(k<10){
				now_num = "0"+k;
			}			
			if(k<DataArray.length){
				if (k>2){
			    temp_fr = DataArray[k].Enable + "/" + DataArray[k].Name + "/" + DataArray[k].Iface_src 
					+ "/" + DataArray[k].Proto +"/"+ DataArray[k].Src_ip_start 
					+ "/" + DataArray[k].Src_ip_end + "/"+ DataArray[k].Iface_dest 
					+ "/" + DataArray[k].Dest_ip_start + "/" + DataArray[k].Dest_ip_end
					+ "/" + DataArray[k].Dest_port_start + "/" + DataArray[k].Dest_port_end
					+  "/Always/" + DataArray[k].Action;
				}
				else{
					temp_fr = DataArray[k].Enable + "/" + DataArray[k].Name + "/" + DataArray[k].Iface_src 
					+ "/" + DataArray[k].Proto +"/"+ DataArray[k].Src_ip_start 
					+ "/" + DataArray[k].Src_ip_end + "/"+ DataArray[k].Iface_dest 
					+ "/" + DataArray[k].Dest_ip_start + "/" + DataArray[k].Dest_ip_end
					+ "/" + DataArray[k].Dest_port_start + "/" + DataArray[k].Dest_port_end
					+  "/Never/" + DataArray[k].Action;
				}
					
			}
			get_by_id("firewall_rule_"+now_num).value = temp_fr;
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
                  <td><a href="firewall_setting.asp" class="submenus"><b><u>Firewall Settings</u></b></a></td>
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
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p></td>
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
                <td width="85%" class="headerbg">Firewall Setting </td>
                <td width="15%" class="headerbg"><a href="help_access.asp#access_firewall_setting" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                    </tr>
                  </table>
				  <form id="form1" name="form1" method="post" action="apply.cgi">
				  	<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
                    <input type="hidden" id="html_response_message" name="html_response_message" value="Settings Saved.">
                    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="firewall_setting.asp">
                    <input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                                    
							<input type="hidden" id="firewall_rule_00" name="firewall_rule_00" value="<% CmoGetCfg("firewall_rule_00","none"); %>">
							<input type="hidden" id="firewall_rule_01" name="firewall_rule_01" value="<% CmoGetCfg("firewall_rule_01","none"); %>">
						  <input type="hidden" id="firewall_rule_02" name="firewall_rule_02" value="<% CmoGetCfg("firewall_rule_02","none"); %>">
						  <input type="hidden" id="firewall_rule_03" name="firewall_rule_03" value="<% CmoGetCfg("firewall_rule_03","none"); %>">
						  <input type="hidden" id="firewall_rule_04" name="firewall_rule_04" value="<% CmoGetCfg("firewall_rule_04","none"); %>">
						  <input type="hidden" id="firewall_rule_05" name="firewall_rule_05" value="<% CmoGetCfg("firewall_rule_05","none"); %>">
						  <input type="hidden" id="firewall_rule_06" name="firewall_rule_06" value="<% CmoGetCfg("firewall_rule_06","none"); %>">
						  <input type="hidden" id="firewall_rule_07" name="firewall_rule_07" value="<% CmoGetCfg("firewall_rule_07","none"); %>">
						  <input type="hidden" id="firewall_rule_08" name="firewall_rule_08" value="<% CmoGetCfg("firewall_rule_08","none"); %>">
						  <input type="hidden" id="firewall_rule_09" name="firewall_rule_09" value="<% CmoGetCfg("firewall_rule_09","none"); %>">
						  <input type="hidden" id="firewall_rule_10" name="firewall_rule_10" value="<% CmoGetCfg("firewall_rule_10","none"); %>">
						  <input type="hidden" id="firewall_rule_11" name="firewall_rule_11" value="<% CmoGetCfg("firewall_rule_11","none"); %>">
						  <input type="hidden" id="firewall_rule_12" name="firewall_rule_12" value="<% CmoGetCfg("firewall_rule_12","none"); %>">
						  <input type="hidden" id="firewall_rule_13" name="firewall_rule_13" value="<% CmoGetCfg("firewall_rule_13","none"); %>">
						  <input type="hidden" id="firewall_rule_14" name="firewall_rule_14" value="<% CmoGetCfg("firewall_rule_14","none"); %>">
						  <input type="hidden" id="firewall_rule_15" name="firewall_rule_15" value="<% CmoGetCfg("firewall_rule_15","none"); %>">
						  <input type="hidden" id="firewall_rule_16" name="firewall_rule_16" value="<% CmoGetCfg("firewall_rule_16","none"); %>">
						  <input type="hidden" id="firewall_rule_17" name="firewall_rule_17" value="<% CmoGetCfg("firewall_rule_17","none"); %>">
						  <input type="hidden" id="firewall_rule_18" name="firewall_rule_18" value="<% CmoGetCfg("firewall_rule_18","none"); %>">
						  <input type="hidden" id="firewall_rule_19" name="firewall_rule_19" value="<% CmoGetCfg("firewall_rule_19","none"); %>">
						  <input type="hidden" id="firewall_rule_20" name="firewall_rule_10" value="<% CmoGetCfg("firewall_rule_20","none"); %>">
						  <input type="hidden" id="firewall_rule_21" name="firewall_rule_21" value="<% CmoGetCfg("firewall_rule_21","none"); %>">
						  <input type="hidden" id="firewall_rule_22" name="firewall_rule_22" value="<% CmoGetCfg("firewall_rule_22","none"); %>">
						  <input type="hidden" id="firewall_rule_23" name="firewall_rule_23" value="<% CmoGetCfg("firewall_rule_23","none"); %>">
						  <input type="hidden" id="firewall_rule_24" name="firewall_rule_24" value="<% CmoGetCfg("firewall_rule_24","none"); %>">
						  <input type="hidden" id="firewall_rule_25" name="firewall_rule_25" value="<% CmoGetCfg("firewall_rule_25","none"); %>">
						  <input type="hidden" id="firewall_rule_26" name="firewall_rule_26" value="<% CmoGetCfg("firewall_rule_26","none"); %>">
						  <input type="hidden" id="firewall_rule_27" name="firewall_rule_27" value="<% CmoGetCfg("firewall_rule_27","none"); %>">
						  <input type="hidden" id="firewall_rule_28" name="firewall_rule_28" value="<% CmoGetCfg("firewall_rule_28","none"); %>">
						  <input type="hidden" id="firewall_rule_29" name="firewall_rule_29" value="<% CmoGetCfg("firewall_rule_29","none"); %>">
						  <input type="hidden" id="firewall_rule_30" name="firewall_rule_30" value="<% CmoGetCfg("firewall_rule_30","none"); %>">
              <input type="hidden" id="edit_row" name="edit_row">
              <input type="hidden" id="wan_port_ping_response_enable" name="wan_port_ping_response_enable" value="<% CmoGetCfg("wan_port_ping_response_enable","none"); %>">
      		<input type="hidden" id="edit_row" name="edit_row">
      		<input type="hidden" id="row_sequence"  name="row_sequence"> 
      		<input type="hidden" id="prior_list"  name="prior_list">   
      		<input type="hidden" id="temp_row"  name="temp_row">  
      		<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
      		<input type="hidden" id="lan_netmask" name="lan_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>"> 
      		<input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">           		
                    
                    <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#FFFFFF">
                      <tr>
                 <td width="150" align="right" class="bgblue">Enable</td>
                 <td colspan="4" bgcolor="#FFFFFF" class="bggrey">
                 <input type="radio" name="enable" value="1">
                    Enable
                 	<input type="radio" name="enable" value="0" checked>
                    Disabled 
                 </td>
                      </tr>
                      <tr>
                 <td align="right" class="bgblue">Name</td>
 								 <td colspan="4" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="name" name="name" size="20" maxlength="31" value=""></td>
                      </tr>
                      <tr>
								 <td align="right" class="bgblue">Action</td>
								 <td colspan="4" bgcolor="#FFFFFF" class="bggrey">
					<input type="radio" name="action" value="Allow">
								 Allow
					<input type="radio" name="action" value="Deny" checked>
								 Deny</td>
							</tr>
 							<tr bgcolor="#339900">
								 <td align="right" class="bgblue"><font color="#FFFFFF"></font></td>
								 <td width="67" bgcolor="#CCCCCC"><b><font color="#666666" size="2">Interface</font></b></td>
								 <td width="106" bgcolor="#CCCCCC"><b><font color="#666666" size="2">IP
								 Range Start</font></b></td>
								 <td width="96" bgcolor="#CCCCCC"><b><font color="#666666" size="2">IP
								 Range End</font></b></td>
								 <td width="128" bgcolor="#CCCCCC"><b><font color="#666666" size="2">Protocol</font></b></td>
							 </tr>
					     <tr>
								 <td align="right" class="bgblue">Source</td>
								 <td width="67" bgcolor="#FFFFFF" class="bggrey">
					<select size="1" id="iface_src" name="iface_src" selected>
					<!-- <option value="*">*</option> -->
					<option value="LAN" selected>LAN</option>
					<option value="WAN">WAN</option>
								 </select></td>
					<td width="106" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="src_ip_start" name="src_ip_start" size="16" maxlength="15" value="*"></td>
					<td width="96" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="src_ip_end" name="src_ip_end" size="16" maxlength="15" value="*"></td>
								 <td bgcolor="#FFFFFF" class="bggrey">&nbsp;</td>
               </tr>
               <tr>
								 <td align="right" class="bgblue">Destination</td>
								 <td width="67" bgcolor="#FFFFFF" class="bggrey">
					<select size="1" id="iface_dest" name="iface_dest">
					<!--<option value="*">*</option>-->
					<option value="LAN">LAN</option>
					<option value="WAN" selected>WAN</option>
 								 </select></td>
					<td width="106" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="dest_ip_start" name="dest_ip_start" size="16" maxlength="15" value="*"></td>
					<td width="96" bgcolor="#FFFFFF" class="bggrey"><input type="text" id="dest_ip_end" name="dest_ip_end" size="16" maxlength="15" value="*"></td>
								 <td bgcolor="#FFFFFF" class="bggrey">
								 <table width="100%" border="0" cellpadding="3" cellspacing="1">
									 <tr>
										 <td>
							 <select size="1" id="proto" name="proto" onChange="check_proto()">
							 <option value="TCP">TCP</option>
							 <option value="UDP">UDP</option>
							 <option value="ICMP">ICMP</option>
							 <option value="Any" selected>*</option>
	          	      	</select></td>
                      </tr>
                      <tr>
										 <td>
							<input type="text" id="dest_port_start" name="dest_port_start" size="6" maxlength="5" value="*" disabled>
										-
							<input type="text" id="dest_port_end" name="dest_port_end" size="6" maxlength="5" value="*" disabled></td>
                      </tr>
                    </table>
 								 </td>
               </tr>
               <tr>
 									<td colspan="5" align="left" class="bggrey2">
                 	<input type="submit" id="add" name="add" value="Add" onClick="return send_request()">		  	
				 	<input type="submit" id="update" name="update" value="Update" disabled onClick="return send_request()">
				 	<input type="submit" id="del" name="del" value="Delete" disabled onClick="return del_row()">
				 	<input type="button" id="cancel" name="cancel" value="Cancel" onClick="clear_row()">
				 	<input type="button" id="up" name="up" value="Priority Up" disabled onclick="change_priority(-1)" > 
				 	<input type="button" id="down" name="down" value="Priority down" disabled onclick="change_priority(1)"> 
				 	<input type="submit" id="priority" name="priority" value="Update Priority" disabled onclick="return send_request()"> 
                  </td>
                      </tr>
                    </table>
 							 <input name="row_index" value="" type="hidden">
            </form>
						<table id="table1" width="100%" border="0" bgcolor="#FFFFFF">
 <tr>
 <td align="center" bgcolor="#C5CEDA"><font face="Arial" color="#FFFFFF"></font></td>
 <td align="center" bgcolor="#C5CEDA"><b>Action</b></td>
 <td align="center" bgcolor="#C5CEDA"><b>Name</b></td>
 <td align="center" bgcolor="#C5CEDA"><b>Source</b></td>
 <td align="center" bgcolor="#C5CEDA"><b>Destination</b></td>
 <td align="center" bgcolor="#C5CEDA"><b>Protocol</b></td>
                      </tr>
                      <script>DataShow();</script>
                    </table>
                  <br>
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
