<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>TRENDNET | TEW-652BRP | Main | LAN &amp; DHCP Server</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
function encode_base64(psstr) {
   		return encode(psstr,psstr.length); 
}

function encode (psstrs, iLen) {
	 var map1="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   var oDataLen = (iLen*4+2)/3;
   var oLen = ((iLen+2)/3)*4;
   var out='';
   var ip = 0;
   var op = 0;
   while (ip < iLen) {
      var xx = psstrs.charCodeAt(ip++);
      var yy = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
      var zz = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
      var aa = xx >>> 2;
      var bb = ((xx &   3) << 4) | (yy >>> 4);
      var cc = ((yy & 0xf) << 2) | (zz >>> 6);
      var dd = zz & 0x3F;
      out += map1.charAt(aa);
      op++;
      out += map1.charAt(bb);
      op++;
      out += op < oDataLen ? map1.charAt(cc) : '='; 
      op++;
      out += op < oDataLen ? map1.charAt(dd) : '='; 
      op++; 
   }
   return out; 
}

function check()
{
	var pwd=get_by_id("login_pass").value;
		if(get_by_id("login_n").value=="")
		{
			alert("Please input the User Name.");
			return false;
		}
	get_by_id("login_name").value=encode_base64(get_by_id("login_n").value);
	get_by_id("login_pass").value=encode_base64(pwd);
	return true;
}
</script>
<style type="text/css">
<!--
.style1 {color: #006699}
-->
</style>
</head>

<body onLoad="MM_preloadImages('but_help1_1.gif')">
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
          <td width="78%" valign="top">
		  <table width="99%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10"><img src="c2_tl.gif" width="10" height="10"></td>
              <td width="684" background="bg2_t.gif"><img src="spacer.gif" width="10" height="10"></td>
              <td width="10"><img src="c2_tr.gif" width="10" height="10"></td>
            </tr>
            <tr>
              <td background="bg2_l.gif">&nbsp;</td>
              <td height="400" valign="top" background="bg3.gif">
                <p>&nbsp;</p>
                <table width="80%" border="0" align="center">
    <tr>
                    <td height="10">
<div id=box_header>
        <H1 align="left" class="style1">Login</H1>
        <div align="left">
          Log in to the router<p>
				<form name="form1" id="form1" action="login.cgi" method="post">
				<input type="hidden" name="html_response_page" value="login_fail.asp">
				<input type="hidden" name="login_name" id="login_name">
          <table width="311" border="0" align="center">
            <tr>
              <td width="102"><strong>User Name&nbsp;:</strong></td>
              <td width="193"><input name="login_n" type="text" id="login_n" maxlength="15" style="width: 153px"></td>
            </tr>
            <tr>
              <td><strong>Password&nbsp;:</strong></td>
              <td><input type="password" name="login_pass" id="login_pass" maxlength="15" style="width: 153px">
                   <input type="submit" name="login" value="Log In" onclick="return check();">
              </td>
            </tr>
          </table></form>
          <p>&nbsp;</p>
        </div>
      </div></td>
      </tr>
  </table>				</td>
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
