class Answer extends Test {
  Answer[] answers;
  float yPos;
  boolean stop;
  int time = -1;
  Answer(String displayT, int idea, Answer[] an, float x, float y) {
    super(displayT, idea, an, x, y); 
    answers = an;
  }
  void update() {
    super.update();
    xPos = width/2;
    yPos = id*50 + 100;;
  }
  void showOneTest() {
    if (stop) {
      clear();
      textSize(30);
      fill(250);
      answers[time].xPos = width/2;
      answers[time].yPos = height/2 + 50;
      text(answers[time].displayText, answers[time].xPos, answers[time].yPos);
     }
     if (keyPressed && key == ENTER) {
       //println("Method used" + 'x' +questions[time].xPos + 'y' +questions[time].yPos);
        time++; 
        
        if (time > 9) {
          clear();
        }
        
        stop = true;
        delay(1000);
        
       
    }
  }
 
}