/* Squid 3D Configurable/Random
Version 1, Enero 2019
Escrito por Jorge Cifuentes (jorgecif at gmail dot com)*/

//Parametros de configuracion

/* Partes
Cabeza
- Ojos
- Posicion ojos
Torzo
Patas


*/

tipo="configurable"; //[configurable,random]

//Resolution
$fn=20;
//Body size (radio)
body_size=10;//[10:1:100]
//Leg n_leg
n_leg=7; //[3:1:12]
//Legs aperture
aperture=-10;//[-10:1:10]
//Lenght legs
l_lenght=10;//[-10:1:50]
//Right eye x desviation
x_eyes_R=2;
//Right eye y desviation
y_eyes_R=2;
//Left eye x desviation
x_eyes_L=-2;
//Left eye y desviation
y_eyes_L=2;

pupila_ratio=2;//[1.5:.1:5]

 
 
 module squid(body_size,n_leg,aperture,l_lenght, resize_scale, scale_hat1, scale_hat2, e_size, pupila_size,pupila_ratio, x_eyes_R, y_eyes_R, x_eyes_L, y_eyes_L)
{

 union(){
 scale([1, 1, resize_scale])
 rotate(a=90, v=[0,0,90]) sphere(body_size*2);
 rotate(a=90, v=[0,0,90]) #ojos();   
 }  
    
 translate([0,0,body_size])
 hull() {
 translate([0,0,body_size]) sphere(body_size*scale_hat1,center=true);
 scale([1, 1, resize_scale/2.5]) sphere(body_size*scale_hat2,center=true);
 }
 
 module ojos_ex(){
  translate([body_size-.4*body_size,body_size*2,-0.2*body_size])
 rotate(a=90, v=[1,0,0])
cylinder(e_size,e_size,e_size);
   translate([-(body_size-.4*body_size),body_size*2,-0.2*body_size])
 rotate(a=90, v=[1,0,0])
cylinder(e_size,e_size,e_size);
 }

 module ojos_in(){
  translate([body_size-.4*body_size,body_size*2,-0.2*body_size])
 rotate(a=90, v=[1,0,0])
cylinder(e_size-1,e_size-1,e_size-1);
   translate([-(body_size-.4*body_size),body_size*2,-0.2*body_size])
 rotate(a=90, v=[1,0,0])
cylinder(e_size-1,e_size-1,e_size-1);
 } 
 
  module contorno_ojos(){
 difference() { 
     ojos_ex();
     #ojos_in(); 
 }
 }
 
 module ojos(){
 union(){
    contorno_ojos();
     #pupilas();
 } 
     
 }
 
  module pupilas(){
  translate([body_size-.4*body_size+x_eyes_R,body_size*2,-(0.2*body_size+y_eyes_R)])
 rotate(a=90, v=[1,0,0])
#cylinder(pupila_size,pupila_size,pupila_size);
   translate([-(body_size-.4*body_size+x_eyes_L),body_size*2,-(0.2*body_size+y_eyes_L)])
 rotate(a=90, v=[1,0,0])
#cylinder(pupila_size,pupila_size,pupila_size);
 } 
     
 //Patas
 for(r = [1:n_leg]) {
      rotate(360/n_leg * r, [0, 0, 1]) translate([-body_size, -body_size*1.2, -body_size*1.8]) 
      hull(){
      translate([0,aperture,-l_lenght])  scale([1, 1, 1]) sphere(body_size);
     scale([1, 1, 1]) sphere(body_size);
          }
    }
} 
/*
      for(r = [1:n_leg]) {
      rotate(360/n_leg * r, [0, 0, 1]) translate([-body_size, -body_size, -body_size])
      scale([1, 1, 0.7])
        sphere(body_size);
    }   
*/

module configurable_squid()
{
     resize_scale=0.8;
     scale_hat1=1.2;
     scale_hat2=2.5;
     e_size=body_size*.8;//Eye size
     pupila_size=e_size/pupila_ratio;//Pulila size
     squid(body_size,n_leg,aperture,l_lenght, resize_scale, scale_hat1, scale_hat2, e_size,pupila_size, pupila_ratio, x_eyes_R, y_eyes_R, x_eyes_L, y_eyes_L);
}

module random_squid()
{
     resize_scale=0.8;//rands(0.5,0.2,5)[0];//0.8;
     scale_hat1=1.2;//rands(1,0.1,2)[0];//1.2;
     scale_hat2=rands(2.5,3.5,1)[0];//2.5;
     e_size=body_size*.8;//Eye size
     pupila_ratio=rands(1.5,4.5,1)[0];
    pupila_size=e_size/pupila_ratio;//Pulila size
    max_desviation=(e_size-2*pupila_size-1);
    x_eyes_R=rands(-max_desviation,max_desviation,1)[0];
    //Right eye y desviation
    y_eyes_R=rands(-max_desviation,max_desviation,1)[0];
    //Left eye x desviation
    x_eyes_L=rands(-max_desviation,max_desviation,1)[0];
    //Left eye y desviation
    y_eyes_L=rands(-max_desviation,max_desviation,1)[0];
    body_size=rands(10,15,1)[0];//10;//[10:1:100]
    //Leg n_leg
    n_leg=rands(3,12,1)[0];//7; //[3:1:12]
    //Legs aperture
    aperture=rands(-10,10,1)[0];//-10;//[-10:1:10]
    //Lenght legs
    l_lenght=rands(-10,50,1)[0];//10;//[-10:1:50]

	squid(body_size,n_leg,aperture,l_lenght, resize_scale, scale_hat1, scale_hat2, e_size,pupila_size, pupila_ratio, x_eyes_R, y_eyes_R, x_eyes_L, y_eyes_L);
}

    
    
    if (tipo=="configurable")
{
    configurable_squid();
}

if (tipo=="random")
{
    random_squid();
}
