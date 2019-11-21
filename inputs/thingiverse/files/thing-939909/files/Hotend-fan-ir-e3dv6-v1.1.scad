//Adaptation of the orginal hotend fan mount for the mini Kossel
//Tony@think3dprint3d.com
//Gpl v3
//modified by dc42

include <configuration.scad>;

// Distance of each mounting hole from the centre of the effector
mountingCircleRadius=14.5;		// [12.2: Think3DPrint3D printed effector, 14.5: Robotdigg metal effector]

// Distance of back of IR sensor board from nozzle centre
IRBoardBackOffset=11.0;			// [8.0: E3Dv6 heater block w/thermistor, 11.0: heater block w/PT100 or thermocouple

/* [Hidden] */
barrel_radius = 11;
barrel_height = 26.2;
main_height = 39.0;

groove_radius = 6.0 + 0.1;
groove_height = 6.0 - 0.2;
ring_radius = 8;

fanVoffset=0;
fan_offset = 18;
nozzleHeight=58.1;


IRflangeThickness=6;
IRboardFixingCentres=21.11-2.70;
IRboardFixingOffset=IRBoardBackOffset+1.01;		// board is 1mm thick
IRboardFixingHeight=nozzleHeight-14.9-1.5;
IRboardWidth=24.6;
IRcutoutWidth=12.5;

m3VertExtraRadius=0.0;

overlap=0.01;

module hotend_fan() {
  difference() {
    union() {
      // Main body
      translate([0, 2 - fan_offset, 0])
        cylinder(r=22, h=main_height, $fn=8);
      // Groove mount body
      translate([0, 2, groove_height/2])
        cube([32, 20, groove_height], center=true);
      // Flange for IR sensor
      translate([-IRboardWidth/2,-IRboardFixingOffset-IRflangeThickness,IRboardFixingHeight-4])
        cube([IRboardWidth,IRflangeThickness,7]);
    }

    // Groove mount insert slot.
    translate([0, 10, 0])
      cube([2*(groove_radius+0.1), 20, 20], center=true);
    // Angle for second fan mount
//    translate([0, 28.2, groove_height/2+6]) rotate([60,0,0])
//        cube([41, 40, 20], center=true); 
    // Groove mount.
    cylinder(r=groove_radius+0.1, h=200, center=true, $fn=24);

    // E3Dv6 barrel.
    translate([0, 0, groove_height+overlap]) cylinder(r=ring_radius + 0.25, h=100, $fn=24);
    translate([-8.1,0,groove_height+overlap]) cube([2*8.1,100,100]);
    translate([0, 0, groove_height + 6]) cylinder(r=barrel_radius + 0.75, h=100, $fn=24);
    translate([-(barrel_radius+0.75),0,groove_height+6]) cube([2*(barrel_radius+0.5),100,100]);

    // Fan mounting surface and screws.
    translate([0, -50 - fan_offset, 0])
      cube([100, 100, 100], center=true);
    for (x = [-16, 16]) {
      for (z = [-16, 16]) {
        translate([x, -fan_offset, z+20+fanVoffset]) rotate([90, 0, 0]) 
          cylinder(r=m3_radius, h=16, center=true, $fn=12);
      }
    }
    // Air funnel.
    difference() {
      translate([0, -6- fan_offset, 20+fanVoffset+1])
        scale([1,1,0.9])
          rotate([-75, 0, 0])
            cylinder(r1=21, r2=0, h=35, $fn=36);
      translate([-50,-50,34.5]) cube([100,100,100]);
    }
    // Main mounting holes
    for (a = [60:60:359]) {
      rotate([0, 0, a]) translate([0, mountingCircleRadius, 0]) 
        cylinder(r=m3_radius+m3VertExtraRadius, h=(a==180) ? 10 : 12.5, center=true, $fn=12);
    }
    // IR board mount
	// fixing holes
   translate([-IRboardFixingCentres/2,-IRboardFixingOffset-overlap-IRflangeThickness,IRboardFixingHeight])
		rotate([-90,0,0]) cylinder(r=1.2, h=6+2*overlap, $fn=12);
   translate([IRboardFixingCentres/2,-IRboardFixingOffset-overlap-IRflangeThickness,IRboardFixingHeight])
		rotate([-90,0,0]) cylinder(r=1.2, h=6+2*overlap, $fn=12);
	// connector hole
	translate([-IRcutoutWidth/2,-25,main_height+overlap]) cube([IRcutoutWidth,50,50]);
  }

  //second fan mount
//  difference(){
//     translate([0, 13, groove_height/2+4]) rotate([60,0,0])
//        cube([40, 18, groove_height], center=true); 
	 //cutout for second fan
// 	 translate([0, 30, 20]) rotate([60,0,0])
//	 cylinder(r=19, h=30, center=true);
    // Groove mount insert slot.
//    translate([0, 10, 0])
//      cube([2*groove_radius, 20, 20], center=true);
//    translate([0, 10, groove_height + 0.02])
//      cube([2*(barrel_radius + 1), 20, 20], center=true);
   //smooth bottom
//    translate([0, 0,-10])
//      cube([50, 50, 20], center=true);
    //dont obstruct mountng holes
//    for (a = [-60:120:60]) {
//      rotate([0, 0, a]) translate([0, 12.5, 5]) 
//        cylinder(r=m3_radius, h=12, center=true, $fn=12);
//    }
//    translate([0, 13, groove_height/2+4])
//    rotate([-30,0,0])
//	   for (x = [-16, 16]) {
//        translate([x, 0, 4]) rotate([90, 0, 0]) 
//          cylinder(r=m3_radius, h=16, center=true, $fn=12);
//      }
//
//  }
}

hotend_fan();


/*
// Hotend barrel.
translate([0, 0, groove_height]) %
  cylinder(r=barrel_radius, h=barrel_height);

// 40mm fan.
translate([0, -5 - fan_offset, 20]) % difference() {
  cube([40, 10, 40], center=true);
  rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
}
// second40mm fan.

translate([0, 30, 20])
rotate([-30,0,0]) 
% difference() {
  cube([40, 10, 40], center=true);
  rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
}*/
