//This piece is for the Deltaprintr; It should prevent the Hotend from moving out of the platform

/* [Parameters] */
//This is the Hotend upper diameter usually around 16mm. It'll add 0.5mm to that value to make assembly easier
Diameter_Hotend = 16;   
//Big upper ø should be around 20mm
Big_Diameter = 20;     
//Little Diameter
little_Diameter = 16;   
//the lower little ø is the upper little ø - cone
Cone = 1;               
//The Height of the upper ø
Upper_Height = 4;       
//The Height of the lower ø
Lower_Height = 10;      

/* [Hole for wires?] */
//With hole for wires?
hole = "off"; //[on:with Hole,off:without Hole]
//Holediameter
holedia = 10; //[1:1:10]    

/* [Traxxas] */

//Traxxas On-Off 
Tra = "on"; //[on:with Traxxas,off:without Traxxas]

//Distance between centre and traxas-joint outer
xdis=17.5;
ydis=8.3;

//Diameter of Traxxas-Joint-mount
traxdia=7.5;


///////////////
///Render//////
///////////////

//Renderquality
$fn= 100;       
difference(){
whole();
minus();
}

//Modules
/* [Hidden] */
d1= Diameter_Hotend+0.5;
h1= Lower_Height;
d2= little_Diameter;
d3 = Big_Diameter;
h2= Upper_Height;
cone = Cone;
module whole(){

    if (Tra == "on"){
    withtra();
    }else{
    withouttra();}
    
}

module top(){
translate([0,0,h1])
    cylinder(h2,d3/2,d3/2);
}

module shaft (){
    cylinder (h1,d2/2-cone,d2/2); 
} 

module minus(){
    translate ([8.12,0,-1]) 
        cylinder (h1+h2+2,d1/2,d1/2);
    if (hole == "on"){
    withhole();
    }else{
   }
}

module withhole(){
    translate ([0,0,-1]) 
    cylinder(h1+h2+2,holedia/2,holedia/2);
}

module traxas(){


difference(){
translate([0,0,h1])
linear_extrude(height =h2)
polygon(points=[[-3,d3/2-1],[-xdis-2,ydis+2],[-xdis-2,-ydis-2],[-3,-d3/2+1]]);

translate([-xdis,ydis,h1-1])
    cylinder(h2+2,traxdia/2,traxdia/2);
translate([-xdis,-ydis,h1-1])
    cylinder(h2+2,traxdia/2,traxdia/2);
}
}

module withtra(){
    
    union(){
    top();
    shaft();
    traxas();
}}

module withouttra(){
    union(){
    top();
    shaft();}}