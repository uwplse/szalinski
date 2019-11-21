//
// Yet Another Lego Duplo Brick Generator
// by Badger
// https://www.thingiverse.com/thing:3320303
//

// TODO for next version
//   - cleanse the parameters, make them parameters of the block to ease the use
//     as library

// rev 3.5
// - add the middle wall for bricks of width of 1
// - fine tuned more dimensions
// rev 3.4
// - fine tuned some dimensions
// rev 3.3
// - fixed the stud and inner cylinder shape

// based on:
// LEGO DUPLO BRICK GENERATOR
//
// Author: Emanuele Iannone (emanuele@fondani.it)
//
// Url: https://www.thingiverse.com/thing:3113862a

// and on
// Adjustable Improved Duplo Brick Generator with Text 
// https://www.thingiverse.com/thing:3122711



/* [Main] */

// Size along X axis (in studs)
// middle walls for bricks of width of 1 only if size of 1 is in x direction
X_size = 1;

// Size along Y axis (in studs)
Y_size = 2;


// (1 = standard brick height)
// (can be multiple of 0.5)
Height_factor = 0.5;
//Height_factor = 1;

// Brick type
Type = 0; //[0:Normal Brick, 1:Base Plate]

/* [Advanced] */
// Studs type
Studs = 3; // [0:No studs, 1:original studs 2:cut studs with thicker bottom 3:round studs]

// Add extended triangular support ridges
Extended_Ridges = 0; // [0:No extended ridges, 1:Add extended ridges]

// Size of a single stud (in mm)
base_unit = 15.88;
// Standard height of a block
std_height = 19.25;
// Vertical walls thickness
wall_thickness = 1.5;
// Top surface thickness
roof_thickness = 1.4;
// Stud outer radius
stud_radius = 4.67;
// height of the stud
stud_height = 4.6;
//stud wall thickness
stud_wall_thickness=1.3;
// height of the guiding section of the stud
stud_guide = 0.7;
// Internal cylinder outer radius
cyl_radius = 6.55;
// Internal cylinder thickness
cyl_thickness = 1;
// Ridge thickness
ridge_thickness = 1;
// Ridge extension (control grip)
ridge_width = 3.48;

// cylinder curve segments / complexity
curve_detail = 60; //[16:2:100]

// how curved or polygonal the above rounded corners are
corner_detail = 16; //[5:1:60]

// thickness of the body if the Base Plate mode selected (in mm)
base_plate_thickness = 2;


// Duplo has unsharp corners for safety, printing thinner layers improves roundness
rounded_corners = 1.0; //[0.0:0.1:2.0]

// Cuts in the internal cylider
internal_cylinder_cuts=0; // [0:No cuts, 1:Cuts added]

// Make the holes for underlaying block as shallow as possible
// usable for e.g. if you want to model something out the cube
full_body = 0; //[0:Hollow, 1:Full body]

// clearance betwen stud top and roof of ovelaying brick in case of full body
stud_clearance = 0.5;


brick(X_size, Y_size, Height_factor, Studs,Type);
//stud_extruded((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);

module brick(nx, ny, heightfact, stud_type=3,type=0) {
if (type==0){
	standard_brick(nx,ny,heightfact,stud_type);
	} else {
	base_plate(nx,ny,heightfact,stud_type);
	}
}

module base_plate(nx=1, ny=1, heightfact, stud_type=3) {
		
	dx = nx * base_unit;
	dy = ny * base_unit;
//	corners = base_plate_thickness/2-0.0001;
	corners = (rounded_corners >= (base_plate_thickness/2))?base_plate_thickness/2-0.0001:rounded_corners;
	
		union(){
		//body
		rcube([dx, dy, base_plate_thickness], corners);
//		cube([dx, dy, base_plate_thickness]);
		// Studs
		if (stud_type != 0) for (r=[0:nx-1])for (c=[0:ny-1]){
			if(stud_type == 1){
				stud((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
			}
			if (stud_type == 2) {
				stud_v2((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
			}
			if (stud_type == 3) {
				stud_extruded((base_unit/2) + r * base_unit, base_unit/2 + c *
base_unit, base_plate_thickness, stud_radius);
			}
		}
	}
}

module standard_brick(nx, ny, heightfact, stud_type=3) {
	height = heightfact * std_height;
	/* 
	 * heigh of the bottom part with holes
	 * it will be either half of std_height or 
	 * or height of the whole brick
	 */
	//hollow_height = (full_body == 1) ? (0.5 * std_height) : height;
	hollow_height = (full_body == 1) ? (stud_height+stud_clearance+roof_thickness) : height;
	dx = nx * base_unit;
	dy = ny * base_unit;

	union() {
		// Shell
		difference() {
			rcube([dx, dy, height], rounded_corners);
			translate(v=[wall_thickness, wall_thickness, -1]) {
				cube([dx - (wall_thickness * 2), dy - (wall_thickness * 2),
						hollow_height - roof_thickness + 1]);
			}
		}

		// Studs
		if (stud_type != 0) for (r=[0:nx-1])for (c=[0:ny-1]){
			if(stud_type == 1){
				stud((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
			}
			if (stud_type == 2) {
				stud_v2((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
			}
			if (stud_type == 3) {
				stud_extruded((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
			}
		}

		// Internal cylinders
		if (nx > 1 && ny > 1) for(r=[1:nx-1]) for(c=[1:ny-1]) {
			internal_cyl(base_unit * r, base_unit * c, hollow_height - roof_thickness + 0.1,
					hollow_height >= std_height ? 1 : 0);
		}

		//internal wall and ridges for width/height of 1
		if (nx == 1 && ny > 1) for(r=[1:ny-1]) {
		translate([wall_thickness,r*base_unit-wall_thickness/2,0])
		cube([base_unit-2*wall_thickness,wall_thickness,height-roof_thickness]);
		translate([base_unit/2-ridge_thickness/2,r*base_unit-wall_thickness,0])
		cube([ridge_thickness,2*wall_thickness,height-roof_thickness]);
		ridgeset(base_unit, r*base_unit, 180, 1, hollow_height);
		ridgeset(0, r*base_unit, 0, 1, hollow_height);
		} 
		

		// Ridges
		ridgeset(0, 0, 0, nx, hollow_height);
		ridgeset(dx, dy, 180, nx, hollow_height);
		ridgeset(0, dy, -90, ny, hollow_height);
		ridgeset(dx, 0, 90, ny, hollow_height);
	}
}

module stud(x, y, z, r){
	translate(v=[x, y, 1.875 + z]){
		difference(){
			cylinder(h=3.75, r=r, center=true, $fn=100);
			cylinder(h=4, r=r-stud_wall_thickness, center=true, $fn=100);
		}
	}
}

module stud_v2(x, y, z, r){


	translate(v=[x, y, 1.875 + z]){
		difference(){
			union(){
				cylinder(h=stud_height-stud_guide, r=r, center=true, $fn=curve_detail);
				translate([0,0,((stud_height)/2)]){color ("green") cylinder(h=stud_guide, r1=r, r2=r-(r*0.12), center=true, $fn=curve_detail);}}
			cylinder(h=(stud_height)*1.5, r1=r-1.2 - stud_wall_thickness, r2=r-stud_wall_thickness, center=true, $fn=curve_detail);
		}
	}
}



module stud_extruded(x=base_,y,z,r) {
inside_rim_radius=rounded_corners;
outside_rim_radius=rounded_corners;
	stud_edge_radius=0.7;
	translate(v=[x, y, z]){
		rotate_extrude($fn=64) {
			union (){
				translate([r-stud_wall_thickness,stud_height-stud_edge_radius,0])
square([stud_wall_thickness-stud_edge_radius,stud_edge_radius]);
				translate([r-stud_wall_thickness,0,0])
square([stud_wall_thickness,stud_height-stud_edge_radius]);
				translate([r-stud_edge_radius,stud_height-stud_edge_radius,0])
					difference(){
					circle(stud_edge_radius, $fn=16);
					translate([-2*stud_edge_radius,-stud_edge_radius,0])square(2*stud_edge_radius);
					}
					/* inner rim */
					translate([r-stud_wall_thickness,0,0])
					difference(){
					translate([-inside_rim_radius,0,0])square(inside_rim_radius);
					translate([-inside_rim_radius,inside_rim_radius,0])circle(inside_rim_radius, $fn=16);
					}
			/* outer rim */
//					translate([r,0,0])
//					difference(){
//					square(inside_rim_radius);
//					translate([inside_rim_radius,inside_rim_radius,0])circle(inside_rim_radius, $fn=16);
//					}
//				
			}
		}
	}

}

/*
 * draw internal cylinder
 * 
 * support    if 1, draw the supporting trianges
 */
module internal_cyl(x, y, h, support) {
int_cyl_corner_radius=0.6;
	translate(v=[x, y, 0]) difference() {
		union() {
			rotate_extrude($fn=100){
			union(){
				translate([0,int_cyl_corner_radius])square([cyl_radius,h-int_cyl_corner_radius]);
				square([cyl_radius-int_cyl_corner_radius,h]);
				translate([cyl_radius-int_cyl_corner_radius,int_cyl_corner_radius,0])circle(r=int_cyl_corner_radius, $fn=corner_detail);
			}
			}
//			cylinder(h=h, r=cyl_radius, $fn=100);
			if (support >= 1) {
				translate([0,0,h]) {
					rotate([-90,0,45]) linear_extrude(height = ridge_thickness, center=true)
						polygon([[-base_unit*0.7,0],[base_unit*0.7,0],[0,14]]);
					rotate([-90,0,-45]) linear_extrude(height = ridge_thickness, center=true)
						polygon([[-base_unit*0.7,0],[base_unit*0.7,0],[0,14]]);
				}
			}
		}
		cylinder(h=h*3, r=cyl_radius-cyl_thickness, center=true, $fn=100);           
		if (internal_cylinder_cuts == 1) {
			cube(size=[cyl_radius*2, 1, 10], center=true); 
			cube(size=[1, cyl_radius*2, 10], center=true); 
		}
	}
}

module ridgeset_orig(x, y, angle, n, height){
	translate([x, y, 0]) rotate([0, 0, angle]) {
		for (i=[1:2*n-1]){
			// Ridge
			translate([(i*base_unit - ridge_thickness)/2,0,0]) rotate([90,0,90]) {
				if (Extended_Ridges) {
					linear_extrude(height = ridge_thickness, center=true) 
						polygon([[0,height - std_height],[0,height],[10,height]]);
				}
				if (i % 2) cube([ridge_width, height, ridge_thickness]);
			}  
		}
	}
}

module ridgeset(x, y, angle, n, height){
	translate([x, y, 0]) rotate([0, 0, angle]) {
		for (i=[1:2*n-1]){
			// Extended Ridge 
			/*FIXME most likely not ported correctly from rounded_duplo_generator_with_text.scad*/
			translate([(i*base_unit - ridge_thickness)/2,0,0]) rotate([90,0,90]) {
				{translate([(wall_thickness-0.2),0,0]) { // keeps them from sticking out of outside rounded corners
														  if (Extended_Ridges && Height_factor > 1) {
															  linear_extrude(height = ridge_thickness, center=false) 
																  polygon([[0,height - std_height-roof_thickness],[0,height],[10,height]]);
														  }
													   //   if (i % 2) cube([ridge_width, height, ridge_thickness]);
														  if (i % 2)  
															  // standard ridge
															  // baa
															  union () {
																  translate([ridge_width-rounded_corners-wall_thickness,rounded_corners,0]) cylinder (r=rounded_corners,h=ridge_thickness, $fn=corner_detail);
																  translate([0,,0])cube([ridge_width-rounded_corners-wall_thickness, rounded_corners, ridge_thickness]);
																  translate([0,rounded_corners,0])cube([ridge_width-wall_thickness, height - rounded_corners, ridge_thickness]);
															  }}
				}  
			}}
	}
}


module rcube(Size=[10,10,10],b=1,center=false)
{
	//    b=b+0.00001;
	$fn=corner_detail;

	minkowski()
	{
		translate([b,b,b])cube(Size-[2*b,2*b,2*b]);
		sphere(r=b);
	}
}
