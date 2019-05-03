class Animation{
  PImage[] images;
  int imageCount;
  int frame;
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i,2) +".gif";
      images[i] = loadImage(filename);
    }
  }// to simplifie the processing of uploading hundreds of gif images.

  void display(float xpos, float ypos) {
    frameRate(24); 
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
     
  }
  
 
}