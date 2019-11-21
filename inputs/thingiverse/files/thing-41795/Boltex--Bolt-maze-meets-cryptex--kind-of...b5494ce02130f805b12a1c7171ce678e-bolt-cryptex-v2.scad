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

$fn=50*1+15*0;

// 23 lines
maze = [ 
[1,1,1,1,1,0,1,1,1,1,1,1,1,1],
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

// Tolerance
tolerance = 2;

// Primary diameter
core_diameter = 25+2;
// Inner tube wall thickness
body_wall = 5;

// The peg is what slides through the maze and this parameter defines how big it is!
peg_diameter = 6;
// Depth that the peg extends into the maze path
peg_length = 6;
path_width = peg_diameter + tolerance;			// the path 1/2 "width"

ring_thickness = path_width + 3;

bolt_length = 2*len(maze)*path_width;
row_height = bolt_length / len(maze);

bolt_diameter = core_diameter + peg_length + (max_len*peg_diameter)/3.1415;

bolt_diameter_capture = bolt_diameter * 1.25;
bolt_capture_length = ring_thickness * 1.25;


bolt_radius_high = bolt_diameter/2;							// the wall
bolt_radius_low = bolt_radius_high - peg_length;		// the path

// Type of accent with which to embellish the outer tube
accent = "diamond"; // [circle,heart,squiggle,diamond]


// Number of stacked 'accent' rings
accent_per_column = 4;
// Number of accents to place per ring
accent_per_row = 5;
// Angular shift to rotate successive accent rows
accent_shift = 0; //[0:360]

// Radial spacing for accents
accent_radius = bolt_length / accent_per_column;

// Number of "grips" on the bolt handle
grips = 12;

module accent()
{
	if(accent == "circle") {
	  	rotate([0,90,0]) cylinder(r=6,h=body_wall,center=true);
	} else if(accent == "diamond") {
		rotate([0,0,90]) rotate([0,45,0]) cube([10,body_wall,10],center=true); 
	} else if(accent == "heart") {
		rotate([180,0,0]) union() { union() { 
			rotate([0,90,0]) translate([0,-2,0]) cylinder(r=3, h=body_wall, center=true);		
			rotate([0,90,0]) translate([0,2,0]) cylinder(r=3, h=body_wall, center=true);
			}	
		hull() {
			union() { 
			rotate([0,90,0]) translate([2,-3,0]) cylinder(r=1, h=body_wall, center=true);		
			rotate([0,90,0]) translate([2,3,0]) cylinder(r=1, h=body_wall, center=true);
			}
			rotate([0,90,0]) translate([6,0,0]) cylinder(r=0.5, h=body_wall, center=true);
		}}
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
	translate([0,0,(i*row_height)])
	for(j = [0:len(maze[i])]) {
		rotate([0,0,j*360/(len(maze[i]))]) 
		union() { if(maze[i][j] == 0) {
			pie(radius=bolt_radius_high, thickness=row_height, angle=angle_1*1.1);
		} else {
			if(maze[i+1][j] == 0) {			
				union() { 
					pie(radius=bolt_radius_low, thickness=row_height, angle=angle_0*1.1);
					translate([0,0,0*row_height+row_height/4]) ledge(radius=bolt_radius_high, thickness=row_height/2, angle=angle_0*1.1);
				}
			} else {
				pie(radius=bolt_radius_low, thickness=row_height, angle=angle_0*1.1);
			}
		}
	  }
	}
}}
cylinder(r=bolt_radius_low-peg_length,h=bolt_length*2);
}
}

// Cap the end...
translate([0,0,-2*bolt_capture_length+path_width+1]) 
	difference() {
		cylinder(r=bolt_radius_high*1.5, h=bolt_capture_length-1);
		union() {
			for(i = [0:grips-1]) {
				rotate([0,0,i*360/grips]) translate([0,bolt_radius_high*1.5,-1]) rotate([0,0,90]) cylinder(r=5,h=bolt_capture_length+1);
			}
		}
	}

translate([0,0,-1*bolt_capture_length+path_width]) cylinder(r=bolt_radius_low, h=bolt_capture_length);


translate([core_diameter*4.5,0,0*bolt_length-6.5]) rotate([0*180,0,0]) union() { 

// the ring!/outer tube
// locking ring at base
translate([50,0,-ring_thickness-0.5-0.5]) 
union() { 
	difference() {
		cylinder(r=bolt_radius_high*1.45, h=ring_thickness+1);
		cylinder(r=bolt_radius_high+1+tolerance, h=ring_thickness*10.55,center=true);
	}
translate([-peg_length+bolt_radius_high+1,-peg_diameter/2,0]) cube([peg_length+2,peg_diameter+2,peg_diameter+2]);

// outer tube
union() {
	difference() { translate([0,0,0]) difference() {
		cylinder(r=bolt_radius_high+1.5*peg_length, h=bolt_length+2);
		translate([0,0,-10]) cylinder(r=bolt_radius_high+1+tolerance, h=bolt_length+2+20);
	}

	// make room for accents
	rotate([0,0,20]) for(i = [0:accent_per_column-1]) 
	{
		rotate([0,0,accent_shift+(360/accent_per_row)/2*i]) spin(no=accent_per_row, angle=360) translate([bolt_radius_high*1.5+15,0,accent_radius*i+accent_radius/1.5-10]) scale([20,2,2]) rotate([0,0,0]) accent();
	}
}
}

	// end caps on outer tube
	translate([0,0,bolt_length]) union() { 
		translate([0,0,-5]) cylinder(r=bolt_radius_high*1.5, h=5);
		spin(no=80, angle=360) translate([0,0,-7.5]) ledge(radius=bolt_radius_high*1.58, thickness=5, angle=4.5);
		translate([0,0,-15]) cylinder(r=bolt_radius_high*1.5, h=5);
		spin(no=80, angle=360) translate([0,0,-17.5]) ledge(radius=bolt_radius_high*1.58, thickness=5, angle=4.5);
	}	
}
}


// Support!
translate([0,0,-bolt_capture_length-ring_thickness/2+0.75]) rotate([0,0,20]) union() {

		translate([0,15,0]) cube([10,60,1+0.6]);
		rotate([0,0,-10]) translate([5,0,0]) cube([60,10,1+0.6]);
  		rotate([0,0,-10]) translate([0,-65,0]) cube([10,60,1+0.6]);
	   translate([-65,0,0]) cube([60,10,1+0.6]);
	difference() {
		cylinder(r=10+75, h=1+0.6);
		translate([0,0,-0.035]) cylinder(r=55, h=1+0.67);
	}
}

translate([169,0,-bolt_capture_length-ring_thickness/2+0.75]) union() {
	
   mirror([1,1,0]){ 
	 translate([0, 35, 0]) cube([10,40,1+0.6]);
	 translate([35,0,  0]) cube([40,10,1+0.6]);
	}
   translate([0,40,0]) cube([10,40,1+0.6]);
   translate([40,0,0]) cube([40,10,1+0.6]);

	difference() {
		cylinder(r=15+75, h=1+0.6);
		union() {
			translate([0,0,-0.035]) cylinder(r=55, h=1+0.67);
		}
	}
}
