// Moravian Star illuminated
// Version 1.05   09.Nov.2015

// #########################################################################
// #########################################################################
// 
// 
// If you do not want to do the Makerbot Cusomizer its job, you can customize it yourself 
// by editing the following parameters in the sections below:
//
//     part
//     diameter_star
//     diameter_illumination
//     mounting_gap
//     radius_correction
//     length_candle_adpter 
//
//  
// #########################################################################
// #########################################################################


// preview[view:west, tilt:top diagonal]

/*[Common]*/
// Which part would you like to render? (Parts must be printed separately).
part = 1; //[1:Body Base, 2:Body Base Top, 3:Body Base Bottom, 4:Square Point, 5:Triangular Point, 6:Cover Cap, 7:Candle Adapter, 8:Mounter]

build_plate_selector = 4; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual,4:None]
build_plate_manual_x = 200; //[100:400]
build_plate_manual_y = 200; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/*[Star]*/

// Outer Diameter of the star
diameter_star = 130;
// Diameter of illumination equipment, bulb diameter
diameter_illumination = 12.6;
// Gap between the inner of pyramides and elevated mounting sections on body 
mounting_gap = 0.35;
//Radius correction for cover cap to fit to the body base
radius_correction = 0.3; //radius correction for cover cap

/*[Candle Adapter]*/
// only used if you want toprint a candle adapter
// How long should the caldle adapter be?
length_candle_adapter = 52;

/*[Hidden]*/
//##############################################################################
// The variables in this section should not be changed.
// They are needed for internal calculations
//
//
// translated variables
ds = diameter_star;
dk = diameter_illumination;
gap = mounting_gap;
rc = radius_correction;
lc = length_candle_adapter;


// calculated variables
w4_min = 7.96;  // minimal angle of inclination for square point
dtheor =(dk+1)*(1+1/sin(45)+1/tan(w4_min));
a = max(dtheor/(1+1/sin(45)+1/tan(w4_min)), ds/(1+1/sin(45)+1/tan(w4_min)));
v = 33/48; // height ratio triangular point / square point
hp4 = (ds - a - 2*a*sin(45))/2;  // height of square point
hp3 = v*hp4; // height of triangular point
bt = a +2*a*sin(45); // dimensions of body base
w4 = atan(a/2/hp4);
w3 = atan(tan(30)*tan(w4)/v);
d = 0.55;  // wall thickness of the points
t = 0.4; // reduction of wall thickness of body base
b = 5; // Länge Kabeldurchführung
//
//
//##############################################################################

print_object();

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module Body Base
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module body_base(){
mirror([0, 0 ,1])
difference(){
    union(){
        difference(){
        full();
        sphere(a/2+a*sin(45) + t, $fn = 128);
        }
    translate([0,0,-a/2-a*sin(45)-1.5])rotate([0, 0, 45])cylinder(h = 1.6, r = a/2/sin(45), $fn = 4);
    translate([0,0,-a/2-a*sin(45)-5])rotate(0, [0,0,1])cylinder($fn = 60, h = 5, r = ((dk+1)/2));
    }    
translate([0,0,-a/2-a*sin(45)-6])rotate(0, [0,0,1])cylinder($fn = 60, h = 7, r = dk/2);
}    
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module Body Base
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module pyramide3
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module pyramide3(){
 cylinder(a/2*tan(30)*tan(90-w3), a/2/cos(30), 0.5, $fn = 3);    
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module pyramide3
//+++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module pyramide4
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module pyramide4(){
 cylinder(a/2/tan(w4), a/2/sin(45), 0.5, $fn = 4);    
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module pyramide4
//+++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module Cover Cap
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module cover_cap(){
difference(){
difference(){
    union(){
         difference(){
            translate([0, 0, 3.5 ])
             union(){
                cylinder(h = a/2/tan(w4), r1 = (a+3.5)/2, r2 = 0.5, $fn = 4);
                cylinder(h = 5, r1 = (a+3.5)/2, r2 = 4,$fn = 60);
            }
            translate([0, 0, -0.5/sin(w4)])
            cylinder(h = a/2/tan(w4), r1 = (a+3.5)/2, r2 = 0.5, $fn = 4);
        }  
 cylinder(h = 3.5, r = (a+3.5)/2, $fn = 60);
    }
union(){
    translate([0, 0, -0.1])
    cylinder (h = 4.11, r=(dk+1)/2+rc, $fn = 128);
}
}
union(){
translate([0, 0, hp4-(1.3+0.5)/sin(w4)])cylinder(h = hp4, r = (a + 3.5)/2, $fn = 4); // obere Öffnung
}
}

}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module Cover Cap
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module Candle Adapter
// 
// Adapter for electric Christmas candles or candle chains
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module candle_adapter(){
   
        difference(){ 
            difference(){
            union(){
                cylinder(h = length_candle_adapter, r = (dk + 2)/2, $fn = 128);
                translate([0, 0, length_candle_adapter-6])cylinder(h = 6, r = (dk+3.5)/2, $fn = 128);    
                }
                union(){
                translate([0, 0, -1])cylinder(h = length_candle_adapter + 2, r = dk/2, $fn = 128);
                translate([0, 0, length_candle_adapter-5.9])cylinder(h = 6, r = (dk+1)/2+rc-0.25, $fn = 128);    
                }
            }
        translate([0, 0, length_candle_adapter-0.5])cylinder(h = 2, r1 = (dk+1)/2+rc, r2= dk/2+rc+1.75, $fn = 128);
        }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module Candle Adapter
//+++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module full
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module full(){
union(){
for (i = [0: 7]){        // 7 square mounting areas on equator
rotate(45+i*45, [0,0,1])
translate([0,-a*sin(45),0])c4();
}

translate([0, 0, -a*sin(45)])cube(a,true); // mounting point illumination


translate([0,0,a*sin(45)])rotate(a=[-90,0,0]) // square mounting area on pole
c4();   

for (i = [0: 3]){   //  8 square mounting areas on northern & southern hemispheres
rotate(i*90, [0,0,1])
translate([0,-a*sin(45),0])
    union(){
    translate([0,a/sin(45)/2-a/2,a/2])
    rotate(a=[-45,0,0])
    c4();
    translate([0,a/sin(45)/2-a/2,-a/2])
    rotate(a=[45,0,0])
    c4();    
}
}
    
for (i= [0 : 3]){ //  triangular mountin areas
    rotate(i*90,[0,0,1])
 union(){
    rotate([0,0,45])c3();
    rotate([0,0,45]) mirror([0,0,1])c3();
}
}
}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module full
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module c4
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module c4(){

// berechnete Variablen
a1 = (a/2/sin(45)-(d+gap)/sin(45));
a2 = a1-tan(15);

difference(){
        union(){
        cube(a, true);
        translate([0,-a/2,0])rotate(a=[90,0,0])rotate(a=[0,0,45])cylinder($fn=4,h=1, r1=a1, r2 = a2);
        }
        cube([(a2-2)/sin(45), 5*a2/sin(45), (a2-2)/sin(45)], true);
        }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module c4
//+++++++++++++++++++++++++++++++++++++++++++++++++++


//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module c3
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module c3(){

// berechnete Variablen
a1 = (a/2/cos(30)-(d+gap)/cos(60));
a2 = a1-tan(15)/cos(60);
r1 = a/2/cos(30);
w = atan(a*sin(45)/(a/2+a*sin(45)-a/2/sin(45)));
w1 = atan(0.5*a/(a/2+a*sin(45)));
w2 = 90-w-w1;
hx = (a/2+a*sin(45))/cos(w1)*cos(w2);
    rotate([0,-w,0])
    difference(){
    union(){
    cylinder($fn=3,hx, r=r1);
	translate([0,0,hx])cylinder($fn=3,h=1, r1=a1, r2 = a2);
    }
    cylinder($fn=3, hx+2, r = a2-1/cos(60));
}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module c3
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module mounter
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module mounter(){
    union(){
    cylinder(h = 2, r = a, $fn = 128);
    cylinder(h = a+2*a*sin(45)+6, r = (diameter_illumination-0.6)/2, $fn = 128);
    translate([0, 0, a+2*a*sin(45)+6])cylinder(h = 10, r1 = (diameter_illumination-0.6)/2, r2 = (diameter_illumination-0.7)/2, $fn = 4);
    }
  }
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module mounter
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module All
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module all(){
%union(){
translate([0, 0, a/2 + a*sin(45)+2])rotate([0,0,0])rotate([0, 0,45])cover_cap();
union(){
rotate([0,0,0])body_base();



for (i = [0: 7]){        // 8 squared points on equator
rotate(i*45, [0,0,1])
translate([a/2+a*sin(45), 0, 0])rotate([90, 0,90])rotate([0,0,45])pyramide4();
}
mirror([0,0,1])translate([0,0,a/2+a*sin(45)])rotate(a=[0,0,45]) // squared point on pole
pyramide4();
for (i = [0: 3]){   // squared points on northern / southern hemisphere
rotate(i*90, [0,0,1])
union(){
rotate([0, -45, 0])translate([a/2+a*sin(45), 0, 0])rotate([90, 0, 90])rotate([0,0,45])pyramide4();
rotate([0, 45, 0])translate([a/2+a*sin(45), 0, 0])rotate([90, 0, 90])rotate([0,0,45])pyramide4();
}
}
  
w = atan(a*sin(45)/(a/2+a*sin(45)-a/2/sin(45)));
for (i= [0 : 3]){ //  8 triangular points
    rotate(i*90,[0,0,1])
 union(){
    rotate([0,0,45])rotate([0,-90+w,0])translate([a/sin(w),0,0])rotate([0, 90, 0])rotate([0,0,60])pyramide3();
    mirror([0,0,1])
    rotate([0,0,45])rotate([0,-90+w,0])translate([a/sin(w),0,0])rotate([0, 90, 0])rotate([0,0,60])pyramide3();
}
}
}
}
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module All
//+++++++++++++++++++++++++++++++++++++++++++++++++++



//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module print object
//+++++++++++++++++++++++++++++++++++++++++++++++++++
module print_object(){

    if (part == 1)
    translate([0, 0, a/2 + a*sin(45) + 1])body_base();
    
    else
    if (part == 2)
     difference(){
    body_base();
    translate([0, 0, -2*a])cylinder(h = 2*a, r = 2*a, $fn = 60);    
    }
    
    else
    if (part == 3)
    mirror([0,0,1])difference(){
    body_base();
    cylinder(h = 2*a, r = 2*a, $fn = 60);
    }
    else
    if (part == 4)
     pyramide4();   
    
    else
    if (part == 5)
     pyramide3();   
    
    else
    if (part == 6)
     cover_cap();
 
     else
    if (part == 7)
     candle_adapter();
    
    else
    if (part == 8)
     mounter();
   
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end of module print object
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// module buid plate
//+++++++++++++++++++++++++++++++++++++++++++++++++++

//use this to include a build plate visualization in your openSCAD scripts. Very useful for things designed to be edited in Makerbot Customizer

//to use, either include or use <utils/build_plate.scad>

//then just call build_plate(); with the following arguments (also, you have to have a real object in your scene for this to render)

//putting 0 as the first argument will give you a Replicator 2 build plate
//putting 1 as the first argument will give you a Replicator 1 build plate
//putting 2 as the first argument will give you a Thingomatic build plate
//putting 3 as the first argument will give you a manually adjustable build plate (note: if you use this option, you need to specify your build plates X length (in mm) as the second argument and the Y length (in mm) as the third argument. eg. build_plate(3,150,120);)

/*

to give your user control of which build plate they see in Customizer, include the following code:

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

*/




//to see how this works, uncomment the following code

//build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//build_plate_manual_x = 100; //[100:400]
//build_plate_manual_y = 100; //[100:400]
//
//build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
//
//cube(5);


module build_plate(bp,manX,manY){

		translate([0,0,-.52]){
			if(bp == 0){
				%cube([285,153,1],center = true);
			}
			if(bp == 1){
				%cube([225,145,1],center = true);
			}
			if(bp == 2){
				%cube([120,120,1],center = true);
			}
			if(bp == 3){
				%cube([manX,manY,1],center = true);
			}
		
		}
		translate([0,0,-.5]){
			if(bp == 0){
				for(i = [-14:14]){
					translate([i*10,0,0])
					%cube([.5,153,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
					%cube([285,.5,1.01],center = true);
				}	
			}
			if(bp == 1){
				for(i = [-11:11]){
					translate([i*10,0,0])
						%cube([.5,145,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
						%cube([225,.5,1.01],center = true);
				}
			}
			if(bp == 2){
				for(i = [-6:6]){
					translate([i*10,0,0])
						%cube([.5,120,1.01],center = true);
				}
				for(i = [-6:6]){
					translate([0,i*10,0])
						%cube([120,.5,1.01],center = true);
				}
			}
			if(bp == 3){
				for(i = [-(floor(manX/20)):floor(manX/20)]){
					translate([i*10,0,0])
						%cube([.5,manY,1.01],center = true);
				}
				for(i = [-(floor(manY/20)):floor(manY/20)]){
					translate([0,i*10,0])
						%cube([manX,.5,1.01],center = true);
				}
			}
		}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++
// end ofmodule buid plate
//+++++++++++++++++++++++++++++++++++++++++++++++++++