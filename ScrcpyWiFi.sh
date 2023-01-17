#!/bin/bash

#  This script connects Linux to Android device over WiFi and mirrors the device's display on the Linux desktop
#  Version 1.4.1


#############################################################################################################################################################

#  Function for Establishing adb Connection to Android Device Over WiFi

#############################################################################################################################################################

new_conn () {
  
zenity --info --text="`printf "Connect Phone to Computer Via USB - Make Sure Phone is Not in Sleep Mode nor Locked\n\nThen Click OK to Continue"`" --title="Connect Phone" --width=250 --height=150
# Pop-up Window with instructions
		
adb tcpip 5555 
# Initialize port 5555 to enable adb over WiFi
    		
sleep 5
# Must use sleep command here - with wait command code hangs if port does not initialize
    		
ipadd=$(adb shell ip -f inet addr show wlan0 | grep -o 192.*/ | cut -d '/' -f1)
# Identify the device's WiFi IP address
    		
ipfull="$ipadd:5555"  
# append a colon and the port number 5555 to the device's WiFi IP Address

mkdir -p $HOME/.config/scrcpy
# Make directory where ip.txt will be stored if it does not already exist

wait
    		
echo "$ipfull" >| $HOME/.config/scrcpy/ip.txt  
# Store the IP address:portnumber to ip.txt
    		
adb connect $ipfull  
# Connect adb to the device using the IP address:portnumber
    		
zenity --info --text="`printf "Disconnect USB Cable From Phone Now\n\nThen Click OK to Continue"`" --title="Attempting WiFi Connection" --width=250 --height=150
# Pop-up Window with instructions
    
}


#############################################################################################################################################################

#  Function for Launching scrcpy 
#  If scrcpy Fails to Connect, One Additional Attempt is Made to Establish adb Connection and Execute scrcpy

#############################################################################################################################################################

launch_scrcpy () {

command="scrcpy"
log="$HOME/.config/scrcpy/prog.log"
match="INFO"
# Define variables
# command is the command to be executed
# log is the log file to be generated
# match is the term being searched for in the log file to determine whether scrcpy successfully connects to the device

$command > "$log" 2>&1 &
# Launch scripy and direct scrcpy output to the log file, automatically creating the log file if it does not exist, 
# where 2>&1 indicates to send standard error (2) to the log file where standard output (1) is being directed 
# "&" at end is an instruction to run in a background process and immediately return to the command line for additional commands
    
pid=$!
# get pid of last command (scrcpy).

sleep 5
# Must use sleep command here - with wait command code hangs in some circumstances

if grep -F -q "$match" "$log"
# Check to see if scrcpy outputs "INFO", indicating it has successfully launched

then
# If Scrcpy outputs "INFO", indicating it has successfully launched

	exit 0
	# Exit script

else
# If Scrcpy does not output "INFO", indicating it has not successfully launched
 	    
    zenity --info --text="`printf "WiFi Connection to Phone Failed\n\nClick OK to Retry"`" --title="Phone Not Connected" --width=250 --height=150  
    # Pop-up Window with instructions
	
    kill $pid
    #kill scrcpy

    new_conn
    #Establish new adb connection

    sleep 2

    $command > "$log" 2>&1 &
    # Launch scripy and again direct scrcpy output to the log file
    
    pid=$!
    # get pid of last command (scrcpy).

    sleep 5

    if grep -F -q "$match" "$log"
    # Check to see if scrcpy outputs "INFO", indicating it has successfully launched

    then
    # If Scrcpy outputs "INFO", indicating it has successfully launched

        exit 0
        # Exit script

    else
    # If Scrcpy does not output "INFO", indicating it has not successfully launched

        zenity --info --text="`printf "WiFi Connection to Phone Twice Failed\n\nClick OK Exit"`" --title="Phone Not Connected" --width=250 --height=150  
        # Pop-up Window with instructions
	
        kill $pid
        #kill scrcpy
   
        exit 0 
        # Exit script

    fi

fi
  
}


############################################################################################################################################################

#  Main Script

############################################################################################################################################################

if adb devices | grep -q 192.* 
#  Check to see if adb is already connected to the device

then
# If adb is already connected to the device

	launch_scrcpy
	# Execute Function to Launch Scrcpy to display device's screen on desktop
    	
	wait
	
else
# If adb is not already connected to the device

    adb kill-server
    wait
    adb start-server
    wait
    # Restart adb server

	if [ -f "$HOME/.config/scrcpy/ip.txt" ]
	#  Check to see if the ip.txt file exists

	then
	# If the ip.txt file exists
	
		storedip=$(head -n 1 $HOME/.config/scrcpy/ip.txt) 
		# Get the stored IP address:portnumber from ip.txt
		
		wait

        if adb connect "$storedip" | grep -q "connected to $storedip"
        # Check to see if adb is able to connect to the stored IP address

        then
        # If adb is able to connect to the stored IP address
	
            launch_scrcpy
            # Execute Function to Launch Scrcpy to display device's screen on desktop
			
            wait

        else
        # If the ip.txt file does not exist or unable to connect to the stored IP address
	
            new_conn
            # Execute new_conn function for adb to connect to the device

            launch_scrcpy
            # Execute Function to Launch Scrcpy to display device's screen on desktop

        fi
    	
    else
    # If the ip.txt file does not exist or unable to connect to the stored IP address
	
        new_conn
        # Execute new_conn function for adb to connect to the device

        launch_scrcpy
		# Execute Function to Launch Scrcpy to display device's screen on desktop
		
	fi
   	
fi
