Class Exercise #7
Name: Gabriel Galarza, Klaus Zeng, Luka Antolic-Soban


For this class exercise, our team looked to simulate possible sounds that can be integrated into a hospital room that need to be kept sterile. 
From our interviews of nurses who were in surgery rooms, it was suggested that soft tones would be easy to take in for small reminders in an environment, but for the case of a higher priority notification we should implement more frequent beeps or beeps that increase in volume. Because of this, we took two base beeping sequences from free sound and edited them to accommodate for the different circumstances.
In this assignment, we simulate three different ambient sounds based on the safety distance of wearer to others. The more frequent beeps or higher volume, the closer you are to others(Range1 > 6ft, range2 >3ft < 6ft, range3 <3ft). To distinguish the our warnings from the background, we designed our sounds(the beep combo or alert) to have a shorter cycle than that of the background(currently denoted by the heart rate sound). There are three different type of alerts in our implementation. The first type of alert is to keep track of doctors’ hands in the sterilized zone. If hands approach the danger zone, he or she will be alerted. The second type of alert is to avoid collision in the room. Sometimes, doctors or nurses in the room focus on their tasks and may not realized potential collision if they continue to walk the same direction. We calculate everyone current velocity in the room and alert them if potential collision would occur in the next three seconds. The last alert is a emergency evacuation warning. This alert denotes that one of more persons in the room have been contaminated and all personals need to be re-sterialized immediately before continue on the surgery. 
These sounds are not our final versions. Gabriel and Luka will conduct a few more interviews with hospital staff in order to have a better understandings if our sounds fit their needs. We want our wearable devices to help the medical team, but not lower their performance. 

Below are the audios

alert base
http://www.freesound.org/people/Freezeman/sounds/153213/

ambient base
http://www.freesound.org/people/pan14/sounds/263133/

heart rate
https://www.youtube.com/watch?v=QXCyzPMEoXM&list=PL4KNBxVV1fBl3mRpEdWQfgdet-axYWBQB&index=2

medalist 
http://www.freesound.org/people/Freezeman/sounds/153205/

Technique for implementing sketch:


