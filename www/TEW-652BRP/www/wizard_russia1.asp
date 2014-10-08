<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function loadSettings(){
		get_by_name("country")[0].checked = true;
		//get_by_name("ConnType")[0].checked = true;
		
		var connect_type = get_by_id("asp_temp_56").value;
		//var connect_type1 = get_by_id("asp_temp_58").value;
		
			//if(connect_type=="wizard_russia2.asp"){
			//	get_by_name("ConnType")[0].checked = true;
			//}else if(connect_type=="wizard_russia4.asp"){
			//	get_by_name("ConnType")[1].checked = true;
			//}else{
			//	get_by_name("ConnType")[0].checked = true;
			//}
			//if(connect_type1=="wizard_russia5.asp"){
			//	get_by_name("ConnType1")[0].checked = true;
			//}else if(connect_type1=="wizard_russia6.asp"){
			//	get_by_name("ConnType1")[1].checked = true;
			//}else{
			//	get_by_name("ConnType1")[0].checked = true;
		//	}
		
	}
	function serviceList(){
		var city_temp =get_by_id("city").value;
		var service_status = get_by_id("service");
		var show_service = get_by_id("show_service").style.display = "";
			
		if(city_temp == "Domodedovo" || city_temp == "Orenburg"){
			service_status.innerHTML = "<select id=\"asp_temp_57\" name=\"asp_temp_57\" onChange=\"ITEMDATA(this)\"><option value=\"Select\">Select</option><option value=\"PPTP\">PPTP</option></select>";
			}else{
			service_status.innerHTML = "<select id=\"asp_temp_57\" name=\"asp_temp_57\" onChange=\"ITEMDATA(this)\">"
										+"<option value=\"Select\">Select</option>"
										+"<option value=\"PPTP\">PPTP</option>"
										+"<option value=\"L2TP\">L2TP</option></select>";
			}
	}
	function ITEMDATA(obj){
		var city_temp =get_by_id("city").value;
		var service = obj.options[obj.selectedIndex].value;

		var url_pptp,url_l2tp;
		if(city_temp == "Moscow" && service == "PPTP" || city_temp == "Balashikha" && service == "PPTP" ||city_temp == "Domodedovo" && service == "PPTP" 
		||city_temp == "Noginsk" && service == "PPTP" ){
			url_pptp = "vpn.corbina.net";
		}else if(city_temp == "Noginsk" && service == "L2TP" ||city_temp == "Balashikha" && service == "L2TP"){
			url_l2tp = "vpn.corbina.net";
		}else if(city_temp == "Moscow" && service == "L2TP"){
			url_l2tp = "tp.corbina.net";
		}else if(city_temp == "St.Petersburg" && service == "PPTP"){
			url_pptp = "vpn.spb.corbina.net";
		}else if(city_temp == "St.Petersburg" && service == "L2TP"){
			url_l2tp = "tp.spb.corbina.net";
		}else if(city_temp == "Yaroslavl" && service == "PPTP"){
			url_pptp = "vpn.yar.corbina.net";
		}else if(city_temp == "Yaroslavl" && service == "L2TP"){
			url_l2tp = "tp.yar.corbina.net";
		}else if(city_temp == "Tula" && service == "PPTP"){
			url_pptp = "vpn.tul.corbina.net";
		}else if(city_temp == "Tula" && service == "L2TP"){
			url_l2tp = "tp.tul.corbina.net";
		}else if(city_temp == "Kaluga" && service == "PPTP"){
			url_pptp = "vpn.klg.corbina.net";
		}else if(city_temp == "Kaluga" && service == "L2TP"){
			url_l2tp = "tp.klg.corbina.net";
		}else if(city_temp == "Volgograd" && service == "PPTP"){
			url_pptp = "vpn.vlg.corbina.net";
		}else if(city_temp == "Volgograd" && service == "L2TP"){
			url_l2tp = "tp.vlg.corbina.net";
		}else if(city_temp == "Rostov-on-Don" && service == "PPTP"){
			url_pptp = "vpn.rnd.corbina.net";
		}else if(city_temp == "Rostov-on-Don" && service == "L2TP"){
			url_l2tp = "tp.rnd.corbina.net";
		}else if(city_temp == "Saratov" && service == "PPTP"){
			url_pptp = "vpn.sar.corbina.net";
		}else if(city_temp == "Saratov" && service == "L2TP"){
			url_l2tp = "tp.sar.corbina.net";
		}else if(city_temp == "Ulyanovsk" && service == "PPTP"){
			url_pptp = "vpn.ul.corbina.net";
		}else if(city_temp == "Ulyanovsk" && service == "L2TP"){
			url_l2tp = "tp.ul.corbina.net";
		}else if(city_temp == "Orenburg" && service == "PPTP"){
			url_pptp = "vpn.orb.corbina.net";
		}	
		var conn = get_by_id("show_connType");
		if(service=="PPTP"){
			conn.innerHTML ="<input type=\"radio\" name=\"ConnType\"  value=\"wizard_russia2.asp\" checked>"
						+"Select from the list (advised)<br>"
						+"<input type=\"radio\" name=\"ConnType\" value=\"wizard_russia4.asp\">"
                  		+"</font>Manual setup";
		}else if(service=="L2TP"){
			conn.innerHTML ="<input type=\"radio\" name=\"ConnType\"  value=\"wizard_russia5.asp\" checked>"
						+"Select from the list (advised)<br>"
						+"<input type=\"radio\" name=\"ConnType\" value=\"wizard_russia6.asp\">"
                  		+"</font>Manual setup";
		}
		
	}
	
	function send_request(){
		var conn_type = get_checked_value(get_by_name("ConnType"));
		if(get_by_id("city").value =="Select"){
			alert("Please select one City");
			return false;
		}
		if(get_by_id("asp_temp_57").value =="Select"){
			alert("Please select one service");
			return false;
		}
		get_by_id("asp_temp_56").value = conn_type;		
		get_by_id("html_response_page").value = conn_type;
		get_by_id("asp_temp_49").value = "0"; //Russia l2tp disable
		get_by_id("asp_temp_48").value = "0"; //Russia pptp disable	
		send_submit("form1");
	}	
</script>
</head>

<body text="#000000" leftmargin="0" topmargin="0" onLoad="loadSettings();">
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
                <td class="headerbg">Set Internet Connection</td>
              </tr>
            </table>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page">
          		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_russia1.asp">
          		<input type="hidden" id="reboot_type" name="reboot_type" value="none">
          		<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
          		<input type="hidden" id="wan_lwtp_russia_enable" name="wan_lwtp_russia_enable" value="<% CmoGetCfg("wan_lwtp_russia_enable","none"); %>">
	  			<input type="hidden" id="asp_temp_22" name="asp_temp_22" value="<% CmoGetCfg("asp_temp_22"); %>">
	  			<input type="hidden" id="asp_temp_56" name="asp_temp_56" value="<% CmoGetCfg("asp_temp_56","none"); %>">
	  			<input type="hidden" id="asp_temp_48" name="asp_temp_48" value="<% CmoGetCfg("asp_temp_48","none"); %>">
	  			<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetCfg("asp_temp_49","none"); %>">
	  			<input type="hidden" id="asp_temp_29" name="asp_temp_29" value="<% CmoGetCfg("asp_temp_29"); %>">
	  			
              
              <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
                <tr>
                  <td width="144" align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Country</font></td>
                  <td width="235" bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                    <input type="radio" name="country" value="1">
                  </font>Russia
                  </font></td>
                </tr>
                <tr id="russia_pptp">
                  <td align="right" bgcolor="#FFFFFF" class="bgblue">City</td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                    <select id="city" name="city" onChange="serviceList()">
                    	<option value="Select">Select</option> 
						<option value="Moscow">Moscow</option> 
						<option value="Balashikha">Balashikha</option> 
						<option value="Domodedovo">Domodedovo</option> 
						<option value="Noginsk">Noginsk</option> 
						<option value="St.Petersburg">St.Petersburg</option> 
						<option value="Yaroslavl">Yaroslavl</option> 
						<option value="Tula">Tula</option> 
						<option value="Kaluga">Kaluga</option> 
						<option value="Orenburg">Orenburg</option> 
						<option value="Volgograd">Volgograd</option> 
						<option value="Rostov-on-Don">Rostov-on-Don</option> 
						<option value="Saratov">Saratov</option> 
						<option value="Ulyanovsk">Ulyanovsk</option> 
                    </select>
                  </font>
                  </font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Provider</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                  <font face="Arial" color="#000000"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                    <font face="Arial" color="#000000"><font face="Arial" color="#000000"><font face="Arial" color="#000000"><font face="Arial" color="#000000"><font face="Arial" color="#000000">
                  <select id="select" name="select">
                    <option value="sm-server">Corbina telecom</option>
                  </select>
                    </font></font></font></font></font> </font></font></font> 
                    </font></font> </font></td>
                </tr>
                <tr id= "show_service" style="display:none">
                  <td align="right" bgcolor="#FFFFFF" class="bgblue"><font face="Arial">Service</font></td>
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <font face="Arial" color="#000000"><font face="Arial" color="#000000">
                  <span id= "service"></span>
                  
                  </font></font></font></td>
                </tr>
                <tr>
                  <td align="right" bgcolor="#FFFFFF" class="bgblue">
                  <td bgcolor="#FFFFFF" class="bggrey"><font face="Arial" color="#000000">
                  <span id= "show_connType"></span>
					</td>
                </tr>
              </table>
               <br>
               <input type="button" value="&lt; Back" id="back" name="back" onClick="window.location='wizard3.asp'">
               <input type="button" value="Next &gt;" id="next" name="next" onClick="send_request()">
               <input type="button" id="exit" name="exit" value="Exit" onClick="exit_wizard()">
              
              </form>
            </td>
            <td width="7%"><img src="spacer.gif" width="30" height="60"></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td height="14"><img src="bg_wizard_4.gif" width="459"></td>
    </tr>
</table>
</body>

</html>
