pt C,E,H;
pt E1,H1;
float HandLength = 150.0;

void drawBody() {

  
  pt Hip = new pt(600, 500);
  C = new pt(600, 250);
  fill(red); pen(red,3);
  E1 = P(P(C, d(C,H1)/2, U(V(C,H1))), sqrt(pow(150,2)-pow(d(C,H1)/2,2)), R(U(V(H1,C))));
  caplet(C,40,E1,30);
  caplet(E1,30,H1,20);
  fill(blue); pen(blue, 2);
  float rH = 70;
  float rC = 100;
  caplet(C, rC, Hip, rH);
  //nect,head
  pt N = new pt(C.x, C.y-180);
  pt Head = new pt(N.x, N.y);
  show(Head,70);
  float _rN = 30;
  caplet(N, _rN, C, _rN);
  
  E = P(P(C, d(C,H)/2, U(V(C,H))), sqrt(pow(150,2)-pow(d(C,H)/2,2)), R(U(V(H,C))));

  fill(green); pen(green,3);
  caplet(C,40,E,30);
  caplet(E,30,H,20);
  
  
  
}


void checkHands() {
  if (alert3On) {
    if (alert3.getPosition() >= alert3.getSample().getLength()) {
        alert3.reTrigger();
      }
  } else if (H.y > 500) {
    if (alert3On == false) {
      g.setGain(1);
      alert3.reTrigger();
      alert3On = true;
    }
  } else if (H.y >400) {
    g.setGain((H.y-400)/100);
    if (alert1On == false) {
      alert1On = true;
      alert1.reTrigger();
    } else {
      if (alert1.getPosition() >= alert1.getSample().getLength()) {
      alert1.reTrigger();
      }
    } 
  } else {
    alert1On = false;
    alert1.pause(true);
  }
  pen(red, 3);
  line(0, 500, 1200, 500);
  pen(green, 3);
  line(0, 400, 1200, 400);
}