class Ball{
  float x;
  float y;
  float radius;
  int num;
  Ball[] balls; 
  float speed;
  Ball(float r, int n, Ball[] bs, float xPos, float yPos, float s) {
    radius = r;
    num = n;
    balls = bs;
    x = xPos;
    y = yPos;
    speed = s; 
    
  }
  void display() {
    fill(0);
    ellipse(x, y, 2*radius, 2*radius);
    x += speed;
    y += speed;
    if (x > width) {
      x = 0;
    }
    if (y > height) {
      y = 0;
    }    
  }
}//make balls moving on the screen