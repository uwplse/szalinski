// Licence: Creative Commons, Attribution
// Parametrized button battery clip holder

// Thingiverse user by bmcage
// Same idea as http://www.thingiverse.com/thing:48606 but 
// parametric


//what button battery should this hold
battery = "CR2032";  //[CR2032, AG13, custom]
//if custom battery, what is radius ?
custom_radius = 10; // [5:30]
//if custom battery, what is width ?
custom_width = 3; // [1:10]
//width of edges, hint: take 2*nozzle diameter of your printer
edge = 0.8;
//radius of the holes for wire
radwire = 0.6;


//number in x direction
rack_x = 1;
//distance in rack
rack_dist_x = 20;
//number in y directionuse 
rack_y = 1;
//distance in rack
rack_dist_y = 15;

use <utils/build_plate.scad>;
use <MCAD/fonts.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 


module divider(radius,width) {
  difference() {
    cylinder(r=radius+edge, h=edge+radwire,$fn=50);
    translate([-radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
    translate([radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
    translate([-radius/2, 1-radwire,edge]) cube([radius,2*radwire,2*radwire]);
    }  
  difference() {
    cylinder(r=radius+edge, h=edge+radwire+width,$fn=50);
    cylinder(r=radius, h=4*(edge+0.8+width),$fn=50, center=true);
    translate([0, 2*radius, width+edge+radwire]) cube([4*radius, 4*radius,2*width], center = true);
    }
  
}

module cap(radius,width) {
  difference() {
    translate([0,0,width+edge+radwire-0.01]) cylinder(r=radius+edge, h=edge+radwire,$fn=50);
    translate([-radius/2,-2,width]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
    translate([radius/2,-2,width]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);

    translate([-radius/2-radwire,-2,width]) cube([2*radwire, 2+radius,2*(edge+radwire)]);
    translate([+radius/2-radwire,-2,width]) cube([2*radwire, 2+radius,2*(edge+radwire)]);

    translate([0, 2*radius, width+2*(edge+radwire)-0.1]) cube([4*radius, 4*radius,2*(edge+radwire)], center = true);
    translate([-radius/2, -2-radwire,edge+width]) cube([radius,2*radwire,2*radwire]);
    }
}

module holder(radius, width) {
  translate([0,0,4+radius])
  rotate([90,0,45])
  union() {
    difference() {
      translate([-radius/2,-radius-4,0]) cube([radius, 4, width+2*(edge+radwire)]);
      translate([radius/4, -radius-edge-1.5,0])cylinder(r=radwire, h=2*(width+edge+10),center=true,$fn=50);
      translate([-radius/4, -radius-edge-1.5,0])cylinder(r=radwire, h=2*(width+edge+10),center=true,$fn=50);
      }
    divider(radius,width);
    cap(radius, width);
    //now a ring to hang it to something
    difference() {
      translate([0,radius+0.4+2*edge,0]) cylinder(r=0.4+2*edge, h=edge+radwire,$fn=50);
      translate([0,radius+0.4+2*edge,-0.8]) cylinder(r=radwire, h=2*(edge+0.8),$fn=50);
    }
  }
}


if (battery == "CR2032") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
       holder(10.8, 3.2);
   }
 }
}
if (battery == "AG13") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
    holder(6, 6.3);
   }
 }
}
if (battery == "custom") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
    holder(custom_radius,custom_width);
   }
 }
} 
