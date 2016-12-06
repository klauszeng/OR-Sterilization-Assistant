void showObjects() {
  for (pts shape:objects) {
    noFill();
    shape.drawCurve();
    shape.drawVertices(red);
  }
}

void showHuman() {
  for (pt man: human) {
    noFill();
    show(man, 30);
    scribe("doctor", man.x, man.y);
  }
}

void checkCloseTo(pt point) {
  float dist = 1000;
  for (pts shape:objects) {
    for (int i = 0; i < shape.nv; i++) {
      if (d(shape.G[i], point) < dist) {
        dist = d(shape.G[i], point);
        if (dist<50){
          pen(red, 3); 
          line(shape.G[i].x, shape.G[i].y, point.x, point.y);
          pen(black, 1);
        }
      }
   }
  }
   //println(dist);
  if (dist < 50) {
    float volume = volumeFunction(dist);
    g.setGain(volume);
    
    if (alert1On == false) {
      alert1On = true;
      alert1.reTrigger();
    } else {
      if (alert1.getPosition() >= alert1.getSample().getLength()) {
      alert1.reTrigger();
      }
    } 
   } else {
   alert1.pause(true);
   alert1On = false;
   }
   
  
  
  dist = 1000;
  for (pt man:human) {
    if (point == man) {
      continue;
    }
    if (d(man, point) < dist) {
      dist = d(man, point);
    }
  }
  
  if (dist < 50) {
    float volume = volumeFunction(dist);
    g.setGain(volume);
    
    if (alert2On == false) {
      alert2On = true;
      alert2.reTrigger();
    } else {
      if (alert2.getPosition() >= alert2.getSample().getLength()) {
        alert2.reTrigger();
      }
    } 
   } else {
     alert2.pause(true);
     alert2On = false;
   }
   //println(dist);
}

float volumeFunction(float num) {
  return (1/150)*pow(num,2)-4*num/150 + 1.5;
}


void caplet(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  show(A,rA);
  show(B,rB);
  // replace the line blow by your code to draw the proper caplet (cone) that the function displays th ecnvex hull of the two disks
  pt n1,n2,n3,n4;
  if (rA > rB) { 
    vec AB = V(A,B);
    float len = n(AB);
    float angle = toRad(90 - 90/len*(rA-rB));
    n1 = P(A, W(rA, R(U(AB),angle)));
    n2 = P(A, W(rA, R(U(AB),-angle)));
    n3 = P(B, W(rB, R(U(AB),-angle)));
    n4 = P(B, W(rB, R(U(AB),angle)));
  } else if (rA < rB){ // inside circle A
    vec BA = V(B,A);
    float len = n(BA);
    float angle = toRad(90 - 90/len*(rB-rA));
    n1 = P(A, W(rA, R(U(BA),angle)));
    n2 = P(A, W(rA, R(U(BA),-angle)));
    n3 = P(B, W(rB, R(U(BA),-angle)));
    n4 = P(B, W(rB, R(U(BA),angle)));
  } else {
    vec AB = U(V(A,B));
    n1 = P(A, W(rA, R(AB)));
    n2 = P(A, M(W(rA, R(AB))));
    n3 = P(B, M(W(rB, R(AB))));
    n4 = P(B, W(rB, R(AB)));
  }
  
  
  beginShape(); v(n1); v(n2); v(n3); v(n4); endShape(CLOSE);
}


void drawHead(){
  show(soundSource, 10);
  scribe("Sound Origin", soundSource.x, soundSource.y-10);
  
  fill(blue);
  show(P(600,300), 60);
  
 
  // left 
  fill(red);
  pen(red, 1);
  show(P(540, 300), 10);
 
  
  pen(black, 1);
  arrow(soundSource, P(540, 300));
  scribe("left ear", 500, 280);
  delay(P(540,300), 1);
  volume(P(540, 300), 1);
  
  //right
  fill(green);
  pen(green, 1);
  show(P(660, 300), 10);
  pen(black, 1);
  arrow(soundSource, P(660, 300));
  scribe("right ear", 660, 280);
  volume(P(660, 300), 2);
  delay(P(660, 300), 2);
  //pen(black,2);
  //scribe();
  
}

void volume(pt point, int a) {
  float dist = d(point, soundSource);
  float intensity = 1/(4*3.14*dist);
  pen(black, 2);
  if (a == 1){ scribe("volume:"+str(intensity), point.x-80, point.y+90);}
  else { scribe("volume:"+str(intensity), point.x, point.y+90);}
}

void delay(pt point, int a) {
  float dist = d(point, soundSource);
  pen(black, 2);
  if (a == 1) {
    scribe("Distance:"+str(dist), point.x-80, point.y+70);
    scribe("Time:"+str(dist/331.0), point.x-80, point.y+80);
  } else {
    scribe("Distance:"+str(dist), point.x, point.y+70);
    scribe("Time:"+str(dist/331.0), point.x, point.y+80);
  }
}