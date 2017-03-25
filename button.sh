#!/bin/sh
# Time-lapse capture script
# Swayam 25-03-2017
###############################

 # Define the wiringPi gpio pin (16) to be used by the button...
 
 button=16

 setup ()
 {
   echo Setup
   gpio mode $button in
 }
  
 # Set a function to check for a button press...
 # Wait for the button to be pressed. Because we have the GPIO
 # pin pulled high, we wait for it to go low to indicate a push.
 
 waitButton ()
 {
   echo "Press the button to take a photo or [CTRL+C] to quit... "
   while [ `gpio read $button` = 1 ]; do
     sleep 0.5
   done
 }
 
 beginCapture ()
 {

   # Generate the date to add to the filename...
   today=$(date +"%d-%m-%Y-%H-%M")

   # use fswebcam to take a photo.  You may need to fiddle with the settings, 
   # especially the resolution, to match your webcam details...
   fswebcam -r 1280x720 -S 15 --jpeg 99 -p MJPEG --shadow --title "ENTER TITLE HERE" --subtitle "ENTER SUBTITLE HERE" --info "Author: SM_RPi" --save photo_"$today".jpg -q
   echo "Your photo has been taken..."
 }

 setup
 while true;
 do
   waitButton
   beginCapture
 done
