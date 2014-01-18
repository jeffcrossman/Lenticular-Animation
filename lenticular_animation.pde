// This is a template for creating a looping animation in Processing. 
// When you press a key, this program will export a series of images
// into an "output" directory located in its sketch folder. 
// These can then be combined into an animated GIF. 
// Prof. Golan Levin, January 2014 - CMU IACD
// Author: Jeff Crossman
 
//===================================================
// Global variables. 
 
int     nFramesInLoop = 30; // for lenticular export, change this to 10!
int     nScreenResolution = 500; // n X n pixels
int     nElapsedFrames;
boolean bRecording; 
 
String  myName = "jeffcrossman";
 
//===================================================
void setup() {
  size (nScreenResolution, nScreenResolution); 
  bRecording = false;
  nElapsedFrames = 0;
  frameRate (nFramesInLoop); 
  rectMode(CENTER);
}
//===================================================
void keyPressed() { 
  // Press a key to export frames to the output folder
  bRecording = true;
  nElapsedFrames = 0;
}
 
//===================================================
void draw() {
 
  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } 
  else {
    float modFrame = (float) (frameCount % nFramesInLoop);
    percentCompleteFraction = modFrame / (float)nFramesInLoop;
  }
 
  // Render the design, based on that percentage. 
  renderMyDesign (percentCompleteFraction);
 
  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    saveFrame("output/"+ myName + "-loop-" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames == nFramesInLoop) {
      bRecording = false;
    }
  }
}
 
//===================================================
void renderMyDesign (float percent) {
 
  // This is an example of a function that renders a temporally looping design. 
  // It takes a "percent", between 0 and 1, indicating where we are in the loop. 
  // This example uses two different graphical techniques. 
  // Use or delete whatever you prefer from this example. 
  // Remember to SKETCH FIRST!
 
  //----------------------
  // here, I set the background and some other graphical properties
  background (0, 153, 255); 
  stroke (229, 6, 123); 
  fill(0, 0, 0);
  strokeWeight (42); 
  smooth();
 
  //----------------------
  // Here, I assign some handy variables. 
  float amplitude = radians(55);
  float period = 240;
  float x = amplitude * cos(TWO_PI * percent);
  
  if (x > radians(45))
    x = radians(45);
  else if ( x < -radians(45))
    x = -radians(45);

  //text (x, 200, 20);
  
  scale(nScreenResolution / 500);  // Scale drawing to screen size
  
  translate(250, 250);
  rotate(-radians(percent*90));
  translate(-250, -250);
  
  pushMatrix();
  translate(250, 250);
  rotate(x);
  rect(0, 0, 100, 100);
  popMatrix();
  
  pushMatrix();
  translate(151, 151);
  rotate(-x);
  rect(0, 0, 100, 100);
  popMatrix();
  
  pushMatrix();
  translate(349, 151);
  rotate(-x);
  rect(0, 0, 100, 100);
  popMatrix();
  
  pushMatrix();
  translate(349, 349);
  rotate(-x);
  rect(0, 0, 100, 100);
  popMatrix();
  
  pushMatrix();
  translate(151, 349);
  rotate(-x);
  rect(0, 0, 100, 100);
  popMatrix();
}
