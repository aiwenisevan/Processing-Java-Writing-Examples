class Question extends Test {
  Question[] questions;
  float yPos;
  int time = -1;
  boolean stop = false;
  Question(String displayT, int idea, Question[] q, float x, float y) {
    super(displayT, idea, q, x, y); 
    questions = q;
  }
  void update() {
    super.update();
  }
  void position() {
    xPos = width/2;
    yPos = id*50 + 100;
  }
  
  void showOneTest() {
    super.showOneTest();
       
    
  }
    
  
}