<HTML>
 <HEAD>
  <!-- $MVD$:app("RoboHELP HTML Edition by Blue Sky Software, portions by MicroVision Dev. Inc.","769") -->
  <!-- $MVD$:template("","0","0") -->
  <!-- $MVD$:fontset("Arial","Arial") -->
  <!-- $MVD$:fontset("Times New Roman","Times New Roman") -->
  <!-- $MVD$:fontset("Arial Narrow","Arial Narrow") -->
  <TITLE>Routing</TITLE>
<link rel="stylesheet" href="style.css" type="text/css"></HEAD>
  
<BODY bgcolor=#FFFFFF>
<table width="100%" border="0" cellpadding="5" cellspacing="5" bgcolor="#F0F0F0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
      <tr>
        <td bgcolor="#C5CEDA" class="headerbg"><p>&nbsp;</p>
          <font size="6">Routing</font></td>
      </tr>
    </table>
      <P>This page enables you to set how the router forwards data.</P>
      <P> Click the items below for more information:</P>
      <UL>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#routing_static">Static</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#routing_dynamic">Dynamic</A></b></P>
        <LI CLASS="mvd-P-Bullet">
          <P CLASS="Bullet"> <b><A HREF="#routing_routing_table">Routing Table</A></b></P>
      </UL>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"> <p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Static</font><font><a name="routing_static"></a></font></td>
        </tr>
      </table>
      <P>This screen enables you to set parameters by which the router
forwards data to its destination if your network has a static <A HREF="glossary.asp#def_ip_address">IP
address</A>.</P>
      <P> <SPAN STYLE="font-weight : bold;">Network Address:</SPAN><A NAME="routing_static_network_address"></A> Type the static <A HREF="glossary.asp#def_ip_address">IP address</A> your network uses to access the Internet. Your <A HREF="glossary.asp#def_ISP">ISP</A> or network <A HREF="glossary.asp#def_administrator">administrator</A> provides you with this information.</P>
      <P> <SPAN STYLE="font-weight : bold;">Network Mask:</SPAN><A NAME="routing_static_network_mask"></A> Type the <A HREF="glossary.asp#def_subnet_mask">network (subnet) mask</A> for your network. If you do not type a value here, the network mask
        defaults to 255.255.255.255. Your <A HREF="glossary.asp#def_ISP">ISP</A> or network <A HREF="glossary.asp#def_administrator">administrator</A> provides you with this information.</P>
      <P> <SPAN STYLE="font-weight : bold;">Gateway Address:</SPAN><A NAME="routing_static_gateway_address"></A> Type the <A HREF="glossary.asp#def_gateway">gateway address</A> for
        your network. Your <A HREF="glossary.asp#def_ISP">ISP</A> or network <A HREF="glossary.asp#def_administrator">administrator</A> provides you with this information.</P>
      <P> <SPAN STYLE="font-weight : bold;">Interface:</SPAN><A NAME="routing_static_interface"></A> Select which interface, <A HREF="glossary.asp#def_WAN">WAN</A> or <A HREF="glossary.asp#def_LAN">LAN</A> or WANPhysical,
        you use to connect to the Internet.</P>
      <P> <SPAN STYLE="font-weight : bold;">Metric:</SPAN><A NAME="routing_static_metric"></A> Select which <A HREF="glossary.asp#def_metric">metric</A> you want to
        apply to this configuration.</P>
      <P> <SPAN STYLE="font-weight : bold;">Add:</SPAN><A NAME="routing_static_add"></A> Click to add the configuration to the static <A HREF="glossary.asp#def_ip_address">IP
        address</A> table at the bottom of the page.</P>
      <P> <SPAN STYLE="font-weight : bold;">Update:</SPAN><A NAME="routing_static_update"></A> Select one of the entries in the static <A HREF="glossary.asp#def_ip_address">IP
        address</A> table at the bottom of the page and, after changing
        parameters, click <SPAN STYLE="font-style : italic;">Update</SPAN> to
        confirm the changes.</P>
      <P> <SPAN STYLE="font-weight : bold;">Delete:</SPAN><A NAME="routing_static_delete"></A> Select one of the entries in the static <A HREF="glossary.asp#def_ip_address">IP
        address</A> table at the bottom of the page and click <SPAN STYLE="font-style : italic;">Delete</SPAN> to remove the entry.</P>
      <P> <A HREF="help_routing.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"> <p>&nbsp;</p>
            <font face="Arial" color="#FFFFFF">Dynamic</font><a name="routing_dynamic"></a></td>
        </tr>
      </table>
      <P><SPAN STYLE="font-weight : bold;">Transmit:</SPAN><A NAME="routing_dynamic_transmit"></A> Click the radio buttons to set the desired transmit parameters,
      disabled, <A HREF="glossary.asp#def_RIP">RIP</A> 1, or <A HREF="glossary.asp#def_RIP">RIP</A> 2.</P>
      <P> <SPAN STYLE="font-weight : bold;">Receive:</SPAN><A NAME="routing_dynamic_receive"></A> Click the radio buttons to set the desired transmit parameters,
        disabled, <A HREF="glossary.asp#def_RIP">RIP</A> 1, or <A HREF="glossary.asp#def_RIP">RIP</A> 2.</P>
      <P> <A HREF="help_routing.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;      </P>
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#C5CEDA" class="headerbg"> <p>&nbsp;</p>
            <font color="#FFFFFF">Routing Table</font><a name="routing_routing_table"></a></td>
        </tr>
      </table>
      <P>This screen enables you to view the routing table for the router. The
routing table is a database created by the router that displays the
network interconnection topology.</P>
      <P> <SPAN STYLE="font-weight : bold;">Network Address:</SPAN><A NAME="routing_table_network_address"></A> Displays the network <A HREF="glossary.asp#def_ip_address">IP address</A> of the connected node.</P>
      <P> <SPAN STYLE="font-weight : bold;">Network Mask:</SPAN><A NAME="routing_table_network_mask"></A> Displays the <A HREF="glossary.asp#def_subnet_mask">network (subnet) mask</A> of the connected node.</P>
      <P> <SPAN STYLE="font-weight : bold;">Gateway Address:</SPAN><A NAME="routing_table_gateway_address"></A> Displays the <A HREF="glossary.asp#def_gateway">gateway address</A> of the connected node.</P>
      <P> <SPAN STYLE="font-weight : bold;">Interface:</SPAN><A NAME="routing_table_interface"></A> Displays whether the node is connected via a <A HREF="glossary.asp#def_WAN">WAN</A> or <A HREF="glossary.asp#def_LAN">LAN </A>or WAN Physical.</P>
      <P> <SPAN STYLE="font-weight : bold;">Metric:</SPAN><A NAME="routing_table_metric"></A> Displays the <A HREF="glossary.asp#def_metric">metric</A> of the
        connected node.</P>
      <P> <SPAN STYLE="font-weight : bold;">Type:</SPAN><A NAME="routing_table_type"></A> Displays whether the node has a static or dynamic <A HREF="glossary.asp#def_ip_address">IP
        address</A>.</P>
      <P> <A HREF="help_routing.asp">back to top</A></P>
      <P>&nbsp;</P>
      <P>&nbsp;</P></td>
  </tr>
</table>
</BODY>
</HTML>