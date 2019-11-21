// Licence: Creative Commons, Attribution
// Created: 02-03-2013 by bmcage http://www.thingiverse.com/bmcage

// An attempt to reproduce a screw box that nicely closes

//thickness of the cup in mm
thickness = 3;  //[1:5]

//diameter of the box in mm
diam = 40;    //[25:200]

//height of the inside box in mm
height = 45;   // [4:200]

//height of the screw part in mm
//Make sure this is less than height!
screwh = 45;   // [4:200]

//amount of twist of the screws over the screw height in degrees
screw_twist = 100;  // [0:200]

//number of petals for the screw part
screwpetals = 3; // [2:6]

//text to but at bottom
logotext = "Ingegno.be";

//height letters in mm. Width spans the cap, added spaces to make letters smaller in width, use this setting for height.
letterheight = 12;   //[4:50]

//in case you want dualstrusion used for the text, the text only is given as a part
part = "box";  //[text, box]

//add reinforcement to the petals or not
reinforce = "yes";   // [yes, no]

//rotate petals clockwise or anti-clockwise
clockwise = "no";  // [yes, no]

//height of the base. Make sure you have sufficient grip to open the box, and the base is sufficiently strong to hold contents of the box. height-screwh+baseh should be 5mm or more. 
baseh = 3;         //[2:5]

//resolution, if cylinders appear blocky, increase the resolution. Note that high values lead to long rendering times
res = 80;

//Add some clearance between petals if they are too connected when creating a box. This is expressed in degrees. A good printer should work fine leaving this 0, using some sand paper to have good rotation. But if you print at layers of 0.4 mm, set this to 1 or 2.
clearance = 0;

use <utils/build_plate.scad>;
use <MCAD/fonts.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 

//code begins, dummy module to indicate this
module test(){
  echo("test");
}

//process the text, we have diam-4 for the symbol, use beta_2 for border!
thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];
theseIndicies=search(logotext,thisFont[2],1,1);
wordlength = (len(theseIndicies));

factorygap = 3;
lettersize_x = (diam-4)/(wordlength+2);
scale_x =  lettersize_x / x_shift;
scale_y = letterheight / y_shift;
textheight = thickness/3;

module logo(){
  mirror([-1,0,0])
  translate([-diam/2+1.5*lettersize_x,-letterheight/2,-0.01])
    for( j=[0:(len(theseIndicies)-1)] )  
      translate([j*lettersize_x, 0 , 0])
        {
        scale([scale_x,scale_y,1]){
          linear_extrude(height=textheight) 
            polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
        }
      }
}

module base() {
  cylinder(r=diam/2, h=baseh, $fn=res);
}

realheight = height+baseh;  //base is added to inner box height
screwstart = height+baseh-screwh;

module box() {
  difference() {
    cylinder(r=diam/2, h=screwstart, $fn=res);
    translate([0,0,-0.01]) cylinder(r=diam/2-thickness, h=screwstart+0.02, $fn=res);
  }
}

stopperheight = 4;
stoppergap = 0.2;
stopperthickness = 2;

module stopper(){
  union() {
  translate([0,0,screwstart])
   difference() {
    cylinder(r=diam/2-thickness-stoppergap, h=stopperheight, $fn=res);
    translate([0,0,-0.01]) cylinder(r=diam/2-thickness-stopperthickness, h=stopperheight+0.02, $fn=res);
    }
  translate([0,0,screwstart-2*thickness/3])
   difference() {
    cylinder(r=diam/2-thickness+0.2, h=2*thickness/3, $fn=res);
    translate([0,0,-0.01]) cylinder(r1=diam/2-thickness-0.01,r2=diam/2-thickness-stopperthickness, h=2*thickness/3+0.02, $fn=res);
    }
  }
}

module wedge_180(r, d)
{
	rotate(d) difference()
	{
		rotate(180-d) difference()
		{
			circle(r = r, $fn=res);
			translate([-(r+1), 0, 0]) square([r*2+2, r+1]);
		}
		translate([-(r+1), 0, 0]) square([r*2+2, r+1]);
	}
}

module wedge(r, d)
{
	if(d <= 180)
		wedge_180(r, d);
	else
		rotate(d) difference()
		{
			circle(r = r, $fn=res);
			wedge_180(r+1, 360-d);
		}
}


module screwprofile(r, count) {
	angle = 360/count;

	union() {
		// "petals"
		for (i=[1:count]) {
			rotate([0,0,angle * i+clearance/2]) difference(){
           wedge(r = r, d=angle/2-clearance-0.01);
           rotate([0,0,-0.005]) wedge(r=r-thickness, d=angle/2-clearance);
           }
		}
	}
}

reinf_thick = 3;
module reinforceprofile(r, count) {
	angle = 360/count;
   anglereinf = 360/12;

	union() {
		// "petals"
		for (i=[1:count]) {
			rotate([0,0,angle * i+angle/4-anglereinf/4]) difference(){
           wedge(r = r-thickness+0.01, d=anglereinf/2-0.01);
           rotate([0,0,-0.005])wedge(r=r-thickness-reinf_thick, d=anglereinf/2);
           }
		}
	}
}

module petals(){
  union() {
  translate([0,0,screwstart-0.01]) 
  if (clockwise == "no") {
    linear_extrude(height = screwh, twist=screw_twist*-1, convexity = 10, $fn=res){
      screwprofile(diam/2, screwpetals);
      }
  } else {
    linear_extrude(height = screwh, twist=screw_twist, convexity = 10, $fn=res){
      screwprofile(diam/2, screwpetals);
      }
  }
  if (reinforce == "yes") {
   translate([0,0,screwstart-0.01]) {
    difference() {
     if (clockwise == "no") {
      linear_extrude(height = screwh, twist=screw_twist*-1, 
                     convexity = 10){
        reinforceprofile(diam/2, screwpetals);
        }
     } else {
      linear_extrude(height = screwh, twist=screw_twist, 
                     convexity = 10){
        reinforceprofile(diam/2, screwpetals);
        }
     }
     //remove the top part
     translate([0,0,screwh-stopperheight-0.2])
       cylinder(r=diam/2-thickness, h=stopperheight+0.2+0.02);
     //taper off at the bottom
     translate([0,0,-2/3*thickness]) cylinder(r1=diam/2-thickness-0.01,r2=diam/2-thickness-2*stopperthickness, h=2*2*thickness/3+0.02, $fn=res);
    }
   }
  }
  }
}

module sharpedgetop(r, count) { 
  angle = 360/count;
  unsharp = angle/20;
  translate([0,0,realheight-4]) 
   linear_extrude(height = 4+0.01, convexity = 10)
   union() {
     for (i=[1:count]) {
       if (clockwise == "no") {
			rotate([0,0,angle * i+screw_twist+angle/2-unsharp])
           difference(){ 
             wedge(r=r+1, d=angle/4);
             rotate([0,0,-0.1]) wedge(r=r/2, d=angle/4+0.2);
           }
       } else {
			rotate([0,0,angle * i-screw_twist-angle/2+angle/4+unsharp])
           difference(){ 
             wedge(r=r+1, d=angle/4);
             rotate([0,0,-0.1]) wedge(r=r/2, d=angle/4+0.2);
           }
       }
     }
   }
}

module sharpedgebase(r, count) { 
  angle = 360/count;
  unsharp = angle/20;
  translate([0,0,screwstart-0.01]) 
   linear_extrude(height = 4+0.01, convexity = 10)
   union() {
     for (i=[1:count]) {
       if (clockwise == "no") {
			rotate([0,0,angle * i+angle/4+unsharp]) 
           difference(){ 
             wedge(r=r, d=angle/4);
             rotate([0,0,-0.005]) wedge(r=r-thickness, d=angle/4+0.01);
           }
       } else {
			rotate([0,0,angle * i-unsharp]) 
           difference(){ 
             wedge(r=r, d=angle/4);
             rotate([0,0,-0.005]) wedge(r=r-thickness, d=angle/4+0.01);
           }
       }
     }
   }
}

if (part == "box") {
union() {
  difference() {
    base();
    logo();
  }
  stopper();
  box();
  difference() {
    petals();
    sharpedgetop(r=diam/2, count=screwpetals);
    }
  sharpedgebase(r=diam/2, count=screwpetals);
}
} else {
  logo();
}


