//Created by Ari M. Diacou, August 2013
//Edited August 2014: Changed design to use hull around spheres, added base, fuctionalized stucture, rotated structure to be more easily buildable, made handle thickness more robust with geometric mean
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

//Number of wedge stones in the arch, odd number looks better
arch_num=7;
//The width of a block
width=12;
//How deep are the blocks?
thick=10;
//The width of the doorway
door_width=20;
//The height of a block
block_height=6;
//Number of blocks on each side
blocks_high=5;
//The radius of curvature of the corners, 0 for flat. Should be less than all of: thickness, width, and 0.5*width*sin(90/arch_num)
curve=1;
//Curviness of curves, recommend a multiple of 4.
$fn=20;
//Do you want a door?
include_door="yes";//[yes,no]
//The thickness of the door
door_thick=3;
//Do you want a base?
include_base="yes";//[yes,no]
//The height of the base as multiples of brick height
base_scale=1;
//When looking at the door face, the angle between the base's sides and base's bottom (90 is flat, zero is singular)
base_angle=70;


/* HIDDEN */
///////////////////////////  MAIN() ///////////////////////////////////
ri=door_width/2;
ep=0.001;
translate([0,0,block_height*blocks_high])
	rotate([90,0,0])
		door_without_base();
if(include_base=="yes"){
	color("grey") 
		base();
	}

///////////////////////////  FUNCTIONS() //////////////////////////////
module door_without_base(){
	arch();
	sides();
	if(include_door=="yes"){
		door();
		}
	}

module arch(){
	for ( i = [0 : arch_num-1] ){
   	color("grey")	
			rotate( i * 180 / arch_num, [0,0,1])	
				wedge(ri,width,180/arch_num,thick,curve);
		}
	}

module base(){
	x=door_width+2*width;
	y=thick;
	z=base_scale*block_height;
	base_adj=z*cos(base_angle)/sin(base_angle);
	translate([0,0,-z+ep])
		hull(){
			translate([0,0,z/2]) 
				cube([x,y,z],center=true); //the height and top of the base
			translate([-.5*x-base_adj,-.5*y-0.5*base_adj,0]) 
				cube([x+2*base_adj,y+1*base_adj,ep]); //the bottom of the base
			}

	}

module sides(){
	for (j = [1:blocks_high]){
		color("grey")	
			translate([ri+width/2,(.5-j)*block_height,0])	
				block(width,block_height+2*ep,thick,curve);
		color("grey")	
			translate([-ri-width/2,(.5-j)*block_height,0]) 	
				block(width,block_height+2*ep,thick,curve);
		}
	}

module door(){
	/*the handle thickeness is a geometric mean of 3 measures that make aesthetic sense*/
	m1=3*door_thick;
	m2=door_thick+2*curve;
	m3=.8*thick+.2*door_thick;
	handle_thickness=pow(m1*m2*m3,0.33);
	union(){
		color("sienna")	cylinder(door_thick,ri+2,ri+2,center=true);
		color("sienna")	translate([0,-block_height*blocks_high/2,0]) cube([(ri+curve)*2,block_height*blocks_high,door_thick],center=true);
		//the handle	
		color("black")	translate([-.75*ri,(ri-block_height*blocks_high)*0.6,0]) cube([ri/5,block_height,handle_thickness],center=true);
		}
	}

module wedge(inner,width,theta,thickness,curvature){
	//inner		=inner radius of arch
	//width		=width of block
	//theta		=angle subtended by block
	//thickness	=thickness of block
	//curvature	=roundedness of corners, should be less than all of: thickness, width and inner*sin(theta/2)
	//The block is made by taking a hull around 8 spheres. This function could be created with a minkowski combination of a sphere and a polyhedron, but the rendering time was horrific. It creates a wedge shaped block on the x axis which extends thickness/2 in each of the z-axis directions, and +theta degrees in the xy-plane
	outer=inner+width;
	r=curvature;
	
	//Angles describing the spheres positions must be recalculated so that the objects fit inside the angle called. Positions are translated to cartesian from cylindrical coorinates (r,theta,z). Because the inner spheres B and C subtend more angle, they requrire a different correction angle than outer spheres A and D.
	phi_o=atan(r/(outer-r));
	phi_i=atan(r/(inner+r));
	h=thickness-2*r;
	H=[0,0,h];
	//The principle vectors that define the centers of the spheres and cylinders
	A=[(outer-r)*cos(theta-phi_o), (outer-r)*sin(theta-phi_o),0]+H/2;
	B=[(inner+r)*cos(theta-phi_i), (inner+r)*sin(theta-phi_i),0]+H/2;
	C=[(inner+r)*cos(phi_i), (inner+r)*sin(phi_i),0]+H/2;
	D=[(outer-r)*cos(phi_o), (outer-r)*sin(phi_o),0]+H/2;
	//The complementary vectors which are below the z axis
	Ac=A-H;
	Bc=B-H;
	Cc=C-H;
	Dc=D-H;
	hull(){
		//The spheres which round the corners, notice the calling of translation vectors above
		translate(A) sphere(r,center=true);
		translate(B) sphere(r,center=true);
		translate(C) sphere(r,center=true);
		translate(D) sphere(r,center=true);
		translate(Ac) sphere(r,center=true);
		translate(Bc) sphere(r,center=true);
		translate(Cc) sphere(r,center=true);
		translate(Dc) sphere(r,center=true);
		}
	}

module block(width, height,thickness,curvature){
	//The block is made by taking a hull around 8 spheres. This function could be created with a minkowski combination of a sphere and a polyhedron, but the rendering time was horrific. 
	//Coorinates for the centers of the spheres and cylinders are recalculated based on the radius of curvature
	r=curvature;
	x=width/2-r; y=height/2-r; z=thickness/2-r;
	//The principle vectors that define the centers of the spheres and cylinders
	A=[-x,y,z];
	B=[x,y,z];
	C=[-x,-y,z];
	D=[x,-y,z];
	//The complementary vectors which are below the z axis
	Ac=[-x,y,-z];
	Bc=[x,y,-z];
	Cc=[-x,-y,-z];
	Dc=[x,-y,-z];
	
	hull(){
		//The spheres which round the corners, notice the calling of translation vectors above
		translate(A) sphere(r,center=true);
		translate(B) sphere(r,center=true);
		translate(C) sphere(r,center=true);
		translate(D) sphere(r,center=true);
		translate(Ac) sphere(r,center=true);
		translate(Bc) sphere(r,center=true);
		translate(Cc) sphere(r,center=true);
		translate(Dc) sphere(r,center=true);
		}
	}





