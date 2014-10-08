<html>
<head>
<title>TRENDNET | TEW-652BRP | Wizard</title>
<meta http-equiv="Content-Type" content="text/html;">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="javascript" type="text/javascript">
<!-- hide script from old browsers
function loadSettings(){
	var dsl_mode="<%  CmoGetStatus("internet_connect_type"); %>";
	if(dsl_mode=="pppoe"){
		get_by_id("html_response_page").value="wizard5c.asp";
	}else if(dsl_mode=="dhcp"){
		get_by_id("html_response_page").value="wizard5a.asp";
	}else{
		get_by_id("html_response_page").value="wizard5.asp";
	}
	window.location.href=get_by_id("html_response_page").value;
}
//-->
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" onLoad="loadSettings();">
<form id="formname" name="formname" method="post">
<input type="hidden" id="html_response_page" name="html_response_page">
</form>
</body>
</html>
