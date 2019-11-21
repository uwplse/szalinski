

//include <pins.scad>;

// Parametric round box by camperking v0.2
// http://www.thingiverse.com/thing:12134
// added option to screw the lid with a M3 screw
// improved thickness of the pin connectors
// usage is round_box(diameter, height, sections, wall_thickness, pin)
// diameter - is the diameter of your box
// height - defines the height of the box
// sections - how many sections you want
// wall_thickness - define your wallthickness, the pins height is 3 times the wallthickness
// pin - set to true if you want tbusers pin connector for the lid, set to false if you want to mount the lidwith a M3 screw
//
//usage for the lid is round_box_cover(diameter, sections, wall_thickness, pin)
// wall_thickness - this should be same value you have used at the box because the pinhole and pin height are calculated with this
//
//uncomment the following lines to test
//round_box(80, 20, 6, 1.2, true);
//round_box_cover(80, 6, 1.2, true);


/* [Global] */
part = "both"; // [first:Round Box only,second:Lid only,both:Box and lid]

Diameter = 80; // [10:250]
Height = 20; // [5:120]
Number_of_Sections = 6; // [0:32]
Pin_or_Hole = "Pin"; // [Pin, Hole]

/* [Hidden] */
diameter = Diameter;
height = Height;
sections = Number_of_Sections;
wall_thickness = 1.2;
pin = Pin_or_Hole;


if (part == "first") {
		round_box(diameter, height, sections, wall_thickness, pin);
	} else if (part == "second") {
		round_box_cover(diameter, sections, wall_thickness, pin);
	} else if (part == "both") {
      round_box(diameter, height, sections, wall_thickness, pin);
		translate([0, diameter+10, 0]) round_box_cover(diameter, sections, wall_thickness, pin);
	} else {
		both();
	}

module round_box(diameter, height, sections, wall_thickness, pin) {
	difference() {
		cylinder(h=height, r=diameter/2);
		if (pin == "Hole") {
			cylinder(h=height, r=1.25);
		}
		difference() {
			translate([0, 0, wall_thickness]) cylinder(h=height, r=diameter/2-wall_thickness);
			cylinder(h=height, r=4);
		}
		
	}
	for(i=[1:sections]) {
		rotate([0, 0, i * 360/sections]) translate([-wall_thickness/2, wall_thickness*2, 0]) cube([wall_thickness, diameter/2-wall_thickness*3, height]);
	}
	if (pin == "Pin") {
		translate([0, 0, height]) pin(h=wall_thickness*3);
	} 
}

module round_box_cover(diameter, sections, wall_thickness, pin) {
	difference() { union() {
		difference() {
			cylinder(h=wall_thickness*3, r=diameter/2);		
			difference() {
				cube([diameter, diameter, wall_thickness*3]);
				rotate([0, 0, 360/sections]) cube([diameter, diameter, wall_thickness*3]);
			}
		} 
			cylinder(h=wall_thickness*3, r=6);
		}
		if (pin == "Pin") {
			pinhole(h=wall_thickness*3);
		} else {
			cylinder(h=wall_thickness*3, r=1.5);
		}
	}
}





///////////////////////////////////////////////////////////////////////////
// Pin Connectors V2
// Tony Buser <tbuser@gmail.com>

// pinhole(h=5);

// test();
// pintack(h=10);
// pinpeg(h=20);

module test() {
  tolerance = 0.3;
  
  translate([-12, 12, 0]) pinpeg(h=20);
  translate([12, 12, 0]) pintack(h=10);
  
  difference() {
    union() {
      translate([0, -12, 2.5]) cube(size = [59, 20, 5], center = true);
      translate([24, -12, 7.5]) cube(size = [12, 20, 15], center = true);
    }
    translate([-24, -12, 0]) pinhole(h=5, t=tolerance);
    translate([-12, -12, 0]) pinhole(h=5, t=tolerance, tight=false);
    translate([0, -12, 0]) pinhole(h=10, t=tolerance);
    translate([12, -12, 0]) pinhole(h=10, t=tolerance, tight=false);
    translate([24, -12, 15]) rotate([0, 180, 0]) pinhole(h=10, t=tolerance);
  }
}

module pinhole(h=10, r=4, lh=3, lt=1, t=0.3, tight=true) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // t = tolerance
  // tight = set to false if you want a joint that spins easily
  
  union() {
    pin_solid(h, r+(t/2), lh, lt);
    cylinder(h=h+0.2, r=r);
    // widen the cylinder slightly
    // cylinder(h=h+0.2, r=r+(t-0.2/2));
    if (tight == false) {
      cylinder(h=h+0.2, r=r+(t/2)+0.25);
    }
    // widen the entrance hole to make insertion easier
    translate([0, 0, -0.1]) cylinder(h=lh/3, r2=r, r1=r+(t/2)+(lt/2));
  }
}

module pin(h=10, r=4, lh=3, lt=1, side=false) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  // side = set to true if you want it printed horizontally

  if (side) {
    pin_horizontal(h, r, lh, lt);
  } else {
    pin_vertical(h, r, lh, lt);
  }
}

module pintack(h=10, r=4, lh=3, lt=1, bh=3, br=8.75) {
  // bh = base_height
  // br = base_radius
  
  union() {
    cylinder(h=bh, r=br);
    translate([0, 0, bh]) pin(h, r, lh, lt);
  }
}

module pinpeg(h=20, r=4, lh=3, lt=1) {
  union() {
    translate([0, -h/4+0.05, 0]) pin(h/2+0.1, r, lh, lt, side=true);
    translate([0, h/4-0.05, 0]) rotate([0, 0, 180]) pin(h/2+0.1, r, lh, lt, side=true);
  }
}

// just call pin instead, I made this module because it was easier to do the rotation option this way
// since openscad complains of recursion if I did it all in one module
module pin_vertical(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness

  difference() {
    pin_solid(h, r, lh, lt);
    
    // center cut
    translate([-r*0.5/2, -(r*2+lt*2)/2, h/4]) cube([r*0.5, r*2+lt*2, h]);
    translate([0, 0, h/4]) cylinder(h=h+lh, r=r/2.5, $fn=20);
    // center curve
    // translate([0, 0, h/4]) rotate([90, 0, 0]) cylinder(h=r*2, r=r*0.5/2, center=true, $fn=20);
  
    // side cuts
    translate([-r*2, -lt-r*1.125, -1]) cube([r*4, lt*2, h+2]);
    translate([-r*2, -lt+r*1.125, -1]) cube([r*4, lt*2, h+2]);
  }
}

// call pin with side=true instead of this
module pin_horizontal(h=10, r=4, lh=3, lt=1) {
  // h = shaft height
  // r = shaft radius
  // lh = lip height
  // lt = lip thickness
  translate([0, h/2, r*1.125-lt]) rotate([90, 0, 0]) pin_vertical(h, r, lh, lt);
}

// this is mainly to make the pinhole module easier
module pin_solid(h=10, r=4, lh=3, lt=1) {
  union() {
    // shaft
    cylinder(h=h-lh, r=r, $fn=30);
    // lip
    // translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r2=r, r1=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r, r2=r-(lt/2), $fn=30);

    // translate([0, 0, h-lh]) cylinder(h=lh*0.50, r1=r, r2=r+(lt/2), $fn=30);
    // translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/3), $fn=30);    

    translate([0, 0, h-lh]) cylinder(h=lh*0.25, r1=r, r2=r+(lt/2), $fn=30);
    translate([0, 0, h-lh+lh*0.25]) cylinder(h=lh*0.25, r=r+(lt/2), $fn=30);    
    translate([0, 0, h-lh+lh*0.50]) cylinder(h=lh*0.50, r1=r+(lt/2), r2=r-(lt/2), $fn=30);    

    // translate([0, 0, h-lh]) cylinder(h=lh, r1=r+(lt/2), r2=1, $fn=30);
    // translate([0, 0, h-lh-lt/2]) cylinder(h=lt/2, r1=r, r2=r+(lt/2), $fn=30);
  }
}
