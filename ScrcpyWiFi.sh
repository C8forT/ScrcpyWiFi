#!/bin/bash

#  This script connects Linux to Android device over WiFi


##################################################################################################################################################################

#  Function for New Connection over WiFi

##################################################################################################################################################################

new_conn () {
  
  	zenity --info --text="Connect Phone Via USB - Make Sure Phone is Not in Sleep Mode nor Locked" --title="Connected Phone" --width=250 --height=150  
	# Pop-up Window with instructions
		
    adb kill-server
    adb start-server
   	#Restart adb server
   		
   	sleep 1
   		
   	adb tcpip 5555 
   	# Initialize port 5555 to enable adb over WiFi
    		
    sleep 2
    		
    ipadd=$(adb shell ip -f inet addr show wlan0 | grep -o 192.*/ | cut -d '/' -f1)
    # Identify the device's WiFi IP address
    		
    ipfull="$ipadd:5555"  
    # append a colon and the port number 5555 to the devices WiFi IP Address

    mkdir -p $HOME/.config/scrcpy
    # Make directory where ip.txt will be stored if it does not already exist
    		
    echo "$ipfull" >| $HOME/.config/scrcpy/ip.txt  
    # Store the IP address with the port number to ip.txt
    		
    adb connect $ipfull  
    # Connect adb to the device using the IP address:portnumber
    		
    zenity --info --text="Disconnect USB Cable From Phone Now" --title="Phone Connected" --width=250 --height=150  
    # Pop-up Window with instructions
    
}



##################################################################################################################################################################

#  Function for Launching Scrcpy and Re-establishing Connection if adb Connection Fails

##################################################################################################################################################################

launch_scrcpy () {

    command="scrcpy"
    log="$HOME/.config/scrcpy/prog.log"
    match="INFO"
    # Define variables
    # command is the command to be executed
    # log is the log file to be generated
    # match is the term being searched for in the log file to determine if scrcpy successfully connects to the device

    $command > "$log" 2>&1 &
    # Launch scripy and direct scrcpy output to the log file, automatically creating the log file if it does not exist, 
    # where 2>&1 indicates to send standard error (2) to the log file where standard output (1) is being directed 
    # "&" at end is an instruction to run in a background process and immediately return to the command line for additional commands
    
    pid=$!
    # get pid of last command.

    sleep 5

    if fgrep --quiet "$match" "$log"
    # Check to see if Scrcpy outputs "INFO", indicating it has successfully launched

    then
    # If Scrcpy outputs "INFO", indicating it has successfully launched
	
	    exit 0
        # Exit script

    else
    # If Scrcpy does not output "INFO", indicating it has not successfully launched
 	    
        zenity --info --text="Connection Failed - Retrying" --title="Phone Not Connected" --width=250 --height=150  
        # Pop-up Window with instructions
 	
     	kill $pid
     	#kill scrcpy
    	
    	new_conn
    	#Establish new adb connection
    	
    	scrcpy 
    	# launch scrcpy
    	
    	exit 0 
        # Exit script
    fi
  
}


#################################################################################################################################################################

#  Main Script

##################################################################################################################################################################


if adb devices | grep -q 192.* 
#  Check to see if adb is already connected to the device


then
# If adb is already connected to the device

	sleep 1
	
   	launch_scrcpy
   	# Execute Function to Launch Scrcpy to display device's screen on desktop
    	
else
# If adb is not connected to the device

	if [ -f "$HOME/.config/scrcpy/ip.txt" ]
	#  Check to see if the ip.txt file exists
	
	then
    # If the ip.txt file exists
                
       	storedip=$(head -n 1 $HOME/.config/scrcpy/ip.txt) 
		# Get the stored IP address from ip.txt
	
       	if adb connect "$storedip" | grep -q unable*  
		# Check to see if adb is unable to connect to the stored IP address
	
		then
        # If adb is unable to connect to the stored IP address
	
			new_conn
    		# Execute new_conn function for adb to connect to the device
			
			launch_scrcpy
			# Execute Function to Launch Scrcpy to display device's screen on desktop
			    	
   		else
        # If adb is able to connect to the stored IP address
    		
   			sleep 1
    			
   			launch_scrcpy
   			# Execute Function to Launch Scrcpy to display device's screen on desktop
    	
   		fi
    	
    else
    # If the ip.txt file does not exist
    		
        new_conn
    	# Execute new_conn function for adb to connect to the device
    		
    	launch_scrcpy
    	# Execute Function to Launch Scrcpy to display device's screen on desktop
    
    fi
   	
fi



