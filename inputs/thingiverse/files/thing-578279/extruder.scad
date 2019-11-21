include <configuration.scad>;
include <arc.scad>

// Based on "Makergear Filament drive goes Bowden" by Luke321
// http://www.thingiverse.com/thing:63674

/* [Global] */

// extra space to be added to some holes' radius, to avoid excessive tightness.
extra_radius=0.3;

// "Manual" removable support (so you don't have to do it in your slicer software)
manual_support = 1; //[0:false,1:true]

// filament size
filament_size = 0; //[0:1.75mm,1:3mm]

/* [Hidden] */

$fn=200;

filament_offset = 22.5;

filament_radius_3mm = 1.5;

filament_radius_175mm = 0.9;

pushfit_radius_3mm = 4.7;

pushfit_radius_175mm = 2.3;

module extruder() {
  rotate([90, 0, 0]) difference() {
    union() {
      //main cylinder
      translate([16,20,21]) rotate([90,0,0]) cylinder(h=20, r=17.5);

      //bearing mount
      translate([31,20,21]) rotate([90,0,0]) cylinder (h=20, r=8);

      //pushfit/pneufit mount
      translate([filament_offset, 6.5, 13])
        cylinder(r=7.5, h=20, center=true, $fn=6);

      //filament support
      translate([21.75,6.5,34]) rotate([0,0,0]) cylinder (h=8, r=3, $fn=12);

      //clamp
      translate([20, 0, 28]) cube([13, 20, 14]);
    
    }

    //pulley opening
    translate([16,21,21]) rotate([90,0,0]){
      cylinder (h=22, r=6.6);

      rotate([0,0,45]) {
        //translate([14,0,0]) cylinder(h=22, r=1.6, $fn=12);
        translate([0,14,0]) cylinder(h=22, r=1.6, $fn=64);
        translate([-14,0,0]) cylinder(h=22, r=1.6, $fn=64);
        translate([0,-14,0]) cylinder(h=22, r=1.6, $fn=64);
      }
    }

    //gearhead indentation
    translate([16,21,21]) rotate([90,0,0]) cylinder (h=3.35, r=11.25);

    //pulley hub indentation
    translate([16,20-2,21]) rotate([90,0,0]) cylinder (h=5.6, r=7);

    //bearing screws
    translate([31,21,21]) rotate([90,0,0]) cylinder (h=22, r=2.6, $fn=64);
    translate([31,22,21]) rotate([90,30,0]) cylinder (h=8.01, r=4.7+extra_radius, $fn=6);

    //bearing
    difference() {
      union() {
        translate([31,10.5,21]) rotate([90,0,0]) cylinder (h=7.25, r=8.5 + extra_radius);
        translate([31,9.5-5.25,21-8.25-2]) cube([20, 5.25, 18.5]);
        //opening between bearing and pulley
        translate([20,9.5-5.25,21-8.25+3.25+1]) cube([10, 5.25, 8]);
      }
      //removable supports
      if (manual_support==1) {
        for (z = [15:3:27]) {
          translate([36, 10, z]) cube([20, 20, 0.5], center=true);
        }
      }
    }

    //filament path chamfer
    if (filament_size==0) {
      translate([filament_offset,6.5,15]) rotate([0,0,0]) 
      cylinder(h=3, r1=0.5, r2=3, $fn=64);
    } else {
      translate([filament_offset,6.85,14.2]) rotate([0,0,0]) 
      cylinder(h=3, r1=1.4, r2=3, $fn=64);
    }

    //filament path
    if (filament_size==0) { //1.75
      translate([filament_offset,6.5,-10]) rotate([0,0,0]) # cylinder(h=60, r=filament_radius_175mm+extra_radius, $fn=64);
    } else {
      translate([filament_offset,6.5,-10]) rotate([0,0,0]) # cylinder(h=60, r=filament_radius_3mm+extra_radius, $fn=64);
    }

    //pushfit/pneufit mount
    if (filament_size==0) { // 1.75mm
      translate([filament_offset, 6.5, 0]) # cylinder(r=pushfit_radius_175mm, h=8, $fn=64);
    } else {
      translate([filament_offset, 6.5, 0]) # cylinder(r=pushfit_radius_3mm, h=8, $fn=64);
    }

    //clamp slit
    translate([25,-1,10]) cube([2, 22, 35]);
    //clamp nut
    translate([10.5,12,38]) rotate([0,90,0])
      cylinder(h=11, r=m3_nut_radius, $fn=6);
    //clamp nut 2
    translate([10.5,3,38]) rotate([0,90,0])
      cylinder(h=11, r=m3_nut_radius, $fn=6);
    //clamp screw hole
    translate([15,12,38]) rotate([0,90,0])
      cylinder(h=20, r=m3_wide_radius, $fn=64);
    //clamp screw hole 2
    translate([15,3,38]) rotate([0,90,0])
      cylinder(h=20, r=m3_wide_radius, $fn=64);

  }
   
}

module hinges() {
// hinges
  translate([31,-7,0]) difference(){
    cylinder(h=20,r=5);
  }
}

module stripedcircle() {
  difference() {
    cylinder(h=1,r=5.1);
    if (manual_support==1) {
      translate([-4.92,-6,-0.1]) cube([.6,12,1.2]);
      translate([-2.3,-6,-0.1]) cube([.6,12,1.2]);
      translate([0,-6,-0.1]) cube([.6,12,1.2]);
      translate([2.3,-6,-0.1]) cube([.6,12,1.2]);
      translate([4.92,-6,-0.1]) cube([.6,12,1.2]);
    }
  }
}

module hingeslits() {
  translate([31,-7,0]) {
    translate([0,0,-1]) cylinder(h=22,r=1.5);
    translate([0,0,5]) stripedcircle();
    translate([0,0,10]) stripedcircle();
    translate([0,0,15]) stripedcircle();
    translate([0,0,15]) rotate([0,0,5]) arc(height=1,depth=6,radius=6,degrees=50);
    translate([0,0,10]) rotate([0,0,-55]) arc(height=1,depth=6,radius=6,degrees=110);
    translate([0,0,5]) rotate([0,0,5]) arc(height=1,depth=6,radius=6,degrees=50);
    if (filament_size==0) {
      translate([0,0,-0.1]) rotate([0,0,-55]) arc(height=1,depth=6.1,radius=6,degrees=110);
    } else {
      translate([0,0,-0.1]) rotate([0,0,-55]) arc(height=1.1,depth=5.1,radius=5.1,degrees=130);
    }
  }
}

difference () {
  union() {
    extruder();
    hinges();
  }
  hingeslits();
  if (filament_size==1) {
      rotate([90,0,0]) translate([filament_offset, 6.5, 0]) cylinder(r=pushfit_radius_3mm, h=8, $fn=64);
  }
}