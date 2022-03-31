# ScrcpyWiFi

ScrcpyWiFi.sh mirrors your Android Device's screen to your Linux desktop over WiFi.  You can control your Android device using your keyboard and mouse to do virtually everything you can do from your device's touch screen, for example to read and send text messages and e-mails, answer and place calls, manage contacts, configure the device, etc.  

You will need to connect your device to your comuputer via USB the first time you execute the script code, but should not need to do so after that unless your device's IP address changes.

INSTRUCTIONS:

I.  Enable USB debugging on your Android device.  The way to enable USB debugging can be different for different devices.  You can do a web search to find out how to do it for your specific device.


II.  Install the following required packages on your Linux computer:

    adb
    scrcpy
    zenity

Notes regarding the packages:

    A.  The repository versions of adb and zenity worked for me in each of the distributions on which I tried the script code, 
    which are Arch Linux (both X11 and Wayland), KDE Neon, Linux Mint Cinnamon 20.3 and LMDE 5.  See the following notes for scrcpy:

    B.  scrcpy compatibility in specific distributions as of March 2022:

    Arch Linux - The repository version of scrcpy works.

    Linux Mint 20.3 -  The Snap package of scrcpy works (the repository version of scrcpy did NOT work for me).

    KDE Neon -  The Snap package of scrcpy works (the repository version of scrcpy did NOT work for me).

    LMDE 5 - Install scrcpy from the source code - https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple 
    (the repository and snap versions of scrcpy did not work for me).

    If launching ScrcpyWiFi.sh at step VI below generates an error indicating that your system has an incorrect version of adb, which happened to me on LMDE 5, installing scrcpy from the source code should force scrcpy to work with the version of adb installed on your computer.  Of course,  uninstall any other scrcpy installations first.


III.  Reboot your computer after installing the above applications.


IV.  Clone this repository:

    git clone https://github.com/C8forT/ScrcpyWiFi

or create a text file in the directory of your choice, and name the file (e.g., ScrcpyWiFi.sh).  Then copy the ScrcpyWiFi.sh script code into the text file you just created (now it is a script file), then save and close the file.


V.  Make the script file executable:

    chmod u+x ScrcpyWiFi.sh


VI.  Make sure your Android device is NOT in sleep mode and you are logged into it.  Launch the script file on your computer and follow the directions in the popup windows.  Your android device also may have a popup message promting you to allow the connection to your computer.  If so, select "Allow".


Note:  The first time you execute ScrcpyWiFi.sh, you will be prompted to plugin your Android device to your computer via a USB cable, then to unplug it. After the first time using it, the cable should not be required unless your device's IP address changes.  I assigned a static IP address to my Android phone in my router, but you also can do that on the phone itself so long as the IP address is outside of your router's DHCP range (problems can arrise if your phone connects to your WiFi network and that IP address has been assigned to another device.)
