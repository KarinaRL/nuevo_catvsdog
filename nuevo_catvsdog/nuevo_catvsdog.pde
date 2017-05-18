import ddf.minim.*;
Minim minim;
AudioPlayer sonido1;
ArrayList<PVector> points = new ArrayList<PVector>();
  lock flock;
int x=250;
int y=450;
PImage img;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;
PImage img8;
int escena=0;
int fin;
//-------------------------------------------------------------
boolean derecha=false;
boolean izquierda=false;
Personaje prs=new Personaje() ;
ArrayList<Maullido>maullidos = new ArrayList<Maullido>();
ArrayList  <Ladrido>Ladridos = new ArrayList<Ladrido>();
ArrayList<Enemigo> enemigos= new ArrayList<Enemigo>();
//_____________
PFont font;
String cadena ="GAME OVER";
int xx=width-400;
float ct=255; 
String titulo ="CAT ";
int a=300;
 Eye e1,e2, e3,e4,e5,e6;
 int eleccionprs=0;
void setup (){
size (500,500);
//--------------------
minim = new  Minim(this);

  sonido1 = minim.loadFile("1.mp3", 1024);
   sonido1 .loop();
//---------------------------------------
img=loadImage("gato2.png");
img2=loadImage("perro.png");
img3=loadImage("la.png");
img4=loadImage("mi.png");
img5=loadImage("perdiste.png");
img6=loadImage("p2.png");
img7=loadImage("g2.png");
img8=loadImage("perdiste2.png");

fill(255);
stroke(255);
 font = loadFont("SitkaSmall-Italic-48.vlw");
  textFont(font);
//Perros
for (int i=0; i<10; i++ ){
  Enemigo nvoEnemigo = new Enemigo(i*20+10);
  enemigos.add(nvoEnemigo);
}
   //MOVIMIENTO DE OJOS
 e1 = new Eye( 96,  234, 25);
 e2 = new Eye( 145, 234, 25);  
 e3 = new Eye( 96,  234, 25);
 e4 = new Eye( 145, 234, 25);
e5 = new Eye( 120, 240, 25);
fondo();
}
void draw ( ){
           if(eleccionprs==1){
image(img5,0,0,width,height);
   }
   if(eleccionprs==2){
image(img8,0,0,width,height);
   }
   if (escena==0){
      background (0 );
      textoinicio();
      botonInicio();
      
   }
         if (escena==2){
          
  salir();
  regreso();
}
   if(escena==1){
      background (255);
      flock.run();
     voton2();
     voton3();
     gato();
  letrero2();
  letrero3();
  perro(); 
  
   }
   if(escena==3){
      background (255);
     jugar();
     
       }
}
//----------------------------------------------------
void fondo(){
    flock = new lock();
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2,height/2));

}
}
//____________________________________________________
void letrero2(){
String [] titulo = {"Elige","una","Mascota"};
  PFont e= createFont("Goudy Stout",15);
colorMode(HSB);
textSize(10);
textFont (e);
fill(random(255),random(255),random(255));
text(titulo[0],50,50); 
text(titulo[1],200,70);
text(titulo[2],320,50); 
}
//----------------------------------------------------
void letrero3(){
String [] titulo = {"Gato","Perro"};
  PFont e= createFont("Goudy Stout",20);
colorMode(HSB);
textSize(10);
textFont (e);
fill(#F0C92C);
text(titulo[0],75,140); 
text(titulo[1],320,140);
}
//----------------------------------------------------
   void jugar(){
      prs.movimiento();
  prs.dibujo();
  for (Maullido x: maullidos ){
    x.avanzar();
     x.dibujo();
  }
  //-----------------------
  for (Enemigo x:enemigos){
    x.avanzar();
     x.dibujo();
     
  }
    for (Ladrido x: Ladridos ){
    x.avanzar();
     x.dibujo();
  }
  
  
  colisionen();
  colision_ladrido_maullido();
  
  
  eliminar();
  eliminaren();
  colision_gato();
  colicion_enemigo_gato();

  
}
   //----------------------------------------------------
void textoinicio(){
  
if (a==0){
  a=0;
}else{
  a=a-10;
}
    image(img6,a,0,width,height);
 println(a);
 image(img7,-a,0,width,height);
}
  

//----------------------------------
void keyPressed(){
 // println("" + keyCode);
 prs.oprimir(keyCode);

}
void keyReleased(){
prs.soltar(keyCode);
}
//----------------------------------------------------
void eliminar(){
  ArrayList<Maullido> eliminarlas=new ArrayList<Maullido>();
  for(Maullido d:maullidos){
    if (d.y<0){
      eliminarlas.add(d);
    }
  }
  maullidos.removeAll(eliminarlas);
}
//----------------------------------------------------
void eliminaren(){
  ArrayList<Ladrido> eliminarlasen=new ArrayList<Ladrido>();
  for(Ladrido d:Ladridos){
    if (d.y>500){
      eliminarlasen.add(d);
    }
  }
  maullidos.removeAll(eliminarlasen);
}//-----------------elimina los enemigos que toca un maullido
void colisionen(){
   ArrayList<Maullido> eliminarlas=new ArrayList<Maullido>();
     ArrayList<Enemigo> enemigosElim =new ArrayList<Enemigo>();
     for(Maullido d: maullidos){
       for(Enemigo e:enemigos){
         //----calcula la distancia entre p y y
         float dist=sqrt(pow(d.x-e.x,2)+pow(d.y-e.y,2));
         if (dist<20){
           eliminarlas.add(d);
           enemigosElim.add(e);
          
         }
       }
     }
    maullidos.removeAll(eliminarlas);
    enemigos.removeAll(enemigosElim);
    
   
    }  
    //------------------los maullidos y los ladridos se elimian
//---------------------------------------------------- 
void colision_ladrido_maullido(){
    ArrayList<Maullido> eliminarlas=new ArrayList<Maullido>();
      ArrayList<Ladrido> LadridoElim=new ArrayList<Ladrido>();//--
       for(Maullido da:maullidos){
         for(Ladrido go:Ladridos){
            float dist=sqrt(pow(go.x-da.x,2)+pow(go.y-da.y,2));
            if (dist<10){
              escena=2;
             eliminarlas.add(da);
              LadridoElim.add(go);
             
            }
         }
       }
       maullidos. removeAll(eliminarlas);
       Ladridos.removeAll( LadridoElim);
}
//----------------------------------------------------
//--------------si un ladrido lo toca se pierde
void colision_gato(){
  for (Ladrido d: Ladridos){
     float dist=sqrt(pow(d.x-prs.x,2) + pow(d.y-prs.y, 2));
    if (dist<15){
      escena=2;
     
    }
  }
}

//------------------------------------
//----------------------------------------------------
class Personaje{
    int x=0;
  int y=450;
  //---------------------------------------

  void dibujo(){
     if(eleccionprs==1){
image(img,x,y-30,width/8,height/8);
   }
   if(eleccionprs==2){
image(img2,x,y-30,width/8,height/8);
   }

  

  }
  void movimiento(){
     if (derecha){
   x=x+5;
 }
  if (izquierda){
   x=x-5;
 }
  }
  //------------------------------
  void oprimir(int p){
     if (p==39){
   derecha=true;
   
 }
  if (p==37){
   izquierda=true;
 }
  if (p==32){
     //maullido
     Maullido aux = new Maullido(x,y);
       maullidos.add(aux);
   }
  }
 // ------------------------------
  void soltar(int s){
       if (s==39){
   derecha=false;
   
 }
   if (s==37){
   izquierda=false;
   
 }
  }
}
class Maullido{
  int x=0;
  int y=0;
  //---------------------------------------
  Maullido(int px,int py){
    x=px;
    y=py;
  }
  //-------------------------------------
  void dibujo(){
    
              if(eleccionprs==1){
image(img4,x,y,width/10,height/10);
   }
   if(eleccionprs==2){
image(img3,x,y,width/10,height/10);
   }
  }
  //----------------------------
  void avanzar(){
    y=y-1;
    
  }
}
//-----------------------------
class Enemigo{
  int x=0;
  int y=0;
  int ay=0;
  boolean derecha=true;
   boolean atak=false;
  Enemigo(int py){
    y =py;
    x=int (random(10,490));
    int ladrido=int (random(0,10));
    if (ladrido <5){ 
      derecha=true; 
    }
    else{
      derecha=false; 
    }
  }
  //-------------
  
    void dibujo(){
         if(eleccionprs==1){
image(img2,x,y,width/10,height/10);
   }
   if(eleccionprs==2){
image(img,x,y,width/10,height/10);
   }
  }
   void avanzar(){
     if (atak==true){
       y=y+2;
       //perseguir
       if (prs.x>x){
         x=x+3;
       }else{
         x=x-4;
       }
       //--------regresar enemigo
       
       if (y>500){
    y=5;
  }
  if(y<ay + 3 && y>ay-2){
    atak=false;
  }
  //------------------
     }else{
   if(derecha){
     x=x+2;
   }else{
     x=x-2;
  }
  if(x>490){
    derecha=false;
  }
  if (x<10){
    derecha = true;
  }}
  int ladrar= int(random(0,300));
  if(ladrar==2){
    Ladrido nvoLadrido= new Ladrido(x,y);
    Ladridos.add(nvoLadrido);
  }
   int atacar= int(random(0,300));
  if(atacar==15){
    ay=y;
    atak=true;
  }
  } 
}
//------------------------------------------
class Ladrido{
  int x=0;
  int y=0;
  //---------------------------------------
  Ladrido(int px,int py){
    x=px;
    y=py;
  }
  //-------------------------------------
  void dibujo(){
           if(eleccionprs==1){
image(img3,x,y,width/10,height/10);
   }
   if(eleccionprs==2){
image(img4,x,y,width/10,height/10);
   }
 
  }
  //----------------------------
  void avanzar(){
    y=y+3;
    
  }
}
void colicion_enemigo_gato(){
  for(Enemigo e:enemigos){
      float dist=sqrt(pow(e.x-prs.x,2) + pow(e.y-prs.y, 2));
      if (dist<15){
       escena=2;
  
        
      }
  }
 
}

void botonInicio(){
  int x= width/2;
  int y=height/12;
  int w=width/10;
  int h=height/10;
  
  if ((mouseX>x)&&(mouseX<x+w)&&(mouseY>y)&&(mouseY<y+h)){
    fill(#D6B549);
     if(mousePressed==true){
        escena=1;
          
     }

}
else{
  fill(255);
}
rect(x,y,w,h,20);
textSize(12);
fill(0);
text("JUGAR",x+8,y+35);
}
void salir(){
      int x= width-80;
  int y=height/2;
  int w=width/10;
  int h=height/10;
 
  if ((mouseX>x)&&(mouseX<x+w)&&(mouseY>y)&&(mouseY<y+h)){
    fill(#D6B549);
     if(mousePressed==true){
          exit();
          
     }

}
else{
  fill(255);
}
rect(x,y,w,h,20);
textSize(15);
fill(0);
text("salir",x+10,y+35);
   }
   void regreso(){
  int x= width/9;
  int y=height/2;
  int w=width/10;
  int h=height/10;
  
  if ((mouseX>x)&&(mouseX<x+w)&&(mouseY>y)&&(mouseY<y+h)){
    fill(#D6B549);
     if(mousePressed==true){
        escena=0;
          
     }

}
else{
  fill(255);
}
rect(x,y,w,h,20);
textSize(12);
fill(0);
text("inicio",x+8,y+35);
}
//ELEGIR PERSONAJES

void gato(){

  //orejas
  stroke(#232727);
    fill(0);
  arc(100,200,100,100,HALF_PI+QUARTER_PI,PI+QUARTER_PI);
    arc(140,200,100,100,PI+HALF_PI+QUARTER_PI,TWO_PI+QUARTER_PI);
    //caveza
     fill(0);
    ellipse(120,250,115,102);
    noStroke();
     //nariz
    fill(#FC9CE1);
    arc(120,265,40,40,PI+QUARTER_PI,PI+HALF_PI+QUARTER_PI);
     //patitas traseras 
    fill(#1F1818);
     rect(60,350,50,90,70,70,50,50);
     rect(140,350,50,90,70,70,50,50);
     fill(#484444);
     rect(60,430,40,18,70,70,50,50);
     rect(150,430,40,18,70,70,50,50);
     //cuerpo
     fill(0);
     rect(85,300,80,150,70,70,50,50);
    //patitas delanteras
    fill(#343131);
    ellipse(110,450,35,20);
    ellipse(150,450,35,20);
      e1.update(mouseX, mouseY);
   e2.update(mouseX, mouseY);

  e1.display();
  e2.display();
 
}

void perro(){
   translate(250,8);
  fill(#9EBC19);
  stroke(255);
  strokeWeight(10);

  //orejas
    fill(0);
    noStroke(); 
    rotar();
    rotate(radians(-10));
    //caveza
     fill(0);
    ellipse(120,250,115,102);
    noStroke();
     //nariz
    fill(#FC9CE1);
    arc(120,265,40,40,PI+QUARTER_PI,PI+HALF_PI+QUARTER_PI);
     //patitas traseras 
    fill(#1F1818);
     rect(60,350,50,90,70,70,50,50);
     rect(140,350,50,90,70,70,50,50);
     fill(#484444);
     rect(60,430,40,18,70,70,50,50);
     rect(150,430,40,18,70,70,50,50);
     //cuerpo
     fill(0);
     rect(85,300,80,150,70,70,50,50);
    //patitas delanteras
    fill(#343131);
    ellipse(110,450,35,20);
    ellipse(150,450,35,20);
      e3.update(mouseX, mouseY);
   e4.update(mouseX, mouseY);
   
  e3.display();
  e4.display();
  
    
}
void rotar(){

rotate(radians(10));
ellipse(100,240,20,100);
ellipse(220,240,20,100);
}
class Eye {
  
  int x, y;
  int size;
  float angle = 0.0;
  
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
 }

  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    fill(255);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(#1BF5EF);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
}
//------------------------------------------------
 void voton2(){
  int x=70-width/10;
  int y=height/5;
  int w=width/2-50;
  int h=height-110;
  
  if ((mouseX>x)&&(mouseX<x+w)&&(mouseY>y)&&(mouseY<y+h)){
    fill(0);
  if (mousePressed==true){
    eleccionprs=1;
     escena=3;
    }
}
else{
  
  fill(255);
}
  
rect(x,y,w,h);
 }
 //---------------------------------------------------
  void voton3(){
  int x=320-width/10;
  int y=height/5;
  int w=width/2-50;
  int h=height-110;
  
  if ((mouseX>x)&&(mouseX<x+w)&&(mouseY>y)&&(mouseY<y+h)){
    fill(0);
    if (mousePressed==true){
      eleccionprs=2;
     escena=3;
    }
}
else{
  
  fill(255);
}
  
rect(x,y,w,h);
 }
 void mouseReleased() {
 
}
//--------------------------------FONDO
 class lock {
  ArrayList<Boid> boids;

  lock() {
    boids = new ArrayList<Boid>(); 
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids); 
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

}


class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;   
  float maxspeed;    

    Boid(float x, float y) {
    acceleration = new PVector(0, 0);

    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 4.0;
    maxspeed = 4;
    maxforce = 0.01;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
  
    acceleration.add(force);
  }

  
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);  
    PVector ali = align(boids);      
    PVector coh = cohesion(boids);   

    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
   
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
  void update() {
   
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

// Un método que calcula y aplica una fuerza de dirección hacia un objetivo
  // STEER = MENOR VELOCIDAD DESEADA
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    float theta = velocity.heading2D() + radians(90);
    
    fill(random(255), random(255),random(255));
    stroke(0,0,random(255));

    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
 
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;        
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }

// Siempre que el vector sea mayor que 0
    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }
 
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); 
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  
    } 
    else {
      return new PVector(0, 0);
    }
  }
}