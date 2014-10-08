<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html;">
<script language="JavaScript" src="public.js"></script>
</head>
<body>

	<script language="javascript" type="text/javascript">
	<!-- hide script from old browsers
	var dsl_mode="<% CmoGetCfg("wan_proto","none"); %>";
	var conn_type="<% CmoGetCfg("asp_temp_60","none"); %>";
	var rus_pppoe = "<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>";
	var rus_pptp = "<% CmoGetCfg("wan_pptp_russia_enable","none"); %>";
	var rus_l2tp = "<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>";
	var dsl_asp = "wan_dhcp.asp";
	
	if(dsl_mode=="pppoe" && rus_pppoe =="1"){
		dsl_asp = "wan_russia_poe.asp";
	}else if(dsl_mode=="pppoe"){
		dsl_asp = "wan_poe.asp";
	}else if(dsl_mode =="pptp" && rus_pptp =="1"){
		dsl_asp="wan_russia_pptp.asp";
	}else if(dsl_mode =="l2tp" && rus_l2tp =="1"){
		dsl_asp="wan_russia_l2tp.asp";
	}else if(dsl_mode=="pptp"){
		dsl_asp="wan_pptp.asp";
	}else if(dsl_mode=="bigpond"){
		dsl_asp="wan_bigpond.asp";
	}else if(dsl_mode=="l2tp"){
		dsl_asp="wan_l2tp.asp";
	}
	window.location.href=dsl_asp;
	//-->
	</script>
</body>
</html>