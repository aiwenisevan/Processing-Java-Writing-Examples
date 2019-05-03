//Aiwen Cheng
//Final Project
//This is a bear-theme interaction project with different games:
//1. you can move mouse to make an effect of openning and closing eyes on the very beginning page;
//2. in game1, you can press up, right, left, down to control the direction of bears,
// and space to stop the bear's movement. Control the direction to avoid colliding with moving balls. 
//otherwise, your lives will be cut down to 0, then the game is over.
//3. in game 2, you can press mouse and hold it to wave the arms of the bear.
// There are multiple classes, various interactions and event listeners, animations and motions.
//Also, there are improvements on what I have learned and done in former projects, and new thing I have explored by myself as well.
String s;
PImage kuma;
Bear bear;
Animation animation1;
float a;
float b;
boolean play;
boolean restart;
float speed;
float eyeHeight;
boolean instruct;
boolean instruct1;
PShape ins1;
PShape ins2; 
float radius;
Ball[] balls = new Ball[10];
int time;
float sp;
boolean playG1;
boolean playG2;//prepare for the button effect of 2 games
PImage heart;//work as symbol of lives users have in games
float m;
float xPos;
float yPos;
final int bearX = 500;
final int bearY = 10;
final int midPointX = 191;
final int leftPivotX =206;
final int rightPivotX = 700;
final int pivotY = 220;
PImage body;
PImage left;
PImage right;
float leftArmAngle = 0.0;
float rightArmAngle = 0.0;//prepare to do the rotate effect of bear arms
PImage gameOverBear;
//int timer;

void setup() {
  size(1200, 700);
  animation1 = new Animation("kumamonmon_1", 19, 124, 100);//small gif;
  bear = new Bear("bear", 5, xPos, yPos, 10);//background image
  a = 3*width/4;
  b = 3*height/4;
  play = false;
  restart = false;
  speed = random(5,10);
  kuma = loadImage("kum.gif");
  instruct = false;
  instruct1 = false;
  ins1 = createShape(RECT, width/2 - 200, height/2, 405, 320);
  s = "WELCOME TO THE WORLD OF KUMAMON!\n1.Move your mouse vertically to see the\n bear openning or closing eyes!\n2.For Game1, press any direction button\n to run the bear, and control it to avoid\n meeting moving balls by using space\n and direction keys. Lives will be cut \nwhen being close to balls.\n3.For Game2, press mouse and hold it to\ndrag bear's arms! ";
  radius = 20;
  sp = random(2,6);
  for(int i = 0; i <10; i ++) {
    balls[i] = new  Ball(radius, 10, balls,random(radius, width - radius), random(radius, height - radius), sp);
  }
  time = 50;
  playG1 = false;
  smooth();
  frameRate(30);
  body = loadImage("a1.png");
  left = loadImage("a2.png");
  right = loadImage("a3.png");
  heart = loadImage("Heart.png");
  gameOverBear = loadImage("gameover.png");
  //timer = 0;
}
void draw() {
  background(0);
  image(kuma, 0, 0, width, height);
  animation1.display(a, b);
  fill(0);
  eye();//the first interaction on the very first page;
  instruction();//instrcution window that can be openned and closed;
  gameButton(); // contains 2 games and go to their pages respectively;
  //update();
}

void eye() {
  fill(0);
  stroke(0);
  ellipse(395, 190, 170, eyeHeight);
  ellipse(795, 190, 170, eyeHeight);
 
  if (mouseY > 250) {
    eyeHeight = 150;
  }
  if (mouseY < 250) {
    eyeHeight = mouseY - 100;
  }  
}//to create an effect of closing eyes

void instruction() {
  fill(252, 77, 2);
  stroke(249, 227, 233);
  ellipse(220, 415, 100, 100);
  fill(0);
  textSize(20);
  text("HOW\n  TO\n PLAY", 190, 395);
  if(instruct) {
    shape(ins1);
    fill(250);
    rect(width/2 + 185, height/2, 20, 20);
    fill(0);
    textSize(20);
    text("X", width/2 + 190, height/2 + 18);
    //textFont(newFont);
    text(s, width/2 - 200, height/2 + 30);
   
  }//window instructions
  if (mouseX > 170 && mouseX < 270 && mouseY > 365 && mouseY < 465) {
    fill(249, 227, 233);
    ellipse(220, 415, 100, 100);
    fill(0);
    textSize(30);
    text("CLICK", 180, 425);//create the hover effect when mouse is on the button   
    if(mousePressed) {
      instruct = true;
    }
  }
  newWindow();
}

void newWindow() {
  if (instruct1) {
      instruct = false;
    }
    if (mousePressed && mouseX > width/2 + 180 && mouseX < width/2 + 200 && mouseY > height/2 && mouseY < height/2 + 20) {
      instruct1 = true;
    }else if(mousePressed && mouseX > 170 && mouseX < 270 && mouseY > 365 && mouseY < 465) {
      instruct1 = false;
    }
    
}//to make the instruction window able to be closed and openned

void gameButton() {
  fill(252, 77, 2);
  stroke(249, 227, 233);
  ellipse(960, 380, 150, 50);
  ellipse(960, 450, 150, 50);//game button 1 and 2
  fill(0);
  textSize(20);
  text("Play Game 1", 900, 390);
  text("Play Game 2", 900, 460);
   if (mouseX > 885 && mouseX < 1035 && mouseY > 355 && mouseY < 415) {
    fill(250);
    ellipse(960, 380, 150, 50);
    fill(0);
    textSize(30);
    text("CLICK", 920, 390);
    if(mousePressed) {
      playG1 = true;// go to game 1 page
    }
  }
  if (mouseX > 885 && mouseX < 1035 && mouseY > 425 && mouseY < 485) {
    fill(250);
    ellipse(960, 450, 150, 50);
    fill(0);
    textSize(30);
    text("CLICK", 920, 460);
    if(mousePressed) {
      playG2 = true;// go to game2 page
    }
  }
  if(playG1) {
    clear();
    background(249, 227, 233);
    bear.display();
    for(Ball ball: balls) {
      ball.display();
    }
    collide();// all content of game1: how the bear and ball move and how scores to be count
  }
  if(playG2) {
    clear();
    background(249, 227, 233);
    float mX;
    float mY;
    pushMatrix();
    translate(bearX, bearY); // place robot so arms are always on screen
    if (mousePressed)
    {
      mX = mouseX - bearX;
      mY = mouseY - bearY;
      if (mX < midPointX) // left side of robot
      {
        leftArmAngle = atan2(mY - pivotY, mX - leftPivotX)
        - HALF_PI;
      }
      else
      {  
        rightArmAngle = atan2(mY - pivotY, mX - rightPivotX)
        - HALF_PI;
     }
  }
  drawBear();  
  popMatrix();
  fill(250);
  ellipse(600, 350, 100, 50);
  update();
  }
  
}//all content of game 2: create interactive rotation of bear's arms
void collide() {
  //timer = 0;
  //timer = minute();
  textSize(30);
  fill(0);
  text(time, 1000, 50);
  //text(timer, 1100, 50);
  text("press mouse to change some of the balls'direction when you need it!", 100, 650);
  image(heart, 950, 22, 30,30);
  for(int i = 0; i <10; i++) {
   
      if(balls[i].x >= bear.x && balls[i].y >= bear.y && balls[i].y <= bear.y + 100 && balls[i].x <= bear.x + 200) {
        time--;
        delay(100);
      }
    }// to create the condition when scores will be cut down
  if (time <= 0) {
    clear();
    background(249, 227, 233);
    image(gameOverBear, 200, 300);
    textAlign(CENTER);
    textSize(80);
    fill(0);
    text("GAMEOVER!", 770, height/2);
    ellipse(600, 450, 150, 50);//game 1 button
    ellipse(960, 450, 150, 50);//game 2 button;
    fill(250);
    textSize(20);
    text("Play Again", 600, 460);
    text("Play Game 2", 960, 460);
  }//to create an criteria when game is over
}
void mouseReleased() {
  for(int i = 0; i <5; i ++) {
     balls[i] = new  Ball(radius,5, balls, random(radius, width - radius), random(radius, height - radius), random(2,6));
  }
}//to make some of the balls change position by clicking mouse
void playAgain() {
  if(mousePressed && mouseX > 525 && mouseX < 675 && mouseY > 375 && mouseY < 435) {
    playG1 = true;
  }
  
  if(mousePressed && mouseX > 525 && mouseX < 675 && mouseY > 475 && mouseY < 535) {
    playG2 = true;
  }
}
void drawLeftArm()
{
  imageMode(CENTER);
  pushMatrix();
  translate(500, 340);
  rotate(leftArmAngle);
  image(left, 0,0);
  popMatrix();
}

void drawRightArm()
{
  imageMode(CORNERS);
  pushMatrix();
  translate(820, 200);
  rotate(rightArmAngle);
  image(right, 0, 0);
  popMatrix();
}

void drawBear()
{
  //imageMode(CORNERS);
  translate(-600, 0);
  image(body, 500, 10);
  drawLeftArm();
  drawRightArm();
  
}
void update() {
  if (restart) {
    //clear();
    redraw();
  }
  ellipse(600, 350, 100, 50);
  if (mouseX > 550 && mouseX < 650 && mouseY > 325 && mouseY < 375) {
    fill(255);
    ellipse(600, 350, 120, 60);
    fill(0);
    textSize(20);
    text("HOME", 570, 360);
    if(mousePressed) {
      restart = true;
    }
  }
}//back to the very beginning