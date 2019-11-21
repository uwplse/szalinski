//fn = 100;

ellipse_length = 10.8;//[10.8,10.9,11,11.1,11.2,11.3,11.4,11.5]
ellipse_width = 6.8;//[6.8,6.9,7,7.1,7.2]
ellipse_height = 7;//[7,8,9]

thickness_of_the_walls = 0.08; //[0.08,0.1,0.15,0.2,0.25,0.3]
screw_hole_size = 3;//[1,2,3,4]
thumbsize = 20;//[15:20]

//cut the bottom of the ellipse by cube
cube_x = 2*ellipse_length*10;
cube_y = 2*ellipse_width*10;
cube_z = 2*ellipse_height*10;

//========================================//
module main_part()
{
difference()
{
//main ellipse part
scale([ellipse_length+1.3,ellipse_width+0.8,ellipse_height]) 
sphere(10);

//========================================//
//bottom cutting cube
translate([-cube_x/2-20,-cube_y/2-10,-cube_z*20/19])
cube([cube_x+100,cube_y+100,cube_z]);

//cutting main ellipse out
scale([ellipse_length-thickness_of_the_walls,ellipse_width-thickness_of_the_walls,ellipse_height-thickness_of_the_walls]) 
sphere(10);


//========================================//

//thumb hole
translate([9,ellipse_width*10+10,20])
scale([2,thickness_of_the_walls-0.7,1]) 
sphere(thumbsize);

//========================================//
//little finger hole
rotate([0,45,0])
translate([9,-ellipse_width*10-10,25])
scale([2,thickness_of_the_walls-0.7,1]) 
sphere(thumbsize);
//========================================//
//HANDLER HOLE
//left	
	rotate([90,90,90])
	translate([0,6,-170])
	cylinder(85,4,4,0);
//left	
	rotate([90,90,90])
	translate([0,-6,-170])
	cylinder(85,4,4,0);

rotate([90,90,90])
translate([-2*10-55,0,40])
cube([70,3,110]);
rotate([90,90,90])
translate([-2*10-55,55,30])
cube([70,3,130]);
rotate([90,90,90])
translate([-2*10-55,-55,30])
cube([70,3,130]);
//HORIZONTAL LINE
rotate([90,0,0])
translate([-2*10+30,2,-58])
cube([120,3,113]);
}

//BUTTON STICKS
	//side buttons
	translate([70,-35,0.5])	
	cube([10,10,41]);	
   translate([66,32,-2.5])	
	cube([10,10,40]);

//FRONT CONNECTORS
//RIGHT
difference(){
translate([20,59,-6])
cylinder(39,6,6,0);	
translate([20,59.5,-6])
cylinder(16.5,screw_hole_size,screw_hole_size,0);	
}
//CONNECTION TO THE WALL
linear_extrude(31)
translate([20,50,0])
polygon(points = [ [10,15],[-5,5],[-20,15.6]  ], paths=[[0,1,2,3]]);

//LEFT
difference()
{
translate([20,-59,-6])
cylinder(39,6,6,0);	
translate([20,-59,-6])
cylinder(16.5,screw_hole_size,screw_hole_size,0);	
}
//CONNECTION TO THE WALL
linear_extrude(31)
translate([20,-56,0])
polygon(points = [ [5,0],[14,-6],[-10,-10],[-5,0]  ], paths=[[0,1,2,3]]);

//BACK CONNECTORS
//RIGHT
difference()
{
translate([-82,36,-7])
cylinder(38,6,6,0);	
translate([-82,36,-7])
cylinder(16.5,screw_hole_size,screw_hole_size,0);	
}

//CONNECTION TO THE WALL
linear_extrude(30)
translate([-82,36,0])
polygon(points = [ [10,15],[5,-4],[-18,-10],[-5,5]  ], paths=[[0,1,2,3]]);

//LEFT
difference()
{
translate([-82,-36,-7])
cylinder(38,6,6,0);	
translate([-82,-36,-7])
cylinder(16.5,screw_hole_size,screw_hole_size,0);	
}
//CONNECTION TO THE WALL
difference()
{
linear_extrude(30)
translate([-82,-36,0])
polygon(points = [ [-14,5],[5,4],[10,-15]  ], paths=[[0,1,2]]);
}
}

scale(0.5)
{
main_part();
}