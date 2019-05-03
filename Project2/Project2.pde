// Aiwen Cheng/Evan
// Project 2: Interactive Toy;
// BUBBLE GAME
/*summary: Those bubble keeps extending from a point while moving horizontally , when one hits the other, each of them 
will shrink to a dot again. All those moving and changing bubbles will be erased if they meet mouse. So when one
bubble approaches the line on the screen, you need to use your mouse to erase bubble, otherwise, there will be an
alert: "You lose!" Press "A" to start, and press mouse to update a different set of animation, press any keys except
"A" end the animation */
/*Requirement: The animation dispalys all the time(of course longer than 1min). Also, keys "A" starts the interacticve toy, 
any keys except "A" pauses or ends the game. If you want to reset the animation, you could press the mouse. There are also 
a Pshape: li---- the line on the screen*/

int numWaves = 30;
float radius = random (10,100);
Wave[] waves = new Wave[numWaves];
String s;
String f;
PShape li;
boolean start = false;
boolean slow = false;// declare all variables

void setup() {
  size(1200, 700);
  frameRate(20);
  mouseReleased(); 
  s = "Click \n   to \nchange";
  f = "Press A \n to start";
  li = createShape(LINE, width - 400, 0, width - 400, height);
  li.setStroke(color(255));// create the alert line
}

void draw() {
  background(0);
  stroke(255);
  fill(255);
  ellipse(mouseX, mouseY, 100, 100);//create the mouse cirle to erase bubbles
  textSize(25);
  fill(250);
  text("Press any key except A to reset!", 10, height - 30);// create instructions to play
  shape(li);
  if (start) {
    for (Wave wave : waves) {
    wave.colorChange();
    wave.collide();
    wave.bounce();
    //wave.boundary();
    wave.update();
    wave.move();
    wave.alert();
    }   
    textSize(20);
    fill(0);
    text(s, mouseX - 32, mouseY - 22);  
  }  
  else {
   textSize(20);
    fill(0);
    text(f, mouseX - 35, mouseY - 10);   
  }   
}//add content in start: when start is true, displaying differnt texts and start the game

void keyPressed() {
 if(key == 'A'){
  start = true;
 }
 else {start = false;}
}// add event to key "A": when A is pressed, the game starts, also add event to any keys beside 'A': press to pause or end the game

  

void mouseReleased() {
  for (int i = 0; i < numWaves; i++ ) {
    waves[i] = new  Wave(random(radius, width - radius), random(radius, height - radius), radius, random(0.5, 2.0), i, waves);
      
  }
  redraw();
}//add event to mouse function, when mouse is clicked The animation will be updated
// also this is the code that makes my animation needs to be clicked before pressing A to start the game.(question solved)