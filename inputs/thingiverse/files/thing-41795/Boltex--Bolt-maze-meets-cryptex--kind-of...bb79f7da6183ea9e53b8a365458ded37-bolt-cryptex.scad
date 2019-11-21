// Parametric Bolt "Cryptex"
//  by seedwire
//
//  Modify the maze array to change the paths through the maze.
//   "0" means no path, "1" means path... a complete path requires
//   adjacent "1"s from top to bottom. The left and right edges do
//   wrap around, so, beware!
//
// The outer tube slides off when you complete the maze, exposing
//  the inner chamber.

// Thanks MCAD!
include <MCAD/utilities.scad>
include <MCAD/shapes.scad>

$fn=50*1;

// 23 lines
maze = [ 
[1,0,1,0,0,0,1,0,1,0,0,1,1,0],
[1,0,0,1,1,1,1,0,1,0,1,0,0,1],
[0,0,1,1,0,0,0,0,1,0,1,0,0,1],
[1,1,1,0,1,1,0,1,1,1,1,1,0,1],
[0,0,0,1,1,0,1,0,0,0,0,1,1,0],
[1,1,1,1,0,0,1,0,1,1,0,0,1,1],
[0,0,0,1,1,0,1,1,0,1,1,1,0,0],
[1,1,1,1,0,1,0,1,0,1,0,1,1,1],
[0,0,0,0,0,1,0,1,0,1,0,0,0,0],
[1,1,1,1,0,1,1,1,0,1,1,1,0,1],
[0,0,0,1,0,0,0,0,0,0,0,1,1,1],
[1,1,1,1,0,1,1,1,0,1,0,0,0,0],
[0,0,0,1,1,1,0,1,0,1,0,0,0,0],
[1,1,1,0,0,0,0,1,0,1,1,1,0,0],
[1,0,1,1,1,1,1,1,0,1,0,1,1,0],
[1,0,0,0,0,0,0,0,0,1,0,0,1,0],
[1,1,1,1,1,1,1,0,1,1,1,0,1,0],
[0,0,1,0,0,0,1,0,1,0,0,0,1,0],
[0,0,1,0,0,0,1,0,1,0,1,1,1,0],
[0,1,1,1,1,0,1,0,1,0,1,0,0,1],
[0,1,0,0,1,0,1,0,1,0,1,0,0,1],
[0,0,0,0,1,0,1,1,1,0,1,0,1,1],
[1,0,1,0,0,1,0,0,0,0,1,0,1,0]
			];

max_len = len(maze[0]);

// Primary diameter
core_diameter = 25;
//inner_diameter = 10;

// The peg is what slides through the maze and this parameter defines how big it is!
peg_diameter = 6;
// Depth that the peg extends into the maze path
peg_length = 6;

ring_thickness = 6.25 * 1;

bolt_length = 1.75*len(maze)*peg_diameter;
bolt_diameter = core_diameter + peg_length + (max_len*peg_diameter)/3.1415;

bolt_diameter_capture = bolt_diameter * 1.25;
bolt_capture_length = ring_thickness*1.25;

path_width = peg_diameter;			// the path 1/2 "width"

bolt_radius_high = bolt_diameter/2;							// the wall
bolt_radius_low = bolt_radius_high - peg_length;		// the path

// Type of accent with which to embellish the outer tube
accent = "squiggle"; // [circle,heart,squiggle,diamond]

// Inner tube wall thickness
body_wall = 5;
// Number of stacked 'accent' rings
accent_per_column = 4;
// Number of accents to place per ring
accent_per_row = 5;
// Angular shift to rotate successive accent rows
accent_shift = 0; //[0:360]

// Radial spacing for accents
accent_radius = bolt_length / accent_per_column;

module accent()
{
	if(accent == "circle") {
	  	rotate([0,90,0]) cylinder(r=6,h=body_wall,center=true);
	} else if(accent == "diamond") {
		rotate([0,0,90]) rotate([0,45,0]) cube([10,body_wall,10],center=true); 
	} else if(accent == "heart") {
		union() { 
			rotate([0,90,0]) translate([0,-2,0]) cylinder(r=3, h=body_wall, center=true);		
			rotate([0,90,0]) translate([0,2,0]) cylinder(r=3, h=body_wall, center=true);
			}	
		hull() {
			union() { 
			rotate([0,90,0]) translate([2,-3,0]) cylinder(r=1, h=body_wall, center=true);		
			rotate([0,90,0]) translate([2,3,0]) cylinder(r=1, h=body_wall, center=true);
			}
			rotate([0,90,0]) translate([6,0,0]) cylinder(r=0.5, h=body_wall, center=true);
		}
	} else if(accent == "squiggle") {
		hull() { rotate([0,90,0]) translate([0,2,0]) cylinder(r=2, h=body_wall, center=true);
		rotate([0,90,0]) translate([3,-2,0]) cylinder(r=2, h=body_wall, center=true);
		}
		hull() { rotate([0,90,0]) translate([3,-2,0]) cylinder(r=2, h=body_wall, center=true);
		rotate([0,90,0]) translate([6,2,0]) cylinder(r=2, h=body_wall, center=true);
		}
		hull() { rotate([0,90,0]) translate([6,2,0]) cylinder(r=2, h=body_wall, center=true);
		rotate([0,90,0]) translate([9,-2,0]) cylinder(r=2, h=body_wall, center=true);
		}
	} else {
		echo("****WARNING: Accent type is unknown - FAIL *****");
	}
}


module ledge(radius=1, thickness=1, angle=45)
{
 intersection() {
  intersection() { 
  rotate([0,0,angle/2]) difference() {
	translate([0,0,thickness/2]) sphere(r=radius, center=true);
	union() {
		translate([-(radius/2),0,0]) cube([radius,3*radius,3*radius], center=true);
		rotate([0,0,180-angle]) translate([-(radius/2),0,0]) cube([radius,5*radius,5*radius], center=true);
		
	}
  }
  cube([5*radius,5*radius,thickness], center=true);
  }
 rotate([30,0,0]) cube([1.10*radius,3*radius,radius*0.85], center=true);
 }
}

module pie(radius=1, thickness=1, angle=45)
{
 rotate([0,0,angle/2]) difference() {
	cylinder(r=radius, h=thickness, center=true);
	union() {
		translate([-(radius/2),0,0]) cube([radius,3*radius,3*radius], center=true);
		rotate([0,0,180-angle]) translate([-(radius/2),0,0]) cube([radius,3*radius,3*radius], center=true);
	}
 }	
}




angle_1 = 360/max_len;
angle_1_ch = bolt_radius_high * (angle_1 * 2 * 3.1415 / 360);
angle_0 = angle_1;

// Build up the maze with pie-slices
union() { difference() { union(){for(i = [0:len(maze)]) {
	translate([0,0,bolt_length-(i*path_width*2)])
	for(j = [0:len(maze[i])]) {
		rotate([0,0,j*360/(len(maze[i]))]) 
		union() { if(maze[i][j] == 0) {
			pie(radius=bolt_radius_high, thickness=path_width*2, angle=angle_1*1.1);
		} else {
			if(maze[i-1][j] == 0) {			
				union() { 
					pie(radius=bolt_radius_low, thickness=path_width*2, angle=angle_0*1.1);
					translate([0,0,path_width/2]) ledge(radius=bolt_radius_high, thickness=path_width, angle=angle_0*1.1);
				}
			} else {
				pie(radius=bolt_radius_low, thickness=path_width*2, angle=angle_0*1.1);
			}
		}
	  }
	}
}}
cylinder(r=bolt_radius_low-peg_length,h=bolt_length*2);
}
}

// Cap the end...
translate([0,0,-2*bolt_capture_length+path_width]) cylinder(r=bolt_diameter_capture/2, h=bolt_capture_length);

translate([0,0,-1*bolt_capture_length+path_width]) cylinder(r=bolt_radius_low, h=bolt_capture_length);


translate([core_diameter*4,0,bolt_length-2.5]) rotate([180,0,0]) union() { 

// the ring!/outer tube
// locking ring at base
translate([0,0,-ring_thickness/2]) 
union() { difference() {
		cylinder(r=bolt_radius_high*1.5, h=ring_thickness);
		cylinder(r=bolt_radius_high+1, h=ring_thickness*10.55,center=true);
	}
translate([-peg_length+bolt_radius_high,-peg_diameter/2,0]) cube([peg_length+2,peg_diameter+2,peg_diameter+2]);

// outer tube
union() {
	difference() { translate([0,0,ring_thickness]) difference() {
		cylinder(r=bolt_radius_high+2*peg_length, h=bolt_length+2);
		translate([0,0,-0.5]) cylinder(r=bolt_radius_high*1.5-8, h=bolt_length+2+2);
	}

	// make room for lamp accents
	rotate([0,0,20]) for(i = [0:accent_per_column-1]) 
	{
		rotate([0,0,accent_shift+(360/accent_per_row)/2*i]) spin(no=accent_per_row, angle=360) translate([bolt_radius_high*1.5-5,0,accent_radius*i+accent_radius/1.5]) scale([10,2,2]) rotate([0,0,0]) accent();
	}
}
}

// end cap on outer tube
translate([0,0,bolt_length+ring_thickness+2]) cylinder(r=bolt_radius_high*1.5, h=4);
}
}

// Support!
translate([0,0,-bolt_capture_length-3.8]) union() {
	mirror([1,1,0]){ 
		cube([10,60,0.6]);
		cube([60,10,0.6]);
	}
	   cube([10,60,0.6]);
	   cube([60,10,0.6]);
	difference() {
		cylinder(r=75, h=0.6);
		translate([0,0,-0.035]) cylinder(r=55, h=0.67);
	}
}


