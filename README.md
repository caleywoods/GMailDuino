GMailDuino
==========

##This currently a work in progress.##

It isn't currently fully functional and a few files needed to run it are
not yet in this repo.

You need to set gmail.rb to be executed on a schedule. If you aren't sure how to do that check the instructions
below. Your arduino will also need to remain connected to your computer via the USB cable, I have not written
this to be compatible with an ethernet shield arduino.

###OSX###
You can use launchd for this. Follow the steps below.

*  You will need to create a .plist file and save it to~/Library/LaunchAgents. If LaunchAgents doesn't exist 
you'll need to create it. I've included a sample .plist file you can modify.

*  Once you've saved the .plist file you need to do the following command in terminal:
    launchctl load ~/Libary/LaunchAgents/org.caleywoods.gmailduino.plist

*  If you're uncomfortable with the above command you can also restart your computer to
get the file loaded.

###Linux###
Follow the steps below.

*  Setup the gmail.rb file to be executed on your set schedule with cron. In a terminal you can type
    crontab -e

*  Create a job such as:
    0 * * * * USERNAME /path/to/gmail.rb

The above job sets gmail.rb to be executed every minute by the specified username.

###Windows###
#####Abandon all hope ye who enter here.######

Windows has scheduled tasks via control panel or through the AT command.

Creating something to run every minute is stupid on windows because it's harder than it should be.

*  In a command prompt type the following:
    at 00:00 path\to\file

*  This should create a scheduled task to run at midnight and execute your file, this is intential we're going
to have to modify it in the gui.

*  Find the task scheduler on your machine and you should be able to locate your newly created task. Mine was
called At1 but yours might end in a different number (it's the id of the task).

*  Right click the task and click "Properties" then go to the Triggers tab. Highlight the "One Time" trigger and
click "Edit...."

*  Change it from "One Time" to "Daily" and to Recur every: 1 days.

*  Under the advanced settings section check the box "Repeat task every:" and then select 5 minutes from the
dropdown and then select "Indefinitely" from the "for a duration of:" drop down list.

*  You can then click Ok and close out of the GUI, your script should now be set to execute every 5 minutes every
single day.
