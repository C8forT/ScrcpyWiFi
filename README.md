# ScrcpyWiFi

The ScrcpyWiFi.sh script file mirrors your Android Device's screen to your desktop over WiFi.  
You can control your Android device using your keyboard and mouse, for example to read and send text messages, 
answer and place calls, configure the device, etc.


1.  The following packages are required to be installed for it to work:

    adb
    
    scrcpy
    
    zenity

Notes:

A.  The repository versions of adb and zenity worked for me in each of the distributions on which I tried the script code, which are Arch Linux, KDE Neon, Linux Mint Cinnamon 20.3 and LMDE 5.  See the following notes for scrcpy:

B.  scrcpy compatibility in specific distributions as of March 2022:

    Arch Linux - The repository version of scrcpy works.

    Linux Mint 20.3 -  The Snap package of scrcpy works (the repository version of scrcpy did NOT work for me).

    KDE Neon -  The Snap package of scrcpy works (the repository version of scrcpy did NOT work for me).

    LMDE 5 - Install scrcpy from the source code - https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple 
    (the repository and snap versions of scrcpy did not work for me).
    
If launching ScrcpyWiFi generates an error indicating that your system has an incorrect version of adb, which happened to me on LMDE 5, installing scrcpy from the source code should force scrcpy to work with the version of adb installed on your computer.  Of course,  uninstall any other scrcpy installations first.


2.  Reboot your computer after installing the above applications.


3.  Download the ScrcpyWiFi.sh script file and place it in a directory of your choice.  I created a directory named "Scripts" in my Home directory and placed the script file there.


4.  Make the ScrcpyWiFi.sh script file executable:

    A.  In the terminal, go into the directory where ScrcpyWiFi.sh is stored, then enter chmod u+x ScrcpyWiFi.sh
    
    OR
    
    B.  In your file manager, open the directory where ScrcpyWiFi.sh is stored, right click on ScrcpyWiFi.sh, select properties, select the permissions tab, then check the box "Is executable" (in Dolphin), "Allow executing file as program" (in Nemo), or the equavlent for your file manager.


5.  The first time you execute ScrcpyWiFi.sh, you will be prompted to plugin your Android device to your computer via a USB cable, then to unplug it. After the first time using it, the cable should not be required unless your device's IP address changes.  I assigned a static IP address to my Android phone in my router, but you also can do that on the phone itself so long as the IP address is outside of your router's DHCP range (problems can arrise if your phone connects to your WiFi network and that IP address has been assigned to another device.)
