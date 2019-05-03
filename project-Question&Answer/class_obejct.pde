class Test {
  String displayText;
  float xPos;
  float yPos;
  int id;
  Test[] tests;
  boolean stop;
  int time = -1;
  Test(String displayT, int idea, Test[] t, float x, float y) {
    displayText = displayT;
    id = idea;
    tests = t;
    xPos= x;
    yPos = y;
  }
  void update() {
    textSize(30);
    fill(250);
    text(displayText, xPos, yPos);
   
  }
  void showOneTest() {
    if (stop) {
      clear();
      textSize(30);
      fill(250);
      tests[time].xPos = width/2;
      tests[time].yPos = height/2;
      text(tests[time].displayText, tests[time].xPos, tests[time].yPos);
     }
     if (keyPressed && key == ENTER) {
       //println("Method used" + 'x' +questions[time].xPos + 'y' +questions[time].yPos);
        time++; 
        
        if (time > 10) {
         time = 9;
        }
        
        stop = true;
        delay(1000);
  //addlistener to make the test appear by clicking ENTER      
       
    }
  }
}