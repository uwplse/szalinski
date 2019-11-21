//All measurements are in millimeters(mm)

//Wider on one side than another? Leave as no for a regular box shaped shim
type = "no";

//How much gap between wall and outlet box? Left side - When type=no is both left and right thickness
L_thickness = 12;	

//Right side - Unused when type=no
R_thickness = 9;	

//Width of outlet box
Box_width = 55;

//Height you want the shim as measured from the edge of the junction box
Box_height = 10.5;

//Thickness of lip that inserts under the junction box, a "0" removes the lip
Lip_thick = 1.5;

//Length of Lip
Lip_length = 7;

//Size of hole radius
Radius = 2;

//Distance from edge of outlet box to the center of the screw hole
Hole_distance = 7.5;



if(type == "no")
{
translate([0,L_thickness,0])cube([Box_width,Lip_length,Lip_thick]);
difference(){
	cube([Box_width,L_thickness,Box_height]);
	translate([Box_width/2,-.00001,Hole_distance])	
	rotate([270,0,0])	
	cylinder(L_thickness+.00002,Radius,Radius);
	
}}
if(type == "yes")
{
cube([Box_width,Lip_length,Lip_thick]);
difference(){
polyhedron(
  points=[ [0,0,0],[0,-L_thickness,0],[0,-L_thickness,Box_height],[0,0,Box_height],																					//left side box
	[Box_width,0,0],[Box_width,0,Box_height],[Box_width,-R_thickness,Box_height],[Box_width,-R_thickness,0]],                          // right side box
  faces=[ [0,1,2],[0,2,3],												//left face
				[0,3,4],[3,5,4],              						//front face
          [3,2,5],[2,6,5],												//top face
				[2,1,6],[1,7,6],												//back face
				[0,4,1],[1,4,7],												//bottom face
				[4,5,6],[4,6,7] ]                         		//right face
 );
	translate([Box_width/2,(-(L_thickness+R_thickness)/2)-3,Hole_distance])	
	rotate([270,0,0])	
	cylinder(L_thickness+3,Radius,Radius);
	
}}