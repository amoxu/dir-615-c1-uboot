<HTML>
 <HEAD>
  <!-- $MVD$:app("RoboHELP HTML Edition by Blue Sky Software, portions by MicroVision Dev. Inc.","769") -->
  <!-- $MVD$:template("","0","0") -->
  <!-- $MVD$:fontset("Arial","Arial") -->
  <!-- $MVD$:fontset("Times New Roman","Times New Roman") -->
  <!-- $MVD$:fontset("Arial Narrow","Arial Narrow") -->
  <TITLE>Access</TITLE>
 <link rel="stylesheet" href="style.css" type="text/css"></HEAD>
  
<BODY bgcolor=#FFFFFF>
<table width="100%" border="0" cellpadding="5" cellspacing="5" bgcolor="#F0F0F0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
          <b><font size="6">Access</font></b></td>
      </tr>
    </table>
      <P>This page enables you to define access restrictions, set up <A HREF="glossary.asp#def_protocol">protocol</A> and <A HREF="glossary.asp#def_IP">IP</A> <A HREF="glossary.asp#def_filter">filters</A>,
create <A HREF="glossary.asp#def_virtual_server">virtual servers</A>,
define access for special applications such as games, and set <A HREF="glossary.asp#def_firewall">firewall</A> rules.</P>
      <P> Click the items below for more information:</P>
      <UL>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_user_group">MAC Filter</A></b></P>
	    <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_url_group">URL Blocking</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_ip_filter">IP Filter</A></b></P>
	    <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_domain_filter">Domain Blocing</A></b></P>
		<LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_protocol_filter">Protocol Filter</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_virtual_server">Virtual Server</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_special_ap">Special AP</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#access_DMZ">DMZ</A></b></P>
	    <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <span class="Bullet style3"><b><A HREF="#access_Firewall_setting ">Firewall settings</A></b></span></P>
      </UL>
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >Mac Filter</font><a name="access_user_group"></a></td>
        </tr>
      </table>
      <P>This screen enables you to allow and deny user access based upon a MAC list you create.</P>
      <P> <SPAN STYLE="font-weight : bold;">MAC Filter:</SPAN><A NAME="access_usergroup_MAC_filter"></A> Enables you to allow or deny Internet access to users within the LAN based upon
        the <A HREF="glossary.asp#def_MAC_address">MAC address</A> of their network
        interface. Click the radio button next to <SPAN STYLE="font-style : italic;">Disabled</SPAN> to disable the MAC filter function.</P>
      <UL>
        <LI CLASS="mvd-P">
			<P> <SPAN STYLE="font-weight : bold;">Disable:</SPAN> Disable the MAC filter function.</P>
        <LI CLASS="mvd-P">
			<P> <SPAN STYLE="font-weight : bold;">Allow:</SPAN> Only allow computers with MAC address listed below to access the internet. </P>
		  <LI CLASS="mvd-P">
			<P> <SPAN STYLE="font-weight : bold;">Deny:</SPAN> Only deny computers with MAC address listed below to access the internet. </P>
      </UL>
      <P> <SPAN STYLE="font-weight : bold;">MAC Table:</SPAN><A NAME="access_usergroup_user_table"></A> Use this section to create a user profile to which Internet access is denied
        or allowed.</P>
      <P> The user profiles are listed in the table at the bottom of the page.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> When selecting items
        in the table at the bottom, <A HREF="#addprotfilter">click</A> anywhere in the item. The line is selected, and the fields
        automatically load the item's parameters, which you can edit.</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Name:</SPAN> Type the name of the user
            to be permitted/denied access.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">MAC Address:</SPAN> Type the <A HREF="glossary.asp#def_MAC_address">MAC
            address</A> of the user's network interface.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Add:</SPAN> Click to add the user to
            the list at the bottom of the page.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN> Click to update information
            for the user, if you have changed any of the fields.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN> Select a user from the
            table at the bottom of the list and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove the user profile.</P>
      </UL>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
	  
	   <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF">URL Blocking</font><a name="access_url_group"></a></td>
        </tr>
      </table>
	  <P>URL Blocking is used to deny computers within the LAN (Local Area Network) from accessing specific web sites by its URL (Uniform Resource Locator). A URL is a specially formatted text string that defines a location on the Internet. If any part of the URL contains the blocked word, the site will not be accessible and the web page will not be displayed.</P>

	   <UL>
		 <P><SPAN STYLE="font-weight : bold;">Disable: </SPAN>Disable the URL Blocking function. </P>
         <p><SPAN STYLE="font-weight : bold;">Allow: </SPAN>Allow users to access all domains in the &quot;URL List &quot;.</p>
         <p><SPAN STYLE="font-weight : bold;">Deny: </SPAN> Deny users to access all domains in the &quot;URL List &quot;.</p>
         <p><SPAN STYLE="font-weight : bold;">Domains List: </SPAN> List URL you will Denied or Allowed. </p>
         <p><SPAN STYLE="font-weight : bold;">Delete: </SPAN>Select a URL from the table at the bottom of the list and click Delete to remove the URL. </p>
         <p><SPAN STYLE="font-weight : bold;">Add: </SPAN>Click the Add button to add domain to the URL list. </p>
         <p><SPAN STYLE="font-weight : bold;">Cancel: </SPAN> Click the Cancel button to erase all fields and enter new information. </p>
		</UL>

 <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
	 

	 
	   <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >IP Filter</font><font color="#FFFFFF"><a name="access_ip_filter"></a></font></td>
        </tr>
      </table>
      <P>This screen enables you to define a minimum and maximum <A HREF="glossary.asp#def_ip_address">IP
address</A> range filter; all IP addresses falling in the range are
not allowed Internet access.</P>
      <P> The IP filter profiles are listed in the table at the bottom of the page.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> When selecting items
        in the table at the bottom, <A HREF="#addprotfilter">click</A> anywhere in the item. The line is selected, and the fields
        automatically load the item's parameters, which you can edit.</P>
      <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN><A NAME="access_ip_filter_enable"></A> Click to enable or disable the <A HREF="glossary.asp#def_ip_address">IP
        address</A> <A HREF="glossary.asp#def_filter">filter</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Range Start:</SPAN><A NAME="access_ip_filter_range_start"></A> Type the minimum address for the IP range. I<A HREF="glossary.asp#def_ip_address">P
        addresses</A> falling between this value and the Range End are not
        allowed to access the Internet.</P>
      <P> <SPAN STYLE="font-weight : bold;">Range End:</SPAN><A NAME="access_ip_filter_range_end"></A> Type the minimum address for the IP range. I<A HREF="glossary.asp#def_ip_address">P
        addresses</A> falling between this value and the Range Start are not
        allowed to access the Internet.</P>
      <P> <SPAN STYLE="font-weight : bold;">Add:</SPAN> Click to add the IP
        range to the table at the bottom of the screen.</P>
      <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN> Click to update
        information for the range if you have selected a list item and have
        made changes.</P>
      <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN> Select a list item
        and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove
        the item from the list.</P>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
     <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >Domain Blocking</font><font color="#FFFFFF"><a name="access_domain_filter"></a></font></td>
        </tr>
      </table>
		<P>Domain Blocking is used to deny or allow computers within the LAN (Local Area Network) from accessing specific domains on the Internet. Domain blocking will deny or allow all requests such as http and ftp to a specific domain.
Select Allow users to access all domains except "Blocked Domains" if you allow users to access all domains except the domains in the Blocked Domains list.
         Select Deny users to access all domains except "Permitted Domains" if you only want users to access Permitted Domains.</P>
         
	  <UL>
	  		 <P><SPAN STYLE="font-weight : bold;">Disable: </SPAN>Disable the Domain Blocking function. </P>
         <p><SPAN STYLE="font-weight : bold;">Allow: </SPAN>Allow users to access all domains in the &quot;Domains List &quot;.</p>
         <p><SPAN STYLE="font-weight : bold;">Deny: </SPAN> Deny users to access all domains in the &quot;Domains List &quot;.</p>
         <p><SPAN STYLE="font-weight : bold;">Domains List: </SPAN> List Domain you will Denied or Allowed. </p>
         <p><SPAN STYLE="font-weight : bold;">Delete: </SPAN>Select a Domain from the table at the bottom of the list and click Delete to remove the Domain/URL. </p>
         <p><SPAN STYLE="font-weight : bold;">Add: </SPAN>Click the Add button to add domain to the Domains list. </p>
         <p><SPAN STYLE="font-weight : bold;">Cancel: </SPAN> Click the Cancel button to erase all fields and enter new information. </p>
   </UL>	  
 <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
	  
	  
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF">Protocol Filter</font><a name="access_protocol_filter"></a></td>
        </tr>
      </table>
      <P>This screen enables you to allow and deny access based upon a
communications <A HREF="glossary.asp#def_protocol">protocol</A> list
you create.</P>
      <P> The protocol filter profiles are listed in the table at the bottom of
        the page.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> <A NAME="addprotfilter"></A>When
        selecting items in the table at the bottom, click anywhere in the
        item. The line is selected, and the fields automatically load the
        item's parameters, which you can edit:</P>
      <P CLASS="graphic"> <IMG SRC="global.jpg" VSPACE="0" HSPACE="0" BORDER="0"></P>
      <P> <SPAN STYLE="font-weight : bold;">Protocol Filter: </SPAN>Enables you
        to allow or deny Internet access to users based upon the
        communications <A HREF="glossary.asp#def_protocol">protocol</A> of
        the origin. Click the radio button next to <SPAN STYLE="font-style : italic;">Disabled</SPAN> to disable the protocol filter.</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Disable:</SPAN> All protocols in the
            list are allowed to connect to the Internet via the LAN. (Create list items
            in section under <A HREF="#access_protocol_filter_apf">Add Protocol Filter</A>.)</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN> Deny to access internet
            from LAN when The list below item be enable. (Create list items in section
            under <A HREF="#access_protocol_filter_apf">Add Protocol Filter</A>.)</P>
      </UL>
      <P> <SPAN STYLE="font-weight : bold;">Add Protocol Filter:</SPAN><A NAME="access_protocol_filter_apf"></A> Use this section to create a profile for the protocol you want to
        permit or deny Internet access to.</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN> Click to enable or
            disable the <A HREF="glossary.asp#def_protocol">protocol</A> <A HREF="glossary.asp#def_filter">filter</A>.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Name:</SPAN> Type a descriptive
            name for the <A HREF="glossary.asp#def_protocol">protocol</A> <A HREF="glossary.asp#def_filter">filter</A>.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Protocol:</SPAN> Select the
            protocol (<A HREF="glossary.asp#def_TCP">TCP</A>, <A HREF="glossary.asp#def_UDP">UDP</A>,
            or <A HREF="glossary.asp#def_ICMP">ICMP</A>) you want to allow/deny
            Internet access to from the drop-down list.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Port Range:</SPAN> Type the <A HREF="glossary.asp#def_port">port</A> range that can be used to deny accessing internet from <A HREF="glossary.asp#def_LAN">LAN</A> in the two text boxes.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Add: </SPAN><SPAN STYLE="font-weight : normal;">Click
            to add the </SPAN><A HREF="glossary.asp#def_protocol">protocol</A> <A HREF="glossary.asp#def_filter">filter</A><SPAN STYLE="font-weight : normal;"> to the list at the bottom of the page.</SPAN></P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN> Click to update
            information for the <A HREF="glossary.asp#def_protocol">protocol</A> <A HREF="glossary.asp#def_filter">filter</A>,
            if you have changed any of the fields.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN> Select a <A HREF="glossary.asp#def_filter">filter</A> profile from the table at the bottom of the list and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove the profile.</P>
      </UL>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;      </P>
 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >Virtual Server</font><a name="access_virtual_server"></a></td>
        </tr>
      </table>
      <P>This screen enables you to create a <A HREF="glossary.asp#def_virtual_server">virtual
server</A> via the router. If the router is set as a virtual server,
remote users requesting Web or <A HREF="glossary.asp#def_FTP">FTP</A> services through the <A HREF="glossary.asp#def_WAN">WAN</A> are
directed to local servers in the <A HREF="glossary.asp#def_LAN">LAN</A>.
The router redirects the request via the <A HREF="glossary.asp#def_protocol">protocol</A> and <A HREF="glossary.asp#def_port">port</A> numbers to the correct
LAN server.</P>
      <P> The Virtual Sever profiles are listed in the table at the bottom of
        the page.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> When selecting items
        in the table at the bottom, <A HREF="#addprotfilter">click</A> anywhere in the item. The line is selected, and the fields
        automatically load the item's parameters, which you can edit.</P>
      <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN><A NAME="access_virtual_server_enable"></A> Click to enable or disable the <A HREF="glossary.asp#def_virtual_server">virtual
        server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Name:</SPAN><A NAME="access_virtual_server_name"></A> Type a descriptive name for the <A HREF="glossary.asp#def_virtual_server">virtual
        server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Protocol:</SPAN><A NAME="access_virtual_server_protocol"></A> Select the <A HREF="glossary.asp#def_protocol">protocol</A> (<A HREF="glossary.asp#def_TCP">TCP</A> or <A HREF="glossary.asp#def_UDP">UDP</A>) you want to use for the <A HREF="glossary.asp#def_virtual_server">virtual
        server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Private Port:</SPAN><A NAME="access_virtual_server_private_port"></A> Type the <A HREF="glossary.asp#def_port">port</A> number of the
        computer on the <A HREF="glossary.asp#def_LAN">LAN</A> that is being
        used to act as a <A HREF="glossary.asp#def_virtual_server">virtual server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Public Port:</SPAN><A NAME="access_virtual_server_public_port"></A> Type the <A HREF="glossary.asp#def_port">port</A> number on the <A HREF="glossary.asp#def_WAN">WAN</A> that will be used to provide access to the <A HREF="glossary.asp#def_virtual_server">virtual
        server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">LAN Server:</SPAN><A NAME="access_virtual_server_LAN_server"></A> Type the <A HREF="glossary.asp#def_LAN">LAN</A> <A HREF="glossary.asp#def_ip_address">IP
        address</A> that will be assigned to the <A HREF="glossary.asp#def_virtual_server">virtual
          server</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Add:</SPAN> Click to add the <A HREF="glossary.asp#def_virtual_server">virtual
        server</A> to the table at the bottom of the screen.</P>
      <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN> Click to update
        information for the <A HREF="glossary.asp#def_virtual_server">virtual server</A> if you have selected a list item and have made changes.</P>
      <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN> Select a list item
        and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove
        the item from the list.</P>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF">Special AP</font><a name="access_special_ap"></a></td>
        </tr>
      </table>
      <P>This screen enables you to specify special applications.</P>
      <P> The special applications profiles are listed in the table at the
        bottom of the page.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> When selecting items
        in the table at the bottom, <A HREF="#addprotfilter">click</A> anywhere in the item. The line is selected, and the fields
        automatically load the item's parameters, which you can edit.</P>
      <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN><A NAME="access_special_AP_enable"></A> Click to enable or disable the application profile. When enabled,
        users will be able to connect to the application via the router <A HREF="glossary.asp#def_WAN">WAN</A> connection. Click Disabled on a profile to prevent users from
        accessing the application on the WAN.</P>
      <P> <SPAN STYLE="font-weight : bold;">Name:</SPAN><A NAME="access_special_AP_name"></A> Type a descriptive name for the application.</P>
      <P> <SPAN STYLE="font-weight : bold;">Trigger:</SPAN><A NAME="access_special_AP_trigger"></A> Defines the outgoing communication that determines whether the user
        has legitimate access to the application.</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Protocol:</SPAN> Select the <A HREF="glossary.asp#def_protocol">protocol</A> (<A HREF="glossary.asp#def_TCP">TCP</A>, <A HREF="glossary.asp#def_UDP">UDP</A>, or <A HREF="glossary.asp#def_ICMP">ICMP</A>)
            that can be used to access the application.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Port Range:</SPAN> Type the <A HREF="glossary.asp#def_port">port</A> range that can be used to access the application in the text boxes.</P>
      </UL>
      <P> <SPAN STYLE="font-weight : bold;">Incoming:</SPAN><A NAME="access_special_AP_incoming"></A> Defines which incoming communications users are permitted to connect with.</P>
      <UL>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Protocol:</SPAN> Select the <A HREF="glossary.asp#def_protocol">protocol</A> (<A HREF="glossary.asp#def_TCP">TCP</A>, <A HREF="glossary.asp#def_UDP">UDP</A>, or <A HREF="glossary.asp#def_ICMP">ICMP</A>)
            that can be used by the incoming communication.</P>
        <LI CLASS="mvd-P">
          <P> <SPAN STYLE="font-weight : bold;">Port:</SPAN> Type the <A HREF="glossary.asp#def_port">port</A> number that can be used for the incoming communication.</P>
      </UL>
      <P> <SPAN STYLE="font-weight : bold;">Add:</SPAN> Click to add the
        special application profile to the table at the bottom of the screen.</P>
      <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN> Click to update
        information for the special application if you have selected a list
        item and have made changes.</P>
      <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN> Select a list item
        and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove
        the item from the list.</P>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >DMZ</font><a name="access_DMZ"></a></td>
        </tr>
      </table>
      <P>This screen enables you to create a <A HREF="glossary.asp#def_DMZ">DMZ</A> for those computers that cannot access Internet applications properly
through the router and associated security settings.</P>
      <P> <SPAN STYLE="font-weight : bold;">Enable:</SPAN><A NAME="access_dmz_enable"></A> Click to enable or disable the <A HREF="glossary.asp#def_DMZ">DMZ</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">DMZ Host IP:</SPAN><A NAME="access_dmz_host_ip"></A> Type a <A HREF="glossary.asp#def_host_name">host</A> <A HREF="glossary.asp#def_ip_address">IP
        address</A> for the <A HREF="glossary.asp#def_DMZ">DMZ</A>. The
        computer with this IP address acts as a DMZ host with unlimited
        Internet access.</P>
      <P CLASS="Note"> <SPAN STYLE="font-weight : bold;">Note:</SPAN> Any clients added to
        the DMZ exposes the clients to security risks such as viruses and
        unauthorized access.</P>
      <P> <SPAN STYLE="font-weight : bold;">Apply:</SPAN> Click to save the settings.</P>
      <P> <A HREF="help_access.asp">back to top</A></P>
      <P>&nbsp;</P>
	  <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"><p></p>
              <font color="#FFFFFF" >Firewall settings</font><a name="access_Firewall_setting"></a></td>
        </tr>
      </table>
	  <P>This screen enables you to set up the <a href="glossary.asp#def_firewall">firewall </a>. The router provides basic firewall functions, by filtering all the packets that enter the router using a set of rules. The rules are in an order sequence list-the lower the rule number, the higher the priority the rule has. </P>
      <p>The rule profiles are listed in the table at the bottom of the page. </p>
      <p>Note: When selecting items in the table at the bottom, <a href="help_access.asp#addprotfilter">click </a> anywhere in the item. The line is selected, and the fields automatically load the item's parameters, which you can edit. </p>
      <p>Enable: <a name="access_firewall_enable"></a> Click to enable or disable the <a href="glossary.asp#def_firewall">firewall </a> rule profile. </p>
      <p>Name: <a name="access_firewall_name"></a> Type a descriptive name for the <a href="glossary.asp#def_firewall">firewall </a> rule profile. </p>
      <p>Action: <a name="access_firewall_action"></a> Select whether to allow or deny <a href="glossary.asp#def_packet">packets </a> that conform to the rule. </p>
      <p>Source: <a name="access_firewall_source"></a> Defines the source of the incoming <a href="glossary.asp#def_packet">packet </a> that the rule is applied to. </p>
      <ul>
      <li>
	  <p>Interface: Select which interface ( <a href="glossary.asp#def_WAN">WAN </a> or <A HREF="glossary.asp#def_LAN">LAN</A>) the rule is applied to. </p>
	<li>
	  <p>IP Range Start: Type the start <a href="glossary.asp#def_ip_address">IP address </a> that the rule is applied to. </p>
	<li>
	  <p>IP Range End: Type the end <a href="glossary.asp#def_ip_address">IP address </a> that the rule is applied to. </p>
	</li>
  </ul>
  <p>Destination: <a name="access_firewall_destination"></a> Defines the destination of the incoming <a href="glossary.asp#def_packet">packet </a> that the rule is applied to. </p>
  <ul>
	<li>
	  <p>Interface: Select which interface ( <a href="glossary.asp#def_WAN">WAN </a> or <A HREF="glossary.asp#def_LAN">LAN</A>) the rule is applied to. </p>
	<li>
	  <p>IP Range Start: Type the start <a href="glossary.asp#def_ip_address">IP address </a> that the rule is applied to. </p>
	<li>
	  <p>IP Range End: Type the end <a href="glossary.asp#def_ip_address">IP address </a> that the rule is applied to. </p>
	<li>
	  <p>Protocol: Select the <a href="glossary.asp#def_protocol">protocol </a> ( <a href="glossary.asp#def_TCP">TCP </a>, <a href="glossary.asp#def_UDP">UDP </a>, or <a href="glossary.asp#def_ICMP">ICMP </a>) of the destination. </p>
	<li>
	  <p>Port Range: Select the <a href="glossary.asp#def_port">port </a> range. </p>
	</li>
  </ul>
  <p>Add: <a name="access_ip_filter_add"></a> Click to add the rule profile to the table at the bottom of the screen. </p>
  <p>Update: <a name="access_ip_filter_update"></a> Click to update information for the rule if you have selected a list item and have made changes. </p>
  <p>Delete: <a name="access_ip_filter_delete"></a> Select a list item and click Delete to remove the item from the list. </p>
  <p>New: <a name="access_ip_filter_new"></a> Click New to erase all fields and enter new information. </p>
  <p>Priority Up: <a name="access_firewall_priority_up"></a> Select a rule from the list and click Priority Up to increase the priority of the rule. </p>
  <p>Priority Down: <a name="access_firewall_priority_down"></a> Select a rule from the list and click Priority Down to decrease the priority of the rule. </p>
  <p>Update Priority: <a name="access_firewall_update_priority"></a> After increasing or decreasing the priority of a rule, click Update Priority to save the changes. </p>
  <p><A HREF="help_access.asp">back to top </a></p>
    </td>
  </tr>
  
</table>

<P>
  
</BODY>
</HTML>
