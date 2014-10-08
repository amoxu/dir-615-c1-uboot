<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Routing | Routing Table</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var DataArray = new Array();
	var rule_max_num = 40;
	
	function DataShow(){
		set_routes();
		for (var i=0; i<DataArray.length;i++){
			document.write("<tr bgcolor=\"#F0F0F0\">");
			document.write("<td>"+ DataArray[i].Ip_addr +"</td>");
			document.write("<td>"+ DataArray[i].Net_mask +"</td>");
			document.write("<td>"+ DataArray[i].Gateway +"</td>");
			document.write("<td>"+ DataArray[i].Show_int +"</td>");
			document.write("<td>"+ DataArray[i].Metric +"</td>");
			document.write("<td>"+ DataArray[i].Type +"</td>");
			document.write("</tr>\n");
		}
	}
	
	//0/name/192.168.31.0/255.255.255.0/192.168.31.1/192.168.31.1/20
	function Data(enable, name, ip_addr, net_mask, gateway, interface, show_inter, metric, type, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = interface;
		this.Show_int = change_inter(show_inter);
		this.Metric = metric;
		this.Type = type;
		this.OnList = onList;
	}
	
	function change_inter(obj_value){
		var return_word = obj_value;
		if(obj_value == "br0"){
			return_word = "LAN";
		}else if(obj_value == "eth1"){
			return_word = "WAN";
		}else if(obj_value == "lo"){
			return_word = "Local Loopback";
		}
		return return_word;
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
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3], temp_st[4], temp_st[5], temp_st[5], temp_st[6], "Static", index);
					index++;
				}
			}
		}
		
		var myData = get_by_id("routing_table").value.split(",");
		var temp_data;
		for (var i=0 ; i<myData.length;i++){
			temp_data = myData[i].split("/");
			if(temp_data.length > 1){				
				var is_not_check= true;
				for(var j=0;j<DataArray.length;j++){
					if(temp_data[0] == DataArray[j].Ip_addr && temp_data[1] == DataArray[j].Net_mask && temp_data[2] == DataArray[j].Gateway){
						is_not_check = false;
						break;
					}
				}
				
				if(is_not_check){
					DataArray[DataArray.length++] = new Data(0, i , temp_data[0], temp_data[1], temp_data[2], temp_data[3], temp_data[3], temp_data[4], "Dynamic", index);
					index++;
				}
			}	
				
		}
	}
</SCRIPT>
</head>

<body onLoad="MM_preloadImages('but_wizard_1.gif','but_status_1.gif','but_tools_1.gif','but_main_1.gif','but_wireless_1.gif','but_routing_1.gif','but_access_1.gif','but_management_1.gif','but_help1_1.gif')">
<!-- New Variable -->
<input type="hidden" id="static_routing_00" name="static_routing_00" value="<% CmoGetCfg("static_routing_00","none"); %>">
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
<input type="hidden" id="routing_table" name="routing_table" value="<% CmoGetList("routing_table"); %>">
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
                    <td width="87%"><a href="static_routing.asp" class="submenus"><b>Static</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="dynamic_routing.asp" class="submenus"><b>Dynamic</b></a></td>
                  </tr>
                  <tr>
                    <td align="right"><font color="#FFFFFF">&bull;</font></td>
                    <td><a href="routing_table.asp" class="submenus"><b><u>Routing Table </u></b></a></td>
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
              <td height="400" valign="top" background="bg3.gif"><table width="100%" border="0" cellpadding="3" cellspacing="0">
                  <tr>
                    <td width="85%" class="headerbg">Routing Table </td>
                    <td width="15%" class="headerbg"><a href="help_routing.asp#routing_routing_table" target="_blank"><img src="but_help1_0.gif" width="69" height="28" border="0" id="Image8" onMouseOver="MM_swapImage('Image8','','but_help1_1.gif',1)" onMouseOut="MM_swapImgRestore()"></a></td>
                  </tr>
                </table>
                <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
<tr>
<td align="center" bgcolor="#C5CEDA"><b>Network Address</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Network Mask</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Gateway Address</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Interface</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Metric</b></td>
<td align="center" bgcolor="#C5CEDA"><b>Type</b></td>
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
