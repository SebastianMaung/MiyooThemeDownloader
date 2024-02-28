#!/bin/sh

echo ----
echo $0 $*
progdir=`dirname "$0"`
homedir=$progdir/advmenu
echo progdir : $progdir
echo homedir : $homedir
echo ----
home="$PWD"
cd "$progdir"
touch /tmp/stay_awake
#Check if a current version of the Theme README has already been downloaded
#Checking if the file exists 
echo "Checking for updates"

#This downloads the latest README and grabs its checksum f1c0835b111e94336679169d1e0b2b07 (29-Feb-2024)
wget -O latest_md https://raw.githubusercontent.com/OnionUI/Themes/main/README.md
latest_checksum=$(md5sum 'latest_md' | awk '{print $1}')
#remove the file once md5sum has been calculated
rm latest_md

#f1c0835b111e94336679169d1e0b2b07

if [ -f "res/current_checksum.txt" ]; then
    #Checking the checksum of the previous saved checksum
    current_checksum=$(<"res/current_checksum.txt")

    if [ $current_checksum = $latest_checksum ]; then
        #There is no changes to the README
        echo "No Updates Found"
    else 
        #There is an update found to the README
        #Download Themes 
        echo "Update Found"
		t -q -e $home"/downloadmain.sh"

		#Saves the new checksum to the txt file
        echo $latest_checksum > res/current_checksum.txt
    fi 
else

    echo "First time installation"
	#Download themes
    st -q -e $home"/downloadmain.sh"
	#Saves the new checksum to the txt file
    echo $latest_checksum > res/current_checksum.txt
fi
#check sum ends
# running thumbnails_generator for AdvanceMenu
#./thumbnails_generator.sh
if [ -f "/mnt/SDCARD/.tmp_update/onionVersion/version.txt" ]; then
	infoPanel -t "ThemeStore" -m "LOADING...\nMusic : The World Of Douve by DOUVE\nThemeStore by Sebastian Maung\nWith help from schmurtzm" --persistent &
	LD_LIBRARY_PATH="./libs:$LD_LIBRARY_PATH"
else
	LD_LIBRARY_PATH="./libs:./bin:/customer/lib:/config/lib:/lib"
	say "Loading..."
fi

# each folder will use its own library folder (infoPanel & jpgr doesn't use the same libSDL_image-1.2.so.0) :


echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor




touch /tmp/dismiss_info_panel


echo "Running advancemenu now !"
cd $homedir

# put backlight to max brightness (as during boot)
echo 255 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle


HOME=. ./advmenu -cfg ./advmenu.rc

/customer/app/sysmon freemma

# restore initial backlight level
brightness=`/customer/app/jsonval brightness`
brightness_raw=`awk "BEGIN { print int(3 * exp(0.350656 * $brightness) + 0.5) }"`
echo "brightness: $brightness -> $brightness_raw"
echo $brightness_raw > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
