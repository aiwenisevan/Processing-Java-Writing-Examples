class Bear{
   PImage[] images;
   int number;
   String prename;
   float x;
   float y;
   int id;
   float speed;
   Bear(String pre, int num, float xPos, float yPos, float s) {
     prename = pre;
     number = num;
     x = xPos;
     y = yPos;
     speed = s;
     images = new PImage[num];
     for (int i = 0; i < num; i++) {
      // Use nf() to number format 'i' into four digits
       String filename = prename + nf(i,1) +".png";
       //println(num);
       images[i] = loadImage(filename);
       //println(filename);
     }
  
   }
   void display() {
     //println(x, y);
     //println(number);
     image(images[id], x, y, 200, 200);
     if (keyPressed && key == CODED) {
       switch(keyCode) {
         case LEFT:
           id = 1;
           x -= speed;
           if (x < - 200) {
             x = width;
           }
           break;
         case DOWN:
           id = 2;
           y += speed;
           if(y > height) {
             y = -200;
           }
           break;
          case RIGHT:
            id = 3;
            x += speed;
            if (x > width) {
              x = -200;
            }
            break;
          case UP:
            id = 4;
            y -= speed;      
            if (y < -200) {
              y = height;
              
            }
       }
     }else {id
   = 0;}
   }
   //show different image when at different direction
}