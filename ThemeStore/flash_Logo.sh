#!/bin/sh

echo "=====================  $0   $1" 
cd ..

filename=$(basename -- "$1")
foldername="${filename%.*}"
echo "===================== displaying : ./logos/$foldername/image1.jpg"
./bin/jpgr "./logos/$foldername/image1.jpg"   # == Displays a rotated preview of the jpeg file


# if we press "A" for downloadr and the current image exists
if [ -f "./logos/$foldername/image1.jpg" ]; then
	DisplayInstructions=1
	./bin/say "Choose Theme?"$'\n'\("$foldername"\)$'\n\nA = Confirm    B = Cancel\nSelect = Fullscreen'
	
	while :
	do
    	KeyPressed=$(./bin/getkey)
    	sleep 0.15  # Little debounce
    	echo "====== Key pressed : $KeyPressed"

    	if [ "$KeyPressed" = "A" ]; then
    		echo "=== Start ==="
    		#./bin/say OK
    		#./bin/blank
    		#exit
    		#./bin
                #$foldername is number
		./bin/say "Loading theme "$foldername"..."
		sleep 3
                sh ./downloadtheme.sh $foldername
                ./bin/blank
    		./bin/say "Done"
    		sleep 3
		cd /mnt/SDCARD/.tmp_update
		./bin/themeSwitcher
		exit 1
    	elif [ "$KeyPressed" = "B" ] || [ "$KeyPressed" = "menu" ] ; then
    		./bin/blank
    		./bin/say "Canceling"
    		exit
		elif [ "$KeyPressed" = "select" ]; then    # == if select has been pressed we don't display the text instructions
			if [ "$DisplayInstructions" = "1" ]; then
				DisplayInstructions=0
				./bin/blank
	            ./bin/jpgr "./logos/$foldername/image1.jpg"   # == Displays a rotated preview of the jpeg file
			else
				DisplayInstructions=1
			#	./bin/blank
	            ./bin/jpgr "./logos/$foldername/image1.jpg"   # == Displays a rotated preview of the jpeg file
				./bin/say "Really want to flash ?"$'\n'\("$foldername"\)$'\n\nA = Confirm    B = Cancel\nSelect = Fullscreen'
			fi
   
    	   	   
    	fi
	done
else
	echo "./logos/$foldername/image1.jpg not found"
	./bin/blank
	./bin/say "$foldername/image1.jpg not found"$'\n\nExiting without flash !'
	./bin/confirm any
	exit 1
fi

