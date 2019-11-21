/*  
    MIDI Keyboard Bass Pedal Synth
    Manuel Guerrero Perez 
    18 May 2017
    Revision C10
*/

PrintTOP = true;
PrintBOTTOM = true;
CutBumperTop = false; // True for White Notes

//PedalBody
largo= 100; //(100 for Black Key, 160 for White Key)
ancho = 25;
alto = 10;
//HollowPedalBody
largo2= largo-6;
ancho2 = ancho-6;
alto2 = alto-5;
//Space between keys
Space=8;

// Bed
LargoBed=largo+6; //x
AltoBed=4;   //z
AnchoBed=ancho+6; //y
Gap=9; // gap between pedal and PedalBody

BumperLenght = 22;
BumperRadius = ancho/2;


r = 6;
r2 = 5;
Air = 0.12; // Gap between moving parts

/////////////// Main Code -------------------------

// PEDAL
if (PrintTOP == true) {
 translate ([0,40,0]){
 difference(){
        PedalBody (); 
        HollowPedalBody();
        HuecoBajoBumper ();
}

AxisPedal();
//RearSide();

//translate ( [0, 0, Gap] ){
//PitorroMuelle();}
}

}

// BED
if (PrintBOTTOM == true) {
FemaleDovesOnBed();
PitorroMuelle();
PedalBody_RightSide ();
PedalBody_LeftSide ();

translate ( [LargoBed-40, (ancho/2)-3, -Gap+AltoBed+4] ){
translate ( [0, 0, -2 ] )

//Activate module Switch() to simulate the switch
// Micro Roller Lever Arm Switch KW12-3 PCB  
//https://www.ebay.com/p/10pcs-Micro-Roller-Lever-Arm-Open-Close-Limit-Switch-Kw12-3-PCB-Microswitch-HU/1356215378 
//Switch ();
    
SwitchSupport ();
}

ArandelasPasaCables ();
SoportesConector ();
BedRearSide ();
Rodillo ();
UnionDoveBlock ();
BedBottom ();
}

/////////////// End Main Code --------------------




module FemaleDovesOnBed(){
  
    //Hueco en Bed Rear Side   

difference (){
FemaleDovetailsx4 ();

    //Hueco PasaCables en Bed Rear Side 
translate ( [-29, -(AnchoBed-ancho), -Gap+3] )
    color("Blue") cube ( [ 2, AnchoBed+5, 3.5] );
}

}

module BedBottom (){
    difference(){
      translate ( [-13.5, -(AnchoBed-ancho)/2, -Gap ] )
 color("Black") cube ( [ LargoBed+13.5, AnchoBed, AltoBed] );
        HuecoPasacables ();
    }
}
module UnionDoveBlock (){// Dovetail Union Block Between Keys
color ("Brown")
    translate ( [0, -6, 0 ] )
translate([-19,-(AnchoBed-ancho-2),-Gap]) {
difference(){
DovetailUnionDoveBlock ();
        //Hueco PasaCables 
translate ( [-10, -Space-2, -Gap+12] )
    cube ( [ 2, AnchoBed+4, 4] );
   }
}
}

module Rodillo (){

difference (){

/// RODILLO
    translate ([ -3, ancho+4, alto/2] )
    rotate ( [ 90, 0, 0 ] )
    color("Orange")cylinder ( r = 22/2, h = ancho+8, center=false);
 
  HuecoPasacables ();  
  
  //Hueco eje grande Rodillo
    translate ([ -3, ancho+Air, alto/2] )
    rotate ( [ 90, 0, 0 ] )
    color("Blue")cylinder ( r =(alto/1.5)+Air, h = ancho+Air*2);

  //Hueco eje fino Rodillo    
    translate ([ -3, ancho+6, alto/2] )
    rotate ( [ 90, 0, 0 ] )
    color("Blue")cylinder(r = (5/2)+Air, h = ancho+12);
  
  //Hueco paso pedal por rodillo 
     translate ([ -0,-Air,-0] )
     rotate ( [ 0, -10, 0 ] )
     color("Grey") cube ( [ 12, ancho+Air*2, 13] );
    
     translate ([ 0,-Air,0] )
     rotate ( [ 0, 15, 0 ] )
     color("Brown") cube ( [ 10, ancho+Air*2, 5] );
}
}
module BedRearSide (){
    l=45-8;
    
difference(){
  translate ( [-l-8, -(AnchoBed-ancho-10), -Gap] )
      color("Pink") cube ( [ l, AnchoBed-14, AltoBed+2] );
 
    //Hueco en Bed Rear Side   
translate ( [-l+2, -(AnchoBed-ancho-10), -Gap+1.5] )
    color("Green") cube ( [ l-16, AnchoBed-14, AltoBed+2] );
    //Hueco PasaCables en Bed Rear Side 
translate ( [-l+8, -(AnchoBed-ancho), -Gap+4] )
    color("Blue") cube ( [ 2, AnchoBed+5, AltoBed] );

  translate ( [-39.5, 12, -Gap] )  
      color("Blue")cylinder(r = (5/2)+Air, h = 10.1);  
      translate ( [-39.5, 12, -Gap-0.1] )  
      color("Blue")cylinder(r = 4.5, h = 3); 
    
/// 4 Holes on Bed Reas Side to attach base to Box with screws

/*    d = 5;
  translate ( [-18, 2, -Gap] )  
      color("Blue")cylinder(r = (d/2)+Air, h = 9.1);  
  translate ( [-18, 22, -Gap] )  
      color("Blue")cylinder(r = (d/2)+Air, h = 9.1); 
  translate ( [-38, 2, -Gap] )  
      color("Blue")cylinder(r = (d/2)+Air, h = 9.1);  
  translate ( [-38, 22, -Gap] )  
      color("Blue")cylinder(r = (d/2)+Air, h = 9.1); 
*/
    HuecoPasacables ();

}
}
module SoportesConector (){
 translate ( [ -18, ancho/2-(5.4/2)-1,-8 ] )
 color ("Brown")     cube ( [ 3, 1, 4]);

 translate ( [ -18, ancho/2+(5.4/2),-8 ] )
 color ("Brown")     cube ( [ 3, 1, 4]);

 translate ( [ -18, ancho/2-(5.4/2),-8 ] )
 color ("White")     cube ( [ 3, 5.4, 1]);
}

module FemaleDovetailsx4 (){
translate ( [-19, -(AnchoBed-ancho-2), -Gap] )   

female_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, block_width=18, block_depth=10, clearance=0.25);

translate ( [-19-17, -(AnchoBed-ancho-2), -Gap] )   

female_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, block_width=18, block_depth=10, clearance=0.25);

rotate ( [ 180, 0, 0 ] ){
translate ( [-19, -ancho-4, Gap-6] )   

female_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, block_width=18, block_depth=10, clearance=0.25);

translate ( [-19-17, -ancho-4, Gap-6] )   

female_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, block_width=18, block_depth=10, clearance=0.25);
}
}
 
module HuecoPasacables (){
 
    d=6;
  //Hueco Horizontal bajo soporte
  translate ( [-17, ancho/2, 1-Gap+d/2] )   
  rotate ( [ 0, 90, 0 ] )
  color("Blue")cylinder(r = (d/2)+Air, h = 31); 
  
  // Hueco Vertical Trasero
 // translate ( [-16, ancho/2, -Gap+1] )  
 // color("Blue")cylinder(r = (d/2)+Air, h = 8.1);
    
  //Hueco conexion a Switch   
 /*
  translate ( [9, ancho/2+7, 1-Gap+d/2] )   
  rotate ( [ 0, 90, 0 ] )
  color("Blue")cylinder(r = (d/3)+Air, h = 55); 
    
  translate ( [10, ancho/2+8, 1-Gap+d/2] )   
  rotate ( [ 90, 90, 0 ] )
  color("Blue")cylinder(r = (d/3)+Air, h = 10); 
    
  translate ( [10+54, ancho/2+8, 1-Gap+d/2] )   
  rotate ( [ 90, 90, 0 ] )
  color("Blue")cylinder(r = (d/3)+Air, h = 10); 
    
  //Hueco Bajo Switch   
  translate ( [LargoBed-43, ancho/2, 1-Gap+d/2] )   
  rotate ( [ 0, 90, 0 ] )
  color("Blue")cylinder(r = (d/3)+Air, h = 26); 
  */
     
     
     //Hueco Bajo Switch 
e=5;
  translate ( [LargoBed-42, (ancho/2)-e/2, -Gap+e/3-1] )   
  rotate ( [ 0, 0, 0 ] ){

color("Blue") cube ( [ 24, e, 4-Air] );}
 

}


module ArandelasPasaCables (){

d=8;
  translate ( [15, ancho/2, 1-Gap+d/2] )   
  rotate ( [ 0, 90, 0 ] )
    difference (){
  color("Green")cylinder(r = (d/2)+Air, h = 4); 
  color("Blue")cylinder(r = (d/2)-2+Air, h = 4.1); }
  
    translate ( [36, ancho/2, 1-Gap+d/2] )   
  rotate ( [ 0, 90, 0 ] )
    difference (){
  color("Green")cylinder(r = (d/2)+Air, h = 4); 
  color("Blue")cylinder(r = (d/2)-2+Air, h = 4.1); }
  
//    translate ( [42, ancho/2, 1-Gap+d/2] )   
//  rotate ( [ 0, 90, 0 ] )
//    difference (){
//  color("Green")cylinder(r = (d/2)+Air, h = 4); 
//  color("Blue")cylinder(r = (d/2)/1.5+Air, h = 4.1); }
  

}

module PedalBody_RightSide (){
   difference (){
    translate ( [-13.5, AnchoBed-2, -Gap ] )
    rotate ( [ 90, 0, 0 ] )
    color("Green") cube ( [ largo-25, 17, 4-Air] );
    
   //Hueco eje fino Rodillo    
    translate ([ -3, ancho+6, alto/2] )
    rotate ( [ 90, 0, 0 ] )
    color("Blue")cylinder(r = (5/2)+Air, h = ancho+12);
    }
  ///Oreja  
  //  translate ( [LargoBed/1.5-AltoBed*2, ancho+4, 0] )
  //  rotate ( [ 90, 0, 0 ] )
  //  color("Brown")cylinder ( r = AltoBed*2, h = 4-Air);
    

// extruded triangle Right Side
b = 17;
h = 45;
w = 4-Air;
translate ( [largo-39, ancho+2+Air/2, -Gap] )
rotate(a=[90,0,0])
    color("Green")
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
}   

module PedalBody_LeftSide (){
   difference (){
    translate ( [-13.5, -Air, -Gap ] )
    rotate ( [ 90, 0, 0 ] )
    color("Green") cube ( [ largo-25, 17, 4-Air] );
    
   //Hueco eje fino Rodillo    
   translate ([ -3, ancho+6, alto/2] )
    rotate ( [ 90, 0, 0 ] )
    color("Blue")cylinder(r = (5/2)+Air, h = ancho+12);
    }
    
    
// extruded triangle Left Side
b = 17;
h = 45;
w = 4-Air;
translate ( [largo-39, -Air-2, -Gap] )
rotate(a=[90,0,0])
    color("Green")
linear_extrude(height = w, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
}


module PitorroMuelle(){           
    difference (){
   translate ( [LargoBed-52, ancho/2, -Gap+AltoBed] )
    color("Grey")cylinder (h=4, r1=11/2, r2=10/2, center=false);
    translate ( [LargoBed-52, ancho/2, -Gap+AltoBed] )
    color("Red")cylinder ( r = 7.8/2, h = 4.0);
    }
     
    translate ( [LargoBed-52, ancho/2, -Gap+AltoBed-1] ){
    color("Magenta") cylinder (r=5.5/2, h=7.0);   
    color("Magenta") cylinder (h=4, r1=7/2, r2=4/2, center=false);
    }
 }
 
 
module AxisPedal (){
translate ([ -3, ancho, alto/2] )
rotate ( [ 90, 0, 0 ] ){
    
  difference(){   
color("Red")cylinder ( r = alto/1.5, h = ancho);
    
color("Blue")cylinder ( r = (5/2)+Air, h = ancho);  
   } 
 }
}

module RearSide (){
longi=30; //x
alti=3;   //z
anchi=10; //y
 translate ( [ -longi/2-5, -(anchi-ancho)/2, 4 ] )
      cube ( [ longi/2, anchi, alti]); 

    
}

module PedalBody (){
 translate ( [ 0, 0, 0 ] )
    {   
        union ()
        {
            
      cube ( [ largo-r, ancho, alto] );
      translate ( [  0, r, 0 ] )
      cube ( [ largo, ancho-2*r, alto] );
            
 // Fillet corners.            
      translate ( [  largo - r, r,   0 ] )     cylinder ( r = r, h = alto );
      translate ( [  largo - r, ancho-r, 0 ] ) cylinder ( r = r, h = alto );
 
 difference() {          
 Bumper();          
            
    /// CutBumperTop
    if (CutBumperTop == true){
    translate ( [ (largo-BumperLenght-r*5), 0, alto+r] )
    color("Yellow") cube ( [ BumperLenght+r*6, ancho, alto] );}
}
        } 
    }   
}

module Bumper() {           
        
     translate ( [ (largo-BumperLenght-r-2), ancho/2, alto] ) rotate ( [ 0, 90, 0 ] )
     cylinder ( r = BumperRadius, h = BumperLenght);
     
     translate ( [ (largo-BumperLenght-r-2), ancho/2, alto] )
     sphere(BumperRadius);
     translate ( [ (largo-r-2), ancho/2, alto] )
     sphere(BumperRadius);

    }
       

module HollowPedalBody (){
 translate ( [ (largo-largo2)/2, (ancho-ancho2)/2, -BumperRadius] )
    color("Red")
   {
   
    cube ([largo2-r2, ancho2, alto2+BumperRadius,]);
    translate ( [  0, r2, 0 ] )
    cube ( [ largo2, ancho2-2*r2, alto2] );
    
                // Fillet corners.            
            translate ( [  largo2 - r2, r2,   0 ] )      cylinder ( r = r2, h = alto2 );
            translate ( [  largo2 - r2, ancho2-r2, 0 ] ) cylinder ( r = r2, h = alto2 );
   }   
}
module HuecoBajoBumper (){
    a=28;
 translate ( [ (largo-a-8), ancho-20, 4] )
    color("Pink")
    cube ([a, 16, alto2+5]);
    
    // provisional para ver hueco
  //   translate ( [ (largo-29-8), ancho2/2-1-20, 4] )
  //  cube ([29, 25, alto2+8]);
}

module Switch (){

L=20;
W=6;
H=10;
     
color("Blue") {
     
  cube ( [ L, W, H] );//Main Box
     
     //Connector Pin
      translate ( [2, (W-3.2)/2, -2] )
      cube ( [ 0.5, 3.2, 4] );
      translate ( [2, (W-1.2)/2, -4] )
      cube ( [ 0.5, 1.2, 4] );
   

    //Connector Pin
      translate ( [L/2, (W-3.2)/2, -2] )
      cube ( [ 0.5, 3.2, 4] );
      translate ( [L/2, (W-1.2)/2, -4] )
      cube ( [ 0.5, 1.2, 4] );
    
     //Connector Pin
      translate ( [L-2, (W-3.2)/2, -2] )
      cube ( [ 0.5, 3.2, 4] );
      translate ( [L-2, (W-1.2)/2, -4] )
      cube ( [ 0.5, 1.2, 4] );
     
     //Lever Arm
        translate ( [4, 1, H+1] )
         rotate ( [ 0, -15, 0 ] )
         cube ( [ 14.5, 4, 0.5] ); 
     //Roller   
          translate ( [18, 5, 10+5.2] )
           rotate ( [ 90, 0, 0 ] )
           cylinder(r = (4/2), h = 4); 
    
    // Hole  1  
    translate ( [5.15, 0, 2.5] )
rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W+1);  

    // Hole  2  
    translate ( [5.15+10, 0, 2.5] )
rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W+1);      
           }
               //Indicador Altura Maxima
 // translate ( [L, 0, 0] )  
 // color("Green") cube ( [ .1, 2, 20] );
    
     //Indicador Altura Minima
 // translate ( [L, 4, 0] )  
 // color("Red") cube ( [ .1, 2, 18] );
   }
   
module SwitchSupport (){
    
L=20;
W=6;
H=10;
 difference(){
    translate ( [0, W, -6] )
    color("Magenta") cube ( [ L, 3 , H+2] );//Main Box  
           
     // Hole  1a 
    translate ( [5.15, 0, -0] )
    rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W*2+1);  

    // Hole  2a  
    translate ( [5.15+10, 0, -0] )
    rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W*2+1);  
       
      // Hole  1b  
    translate ( [5.15, 0, 1] )
    rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W*2+1);  

    // Hole  2b  
    translate ( [5.15+10, 0, 1] )
    rotate ( [ -90, 0, 0 ] )    
    color("Orange")cylinder(r = (2.35/2), h = W*2+1); //Vena 1
    
    // Vena1
     translate ( [5.15-1, W,-0.5])
     color("Red") cube ( [ 2, 5 , 2] );
     //Vena 2
     translate ( [5.15-1+10, W-2,-0.5])
     color("Red") cube ( [ 2, 5 , 2] );                
               
           }  
     
    rotate ( [ 0, -90, 0 ] )translate ( [-2, W+3, -10] )
        color("Magenta")   fillet(5, 4);      
               }



module DovetailUnionDoveBlock (){
     
        translate([-26,-Space,0])cube([35,Space,AltoBed+2]); 
      
    male_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, cutout_width=3, cutout_depth=4);
		translate([-10,-5,0]) cube([19,5,AltoBed+2]);
        
        translate ( [-17, 0, 0] ){
    male_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, cutout_width=3, cutout_depth=4);
		translate([-9,-5,0]) cube([19,5,AltoBed+2]);}
    
 rotate ( [ 180, 0, 0 ] ){ 
   
     translate ( [0, Space, -Gap+3] ){
male_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, cutout_width=3, cutout_depth=4);
		translate([-10,-5,0]) cube([19,5,AltoBed+2]);
        
        translate ( [-17, 0, 0] ){
 male_dovetail(max_width=10, min_width=6, depth=5, height=AltoBed+2, cutout_width=3, cutout_depth=4);
 translate([-9,-5,0]) cube([19,5,AltoBed+2]);           
                }
            }
        } // end rotate     
        
	       

} // end module DovetailUnionDoveBlock

         
               
///////////////////// DOVETAIL MODULES
//female_dovetail(max_width=10, min_width=8, depth=5, height=30, block_width=20, block_depth=10, clearance=0.25);


/* translate([0,-15,0]) 
	union() {
		male_dovetail(max_width=10, min_width=8, depth=5, height=30, cutout_width=3, cutout_depth=4);
		translate([-10,-5,0]) cube([20,5,30]);
	}
*/

module female_dovetail_negative(max_width=11, min_width=5, depth=5, height=30, clearance=0.25) {
	union() {
		translate([0,-0.001,-0.05])
			dovetail_3d(max_width+clearance,min_width+clearance,depth,height+0.1);
			translate([-(max_width+clearance)/2, depth-0.002,-0.5])
				cube([max_width+clearance,clearance/2,height+1]);
	}
}

module female_dovetail(max_width=11, min_width=5, depth=5, height=30, block_width=15, block_depth=9, clearance=0.25) {
		difference() {
			translate([-block_width/2,0,0]) cube([block_width, block_depth, height]);
			female_dovetail_negative(max_width, min_width, depth, height, clearance);
		}
}

module male_dovetail(max_width=11, min_width=5, depth=5, height=30, cutout_width=5, cutout_depth=3.5) {
	difference() {
		dovetail_3d(max_width,min_width,depth,height);
		translate([0.001,depth+0.001,-0.05])
			dovetail_cutout(cutout_width, cutout_depth, height+0.1);
	}
}

module dovetail_3d(max_width=11, min_width=5, depth=5, height=30) {
	linear_extrude(height=height, convexity=2)
		dovetail_2d(max_width,min_width,depth);
}

module dovetail_2d(max_width=11, min_width=5, depth=5) {
	angle=atan((max_width/2-min_width/2)/depth);
	echo("angle: ", angle);
	polygon(paths=[[0,1,2,3,0]], points=[[-min_width/2,0], [-max_width/2,depth], [max_width/2, depth], [min_width/2,0]]);
}

module dovetail_cutout(width=5, depth=4, height=30) {
	translate([0,-depth+width/2,0])
		union() {
			translate([-width/2,0,0])
				cube([width,depth-width/2,height]);
			difference() {
				cylinder(r=width/2, h=height, $fs=0.25);
				translate([-width/2-0.05,0.05,-0.05]) cube([width+0.1,width+0.1,height+0.1]);
			}
		}
}

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);
        }
}