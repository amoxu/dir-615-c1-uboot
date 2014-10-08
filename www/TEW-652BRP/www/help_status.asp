<HTML>
 <HEAD>
  <!-- $MVD$:app("RoboHELP HTML Edition by Blue Sky Software, portions by MicroVision Dev. Inc.","769") -->
  <!-- $MVD$:template("","0","0") -->
  <!-- $MVD$:fontset("Arial","Arial") -->
  <!-- $MVD$:fontset("Times New Roman","Times New Roman") -->
  <!-- $MVD$:fontset("Arial Narrow","Arial Narrow") -->
  <TITLE>Status</TITLE>
 <link rel="stylesheet" href="style.css" type="text/css"></HEAD>
  
<BODY bgcolor=#FFFFFF>
<table width="100%" border="0" cellpadding="5" cellspacing="5" bgcolor="#F0F0F0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
          <font size="6">Status</font></td>
      </tr>
    </table>
      <P>This screen enables you to view the status of the router <A HREF="glossary.asp#def_LAN">LAN</A>, <A HREF="glossary.asp#def_WAN">WAN</A> and <A HREF="glossary.asp#def_wireless_lan">wireless
LAN</A> connections, and view logs and statistics pertaining to
connections and <A HREF="glossary.asp#def_packet">packet</A> transfers.</P>
      <P> Click the items below for more information:</P>
      <UL>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#status_device_info">Device Information</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#status_log">Log</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#status_log_settings">Log Settings</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#status_statistic">Statistics</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#status_wireless">Wireless</A></b></P>        
      </UL>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Device Information</font><a name="status_device_info"></a></td>
        </tr>
      </table>
      <P>This screen enables you to view the router <A HREF="glossary.asp#def_LAN">LAN</A>, <A HREF="glossary.asp#def_wireless_lan">wireless LAN</A>, and <A HREF="glossary.asp#def_WAN">WAN</A> configuration.</P>
      <p> <SPAN STYLE="font-weight : bold;">Firmware Version:</SPAN><A NAME="status_firmware_version"></A> <SPAN STYLE="font-style : normal;">D</SPAN>isplays the latest build of the wireless router <A HREF="glossary.asp#def_firmware">firmware</A> interface. After updating the
        firmware in <A HREF="help_tools.asp#tools_firmware">Tools - Firmware</A>, check
        this to ensure that your firmware was successfully updated.</P>
      <p><SPAN STYLE="font-weight : bold;">WAN:</SPAN><A NAME="status_devinfo_WAN"></A> This field displays the router's <A HREF="glossary.asp#def_WAN">WAN</A> interface <A HREF="glossary.asp#def_MAC_address">MAC address</A>, <A HREF="glossary.asp#def_dhcp">DHCP</A> client status, <A HREF="glossary.asp#def_ip_address">IP address</A>, <A HREF="glossary.asp#def_subnet_mask">subnet mask</A>, default <A HREF="glossary.asp#def_gateway">gateway</A>, and <A HREF="glossary.asp#def_DNS">DNS</A>.</P>
      <P> Click <SPAN STYLE="font-style : italic;">DHCP Release</SPAN> to release all IP addresses assigned to client stations connected to the WAN via the router. Click <SPAN STYLE="font-style : italic;">DHCP Renew</SPAN> to reassign IP addresses to client stations connected to the WAN.</P>
      <P><SPAN STYLE="font-weight : bold;">Wireless:</SPAN><A NAME="status_devinfo_wireless"></A> Displays the router's wireless connection information, including the
        router's wireless interface <A HREF="glossary.asp#def_MAC_address">MAC
      address</A>, the connection status, the <A HREF="glossary.asp#def_ssid">SSID</A> status, which channel is being used, and whether <A HREF="glossary.asp#def_WEP">WEP</A> is enabled or not.</P>
      <P><SPAN STYLE="font-weight : bold;">LAN:</SPAN><A NAME="status_devinfo_lan"></A> This field displays the router's <A HREF="glossary.asp#def_LAN">LAN</A> interface <A HREF="glossary.asp#def_MAC_address">MAC address</A>, <A HREF="glossary.asp#def_ip_address">IP address</A>, <A HREF="glossary.asp#def_subnet_mask">subnet mask</A>, and <A HREF="glossary.asp#def_dhcp">DHCP</A> server status. Click <SPAN STYLE="font-style : italic;"><A HREF="help_main.asp#lanski_dhcp_server">DHCP Table</A></SPAN> to view a list of client stations currently connected to the router LAN interface. </P>
      <P> <A HREF="help_status.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Log</font><a name="status_log"></a></td>
        </tr>
      </table>
      <P>This screen enables you to view a running log of router system
statistics, events, and activities. The log displays up to 200
entries. Older entries are overwritten by new entries. You can save
logs via the <A HREF="#status_log_settings">Log Settings</A> screen (<A HREF="#status_logset_sent_to">Send
to</A>). The Log screen commands are as follows:</P>
      <UL>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">First
            Page</SPAN><SPAN STYLE="font-weight : normal;"> to view the first
              page of the log</SPAN></P>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Last
            Page</SPAN><SPAN STYLE="font-weight : normal;"> to view the final
              page of the log</SPAN></P>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Previous
            Page</SPAN><SPAN STYLE="font-weight : normal;"> to view the page
              just before the current page</SPAN></P>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Next
            Page</SPAN><SPAN STYLE="font-weight : normal;"> to view the page
              just after the current page</SPAN></P>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Clear
            Log</SPAN><SPAN STYLE="font-weight : normal;"> to delete the
              contents of the log and begin a new log</SPAN></P>
        <LI CLASS="mvd-P">
          <P STYLE="margin-top : 0.0pt;margin-bottom : 0.0pt;"> <SPAN STYLE="font-weight : normal;">Click </SPAN><SPAN STYLE="font-style : italic;font-weight : normal;">Refresh</SPAN><SPAN STYLE="font-weight : normal;"> to renew log statistics</SPAN></P>
      </UL>
      <P> <SPAN STYLE="font-weight : bold;">Time:</SPAN><A NAME="status_log_time"></A> Displays the time and date that the log entry was created.</P>
      <P> <SPAN STYLE="font-weight : bold;">Message:</SPAN><A NAME="status_log_message"></A> Displays summary information about the log entry.</P>
      <P> <SPAN STYLE="font-weight : bold;">Note:</SPAN><A NAME="status_log_note"></A> Displays the <A HREF="glossary.asp#def_ip_address">IP address</A> of
      the communication.</P>
      <P> <A HREF="help_status.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"> <p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Log Settings</font><a name="status_log_settings"></a></td>
        </tr>
      </table>
      <P>This screen enables you to set router logging parameters.</P>
	  <P> <SPAN STYLE="font-weight : bold;">SMTP Authentication:</SPAN><A NAME="status_logset_smtp_authentication"></A> Selected the Enabled if the SMTP server need for authentication, fill in account name and password in SMTP Account field and SMTP Password field.</P>
	  <P> <SPAN STYLE="font-weight : bold;">SMTP Account:</SPAN><A NAME="status_logset_smtp_account"></A> If the SMTP Authentication enabled, fill in the SMTP account name here.</P>
	  <P> <SPAN STYLE="font-weight : bold;">SMTP Password:</SPAN><A NAME="status_logset_smtp_password"></A> If the SMTP Authentication enabled, fill in the password of the SMTP account here.</P>
	  
	  
	  
      <P> <SPAN STYLE="font-weight : bold;">SMTP Server:</SPAN><A NAME="status_logset_smtp_server"></A> Type the <A HREF="glossary.asp#def_SMTP">SMTP</A> server address for
        the email that the log will be sent to in the next field.</P>
      <P> <SPAN STYLE="font-weight : bold;">Send to:</SPAN><A NAME="status_logset_sent_to"></A> Type an email address for the log to be sent to. Click <SPAN STYLE="font-style : italic;">Email
        Log Now</SPAN> to immediately send the current log.</P>
      <P> <SPAN STYLE="font-weight : bold;">E-mail Log :</SPAN><A NAME="status_logset_sent_to"></A> When log is full or on schedule. </P>
      <P> <SPAN STYLE="font-weight : bold;">Log Type:</SPAN><A NAME="status_logset_log_type"></A> Enables you to select what items will be included in the log:</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">System Activity: </SPAN>Displays
            information related to WLAN Router operation.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Debug Information:</SPAN> Displays
            information related to errors and system malfunction.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Attacks:</SPAN> Displays information 
            about any malicious activity on the network.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Dropped Packets:</SPAN> Displays
            information about <A HREF="glossary.asp#def_packet">packets</A> that
            have not been transferred successfully.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Notice:</SPAN> Displays important
            notices by the system <A HREF="glossary.asp#def_administrator">administrator</A>.</P>
      </UL>
	  <P> <SPAN STYLE="font-weight : bold;">Syslog Server: </SPAN><A NAME="status_syslog_server"></A> Type the IP address of the Syslog Server if you want the router to listen and receive incoming SysLog messages.</P>
      <P> <A HREF="help_status.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
            <font color="#FFFFFF">Statistic</font><a name="status_statistic"></a></td>
        </tr>
      </table>
      <P>This screen displays a table that shows the rate of packet
transmission via the router <A HREF="glossary.asp#def_LAN">LAN</A>, <A HREF="glossary.asp#def_wireless_lan">wireless
LAN</A>, and <A HREF="glossary.asp#def_WAN">WAN</A> ports (in bytes
per second).</P>
      <P> Click <SPAN STYLE="font-style : italic;">Reset</SPAN> to erase all
        statistics and begin logging statistics again.</P>
      <P> <SPAN STYLE="font-weight : bold;">Utilization:</SPAN><A NAME="status_statistics_utilization"></A> Separates packet transmission statistics into send and receive
        categories. Peak indicates the maximum packet transmission recorded
        since logging began, while  transmission since recording began.</P>
      <P> <A HREF="help_status.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Wireless</font><a name="status_wireless"></a></td>
        </tr>
      </table>
      <P>This screen enables you to view information about wireless devices
that are connected to the router wireless interface.</P>
      <P> <SPAN STYLE="font-weight : bold;">Connected Time:</SPAN><A NAME="status_wireless_connected_time"></A> Displays how long the wireless device has been connected to the <A HREF="glossary.asp#def_LAN">LAN</A> via the router.</P>
      <P> <SPAN STYLE="font-weight : bold;">MAC Address:</SPAN><A NAME="status_wireless_mac_address"></A> Displays the devices <A HREF="glossary.asp#def_wireless_lan">wireless LAN</A> interface <A HREF="glossary.asp#def_MAC_address">MAC address</A>.</P>
      <P> <A HREF="help_status.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P></td>
  </tr>
</table>
</BODY>
</HTML>
