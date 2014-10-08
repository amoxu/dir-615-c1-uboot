<HTML>
 <HEAD>
  <!-- $MVD$:app("RoboHELP HTML Edition by Blue Sky Software, portions by MicroVision Dev. Inc.","769") -->
  <!-- $MVD$:template("","0","0") -->
  <!-- $MVD$:fontset("Arial","Arial") -->
  <!-- $MVD$:fontset("Times New Roman","Times New Roman") -->
  <!-- $MVD$:fontset("Arial Narrow","Arial Narrow") -->
  <TITLE>Main</TITLE>
<link rel="stylesheet" href="style.css" type="text/css">
 </HEAD>
  
<BODY bgcolor=#FFFFFF>
<table width="100%" border="0" cellpadding="5" cellspacing="5" bgcolor="#F0F0F0">
  <tr>
    <td bgcolor="#C5CEDA"><table width="100%" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
          <font size="6">Main Screen</font></td>
      </tr>
    </table>
      <P>The main screen enables you to configure the <A HREF="glossary.asp#def_LAN">LAN</A> &amp; <A HREF="glossary.asp#def_dhcp">DHCP</A> Server, set <A HREF="glossary.asp#def_WAN">WAN</A> parameters, create <A HREF="glossary.asp#def_administrator">Administrator</A> and User passwords, and set the local time, time zone, and default <A HREF="glossary.asp#def_NTP">NTP</A> server.</P>
      <P> Click the items below for more information:</P>
      <UL>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#lanski_dhcp_server">LAN &amp; DHCP Server</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#main_wan">WAN</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#main_password">Password</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#main_time">Time</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#main_ddns">Dynamic DNS</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#tools_setup_wizard">Setup Wizard</A></b></P>
      </UL>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
          <font color="#FFFFFF" >LAN &amp; DHCP Server</font><a name="lanski_dhcp_server"></a></td>
        </tr>
      </table>
      <P>This page enables you to set <A HREF="glossary.asp#def_LAN">LAN</A> and <A HREF="glossary.asp#def_dhcp">DHCP</A> properties, such as the <A HREF="glossary.asp#def_host_name">host
name</A>, <A HREF="glossary.asp#def_ip_address">IP address</A>, <A HREF="glossary.asp#def_subnet_mask">subnet
mask</A>, and <A HREF="glossary.asp#def_domain_name">domain name</A>.
LAN and DHCP profiles are listed in the DHCP table at the bottom of
the screen.</P>
      <P> <SPAN STYLE="font-weight : bold;">Host Name:</SPAN><A NAME="lan&amp;dhcp_server_hostname"></A> Type the <A HREF="glossary.asp#def_host_name">host name</A> in the
        text box. The host name is required by some <A HREF="glossary.asp#def_ISP">ISP</A>s.
        The default host name is &quot;TEW-652BRP&quot;</P>
      <P> <SPAN STYLE="font-weight : bold;">IP Address:</SPAN><A NAME="lan_dhcp_server_ipaddress"></A> This is the <A HREF="glossary.asp#def_ip_address">IP address</A> of
        the router. The default IP address is 192.168.10.1.</P>
      <P> <SPAN STYLE="font-weight : bold;">Subnet Mask:</SPAN><A NAME="lan_dhcp_server_subnet_mask"></A> Type the <A HREF="glossary.asp#def_subnet_mask">subnet mask</A> for
        the router in the text box. The default subnet mask is <SPAN STYLE="font-style : normal;">255.255.255.0.</SPAN></P>
      <P> <SPAN STYLE="font-weight : bold;">DHCP Server:</SPAN><A NAME="lan_dhcp_server_dhcp_server"></A> Enables the <A HREF="glossary.asp#def_dhcp">DHCP</A> server to allow
        the router to automatically assign IP addresses to devices connecting
        to the <A HREF="glossary.asp#def_LAN">LAN</A>. DHCP is enabled by default.</P>
      <P> All DHCP client computers are listed in the table at the bottom of
        the screen, providing the host name, IP address, and <A HREF="glossary.asp#def_MAC_address">MAC
          address</A> of the client.</P>
      <P> <SPAN STYLE="font-weight : bold;">Start IP:</SPAN><A NAME="lan_dhcp_server_start_ip"></A> Type an <A HREF="glossary.asp#def_ip_address">IP address</A> to serve
        as the start of the IP range that <A HREF="glossary.asp#def_dhcp">DHCP</A> will use to assign IP addresses to all <A HREF="glossary.asp#def_LAN">LAN</A> devices connected to the router.</P>
      <P> <SPAN STYLE="font-weight : bold;">End IP:</SPAN><A NAME="lan_dhcp_server_end_ip"></A> Type an <A HREF="glossary.asp#def_ip_address">IP address</A> to serve
        as the end of the IP range that <A HREF="glossary.asp#def_dhcp">DHCP</A> will use to assign IP addresses to all <A HREF="glossary.asp#def_LAN">LAN</A> devices connected to the router.</P>
      <P> <SPAN STYLE="font-weight : bold;">Domain Name:</SPAN><A NAME="lan_dhcp_server_domain_name"></A> Type the local <A HREF="glossary.asp#def_domain_name">domain name</A> of the network in the text box. This item is optional.</P>
      <P> <SPAN STYLE="font-weight : bold;">Lease Time:</SPAN> The lease time specifies the amount of connection time a network user be allowed with their current dynamic IP address.</P>
	  <P><SPAN STYLE="font-weight : bold;">Static DHCP:</SPAN>Reserves an <A HREF="glossary.asp#def_ip_address">IP address</A> to a <A HREF="glossary.asp#def_dhcp">DHCP</A> client.  This ensures that the PC's <A HREF="glossary.asp#def_ip_address">IP address</A> does not change.</P>
	  <P> <SPAN STYLE="font-weight : bold;">Apply:</SPAN> Click to save the settings.</P>
	  <P> <A HREF="help_main.asp">back to top</A></P>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
          <font color="#FFFFFF" >WAN</font><a name="main_wan"></a></td>
        </tr>
      </table>
      <P>This screen enables you to set up the router <A HREF="glossary.asp#def_WAN">WAN</A> connection, specify the <A HREF="glossary.asp#def_IP">IP address</A> for the WAN, add <A HREF="glossary.asp#def_DNS">DNS</A> numbers,
enter the <A HREF="glossary.asp#def_MAC_address">MAC address</A>, and
set the <A HREF="glossary.asp#def_MTU">MTU</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Connection Type:</SPAN><A NAME="WAN_connection_type"></A> Select the connection type, either <A HREF="glossary.asp#def_dhcp">DHCP</A> client/Fixed IP or <A HREF="glossary.asp#def_PPPoE">PPPoE</A> from
        the drop-down list.</P>
      <P> When using DHCP client/Fixed IP, enter the following information in
        the fields (some information is provided by your <A HREF="glossary.asp#def_ISP">ISP</A>):</P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">WAN IP:</SPAN><A NAME="WAN_WAN_IP"></A> <SPAN STYLE="font-weight : normal;">Select
        whether you want to specify an </SPAN><A HREF="glossary.asp#def_ip_address"><SPAN STYLE="font-weight : normal;">IP
          address</SPAN></A><SPAN STYLE="font-weight : normal;"> manually, or
            want </SPAN><A HREF="glossary.asp#def_dhcp"><SPAN STYLE="font-weight : normal;">DHCP</SPAN></A><SPAN STYLE="font-weight : normal;"> to obtain an IP address automatically. When </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Specify
              IP </SPAN><SPAN STYLE="font-weight : normal;">is selected, type the </SPAN><A HREF="glossary.asp#def_ip_address"><SPAN STYLE="font-weight : normal;">IP
                address</SPAN></A><SPAN STYLE="font-weight : normal;">, </SPAN><A HREF="glossary.asp#def_subnet_mask"><SPAN STYLE="font-weight : normal;">subnet
                  mask</SPAN></A><SPAN STYLE="font-weight : normal;">, and default </SPAN><A HREF="glossary.asp#def_gateway"><SPAN STYLE="font-weight : normal;">gateway</SPAN></A><SPAN STYLE="font-weight : normal;"> in the text boxes. Your </SPAN><A HREF="glossary.asp#def_ISP"><SPAN STYLE="font-weight : normal;">ISP</SPAN></A><SPAN STYLE="font-weight : normal;"> will provide you with this information.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">DNS 1/2:</SPAN> <SPAN STYLE="font-weight : normal;">Type
        up to two </SPAN><A HREF="glossary.asp#def_DNS"><SPAN STYLE="font-weight : normal;">DNS</SPAN></A><SPAN STYLE="font-weight : normal;"> numbers in the text boxes. Your </SPAN><A HREF="glossary.asp#def_ISP"><SPAN STYLE="font-weight : normal;">ISP</SPAN></A><SPAN STYLE="font-weight : normal;"> will provide you with this information.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">MAC Address:</SPAN><A NAME="WAN_MAC_address"></A><SPAN STYLE="font-weight : normal;"> If required by your </SPAN><A HREF="glossary.asp#def_ISP"><SPAN STYLE="font-weight : normal;">ISP</SPAN></A><SPAN STYLE="font-weight : normal;">,
        type the </SPAN><A HREF="glossary.asp#def_MAC_address"><SPAN STYLE="font-weight : normal;">MAC
          address</SPAN></A><SPAN STYLE="font-weight : normal;"> of the router </SPAN><A HREF="glossary.asp#def_WAN"><SPAN STYLE="font-weight : normal;">WAN</SPAN></A><SPAN STYLE="font-weight : normal;"> interface in this field.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">MTU:</SPAN><A NAME="WAN_MTU"></A> <SPAN STYLE="font-weight : normal;">Type
        the </SPAN><A HREF="glossary.asp#def_MTU"><SPAN STYLE="font-weight : normal;">MTU</SPAN></A><SPAN STYLE="font-weight : normal;"> value in the text box.</SPAN></P>
      <P> When using PPPoE, enter the following information in the fields (some information is provided by your <A HREF="glossary.asp#def_ISP">ISP</A>):</P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">WAN IP:</SPAN><SPAN STYLE="font-weight : normal;"> Select whether you want the <A HREF="glossary.asp#def_ISP">ISP</A> to
        provide the <A HREF="glossary.asp#def_ip_address">IP address</A> automatically, or whether you want to assign a static IP address to
        the router <A HREF="glossary.asp#def_WAN">WAN</A>. When </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Specify
          IP </SPAN><SPAN STYLE="font-weight : normal;">is selected, type the
            PPPoE </SPAN><A HREF="glossary.asp#def_ip_address"><SPAN STYLE="font-weight : normal;">IP
              address</SPAN></A><SPAN STYLE="font-weight : normal;"> in the text
                box. Your </SPAN><A HREF="glossary.asp#def_ISP"><SPAN STYLE="font-weight : normal;">ISP</SPAN></A><SPAN STYLE="font-weight : normal;"> will provide you with this information.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">DNS 1/2:</SPAN><A NAME="WAN_DNS_1_2_3"></A> <SPAN STYLE="font-weight : normal;">Type
        up to two </SPAN><A HREF="glossary.asp#def_DNS"><SPAN STYLE="font-weight : normal;">DNS</SPAN></A><SPAN STYLE="font-weight : normal;"> numbers in the text boxes. Your </SPAN><A HREF="glossary.asp#def_ISP"><SPAN STYLE="font-weight : normal;">ISP</SPAN></A><SPAN STYLE="font-weight : normal;"> will provide you with this information.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">User Name:</SPAN><SPAN STYLE="font-weight : normal;"> Type your <A HREF="glossary.asp#def_PPPoE">PPPoE</A> user name.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">Password:</SPAN><SPAN STYLE="font-weight : normal;"> Type your <A HREF="glossary.asp#def_PPPoE">PPPoE</A> password.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">Connect on Demand:</SPAN><SPAN STYLE="font-weight : normal;"> Enables or disables the connect on demand function, which enables the
        the router to initiate a connection with your <A HREF="glossary.asp#def_ISP">ISP</A> when an Internet request is made to the router. When enabled, the
        router automatically connects to the Internet when you open your
        default browser.</SPAN></P>
      <P CLASS="Bullet"> <SPAN STYLE="font-weight : bold;">Idle Time Out:</SPAN><SPAN STYLE="font-weight : normal;"> Specify the time that will elapse before the router times out of a connection.</SPAN></P>
      <P CLASS="Bullet"> MTU: <SPAN STYLE="font-weight : normal;">Type the </SPAN><A HREF="glossary.asp#def_MTU"><SPAN STYLE="font-weight : normal;">MTU</SPAN></A><SPAN STYLE="font-weight : normal;"> value in the text box.</SPAN></P>
      <P><SPAN STYLE="font-weight : bold;">PPTP:</SPAN><SPAN STYLE="font-weight : normal;"> Point-to-Point Tunneling Protocol uses TCP to deal data for tunnel maintenance, and uses PPP for sum up the information carried within the tunnel.
        The data carried within the tunnel can be compressed or encrypted.
        The encryption method used is RSA RC4. PPTP can operate
        when the protocol is supported only on the client and the server located on the other end that the client is corresponds with.
      No support is essential from any of the routers or servers within the network the two PCs are connecting across. </SPAN>      
      <P> <strong>L2TP:</strong> L2TP is often used as a tunneling mechanism to resell ADSL endpoint connectivity. An L2TP tunnel would sit between the user and the ISP the connection would be resold to, so the reselling ISP wouldn't appear as doing the transit.       
      <P><strong>IP Address </strong><strong>: </strong> This is the <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> of the router. The IP address is provided by ISP <strong></strong>
      <p><strong>Subnet Mask </strong><strong>: </strong>The <a href="http://192.168.10.1/glossary.asp#def_subnet_mask">subnet mask </a> for the router in the text box which provided by ISP. <strong></strong></p>
                          <p><strong>Gateway: </strong>The gateway address of the network. Contact the ISP or network administrator for this information. <strong></strong></p>
                          <p><strong>DNS: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_DNS">DNS </a> IP addresses in the text boxes. Your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> will provide you with this information. <strong></strong></p>
                          <p><strong>Server IP: </strong><strong></strong>Type the server IP address in the text box. Your ISP will provide you with this information. <strong></strong></p>
                          <p><strong>PPTP or L2TP Account: </strong>Type your PPTP or L2TP account number. <strong></strong></p>
                          <p><strong>PPTP or L2TP Password: </strong> Type your PPTP or L2TP password. <strong></strong></p>
                          <p><strong>PPTP or L2TP Retype password: </strong> Retype your PPTP or L2TP password again. <strong></strong></p>
                          <p><strong>Auto-reconnect: </strong> Enables <em>Always-on </em>, <em>Manual </em> or <em>connect on demand </em> function. Connect on demand enables the router to initiate a connection with your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> when an Internet request is made to the router. When enabled, the router automatically connects to the Internet when you open your default browser. <strong></strong></p>
                          <p><strong>Idle Time Out: </strong>Specify the time that will elapse before the router drops connection. <strong></strong></p>
                          <p><strong>MTU: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_MTU">MTU </a> value in the text box. </p>
						  <p><strong>MPPE Enable: </strong>Select to enable Microsoft Point-to-Point Encryption.(Only for MSCHAPv2)</p>
                          <p><span class="Bullet">-----------------------------------------------------------------------------------------------------------------------------------</span></p>
                          <P><strong>Bigpond Cable:</strong> BigPond is Australia's largest Internet Service Provider and is Telstra's brand name for consumer broadband services.                           
                          <P><br>
                            <strong>User Name: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">BigPond </a> user name. 
                          <p><strong>Password: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">BigPond </a> password. </p>
                          <p><strong>Retype Password </strong><strong>: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">BigPond </a> password again. </p>
                          <p><strong>Auth Server: </strong>sm-server : small mmo (sm) server </p>
                          <p><strong>Dce-server :</strong> distributed computing environment (dce) server. </p>
                          <p><strong>Login Server IP: </strong><strong></strong>Type the server IP. Your ISP will provided this information. <strong></strong></p>
                          <p><strong>MAC Address: </strong> If required by your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a>, type the <a href="http://192.168.10.1/glossary.asp#def_MAC_address">MAC address </a> of the router <a href="http://192.168.10.1/glossary.asp#def_WAN">WAN </a> interface in this field. </p>
                          <p><span class="Bullet">-----------------------------------------------------------------------------------------------------------------------------------</span></p>
                          <P> <strong>Russia </strong><strong> PPPoE: </strong>When using PPPoE, enter the following information in the fields (some information is provided by your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a>)
                          <P><strong>WAN IP: </strong> Select whether you want the <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> to provide the <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> automatically, or whether you want to assign a static IP address to the router <a href="http://192.168.10.1/glossary.asp#def_WAN">WAN </a>. When <em>Specify IP </em>is selected, type the PPPoE <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> in the text box. Your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> will provide you with this information. 
                          <p><strong>Service Name </strong><strong>: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">PPPoE </a> service name. </p>
                          <p><strong>User Name: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">PPPoE </a> user name. </p>
                          <p><strong>Password: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">PPPoE </a> password. </p>
                          <p><strong>Retype Password </strong><strong>: </strong> Type your <a href="http://192.168.10.1/glossary.asp#def_PPPoE">PPPoE </a> password again. </p>
                          <p><strong>Auto-reconnect: </strong> Enables <em>Always-on </em>, <em>Manual </em> or <em>connect on demand </em> function. Connect on demand enables the router to initiate a connection with your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> when an Internet request is made to the router. When enabled, the router automatically connects to the Internet when you open your default browser. </p>
                          <p><strong>Idle Time Out: </strong> Specify the time that will elapse before the router drops connection. </p>
                          <strong>MTU :</strong> Type the <a href="http://192.168.10.1/glossary.asp#def_MTU">MTU </a> value in the text box. 
                          <p><strong>WAN physical settings :</strong> Russia PPPoE supports dual WAN access. Configure the second WAN connection below: 
 						  <p><strong>Dynamic IP :</strong> Select this option if the WAN IP address is obtained automatically. 
  						  <p><strong>Static IP: </strong>Select this option if the WAN IP address is static. Then fill out the fields below: 
 						  <p><strong>IP Address </strong><strong>: </strong> This is the <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> of the router. The IP address is provided by ISP <strong></strong></p>
                          <p><strong>Subnet Mask </strong><strong>: </strong>The <a href="http://192.168.10.1/glossary.asp#def_subnet_mask">subnet mask </a> for the router in the text box which provided by ISP. <strong></strong></p>
                          <p><strong>Gateway: </strong>The gateway address of the network. Contact the ISP or network administrator for this information. 
						  <p><strong>DNS Primary: </strong>The primary Domain Name Server (DNS) IP address. This is provided by your ISP. </p>
                          <p><strong>DNS Secondary: </strong>The secondary Domain Name Server (DNS) IP address. This is provided by your ISP. </p>
                          <p><span class="Bullet">-----------------------------------------------------------------------------------------------------------------------------------</span></p>
                          <P><strong>Russia </strong><strong> PPTP: </strong> When using PPTP, enter the following information in the fields (some information is provided by your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a>): <br>
                            <br>
                            <strong>IP Address </strong><strong>: </strong> This is the <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> of the router. The IP address is provided by ISP <strong></strong>
                          <p><strong>Subnet Mask </strong><strong>: </strong>The <a href="http://192.168.10.1/glossary.asp#def_subnet_mask">subnet mask </a> for the router in the text box which provided by ISP. <strong></strong></p>
                          <p><strong>Gateway: </strong>The gateway address of the network. Contact the ISP or network administrator for this information. <strong></strong></p>
                          <p><strong>DNS: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_DNS">DNS </a> IP addresses in the text boxes. Your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> will provide you with this information. <strong></strong></p>
                          <p><strong>Server IP: </strong><strong></strong>Type the server IP address in the text box. Your ISP will provide you with this information. <strong></strong></p>
                          <p><strong>PPTP Account: </strong>Type your PPTP account number. <strong></strong></p>
                          <p><strong>PPTP: </strong> Type your PPTP password. <strong></strong></p>
                          <p><strong>PPTP Retype password: </strong> Retype your PPTP password again. <strong></strong></p>
                          <strong>Auto-reconnect: </strong> Enables <em>Always-on </em>, <em>Manual </em> or <em>connect on demand </em> function. Connect on demand enables the router to initiate a connection with your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> when an Internet request is made to the router.
                          <p>When enabled, the router automatically connects to the Internet when you open your default browser. <strong></strong></p>
                          <p><strong>Idle Time Out: </strong>Specify the time that will elapse before the router drops connection. <strong></strong></p>
                          <p><strong>MTU: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_MTU">MTU </a> value in the text box. </p>
						  <p><strong>MPPE Enable: </strong>Select to enable Microsoft Point-to-Point Encryption.(Only for MSCHAPv2)</p>
                          <p><span class="Bullet">-----------------------------------------------------------------------------------------------------------------------------------</span></p>
                          <p><strong>Russia </strong><strong> L2TP: </strong><strong></strong>When using L2TP, enter the following information in the fields (some information is provided by your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a>): </p>
                          <p><strong>IP Address </strong><strong>: </strong> This is the <a href="http://192.168.10.1/glossary.asp#def_ip_address">IP address </a> of the router. The IP address is provided by ISP <strong></strong></p>
                          <p><strong>Subnet Mask </strong><strong>: </strong>The <a href="http://192.168.10.1/glossary.asp#def_subnet_mask">subnet mask </a> for the router in the text box which provided by ISP. <strong></strong></p>
                          <p><strong>Gateway: </strong>The gateway address of the network. Contact the ISP or network administrator for this information. <strong></strong></p>
                          <p><strong>DNS: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_DNS">DNS </a> IP addresses in the text boxes. Your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> will provide you with this information. <strong></strong></p>
                          <p><strong>Server IP\Name: </strong> Type the server IP address in the text box. Your ISP will provide you with this information. <strong></strong></p>
                          <p><strong>L2TP Account: </strong>Type your L2TP account number. <strong></strong></p>
                          <p><strong>L2TP Password: </strong> Type your L2TP password. <strong></strong></p>
                          <p><strong>L2TP Retype password: </strong> Retype your L2TP password again. <strong></strong></p>
                          <p><strong>Auto-reconnect: </strong> Enables <em>Always-on </em>, <em>Manual </em> or <em>connect on demand </em> function. Connect on demand enables the router to initiate a connection with your <a href="http://192.168.10.1/glossary.asp#def_ISP">ISP </a> when an Internet request is made to the router. When enabled, the router automatically connects to the Internet when you open your default browser. <strong></strong></p>
                          <p><strong>Idle Time Out: </strong>Specify the time that will elapse before the router drops connection. <strong></strong></p>
                          <p><strong>MTU: </strong>Type the <a href="http://192.168.10.1/glossary.asp#def_MTU">MTU </a> value in the text box. </p>
    <p><A HREF="help_main.asp">back to top</A></p></td>
  </tr>
                  </table></td>
                </tr>
              </table>
              <br>
              <br>              <a name="main_password"></a><br>
              <table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#000000">
                <tr>
                  <td bgcolor="#C5CEDA" class="headerbg2"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding: 10px 0 10px 0">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
          <font color="#FFFFFF" >Password</font><a name="main_password"></a></td>
        </tr>
      </table>
      <P>This screen enables you to set administrative and user passwords.
These passwords are used to gain access to the router interface.</P>
      <P> <SPAN STYLE="font-weight : bold;">Administrator:</SPAN><A NAME="password_administrator"></A> Type the password the <A HREF="glossary.asp#def_administrator">Administrator</A> will use to log in to the system. The password must be typed again
        for confirmation.</P>
      <P> <SPAN STYLE="font-weight : bold;">User:</SPAN><A NAME="password_user"></A> Users can type a password to be used for logging in to the system.
        The password must be typed again for confirmation.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> Users do not have
        permission to configure router functions.</P>
      <p><A HREF="help_main.asp">back to top</A></P>
      <p>&nbsp;</P>
      <p>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
          <font color="#FFFFFF" >Time</font><a name="main_time"></a></td>
        </tr>
      </table>
      <P>This screen enables you to set the time and date for the router's
realtime clock, select your time zone, specify an <A HREF="glossary.asp#def_NTP">NTP</A> server, and enable or disable daylight saving.</P>
      <P> <SPAN STYLE="font-weight : bold;">Local Time:</SPAN><A NAME="time_local_time"></A> Displays the local time and date.</P>
      <P> <SPAN STYLE="font-weight : bold;">Time Zone:</SPAN><A NAME="time_time_zone"></A> Select your time zone from the drop-down list.</P>
      <P> <SPAN STYLE="font-weight : bold;">Synchronize the clock with:</SPAN><A NAME="Synchronize_the_clock_with:"></A>Select 
        the clock adjustment method form the drop-down list. <br>Automatic: Automatically 
        adjust the system time from NTP Server.<br>Manual: Manually adjust the system 
        time when you press the <SPAN STYLE="font-style : italic;font-weight : bold;">Set Time</span> button. </P>  
      <P> <SPAN STYLE="font-weight : bold;">Default NTP Server:</SPAN><A NAME="time_default_ntp_server"></A> Type the <A HREF="glossary.asp#def_NTP">NTP</A> server address in the
        text box to enable the router to automatically set the time from the
        Internet NTP server.</P>
      <P> <SPAN STYLE="font-weight : bold;">Set the Time:</SPAN><SPAN STYLE="font-style : normal;"><A NAME="time_set_the_time"></A> Select the date and time from the drop-down lists, and click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Set
        Time</SPAN><SPAN STYLE="font-style : normal;"> to set the router's
          internal clock to the correct date and time.</SPAN></P>
      <P> <SPAN STYLE="font-weight : bold;">Daylight Saving:</SPAN><A NAME="time_daylight_saving"></A> Enables you to enable or disable daylight saving time. When enabled,
        select the start and end date for daylight saving time.</P>
      <P> <A HREF="help_main.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;  </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF">Dynamic DNS</font><a name="main_ddns"></a></td>
        </tr>
      </table>
      <P>Dynamic DNS (Domain Name Service) is a method of keeping a domain name linked
  to a changing (dynamic) IP address. With most Cable and DSL connections, you
  are assigned a dynamic IP address and that address is used only for the duration
  of that specific connection. You can setup your DDNS service and the router
  will automatically update your DDNS server every time it receives a different
  IP address.</P>
      <p><A HREF="help_main.asp">back to top</A></P>
      <p>&nbsp;</P>
      <p>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF">Setup Wizard</font><a name="tools_setup_wizard"></a></td>
        </tr>
      </table>
      <P>The setup wizard enables you to configure the router quickly and
conveniently. Follow these instructions:</P>
      <OL>
        <LI CLASS="mvd-P">
          <P> In the Settings screen Setup Wizard section, click Run Wizard.</P>
      </OL>
      <OL START="2">
        <LI CLASS="mvd-P">
          <P> Click <SPAN STYLE="font-style : italic;">Next</SPAN>. You are
            prompted to select a password. Type a password in the text box, and
            then type it again for verification.</P>
      </OL>
      <OL START="3">
        <LI CLASS="mvd-P">
          <P> Click <SPAN STYLE="font-style : italic;">Next</SPAN>. Select your
            time zone from the drop-down list.</P>
      </OL>
      <OL START="4">
        <LI CLASS="mvd-P">
          <P> Click <SPAN STYLE="font-style : italic;">Next</SPAN>. Type the LAN <A HREF="glossary.asp#def_ip_address">IP
            address</A> in the text box. The default IP address 192.168.10.1.</P>
        <LI CLASS="mvd-P">
          <P> Type the <A HREF="glossary.asp#def_subnet_mask">subnet mask</A> in
            the text box.</P>
        <LI CLASS="mvd-P">
          <P> Enable DHCP Server if you want <A HREF="glossary.asp#def_dhcp">DHCP</A> to automatically assign <A HREF="glossary.asp#def_ip_address">IP addresses</A>.
            Type a beginning IP address and an end IP address for the DHCP
            server to use in assigning IP addresses.</P>
      </OL>
      <OL START="7">
        <LI CLASS="mvd-P">
          <P> Click <SPAN STYLE="font-style : italic;">Next</SPAN>. Select how the
            router will set up the Internet connection. If you have enabled <A HREF="glossary.asp#def_dhcp">DHCP</A> server, choose &quot;Obtain IP automatically (DHCP client)&quot; to
            have the router assign <A HREF="glossary.asp#def_ip_address">IP
              addresses </A>automatically.</P>
      </OL>
      <OL START="8">
        <LI CLASS="mvd-P">
          <P> Click <SPAN STYLE="font-style : italic;">Next</SPAN>. You are
            prompted to restart save the settings and restart the router
            interface. Click <SPAN STYLE="font-style : italic;">Restart</SPAN> to
            complete the wizard.</P>
      </OL>
      <P> <A HREF="help_main.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P></td>
  </tr>
</table>
</BODY>
</HTML>