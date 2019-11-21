//Created by Ari M. Diacou, August 2013
//edited March 2014 (v1.1), March 2015 (v1.2)
//Shared under Creative Commons License: Creative Commons Attribution 4.0 International Public License (CC BY 4.0) 
//see http://creativecommons.org/licenses/by/4.0/
//v1.0 had 301 downloads - (version with union of 8 spheres, 12 cylinders, and 3 blocks)
//v1.1 had 206 downloads - (added hull(), corrected problem of missing faces in Thingiverse Customizer)
//v1.2 - removed extraneous calculations in hull of wedge(), and added some comments.

/* [Base] */
//How many blocks form a circle?
blocks_per_rev=20;
//Number of layers of blocks in the turret base
height=6;
//The height of each block in mm
block_height=8;
//The radial width of a block in mm
block_thickness=8;
//The internal radius of the turret in mm
turret_radius=20;
//The radius of curvature of the edges
curvature=1;
//How much curviness do you want?
$fn=20;
/* [Top] */
//Do you want a top?
care="yes";//[yes,no]
//Do 45 degree overhangs scare you?
noob="no";//[yes,no]
//How many blocks wide do you want the lookout stones?
factor=1.5;

//////////////////////////// Derived Constants //////////////////////////////
rad=turret_radius;
num=blocks_per_rev;

///////////////////////////////   Main()  ///////////////////////////////////
base();
if (care=="yes") {crown();}
/////////////////////////////// Functions ///////////////////////////////////
module base(){
	for(h=[0:height-1]){ //For loop going up
		rotate([0,0,90*(pow(-1,h))/num]) 
			translate([0,0,h*block_height]) 
				union(){
					for(i=[1:num]){ //For loop going around
					   rotate( i * 360 / num, [0,0,1])	
							wedge(turret_radius,block_thickness,360/num,block_height,curvature);
						}
					}
		}
	}

module crown(){
	phase=360/num*(ceil(factor)-factor)/2;
	if(noob=="no"){
		translate([2*rad+4*block_thickness,0,block_height]) union(){
			//The base
			translate([0,0,block_height*(-1.5)]) 
				cylinder(block_height,turret_radius+block_thickness,turret_radius+2*block_thickness, $fn=2*blocks_per_rev);
			//The blocks
			for(i=[1:num]){
				rotate( i * 360 / num, [0,0,1])	
					wedge(turret_radius+block_thickness,block_thickness,360/num,block_height,curvature);
				}
			//The crenelations
			for(i=[1:num/2]){
				translate([0,0,block_height])	
					rotate( phase+i * 720 / num, [0,0,1])	
						wedge(turret_radius+block_thickness,block_thickness,(360*factor)/num,block_height,curvature);
				}
			}
		}
	if(noob=="yes"){
		translate([2*rad+4*block_thickness,0,0*block_height]) union(){
			//The blocks
			for(i=[1:num]){
				rotate( i * 360 / num, [0,0,1])	
					wedge(turret_radius+block_thickness,block_thickness,360/num,block_height,curvature);
				}
			//The crenelations
			for(i=[1:num/2]){
				translate([0,0,block_height])	
					rotate( phase+i * 720 / num, [0,0,1])	
						wedge(turret_radius+block_thickness,block_thickness,(360*factor)/num,block_height,curvature);
				}
			}
		//The base
		translate([0,2*rad+4*block_thickness,-.5*block_height])
			cylinder(block_height,turret_rad7us+2*block_thickness,turret_radius+block_thickness,$fn=2*blocks_per_rev);
		}
	}

module wedge(inner,width,theta,thickness,curvature){
	//inner		=inner radius of arch
	//width		=width of block
	//theta		=angle subtended by block
	//thickness	=thickness of block
	//curvature	=roundedness of corners, should be less than all of: thickness, width and inner*sin(theta/2)
	//The block is made by a hull around 8 spheres. This function could be created with a minkowski combination of a sphere and a polyhedron, but the rendering time was horrific. It creates a wedge shaped block on the x axis which extends thickness/2 in each of the z-axis directions, and +theta degrees in the xy-plane
	outer=inner+width;
	r=curvature;
	
	
	//     A---------------D     ---
	//      \-------------/      /
	//       \-----------/      } Width
	//        \---------/      /
	//         B-------C --- ---
	//          \theta/  /
   //           \   /  } Inner (radius)
   //            \ /  /
   //             O ---

	//Angles describing the spheres positions must be recalculated so that the objects fit inside the angle called. Positions are translated to cartesian from cylindrical coorinates (r,theta,z). Because the inner spheres B and C subtend more angle, they requrire a different correction angle than outer spheres A and D.
	phi_o=atan(r/(outer-r));
	phi_i=atan(r/(inner+r));

	h=thickness-2*r;
	H=[0,0,h];

	//The principle vectors that define the centers of the spheres
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