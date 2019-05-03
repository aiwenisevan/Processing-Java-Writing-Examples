class Wave {
  private float x;
  //wave.get(x);
  // wave.setX(1);
  float y;
  float radius;
  float speed;
  int id;
  Wave[] others;
  float sColor1;
  float sColor2;
  float sColor3;
  
  Wave(float xPos, float yPos, float r, float s, int idea, Wave[] oin) {
    this.x = xPos;
    y = yPos;
    radius = r;
    speed = s;
    id = idea;
    others = oin;
  }// configure a wave(bubble) with x,y position, radius, array features
  
  void move() {  
    if(slow){
       x += radius / 10;
    }
    if (id < 10 && x < 800) {
      slow = true;      
    }    
    else{
     x += radius / 100; //changing its speed when more bubbles reach the alert line
    }
    if (x > width - radius || x < radius) {
      x = radius;
    }   
    if (y > height - radius || y < radius) {
      y = radius;
    }
  }
  // define its movement trajectory: all bubbles are moving horizontally and will start from the very begging if they hit the edge of the scrren
  void alert() {
    if (x > width - 400 && id > 8) {
        fill(250);
        textSize(30);
        text("You Lose!", 900, 350);        
      }  
  }
  // put function to the alert line: when bubbles hits or surpass the alert line, "You Lose" appears.
  void colorChange() {
    sColor1 = random(230, 255);
    sColor2 = random(0, 255);
    sColor3 = random(100, 255);
  }//add color features to bubbles, making it chaging all the time.
  
  void collide(){
     for (int i = 0; i < numWaves; i++) {
      float xDis = others[i].x - mouseX;
      float YDis = others[i].y - mouseY;
      float disBetween = sqrt(xDis*xDis + YDis*YDis); 
      float disMin = others[i].radius + 50;
      if (disBetween < disMin) {
        others[i].radius = 0;
        others[i].x = radius;
      }
    }
  }// add features between bubbles and mouse circles: move mouse to erase all bubbles
  
  void bounce() {
    for (int i = id + 1; i < numWaves; i++) {
      float disX = others[i].x - x;
      float disY = others[i].y - y;
      float distance = sqrt(disX*disX + disY*disY);
      float minDis = others[i].radius + radius;
      if (distance < minDis) {
        radius = 0;
      }
    }
  }// add features between bubbles themselves: when one hits another, both of them will shirink back to a dot instantly
  
 
  
  void update() { 
    radius += speed;//the bubble is extending while moving
    if (radius > 100) {
      radius = 0;
    }// give a ceiling of the extent that the bubble is going to extend
    fill(0);
    ellipse(x, y, 2 * radius, 2 * radius);//define the shape
    stroke(sColor1, sColor2, sColor3);
  }
}