import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;


// boolean control
boolean release = true;
boolean playing = false;

// Button
ControlP5 cp5;
Button ambient1;  
Button ambient2;
Button ambient3;
Button alert1;
Button alert2;
Button alert3;
PFont pfont;
ControlFont font;

// SamplePlayer
SamplePlayer ambient;
SamplePlayer ambientSound1;
SamplePlayer ambientSound2;
SamplePlayer ambientSound3;
SamplePlayer alertSound1;
SamplePlayer alertSound2;
SamplePlayer alertSound3;
SamplePlayer current;
double len;
double currentLen;
//Gain g;
//Glide currentRate;
//SamplePlayer.LoopType loopBackward = SamplePlayer.LoopType.valueOf("NO_LOOP_BACKWARDS");
//SamplePlayer.LoopType loopForward = SamplePlayer.LoopType.valueOf("NO_LOOP_FORWARDS");
void setup() {
  size(480, 360);
  background(255);
  cp5 = new ControlP5(this);
  //PFont pfont = createFont("TimesNewRoman",20,true); // use true/false for smooth/no-smooth
  //ControlFont font = new ControlFont(pfont,10);
  
  //Buttons 
  ambient1 = cp5.addButton("ambient1")
    .setPosition(0, 0)
    .setSize(100, 120)
    .setLabel("Distance-Safe")
    ;  
  
  ambient2 = cp5.addButton("ambient2")
    .setPosition(0, 120)
    .setSize(100, 120)
    .setLabel("Distance-Caution")
    ;
    
  ambient3 = cp5.addButton("ambient3")
    .setPosition(0, 240)
    .setSize(100, 120)
    .setLabel("Distance-Alert")
    ;
    
  alert1 = cp5.addButton("alert1")
    .setPosition(380,0)
    .setSize(100, 120)
    .setLabel("Warning-Hands below safety zone ")
    ;
    
  alert2 = cp5.addButton("alert2")
    .setPosition(380, 120)
    .setSize(100, 120)
    .setLabel("Warning-Potential collision")
    ;
  
  alert3 = cp5.addButton("alert3")
    .setPosition(380, 240)
    .setSize(100, 120)
    .setLabel("Warning-Resterialized immediatly ")
    ;
    
  //Load sounds
  ac = new AudioContext();
  ambient = getSamplePlayer("heart rate.mp3");
  ambientSound1 = getSamplePlayer("twobeeps.wav");
  ambientSound2 = getSamplePlayer("fourbeeps.wav");
  ambientSound3 = getSamplePlayer("majoralert.wav");
  alertSound1 = getSamplePlayer("lowalert.wav");
  alertSound2 = getSamplePlayer("highalert.wav");
  alertSound3 = getSamplePlayer("medalert.wav");
  len = ambient.getSample().getLength();
  current = ambientSound1;
  currentLen = ambientSound1.getSample().getLength();
  ambientSound2.pause(true);
  ambientSound3.pause(true);
  alertSound1.pause(true);
  alertSound2.pause(true);
  alertSound3.pause(true);
  //g = new Gain(ac, 1, 1);
  //g.addInput(ambient);
  ac.out.addInput(ambient);
  ac.out.addInput(ambientSound1);
  ac.out.addInput(ambientSound2);
  ac.out.addInput(ambientSound3);
  ac.out.addInput(alertSound1);
  ac.out.addInput(alertSound2);
  ac.out.addInput(alertSound3);
  ac.start();
    
  
}

void draw() {
   if (ambient.getPosition() >= len) {
     ambient.reTrigger();
   } 
   
   if (current.getPosition() >= currentLen) {
     current.reTrigger();
   }
   
   if (ambient1.isPressed() && release) {
     release = false;
     current = ambientSound1;
     currentLen = ambientSound1.getSample().getLength();
     current.reTrigger();
   } else if (ambient2.isPressed() && release) {
     release = false;
     current = ambientSound2;
     currentLen = ambientSound2.getSample().getLength(); 
     current.reTrigger();
   } else if (ambient3.isPressed() && release) {
     release = false;
     current = ambientSound3;
     currentLen = ambientSound3.getSample().getLength();
     current.reTrigger();
   }
   
  if (alert1.isPressed() && release) {
    release = false;
    alertSound1.reTrigger();
  } else if (alert2.isPressed() && release) {
    release = false;
    alertSound2.reTrigger();
  } else if (alert3.isPressed() && release) {
    release = false;
    alertSound3.reTrigger();
  }
  
}


void mousePressed() {
  
}

void mouseReleased() {
  release = true;
}