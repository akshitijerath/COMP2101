#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

# Get the current hostname using the hostname command and save it in a variable

# Tell the user what the current hostname is in a human friendly way

# Ask for the user's student number using the read command

# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user

# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts

# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname
hname=$(hostname) #to check the hostname  of the system and store it in a variable named hname
echo -e 'Cureent Hostname is:' $hname '\n'  #this command will help in displaying the hostname of the system and -e is used in order to \n command rahter than using another echo command for next line
echo 'Please enter your studentnumber: ' # command to display  in order to enter the student number
read studentnumber # read is used to read the inpput given by user. 
update=pc$studentnumber #another variable  in  order to store the new hostname of the system
echo -e '\nYour new hostname has been changed to: ' $update  # printing the newhostname of the system.
sudo sed -i "s/$hname/$update/" /etc/hosts &&  echo -e '\n''Hostname has been changed by chaning file /etc/hosts'' \n' # changing the old hostname with a new hostname using sed command and changing that in /etc/hosts
if [[ $hostname!=$update ]]; then  # using a loop and comparing hostname with the variable  if the values are not equal 
hostnamectl set-hostname $update && echo -e 'Reboot required in order to make the changes happen''\n'  # chaning hostnmae using  hostnamectl command and printing that system requires reboot
fi
echo 'Thanks for choosing automated system of updating hostname' # last message printing
