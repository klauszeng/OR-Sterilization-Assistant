// PROJECT
// Author: Hongrui Zheng, Jianming Zeng
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!
import beads.*;
import org.jaudiolibs.beads.*;
import javax.swing.*;
import controlP5.*;
import java.util.ArrayList;


//**************************** global variables ****************************
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean lerp=true, slerp=true, spiral=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
pt soundSource;

// Objects
pts P = new pts(); // class containing array of points, used to standardize GUI
pts P1 = new pts();
pts P2 = new pts(); 
pts P3 = new pts();
pts P4 = new pts();
pts P5 = new pts();
// person 
pt surgeon;
pt assistant;

// audio global vars
SamplePlayer heartBeat;
SamplePlayer alert1;
SamplePlayer alert2;
SamplePlayer alert3;
Gain g; 
Gain g1;
double len;
float volume,volume1,volume2;
boolean alert1On = false;
boolean alert2On = false;
boolean alert3On = false;

ArrayList<pts> objects = new ArrayList<pts>();
ArrayList<pt> human = new ArrayList<pt>();


//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(1200, 600);            // window size
  frameRate(60);             // render 30 frames per second
  smooth();                  // turn on antialiasing

  P.declare(); P1.declare(); P2.declare(); P3.declare(); P4.declare(); P5.declare();// declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  P.loadPts("data/surgery bed"); P1.loadPts("data/video monitor"); P2.loadPts("data/video monitor2");
  P3.loadPts("data/video monitor3"); P4.loadPts("data/video monitor3 access");
  P5.loadPts("data/suction");// loads points form file saved with this program
  objects.add(P); objects.add(P1); objects.add(P2); objects.add(P3); objects.add(P4); objects.add(P5);
  soundSource = P(300, 200);
  
  //surgeon 
  surgeon = new pt(732.0,290.0);
  assistant = new pt(768.0,389.0);
  human.add(surgeon); human.add(assistant);
  H = new pt(350, 300);
  H1 = new pt(400, 300);
  
  //Audio
  
  ac = new AudioContext();
  heartBeat = getSamplePlayer("heart rate.mp3");
  len = heartBeat.getSample().getLength();
  alert1 = getSamplePlayer("text.mp3");
  alert2 = getSamplePlayer("twobeeps.wav");
  alert3 = getSamplePlayer("medalert.mp3");
  alert1.pause(true);
  alert2.pause(true);
  alert3.pause(true);
  
  g = new Gain(ac, 1, 1);
  g.addInput(alert1);
  g.addInput(alert2);
  g.addInput(alert3);
  ac.out.addInput(heartBeat);
  ac.out.addInput(g);
  ac.start();
  
  } // end of setup
  //done

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  background(white);
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  if (heartBeat.getPosition() >= len) {
     heartBeat.reTrigger();
  } 
  
  // OR simulation
  //showObjects();
  //showHuman();
  //checkCloseTo(surgeon);
  
  //// Body simulation
  //drawBody();
  //checkHands();
  
  //Sounds Mechanic Simulation 
  drawHead();
  
  
  
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens

// draw arrow
}  // end of draw
  