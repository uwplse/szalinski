////////////////////////////////////////////////
//  Animated Parametric adjustable Tap Wrench  /
////////////////////////////////////////////////
/// OpenSCAD File V1.0 by Ken_Applications /////
/////////  OpenSCAD version 2015.03-2 //////////
////////       21 - 01 - 2018              /////
////////////////////////////////////////////////

///////////////////////////////////////////////////////////
/// To activate animation, select "View->Animation" from the
/// menu and enter values into the appearing FPS and Steps input
/// fields (e.g. 5 FPS and 50 Steps for this animation).
////////////////////////////////////////////////////////////

////  Parameters ////////////////////////////// 
////////////////////////////////////////////////
// Maximum the square will grow to
max_adj_square=11;
// The size of the square the 4 segments fit into
square=33;
// Thickness
thickness=11;
//Thread diameter default... 6
thread_dia=6;
// The Tapping drill size... default 5
tap_hole_size=5;
// Show individual parts default... 6
show=6;// 0=body 1=segment1 2=segment2 3=segment3 4=segment4 5=all parts 6=all with animation 7=cover
////////////////////////////////////////////////
////////////////////////////////////////////////

module the_shape(){
round2d(external_rad,square/1.5){
square(square+add_0n,true);
square([square*4.6,handle_width],true);
    
}
}

$fn=100;
///// calculations ///
add_0n=square*0.25;
handle_width=square*0.36;
external_rad=(handle_width/2)-1;
hole_dia=square*0.5757;
adj=0.7071*max_adj_square;
s=(1+ sin(360*$t))/2; //this is for animation
////////////////////////////////////////
if (show==6 ) body();
if (show==5 ) body();
if (show==0 ) body();
if (show==7 ) cover();
if (show==6 ) translate([-(square/2)+thread_dia/2+2,0,((thickness-1)/2)+1])  adjuster();
if (show==5 )translate([-(square/2)+thread_dia/2+2,0,((thickness-1)/2)+1])adjuster();
  
//seg1 moving
 if (show==6 ) translate([-square/2,(square/2)-square-adj*s,1])seg1() ; 
 // seg2 moving
 if (show==6 ) rotate([0,0,90]) translate([-square/2,(square/2)-square-adj*s,1])seg1() ; 
// seg3 moving
 if (show==6 ) rotate([0,0,180]) translate([-square/2,(square/2)-square-adj*s,1])seg1() ; 
// seg4 moving
  if (show==6 ) rotate([0,0,270]) translate([-square/2,(square/2)-square-adj*s,1])seg1() ; 

module adjuster (){
  rotate([0,360*s,0]){  
  color( "grey", 1.0 ) {
//threaded shaft       
   rotate([90,0,0])   cylinder(h=square+add_0n+2, d1=thread_dia, d2=thread_dia, center=true);
//nut1
  translate([0,-(square/2)-add_0n/2,0])  rotate([90,0,0])   cylinder(h=5, d1=thread_dia*2.5, d2=thread_dia*2.5, center=false,$fn=6);
//nut2
  translate([0,(square/2)+5+add_0n/2,0])  rotate([90,0,0])   cylinder(h=5, d1=thread_dia*2.5, d2=thread_dia*2.5, center=false,$fn=6);
        }
    }     
}

module cover(){
  difference(){   
       union(){
 translate([0,0,thickness+0.1]) 
 linear_extrude(height=1.5)   
 round2d(thread_dia,0){
 square([square+8,square+8],true);
 square([square+thread_dia*4,thread_dia*3],true);
 }
 }
 //hole in cover
    cylinder(h=thickness*5, d1=hole_dia, d2=hole_dia, center=true);
// 2 fixing holes in cover
translate([square/2+4,0,1]) cylinder(h=50,d1=thread_dia,d2=thread_dia);
translate([-(square/2+4),0,1]) cylinder(h=50,d1=thread_dia,d2=thread_dia);
 }
 }
 
if (show==1){
//segment 1 in position
  difference(){
 translate([-square/2,-square/2,1]) seg1();
  translate([-(square/2)+thread_dia/2+2,0,((thickness-1)/2)+1])  rotate([90,0,0])   cylinder(h=square*2, d1=tap_hole_size, d2=tap_hole_size, center=true);
               
  }
}

if (show==5){
//segment 1 in position
  difference(){
 translate([-square/2,-square/2,1]) seg1();
  translate([-(square/2)+thread_dia/2+2,0,((thickness-1)/2)+1])  rotate([90,0,0])   cylinder(h=square*2, d1=tap_hole_size, d2=tap_hole_size, center=true);
  }
}

if (show==2){
//segment 2 in position
difference(){
 translate([-square/2,-square/2,1]) rotate([0,0,90]) translate([0,-square,0]) seg1();
 clearance ();
}
}


if (show==5){
//segment 2 in position
difference(){
 translate([-square/2,-square/2,1]) rotate([0,0,90]) translate([0,-square,0]) seg1();
 clearance ();
}
}

if (show==3){
//segment 3 in position
 translate([square/2,square/2,1]) rotate([0,0,180]) seg1();
}
if (show==5){
//segment 3 in position
 translate([square/2,square/2,1]) rotate([0,0,180]) seg1();
}

if (show==4){
//segment 4 in position
difference(){
translate([-square/2,square/2,1]) rotate([0,0,-90])  seg1();
 clearance ();
}
}

if (show==5){
//segment 4 in position
difference(){
translate([-square/2,square/2,1]) rotate([0,0,-90])  seg1();
 clearance ();
}
}

module clearance (){
hull(){
  translate([-(square/2)+thread_dia/2+3,0,((thickness-1)/2)+1])  rotate([90,0,0])   cylinder(h=square*2, d1=thread_dia, d2=thread_dia, center=true);
  translate([-(square/2)+thread_dia/2-20,0,((thickness-1)/2)+1])  rotate([90,0,0])   cylinder(h=square*2, d1=thread_dia, d2=thread_dia, center=true);
 }
}

module seg1(){
difference(){
    color( "skyblue", 1.0 )
cube([square/2,square,thickness-1],false);
translate([0,0,thickness/2-.5]) rotate([0,0,45])cube([max_adj_square*50,max_adj_square,thickness],true);
  translate([0,0,-0.5]) rotate([0,0,-45]) cube([square,square,thickness]);
   translate([square/2+adj,square/2+adj,thickness/2-0.5]) rotate([0,0,-45]) cube([max_adj_square*50,max_adj_square,thickness],true);
    
   translate([square/2+adj,square/2+adj,-.1]) rotate([0,0,45]) cube([square,square,square]);
    
}
}

module body(){
difference(){
linear_extrude(height=thickness+0.3) the_shape();
translate([-square/2,-square/2,1]) cube([square,square,square],false);
     cylinder(h=thickness*5, d1=hole_dia, d2=hole_dia, center=true);

  translate([-(square/2)+thread_dia/2+2,0,((thickness-1)/2)+1])  rotate([90,0,0])   cylinder(h=square*2, d1=thread_dia, d2=thread_dia, center=true);
    
    translate([square/2+4,0,+3]) cylinder(h=50,d1=tap_hole_size,d2=tap_hole_size);
translate([-(square/2+4),0,+3]) cylinder(h=50,d1=tap_hole_size,d2=tap_hole_size);
}
}

//////""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


