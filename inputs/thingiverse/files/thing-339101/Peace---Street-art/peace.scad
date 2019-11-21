
//Thickness/height of sign
height = 3;
//Diameter of sign
diameter = 80;

//width of inner and outer walls
wall_thickness = 8;

/*[Magnet]*/
//Diameter of hole for inserting magnet
magnet_diameter = 10;
//Depth of hole for magnet
magnet_thickness = 2;


/*[Extra-advanced]*/
inside_resolution = 50;

outside_resolution = 50;
//for aligning rotated bars to center of ring 
delta_stick_move = sqrt(pow((wall_thickness/2),2)/2);

// preview[view:south west, tilt:top diagonal]

//outside ring
difference(){
	translate([0,0,height/2])
	cylinder(h = height, r = diameter/2, $fn = outside_resolution, center = true);
	translate([0,0,height/2 - 1])
	cylinder(h = height + 3, r = (diameter - wall_thickness*2)/2, $fn = inside_resolution, center = true);
}

//make hole for magnet
difference(){
//union body
union(){

//middlestick
translate([-diameter/2 + wall_thickness/2, -wall_thickness/2, 0]) 
cube([diameter - wall_thickness, wall_thickness, height]);

//first sidestick

translate([delta_stick_move,delta_stick_move,0])
rotate([0,0,135]) 
cube([diameter/2 - wall_thickness/2, wall_thickness, height]);

//second sidestick
mirror([0,1,0]){

translate([delta_stick_move,delta_stick_move,0])
rotate([0,0,135])
cube([diameter/2 - wall_thickness/2, wall_thickness, height]);
}

} //end of union for body

//magnet hole
translate([-wall_thickness/2,0,-2])
cylinder(h = magnet_thickness+2, r = magnet_diameter/2, $fn = 50);
}