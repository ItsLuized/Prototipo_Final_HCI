import jp.nyatla.nyar4psg.*;
import processing.video.*;

Capture cam;
MultiMarker nya;
PImage img;
PImage img2;

void setup() {
 size(640, 480, P3D);
 colorMode(RGB, 100);
 cam = new Capture(this, 640, 480);
 nya = new MultiMarker(this,width,height,"../libraries/nyar4psg/data/camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
 nya.addARMarker("../libraries/nyar4psg/data/patt.hiro", 80);
 cam.start();
 img = loadImage("Manos_Sucias.png", "png");
 img2 = loadImage("CUIDADO.png", "png");
}

void draw() {
  
  if (cam.available() !=true) {
      return;
  }
  
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  
  if(!nya.isExist(0)) {
    return;
  }
  
  nya.beginTransform(0);
  image(img, -160, -100, width/4, height/4);
  image(img2, 20, -100, width/4, height/4);
  nya.endTransform();
}
void keyPressed() {
  
  if (key == '1') {
     img = loadImage("Manos_Sucias.png", "png");
     img2 = loadImage("CUIDADO.png", "png");
    }
  if (key == '2') {
     img = loadImage("Persona_Lejos.png", "png");
     img2 = loadImage("Distancia_Lejos.png", "png");
    }
  if (key == '3') {
     img = loadImage("Zona_Riesgo.png");
     img2 = loadImage("Porcentaje_Riesgo.png");
  }
  if (key == '4') {
     img = loadImage("ALERTA.png");
     img2 = loadImage("ALERTA.png");
  }
  if (key == '5') {
     img = loadImage("Persona_Cerca.png");
     img2 = loadImage("Distancia_Cerca.png");
  }
  if (key == '6') {
     img = loadImage("Aviso_3_horas_Manos.png");
     img2 = loadImage("Lavar_Manos.png");
  }
  
}
