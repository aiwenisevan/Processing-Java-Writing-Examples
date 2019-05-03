//Evan Cheng 
//Project 3 : Trivia Game;
// wacth 4 animated gifs and answer questions. 
/* summary:   It’s a game requiring users to answer question (choosing A or B) based on the content of   
             four animated gifs(20 seconds to watch). Before watching those gifs, users have 10 
             seconds to view all the questions so that they know what will be looked at when watching 
             animations. So this game requires flexible reaction and good memory. When answering 
             Questions, each question will be displayed on the screen one by one. If your answer is 
             right, your score will be added 1 credits, and the little Rick(the cartoon) at the bottom of 
             page will move ahead. When you finish answering questions, you will get your final scores
*/
//requirement: 1. 10 questions; 2. Questions and answers are from XML file
//3.cartoon moves with each question if you get the scores.
//4. Has a super class Test and 2 sub classes: questions and answers, and 1 independent class: animation
//5.it keeps track of the socre;
//6.it has way to start the game;
import ddf.minim.*;//library to play sound file
Minim soundEngine1;
Minim soundEngine2;
AudioPlayer soundStat1;
AudioPlayer soundStat2;
//import gifAnimation.*;// fail to use this library 

Question[] questions;
Answer[] answers;
Test[] tests;
PImage img;
PImage instruct;
PImage walk;
int m;
int n;
int p;
int q;
String ins;
boolean a = false;
boolean b = false;
XML xml;
String displayQuestion;
int id;
int time;
int timer;
int t;
//PImage gif1;
String displayAnswer;
float yPos;
String displayTest;
String printInput = "";
String[] letters;
String[] rightanswers = new String[10];
Animation animation1;
Animation animation2;
Animation animation3;
Animation animation4;
float x;
int score = 0;
boolean checka = false;
boolean press = false;
boolean restart = false;
void setup() {
  size(1067, 600);
  surface.setResizable(true);
  img = loadImage("randm.png");
  instruct = loadImage("instructions.png");
  walk = loadImage("walk.png");
  textAlign(CENTER);
  textSize(30);
  soundEngine1 = new Minim(this);
  soundStat1 = soundEngine1.loadFile("begin.wav");// use library to load and play sound file
  soundStat1.play();
  soundEngine2 = new Minim(this);
  soundStat2 = soundEngine1.loadFile("goodjob.wav");// use library to load and play sound file
  m = width / 10;
  n = width / 30;
  p = width/2 - 40;
  q = 4*height/5;
  ins = "For this game, you will select the right answer \n for each question(10 in total).  To begin with, \n you will see all the questions at once, after\n that you will see four GIFs, and find your \n answers in GIFs";
  textAlign(CENTER);
  textSize(30);
  loadData();
  //gif1 = loadImage("dancing.gif", "gif");// where I failed loading gif, I have followed the PImage instruction, but it dosen't work 
  
  //frameRate(24);  
  animation1 = new Animation("elevator_1", 20);
  animation2 = new Animation("dancing_1", 84);
  animation3 = new Animation("flypink_1", 50);
  animation4 = new Animation("setitfree_1", 32);//load each frame of gif to play the whole animation
  loadAnswerData();
  t = -1;
 
}
void draw() {
  image(img, 0, 0, width, height);//background image
  image(instruct, width/2 - 40, 4*height/5, m, n);//instructions image, ready to be used as a button
  showIns();
  if(a) {
    clear();
    fill(250);
    text(ins, width/2, height/3);
    rect(width/2 - 40, height-50, 80, 30);
    textSize(25);
    fill(0);
    text("Go!", width/2, height - 25);
  }//use boolean to create a button: clicking and display instructions
  showQ();
  if(b) {
    clear();
    for (Question question : this.questions) {
      question.update();   
      question.position();
    }// use boolean to create a button: clicking and displaying questions 
    textSize(20);
    fill(255);
    text("You have 10 seconds to view all questions", width/2, height -10);
    if(millis() - time >= 10000) {
      clear();// a timer to coundtdown 10 seconds to view questions and then goes to gif page;
      //image(gif1, 0, 0);
      animation1.display(0, 0);
      animation2.display(width/2,0);
      animation3.display(0, height/2);
      animation4.display(width/2, height/2);
      textSize(30);
      fill(250);
      text("You have 20 seconds to view these gifs!", width/2, height - 10);
      countDown();// a timer to count down 20 seconds to view gif and the go to Q&A page
      }
 
  }
  
}
void showIns() {
  if(mousePressed && mouseX > m && mouseX < p + m && mouseY > q && mouseY < q + n) {
    a = true;
    
  } //else if (mousePressed && mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height/2 && mouseY < height/2 + 60){a = false;}
}// the condition when instructions should be shown
void showQ() {
  if(mousePressed && mouseX > p && mouseX < p+80 && mouseY > height - 50 && mouseY < height - 20) {
    b = true;
  }
}// the condition when questions should be shown
void loadAnswerData(){
  rightanswers[0] = "B";
  rightanswers[1] = "A";
  rightanswers[2] = "A";
  rightanswers[3] = "B";
  rightanswers[4] = "B";
  rightanswers[5] = "A";
  rightanswers[6] = "B";
  rightanswers[7] = "B";
  rightanswers[8] = "B";
  rightanswers[9] = "A";
}// load an array of right answers
void loadData() {
  xml = loadXML("dat.xml");
  XML[] children = xml.getChildren("test"); 
  tests = new Test[children.length];
  this.questions = new Question[children.length];
  this.answers = new Answer[children.length];
  for (int i = 0; i < children.length; i++) {
    XML questionElement = children[i].getChild("question");
    displayQuestion = questionElement.getContent();
    XML answerElement = children[i].getChild("answer");
    displayAnswer = answerElement.getContent();
    id = children[i].getInt("id");
    float ypp;
    ypp = id*50 + 100;
    displayTest = displayQuestion + "\n" + displayAnswer + "";
    this.questions[i] = new Question (displayQuestion, id, questions, width/2, ypp);
    this.answers[i] = new Answer (displayAnswer, id, answers, width/2, ypp);
    tests[i] = new Test(displayTest, id, tests, width/2, height/2);
    //load questions and answers from external files
    
  }
}

void keyPressed() {
    if (key == CODED) {
      switch(keyCode){
      case LEFT:
        if(printInput.length() > 0){
          printInput = printInput.substring(0, printInput.length() - 1);
        }
        break;
      default:
        break;
      case ENTER:
        clear();
    }// define keys when printing answers
    
    
    } else if (key != ENTER){
    printInput = printInput + key;
    }
  }//enable what has been pressed to be displayed on the screen
  
void checkAnswer() {
  if (checka) {
   
  }
  if (keyPressed && key == 32){
    printInput =printInput.toUpperCase();
    letters = split(printInput, " ");  
    t++;
    //println("wenwen sha 1" + rightanswers[t]);
    //println("wenwen sha 2" + letters[t]);
    loadAnswerData();
    //println(letters[time].equals(rightanswers[time]));
    if(rightanswers[t].equals(letters[t]) == true) { 
      if(t>10) {
      stop();}
      //checka = true;
      score++;
      delay(500);
    } else if (rightanswers[t].equals(letters[t]) == false) {
    score--; 
  delay(500);
}
  }
  // to make print answers match the right answers, and make scores changeing with them
}
    

void countDown() {
   if(millis() - timer >= 30000) {//the int should be 30000 instead of 12000, but for testing convinience, I made it 12000, so you don't need to wait for 20 seconds.
     clear();
     tests[0].showOneTest();
     text(printInput, width/2, height/2 + 100);
     text("1.Press ENTER to view your test one by one!", width/2, 50);
     text("2.Press 'A' or 'a' or 'B' or 'b' to choose your answer!", width/2, 100);
     text("3.Press space to check your answer!", width/2, 150);
     checkAnswer();
     textSize(28);
     fill(250);    
     text(score, width/2, height/30);
     textSize(30);
     fill(0);
     text("finish!", width - 100, height - 40);
     fill(255);
     rect(width-150, height - 80, 90, 50);
     textSize(25);
     fill(0);
     text("finish!", width - 100, height - 40);
     translate(score * width / 11, 0);
     image(walk, 0, height - 222, 200, 221 );
     lastScene();
   }//instructions for how to answer questions by pressing keys. 
}
void lastScene() {
  if(press) {
    clear();
    translate(- score * width / 11, 0);
    fill(250);
    rect(width/2 - 100, height / 2, 200, 60);
    textSize(30);
    text("your score:" + score, width / 2, 100);
    textSize(35);
    fill(0);
    text("Replay", width / 2, height/2 + 40);
    soundStat2.play();
    mouseReleased();
  }
  if(mousePressed && mouseX > width - 150 && mouseX < width - 60 && mouseY > height - 80 && mouseY < height - 30) {
    press = true;
  }
}//press button to go to the last page

void mouseReleased() {
  if (restart) {
    //clear();
    redraw();
    //showIns();
    
  }
  if(mousePressed && mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height / 2 && mouseY < height/2 + 60) {
    restart = true;
    
  }
}//restart function