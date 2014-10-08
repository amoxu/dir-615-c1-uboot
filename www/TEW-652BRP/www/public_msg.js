var msg = new Array("Quit setup wizard and discard settings?",		// MSG0
				  	"The Verify password does not match the New password.",	// MSG1
				  	"The IP address and the %s are not in the same domain.",	// MSG2
				  	"The %s and the LAN IP address are not in the same domain.",	// MSG3
				  	"The Ending IP address must be greater than the Starting IP address.",	// MSG4
				  	"The legal characters of MAC address must be 0~9, A~F, or a~f.",	// MSG5
				  	"SSID can not be empty.",		// MSG6
				  	"The IP Address and the Gateway IP Address are not in the same subnet.",	// MSG7
				  	"The confirmed password does not match the new Admin password.",	// MSG8
					"The confirmed password does not match the new User password.",	// MSG9
					"The selected WEP key field cannot be blank.",					// MSG10
					"The Confirmed Passphrase does not match the Passphrase.",		// MSG11
					"The length of the Passphrase must be between 8 and 64 characters.",	// MSG12
					"The Passphrase must be 0~9, A~F, or a~f.",						// MSG13
					"Please enter another SMTP Server or IP Address.",				// MSG14
					"Please enter a valid email Address.",							// MSG15
					"Are you sure that you want to delete this %s?",			// MSG16
					"Load settings from a saved configuration file?",		// MSG17
					"Please enter another name.",									// MSG18
					"Please enter another keyword.",								// MSG19
					"---This keyword is already existing in the keyword list.",		// MSG20
					"Are you sure that you want to delete this IP filter?",			// MSG21
					"",		// MSG22
					"This %s is already existing in the list.",			// MSG23
					"Are you sure that you want to delete this protocol filter?",			// MSG24
					"Please enter another port number 1~65535.",			// MSG25
					"Please enter another Private Port number.",		// MSG26
					"Please enter another Public Port number.",		// MSG27
					"%sPort conflict.",	// MSG28
					"Are you sure that you want to delete this special ap?",		// MSG29
					"Please enter another Trigger Port number.",	// MSG30
					"Please enter another Incoming Port number.",	// MSG31
					"Do you want to restart this router?",			// MSG32
					"Please select a saved configuration file to upload.",				// MSG33
					"Restore to Factory Default Settings?",			// MSG34
					"Please select a Firmware file to upgrade the router.",		// MSG35
					"Please enter a host name or an IP address.",	// MSG36
					"Are you sure that you want to delete this firewall rule?",	// MSG37
					"The Community can not be blank.",							// MSG38
					"The Host Name must be 0~9, A~Z, or a~z.",					// MSG39
					"The Server IP Address entered is invalid",					// MSG40
					"The %s has the same name.",					// MSG41
					"The %s has the same MAC.",					// MSG42
					"%s is conflicted with LAN IP address, please enter again.",	// MSG43
					"Rule name can not be empty string!",		//MSG44
					"Nothing has changed, save anyway?",		//MSG45
					"The IP Address and the reservation IP Address are not in the same subnet.",	// MSG46
					"The MAC Address entered is invalid.",	//MSG47	 																	
					"Are you sure that you want to delete ",	//MSG48
					"%s is conflicted with LAN IP address, please enter again.",	// MSG49
					"Please enter another Name",	//MSG50
					"Please enter user name", //MSG51
					"The Ending port number must be greater than the Starting port number.",	// MSG52		
					"The host Name length can't be more than 63.",	// MSG53
					"Host name format error, please check again. \n 1.All text can not be for the digital. \n 2.At the beginning and the end of the text is not as -. \n 3.Max length can't over then 63"	// MSG54								
				   );
					   
var MSG0 = 0;
var MSG1 = 1;
var MSG2 = 2;
var MSG3 = 3;
var MSG4 = 4;
var MSG5 = 5;
var MSG6 = 6;
var MSG7 = 7;
var MSG8 = 8;
var MSG9 = 9;
var MSG10 = 10;
var MSG11 = 11;
var MSG12 = 12;
var MSG13 = 13;
var MSG14 = 14;
var MSG15 = 15;
var MSG16 = 16;
var MSG17 = 17;
var MSG18 = 18;
var MSG19 = 19;
var MSG20 = 20;
var MSG21 = 21;
var MSG22 = 22;
var MSG23 = 23;
var MSG24 = 24;
var MSG25 = 25;
var MSG26 = 26;
var MSG27 = 27;
var MSG28 = 28;
var MSG29 = 29;
var MSG30 = 30;
var MSG31 = 31;
var MSG32 = 32;
var MSG33 = 33;
var MSG34 = 34;
var MSG35 = 35;
var MSG36 = 36;
var MSG37 = 37;
var MSG38 = 38;
var MSG39 = 39;
var MSG40 = 40;
var MSG41 = 41;
var MSG42 = 42;
var MSG43 = 43;
var MSG44 = 44;
var MSG45 = 45;
var MSG46 = 46;
var MSG47 = 47;
var MSG48 = 48;
var MSG49 = 49;
var MSG50 = 50;
var MSG51 = 51;
var MSG52 = 52;
var MSG53 = 53;
var MSG54 = 54;

/** for check_address() using **/

var all_ip_addr_msg = new Array("The %s is an invalid address.",	// INVALID_IP
						       "The %s can not be zero.",	// ZERO_IP
						       "The 1st address of %s must be an integer.",	// FIRST_IP_ERROR
						       "The 2nd address of %s must be an integer.",	// SECOND_IP_ERROR
						       "The 3rd address of %s must be an integer.",	// THIRD_IP_ERROR
						       "The 4th address of %s must be an integer.",	// FOURTH_IP_ERROR
						       "The 1st range of %s is must be between ",			// FIRST_RANGE_ERROR
						       "The 2nd range of %s is must be between  ",			// SECOND_RANGE_ERROR
						       "The 3rd range of %s is must be between   ",			// THIRD_RANGE_ERROR
						       "The 4th range of %s is must be between  ",		// FOURTH_RANGE_ERROR
						       "The port of %s is invalid.",		// RADIUS_SERVER_PORT_ERROR
						       "The Shared Secret of %s can not be empty.",		// RADIUS_SERVER_SECRET_ERROR
						       "The %s can't allow enter loopback IP or multicase IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x)."			// MULTICASE_IP_ERROR
						      );

var subnet_mask_msg = new Array("The Subnet Mask is an invalid address.",	// INVALID_IP
						           "The Subnet Mask can not be zero.",	// ZERO_IP
						           "The 1st address of Subnet Mask must be an integer.",	// FIRST_IP_ERROR
						    	   "The 2nd address of Subnet Mask must be an integer.",	// SECOND_IP_ERROR
						    	   "The 3rd address of Subnet Mask must be an integer.",	// THIRD_IP_ERROR
						    	   "The 4th address of Subnet Mask must be an integer.",	// FOURTH_IP_ERROR
						    	   "The 1st range of Subnet Mask must be 128, 192, 224, 240, 248, 252, 254, 255.",			// FIRST_RANGE_ERROR
						    	   "The 2nd range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252, 254, 255.",			// SECOND_RANGE_ERROR
						    	   "The 3rd range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252, 254, 255.",			// THIRD_RANGE_ERROR
						    	   "The 4th range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252."			// FOURTH_RANGE_ERROR
						          );
	
var src_start_ip_msg = new Array("The Source Start IP address is an invalid address.",	// INVALID_IP
							     "The Source Start IP address can not be zero.",	// ZERO_IP
							     "The 1st address of Source Start IP address must be an integer.",	// FIRST_IP_ERROR
							     "The 2nd address of Source Start IP address must be an integer.",	// SECOND_IP_ERROR
							     "The 3rd address of Source Start IP address must be an integer.",	// THIRD_IP_ERROR
							     "The 4th address of Source Start IP address must be an integer.",	// FOURTH_IP_ERROR
							     "The 1st range of Source Start IP address must be between 1 to 254.",			// FIRST_RANGE_ERROR
							     "The 2nd range of Source Start IP address must be between 0 to 254.",			// SECOND_RANGE_ERROR
							     "The 3rd range of Source Start IP address must be between 0 to 254.",			// THIRD_RANGE_ERROR
							     "The 4th range of Source Start IP address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
							     );		
var src_end_ip_msg = new Array("The Source End IP address is an invalid address.",	// INVALID_IP
						       "The Source End IP address can not be zero.",	// ZERO_IP
						       "The 1st address of Source End IP address must be an integer.",	// FIRST_IP_ERROR
						       "The 2nd address of Source End IP address must be an integer.",	// SECOND_IP_ERROR
						       "The 3rd address of Source End IP address must be an integer.",	// THIRD_IP_ERROR
						       "The 4th address of Source End IP address must be an integer.",	// FOURTH_IP_ERROR
						       "The 1st range of Source End IP address must be between 1 to 254.",			// FIRST_RANGE_ERROR
						       "The 2nd range of Source End IP address must be between 0 to 254.",			// SECOND_RANGE_ERROR
						       "The 3rd range of Source End IP address must be between 0 to 254.",			// THIRD_RANGE_ERROR
						       "The 4th range of Source End IP address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
						       );	
var dst_start_ip_msg = new Array("The Destination Start IP address is an invalid address.",	// INVALID_IP
							     "The Destination Start IP address can not be zero.",	// ZERO_IP
							     "The 1st address of Destination Start IP address must be an integer.",	// FIRST_IP_ERROR
							     "The 2nd address of Destination Start IP address must be an integer.",	// SECOND_IP_ERROR
							     "The 3rd address of Destination Start IP address must be an integer.",	// THIRD_IP_ERROR
							     "The 4th address of Destination Start IP address must be an integer.",	// FOURTH_IP_ERROR
							     "The 1st range of Destination Start IP address must be between 1 to 254.",			// FIRST_RANGE_ERROR
							     "The 2nd range of Destination Start IP address must be between 0 to 254.",			// SECOND_RANGE_ERROR
							     "The 3rd range of Destination Start IP address must be between 0 to 254.",			// THIRD_RANGE_ERROR
							     "The 4th range of Destination Start IP address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
							     );		
var dst_end_ip_msg = new Array("The Destination End IP address is an invalid address.",	// INVALID_IP
						       "The Destination End IP address can not be zero.",	// ZERO_IP
						       "The 1st address of Destination End IP address must be an integer.",	// FIRST_IP_ERROR
						       "The 2nd address of Destination End IP address must be an integer.",	// SECOND_IP_ERROR
						       "The 3rd address of Destination End IP address must be an integer.",	// THIRD_IP_ERROR
						       "The 4th address of Destination End IP address must be an integer.",	// FOURTH_IP_ERROR
						       "The 1st range of Destination End IP address must be between 1 to 254.",			// FIRST_RANGE_ERROR
						       "The 2nd range of Destination End IP address must be between 0 to 254.",			// SECOND_RANGE_ERROR
						       "The 3rd range of Destination End IP address must be between 0 to 254.",			// THIRD_RANGE_ERROR
						       "The 4th range of Destination End IP address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
						       );						    

var syslog_server_msg = new Array("The Syslog Server is an invalid address.",	// INVALID_IP
								    "The Syslog Server can not be zero.",	// ZERO_IP
								    "The 1st address of Syslog Server must be an integer.",	// FIRST_IP_ERROR
								    "The 2nd address of Syslog Server must be an integer.",	// SECOND_IP_ERROR
								    "The 3rd address of Syslog Server must be an integer.",	// THIRD_IP_ERROR
								    "The 4th address of Syslog Server must be an integer.",	// FOURTH_IP_ERROR
								    "The 1st range of Syslog Server must be between 1 to 254.",			// FIRST_RANGE_ERROR
								    "The 2nd range of Syslog Server must be between 0 to 255.",			// SECOND_RANGE_ERROR
								    "The 3rd range of Syslog Server must be between 0 to 255.",			// THIRD_RANGE_ERROR
								    "The 4th range of Syslog Server must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
								    );
var http_form_ip_addr_msg = new Array("The From IP address is an invalid address in the HTTP section.",	// INVALID_IP
						    "The From IP address can not be zero in the HTTP section..",	// ZERO_IP
						    "The 1st address of From IP address must be an integer in the HTTP section..",	// FIRST_IP_ERROR
						    "The 2nd address of From IP address must be an integer in the HTTP section..",	// SECOND_IP_ERROR
						    "The 3rd address of From IP address must be an integer in the HTTP section..",	// THIRD_IP_ERROR
						    "The 4th address of From IP address must be an integer in the HTTP section..",	// FOURTH_IP_ERROR
						    "The 1st range of From IP address must be between 1 to 254 in the HTTP section..",			// FIRST_RANGE_ERROR
						    "The 2nd range of From IP address must be between 0 to 255 in the HTTP section..",			// SECOND_RANGE_ERROR
						    "The 3rd range of From IP address must be between 0 to 255 in the HTTP section..",			// THIRD_RANGE_ERROR
						    "The 4th range of From IP address must be between 1 to 254 in the HTTP section.."			// FOURTH_RANGE_ERROR						    
						    );	
var http_to_ip_addr_msg = new Array("The To IP address is an invalid address in the HTTP section.",	// INVALID_IP
						    "The To IP address can not be zero in the HTTP section..",	// ZERO_IP
						    "The 1st address of To IP address must be an integer in the HTTP section..",	// FIRST_IP_ERROR
						    "The 2nd address of To IP address must be an integer in the HTTP section..",	// SECOND_IP_ERROR
						    "The 3rd address of To IP address must be an integer in the HTTP section..",	// THIRD_IP_ERROR
						    "The 4th address of To IP address must be an integer in the HTTP section..",	// FOURTH_IP_ERROR
						    "The 1st range of To IP address must be between 1 to 254 in the HTTP section..",			// FIRST_RANGE_ERROR
						    "The 2nd range of To IP address must be between 0 to 255 in the HTTP section..",			// SECOND_RANGE_ERROR
						    "The 3rd range of To IP address must be between 0 to 255 in the HTTP section..",			// THIRD_RANGE_ERROR
						    "The 4th range of To IP address must be between 1 to 254 in the HTTP section.."			// FOURTH_RANGE_ERROR						    
						    );		
var allow_form_ip_addr_msg = new Array("The From IP address is an invalid address in the Allow to Ping WAN port section.",	// INVALID_IP
						    "The From IP address can not be zero in the Allow to Ping WAN port section..",	// ZERO_IP
						    "The 1st address of From IP address must be an integer in the Allow to Ping WAN port section..",	// FIRST_IP_ERROR
						    "The 2nd address of From IP address must be an integer in the Allow to Ping WAN port section..",	// SECOND_IP_ERROR
						    "The 3rd address of From IP address must be an integer in the Allow to Ping WAN port section..",	// THIRD_IP_ERROR
						    "The 4th address of From IP address must be an integer in the Allow to Ping WAN port section..",	// FOURTH_IP_ERROR
						    "The 1st range of From IP address must be between 1 to 254 in the Allow to Ping WAN port section..",			// FIRST_RANGE_ERROR
						    "The 2nd range of From IP address must be between 0 to 255 in the Allow to Ping WAN port section..",			// SECOND_RANGE_ERROR
						    "The 3rd range of From IP address must be between 0 to 255 in the Allow to Ping WAN port section..",			// THIRD_RANGE_ERROR
						    "The 4th range of From IP address must be between 1 to 254 in the Allow to Ping WAN port section.."			// FOURTH_RANGE_ERROR						    
						    );	
var allow_to_ip_addr_msg = new Array("The To IP address is an invalid address in the Allow to Ping WAN port section.",	// INVALID_IP
						    "The To IP address can not be zero in the Allow to Ping WAN port section..",	// ZERO_IP
						    "The 1st address of To IP address must be an integer in the Allow to Ping WAN port section..",	// FIRST_IP_ERROR
						    "The 2nd address of To IP address must be an integer in the Allow to Ping WAN port section..",	// SECOND_IP_ERROR
						    "The 3rd address of To IP address must be an integer in the Allow to Ping WAN port section..",	// THIRD_IP_ERROR
						    "The 4th address of To IP address must be an integer in the Allow to Ping WAN port section..",	// FOURTH_IP_ERROR
						    "The 1st range of To IP address must be between 1 to 254 in the Allow to Ping WAN port section..",			// FIRST_RANGE_ERROR
						    "The 2nd range of To IP address must be between 0 to 255 in the Allow to Ping WAN port section..",			// SECOND_RANGE_ERROR
						    "The 3rd range of To IP address must be between 0 to 255 in the Allow to Ping WAN port section..",			// THIRD_RANGE_ERROR
						    "The 4th range of To IP address must be between 1 to 254 in the Allow to Ping WAN port section.."			// FOURTH_RANGE_ERROR						    
						    );	
var trap1_addr_msg = new Array("The Trap Receiver 1 address is an invalid address.",	// INVALID_IP
						    "The Trap Receiver 1 address can not be zero.",	// ZERO_IP
						    "The 1st address of Trap Receiver 1 address must be an integer.",	// FIRST_IP_ERROR
						    "The 2nd address of Trap Receiver 1 address must be an integer.",	// SECOND_IP_ERROR
						    "The 3rd address of Trap Receiver 1 address must be an integer.",	// THIRD_IP_ERROR
						    "The 4th address of Trap Receiver 1 address must be an integer.",	// FOURTH_IP_ERROR
						    "The 1st range of Trap Receiver 1 address must be between 1 to 254.",			// FIRST_RANGE_ERROR
						    "The 2nd range of Trap Receiver 1 address must be between 0 to 255.",			// SECOND_RANGE_ERROR
						    "The 3rd range of Trap Receiver 1 address must be between 0 to 255.",			// THIRD_RANGE_ERROR
						    "The 4th range of Trap Receiver 1 address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
						    );	
var trap2_addr_msg = new Array("The Trap Receiver 2 address is an invalid address.",	// INVALID_IP
						    "The Trap Receiver 2 address can not be zero.",	// ZERO_IP
						    "The 1st address of Trap Receiver 2 address must be an integer.",	// FIRST_IP_ERROR
						    "The 2nd address of Trap Receiver 2 address must be an integer.",	// SECOND_IP_ERROR
						    "The 3rd address of Trap Receiver 2 address must be an integer.",	// THIRD_IP_ERROR
						    "The 4th address of Trap Receiver 2 address must be an integer.",	// FOURTH_IP_ERROR
						    "The 1st range of Trap Receiver 2 address must be between 1 to 254.",			// FIRST_RANGE_ERROR
						    "The 2nd range of Trap Receiver 2 address must be between 0 to 255.",			// SECOND_RANGE_ERROR
						    "The 3rd range of Trap Receiver 2 address must be between 0 to 255.",			// THIRD_RANGE_ERROR
						    "The 4th range of Trap Receiver 2 address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
						    );	
var trap3_addr_msg = new Array("The Trap Receiver 3 address is an invalid address.",	// INVALID_IP
						    "The Trap Receiver 3 address can not be zero.",	// ZERO_IP
						    "The 1st address of Trap Receiver 3 address must be an integer.",	// FIRST_IP_ERROR
						    "The 2nd address of Trap Receiver 3 address must be an integer.",	// SECOND_IP_ERROR
						    "The 3rd address of Trap Receiver 3 address must be an integer.",	// THIRD_IP_ERROR
						    "The 4th address of Trap Receiver 3 address must be an integer.",	// FOURTH_IP_ERROR
						    "The 1st range of Trap Receiver 3 address must be between 1 to 254.",			// FIRST_RANGE_ERROR
						    "The 2nd range of Trap Receiver 3 address must be between 0 to 255.",			// SECOND_RANGE_ERROR
						    "The 3rd range of Trap Receiver 3 address must be between 0 to 255.",			// THIRD_RANGE_ERROR
						    "The 4th range of Trap Receiver 3 address must be between 1 to 254."			// FOURTH_RANGE_ERROR						    
						    );
var INVALID_IP = 0;
var ZERO_IP = 1;
var FIRST_IP_ERROR = 2;
var SECOND_IP_ERROR = 3;
var THIRD_IP_ERROR = 4;
var FOURTH_IP_ERROR = 5;
var FIRST_RANGE_ERROR = 6;
var SECOND_RANGE_ERROR = 7;
var THIRD_RANGE_ERROR = 8;
var FOURTH_RANGE_ERROR = 9;
var RADIUS_SERVER_PORT_ERROR = 10;	// for radius server
var RADIUS_SERVER_SECRET_ERROR = 11; // for radius server
var MULTICASE_IP_ERROR = 12;
/** the end of check_address() using **/

/** for check_varible() using **/
var check_num_msg = new Array("Please enter another %s value.",
						 "The value of %s must be numeric!",
						 "The range of %s is %1n ~ %2n.",
						 "The value of %s is even number only."
						 );

var metric_msg = new Array("Please enter another Metric value.",
						 "The value of Metric must be an integer.",
						 "The range of Metric is 1 ~ 15."
						 );							 
var EMPTY_VARIBLE_ERROR = 0;
var INVALID_VARIBLE_ERROR = 1;
var VARIBLE_RANGE_ERROR = 2;
var EVEN_NUMBER_ERROR = 3;
/** the end of check_varible() using **/

/** for get_key_len_msg() using **/
var key1_len_error = new Array("The length of Key1 must be 5 characters.",
							   "The length of Key1 must be 13 characters.",
							   "The length of Key1 must be 10 characters.",
							   "The length of Key1 must be 26 characters."
							   );
							   
var key2_len_error = new Array("The length of Key2 must be 5 characters.",
							   "The length of Key2 must be 13 characters.",
							   "The length of Key2 must be 10 characters.",
							   "The length of Key2 must be 26 characters."
							   );	
							   
var key3_len_error = new Array("The length of Key3 must be 5 characters.",
							   "The length of Key3 must be 13 characters.",
							   "The length of Key3 must be 10 characters.",
							   "The length of Key3 must be 26 characters."
							   );
							   
var key4_len_error = new Array("The length of Key4 must be 5 characters.",
							   "The length of Key4 must be 13 characters.",
							   "The length of Key4 must be 10 characters.",
							   "The length of Key4 must be 26 characters."
							   );
							   						   						  							  						
var illegal_key_error = new Array("Key1 is wrong, the legal characters are 0~9, A~F, or a~f.",
								  "Key2 is wrong, the legal characters are 0~9, A~F, or a~f.",
								  "Key3 is wrong, the legal characters are 0~9, A~F, or a~f.",
								  "Key4 is wrong, the legal characters are 0~9, A~F, or a~f."								 
								  );
/** the end of get_key_len_msg() using **/						   