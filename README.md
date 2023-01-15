# ScrcpyWiFi vers. 1.4

ScrcpyWiFi.sh mirrors your Android Device's screen to your Linux desktop over WiFi.  You can control your Android device using your keyboard and mouse to do virtually everything you can do from your device's touch screen, for example to read and send text messages and e-mails, answer and place calls, manage contacts, configure the device, etc.  

You will need to connect your device to your comuputer via USB the first time you execute the script code, but should not need to do so after that unless your device's IP address changes.

INSTRUCTIONS:

I.  Activate USB debugging on your Android device.  Also activate the option to "Disable adb authorization timeout" if your device has that option.   

    The way to activate USB debugging can be different for different devices.  You can do a web search to find out how to do it
    for your specific device.  Usually you need to enable Developer options on your Android device, then under Developer options
    activate USB debugging and activate the option to "Disable adb authorization timeout".


II.  Install the following required packages on your Linux computer:

    adb
    scrcpy
    zenity
    
    (For Arch, if adb is not in the repository, install android-tools, which includes adb)

Notes regarding installation of the required packages:

    A.  adb and zenity compatibility as of March 2022:
    
    The repository versions of adb and zenity worked for me in each of the distributions on which I tried the script code, 
    which are Arch Linux (both X11 and Wayland), KDE Neon, Linux Mint Cinnamon, LMDE 5 and Fedora. Thus, you can install adb
    and zenity via your package manager or software store.  UPDATE Jan. 2023 - adb is in the Fedora repository, and Fedora 37
    includes zenity by default.
   
    B.  scrcpy compatibility as of March 2022:

        1.  Arch Linux - the repository version of scrcpy should work in Arch and any Arch based distributions.  
        It worked for me in Arch.

        2.  Ubuntu -  UPDATE:  As of Sept. 2022, the repository version of scrcpy worked in Linux Mint 21.  
        I would presume that the repository version of scrcpy will work in Ubuntu 22.04 and other distributions based on Ubuntu 22.04.  
        If not, the scrcpy Snap package should work in Ubuntu and any Ubuntu based distributions.  UPDATE 2:  As of Nov. 2022 the Snap
        package stopped working on KDE Neon after upgrading to version 22.04.  If you have the Snap version installed and run into
        problems, uninstall it and install the repository version.
             
        3.  Debian - for Debian and Debian based distributions (that are not based on Ubuntu), install scrcpy from the source code - 
            
            https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple 
    
        The repository and Snap versions of scrcpy did not work for me in LMDE 5, which is based on Debian.
        
        4.  Fedora (Jan. 2023) - scrcpy is not in the main Fedora repository.  I accessed it from the Fedora Copr repository, which is 
        a user repository:
                sudo dnf copr enable zeno/scrcpy
                sudo dnf install scrcpy
    
    If launching ScrcpyWiFi.sh at step VI below generates an error indicating that your system has an incorrect version of adb,
    which happened to me on LMDE 5, installing scrcpy from the source code should force scrcpy to work with the version of adb
    installed on your computer.  Of course, first uninstall any other versions of scrcpy you may have intalled.  Otherwise,
    you still may get errors if you have multiple versions of scrcpy installed.
    

III.  Reboot your computer after installing the required packages.


IV.  Clone this repository:

    git clone https://github.com/C8forT/ScrcpyWiFi

Alternatively, you can create a text file in the directory of your choice, and name the file ScrcpyWiFi.sh (or whatever else you want to call it).  Then copy the ScrcpyWiFi.sh script code into the text file you just created (now it is a script file), then save and close the file.


V.  Make the script file executable.  

To do so, in the terminal change to the directory where ScrcpyWiFi.sh is stored, and enter the following command:

    chmod u+x ScrcpyWiFi.sh
    
Alternatively, you can make the script file executable in your file manager by selecting the file's properties, going to the Permissions tab and selecting the option to make the file executable (usually a checkbox).

VI.  Make sure your Android device is NOT in sleep mode and you are logged into it.  Launch the script file on your computer and follow the directions in the popup windows.  Your Android device also may have a popup message promting you to allow the connection to your computer.  If so, select "Allow".

To launch ScrcpyWiFi.sh from the file manager, double click the ScrcpyWiFi.sh file.

To launch ScrcpyWiFi.sh from the terminal, change to the directory where ScrcpyWiFi.sh is stored, and enter the following command:

    ./ScrcpyWiFi.sh
    
Optionally, create a path statement, e.g., in ~/.bash_profile or ~/.bashrc, to the directory where ScrcpyWiFi.sh is stored to be able to launch ScrcpyWiFi.sh from the terminal without having to change into that directory. 

    Notes:  
    
    Your computer and your Android device must be assigned IP addresses on the same subnet.  
    
    The first time you execute ScrcpyWiFi.sh, you will be prompted to plugin your Android device to your computer via a
    USB cable, then to unplug it. After the first time using it, the cable should not be required unless your device's 
    IP address changes or your Android device removes your computer from the allowed connections after some time.  I have
    Noticed that if I don't connect my Phone to my system for some time, maybe a week or so, my phone no longer recognizes
    my computer as an allowed connection and I am prompted again to plug my phone into the computer and repeat the first
    connection process.
    
    I assigned a static IP address to my Android phone in my router, but you also can do that on the phone itself so long 
    as the IP address is outside of your router's DHCP range (problems can arrise if your phone connects to your WiFi network
    and that IP address has been assigned to another device.)
    
VII. (Optional) Create a menu item for ScrcpyWiFi.sh in your desktop's menu.  Once the menu item is created, you also can add the menu item to your panel and/or, in some destop environments, to your desktop.
