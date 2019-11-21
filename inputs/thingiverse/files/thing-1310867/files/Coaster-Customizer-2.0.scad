//use <write.scad>
//http://customizer.makerbot.com/image_surface?image_x=100&image_y=100

/* [Coaster] */
//Upper Image (150x150 pixels)
Upper_Logo = "Mets2.dat"; // [image_surface:150x150]
//Lower_Image (150x150 pixels)
Lower_Logo = "Mets.dat"; // [image_surface:150x150]

/* [Hidden] */
//Coaster diameter in mm
Coaster_diameter = 91; //[50:0.1:100]
//Base thickness in mm
Base_thickness = 5.8; //[2:0.1:10]     //5
//Cup Depression Width
Depression_diameter = 83; //[50:0.1:100]  //formerly 81.5
//Cup Depression Depth
Depression_depth = 20; //[10:0.1:40]
//Curve Radius
Curve_radius = 20.5; //[10:0.01:30]


//Coaster radius
Coaster_radius=Coaster_diameter/2;  
//Coaster radius
Depression_radius=Depression_diameter/2; 


///////////////////////program/////////////



difference(){
	union(){
		translate([0,0,0])
		cylinder(r=Coaster_radius,h=Base_thickness,$fn = 300);

		translate([0,0,-1])
		rotate_extrude(convexity = 20, $fn = 300)
		scale([1, .754, 1])
		translate([Curve_radius*2, 8.5, 0])
		
		circle(r = 4.5, $fn = 100);

	}
	//Top layer logo
	translate([0,0,5.4])	rotate([0,180,0])	scale([-.385, .385, 1.5])
		surface(file = Upper_Logo, center = true, invert = false);

	//Bottom layer logo
	translate([0,0,5.435])	rotate([0,180,0])scale([-.385, .385, 3])
		surface(file = Lower_Logo, center = true, invert = false);
	
	//Depression
	translate([0, 0, 5])
cylinder(r=Depression_radius,50,$fn = 100);
	translate([-100, -100, -30])cube([200, 200, 30],center=false); //cut off the bottom
	
}
