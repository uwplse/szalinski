/* [Global] */

$fa = 3;
$fs = 0.3;

// the side of the z top mount when locking to the printer
side = "left"; // [left, right]

// whether or not to use add a filament holder spool
add_fila_holder = 1; // [1:true, 0:false]

// whether or not to include two holes to mount leds
add_leds = 1; // [1:true, 0:false]

// the thickness of the mount
thn = 7;

// the extra thickness on top of the stock mount from anycubic
thnplus = 3;

/* [Dimensions] */

// the first width of the mount
width1 = 48;

// the width of the left-out part of the framework
width2 = 29;

// the second width of the mount
width3 = 64;

// the last width of the mount
width4 = 18;

// the depth of the entire mount
depth  = 86.5;

// the first depth of the mount
depth1 = 43.5;

// the depth of the left-out part of the framework
depth2 = 9;

// the second depth of the mount
depth3 = 34;

// the diameter of the used screws
screw_d = 3.5;

// the diameter of the rods
rod_d   = 10;

// the distance from the left to the center of the rod
rod_x  = 15.5;

// the distance from the front to the center of the rods
rod_y   = 9;

/* [Filament Holder] */

// the radius of the filament spool
fila_r   = 100;
// the width of the filament spool
fila_w   = 70;

// the diameter of the hole in the filament spool
fila_d   = 20;

// the tilt of the spool holder around the x axis
fila_tx  = 30;
// the tilt of the spool holder around the y axis
fila_ty  = 30;

/* [LEDs] */

// the diameter of the leds
led_d   = 3.5;

// the tilt of the led around the x axis
led_tx  = 15;
// the tilt of the led around the y axis
led_ty  = 20;

// the radius of the cable support
led_cs_r = 4;

/* [Hidden] */

module part1()
{
	module add() {
		r=6;
		x0 = 0; x1 = add_fila_holder!=0 ? depth1+4*led_d : width1;
		y0 = 0; y1 = depth1;
		linear_extrude(height=thn)
		hull() {
			translate([x0+r, y0+r]) circle(r=r);
			translate([x1-r, y0+r]) circle(r=r);
			translate([x0  , y1-r]) square(r);
			translate([x1-r, y1-r]) square(r);
		}
		
		translate([rod_x, rod_y, thn])
			cylinder(d1=rod_d+thn/2, d2=rod_d, h=thnplus);
		
		
		if (add_fila_holder != 0) {
			//x0=0; x1=width1/2+fila_d/2;
			x0=0; x1=depth1;
			y0=0; y1=depth1;
			difference() {
				translate([0, 0, thn])
				linear_extrude(height=fila_r/2+50)
				hull() {
					translate([x0+r, y0+r]) circle(r=r);
					translate([x1-r, y0+r]) circle(r=r);
					translate([x0+r, y1-r]) circle(r=r);
					translate([x1-r, y1-r]) circle(r=r);
				}
				
				translate([x1-fila_d*3/5, y1-fila_d*3/5, fila_w/2+fila_r/2+13])
					rotate([fila_tx, -fila_ty, 0])
						cube([200, 200, fila_w], center=true);
			}
			translate([x1-fila_d*3/5, y1-fila_d*3/5, fila_r/2])
				rotate([fila_tx, -fila_ty, 0])
					cylinder(d=fila_d, h=fila_w+thn);
		}
	}
	module sub() {
		// rod
		translate([rod_x, rod_y, -0.4])
			cylinder(d=rod_d, h=thn+1);
	}
	
	difference() {
		add();
		sub();
	}
}

module part2()
{
	module add() {
		translate([(width1-width2-1)/2, depth1, 0])
			cube([width2, depth2, thn]);
	}
	module sub() {
		translate([(width1-1)/2, depth1+depth2/2, -1])
			cylinder(d=screw_d, h=thn+2);
	}
	
	difference() {
		add();
		sub();
	}
}

module part3()
{
	module add() {
		r=2;
		x0 = 0;
		x1 = width3 - width4;
		x2 = width3;
		y0 = depth1+depth2;
		y1 = y0 + 2*r;
		y2 = y0 + depth3;
		linear_extrude(height=thn)
		hull() {
			translate([x0  , y0  ]) square(r);
			translate([x2-r, y0  ]) square(r);
			translate([x0+r, y1-r]) circle(r=r);
			translate([x1+r, y2-r]) circle(r=r);
			translate([x2-r, y2-r]) circle(r=r);
		}
	}
	module sub() {
		translate([width3-width4/2, depth1+depth2+depth3/2, -1])
			cylinder(d=screw_d, h=thn+2);
		
		translate([width3-width4/2-depth2/2, depth1+depth2+depth3-depth2+1.5, -1])
			cube([depth2, depth2-1.5, thn+2]);
	}
	
	difference() {
		add();
		sub();
	}
}

module mount()
{
	module add() {
		color("orange") part1();
		color("green") part2();
		color("red") part3();
		
		color("red")
		if (add_leds != 0) {
			translate([width1-2*led_cs_r, depth1+depth2+1.5*led_cs_r, thn])
			rotate([90, -90, 0])
			difference() {
				cylinder(r=led_cs_r+thn/4, h=thn/2, center=true);
				cylinder(r=led_cs_r      , h=thn  , center=true);
				translate([1.4*led_cs_r, 0, 0])
				cube([led_cs_r, thn/4, thn], center=true);
			}
		}
	}
	module sub() {
		if (add_leds != 0) {
			x = add_fila_holder!=0 ? depth1+2.5*led_d : width1-1.5*led_d;
			translate([x, depth1-thn-led_d, thn/2])
				rotate([led_tx, -led_ty, 0])
					cylinder(d=led_d, h=thn+10, center=true);
			translate([x, depth1-thn-4*led_d, thn/2])
				rotate([-led_tx, -led_ty, 0])
					cylinder(d=led_d, h=thn+10, center=true);
		}
	}
	
	difference() {
		add();
		sub();
	}
}

if (true) {
	if (side == "left")
		mount();
	else if (side == "right")
		mirror([1, 0, 0])
			mount();
}

if (false) {
	difference() {
		cube([3*led_d, 3*led_d, thn]);
		translate([1.5*led_d, 1.5*led_d, thn/2])
				rotate([led_tx, -led_ty, 0])
					cylinder(d=led_d, h=thn+10, center=true);
	}
}
