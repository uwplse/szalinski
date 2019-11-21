// Graber i3 xy belt holder v3.00 by ValterFC
// January / 2014

// ******************************************************
// Select your belt type *NOT TESTED*
// ******************************************************
//T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.8;

//T5 (strongly discouraged)
//belt_tooth_distance = 5;
//belt_tooth_ratio = 1.05;

//HTD3
//belt_tooth_distance = 3;
//belt_tooth_ratio = 1.05;

//MXL
//belt_tooth_distance = 2.032;
//belt_tooth_ratio = 0.94;

//GT2
belt_tooth_distance = 2; // [2.5:T2.5, 5:T5, 3:HTD3, 2.032:MXL, 2:GT2]
belt_tooth_ratio = 0.8; // [0.8:T2.5, 1.05:T5, 1.05:HTD3, 0.94:MXL, 0.8:GT2]

//call main function
main();


module main()
{
	//make_object 0:left, 1:rigth
	
	//translate([-105, -180, 0])
	//	linear_extrude(height=5, convexity=10)
	//		import(file = "graber_i3_y_mount.dxf");

	translate([-5, -39.45, 0]) cube([12, 22.9, 3.4]);

	//Y holder
	translate([0, 0, -11]) {
		//translate([-11.2,-28,width+1]) y_holder(0);
		translate([-11,-28,width+1]) y_holder(0);
		translate([+11,-28,width+1]) y_holder(1);
	}

	//X holder
	difference() {
		union() {
			translate([-30, -3.45, 0]) cube([60, 17.3, 3.4]);
			translate([-3.7, 0, -11])
				translate([-14,5,width+1]) x_holder(0);
		
			translate([3.5, 0, -11])
				translate([+14,5,width+1]) x_holder(1);
		}

		translate([-23.7, 6, 3.9]) rotate([180,0,0])
			cylinder( h=4, r=screw_hole_diameter/2, $fn=30);
		translate([23.5, 6, 3.9]) rotate([180,0,0])
			cylinder( h=4, r=screw_hole_diameter/2, $fn=30);
	}

}




/*Non customizer variables*/
length = 17+0;
width = 10+0;
thickness = 21+0;
extra = 0.2+0;
belt_width = 6+0.6;
belt_thickness = 1.2+0; // Excluding teeth height (0.9)
belt_pitch = belt_tooth_distance+0;
teeth_height = 1.1+0;
teeth_width = belt_tooth_ratio+0;
screw_hole_diameter = 3+0;
nut_diameter = 5+0.8;
nut_thickness = 2.5+0;

//for x holder
length_plus = 0+4;
length_xholder = length+length_plus; 
bolt_head_diam = 0+nut_diameter; //adjuste bolt head diameter
//trim block variables
trim_width = nut_thickness+0.5;
trim_pos = (length/2)-(trim_width/2);


//####################################################
// X
//####################################################
module x_holder(make_object) {
	difference()
	{
		roundedRect([length+length_plus,thickness-6,width], 2);

		//+++++++++++++++++++++++++++++++++++++++
		// belt top
		translate([(-length-length_plus)/2,((thickness+belt_thickness+teeth_height)/4)-teeth_height,width-belt_width-4])
			cube([length+length_plus,belt_thickness+6,belt_width+4]);

		// tooth top
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4),width-belt_width-4])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+4], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++


		//+++++++++++++++++++++++++++++++++++++++
		// belt button
		translate([(-length-length_plus)/2,((thickness+belt_thickness+teeth_height)/4)-(teeth_height+8.7),width-belt_width])
			cube([length+length_plus,belt_thickness,belt_width+1]);

		// tooth button
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4)-7.2,width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++



		// top bolt hole
		if (make_object == 1)
		{
			//plus hole (positive ou negative position)
			translate([+4+(length_plus/2),1,width+1]) rotate([180,0,0])
				cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);
		} else {
			//plus hole (positive ou negative position)
			translate([-4-(length_plus/2),1,width+1]) rotate([180,0,0])
				cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);
		}
	}
}




//####################################################
// Y
//####################################################
module y_holder(make_object) {
	length = 17+0;
	width = 10+0;
	thickness = 21+0;
	extra = 0.2+0;
	belt_width = 6+0.6;
	belt_thickness = 1.2+0; // Excluding teeth height (0.9)
	belt_pitch = belt_tooth_distance+0;
	teeth_height = 1.1+0;
	teeth_width = belt_tooth_ratio+0;
	screw_hole_diameter = 3+0;
	nut_diameter = 5+0.8;
	nut_thickness = 2.5+0;

	difference()
	{
		roundedRect([length,thickness,width], 2);

		//+++++++++++++++++++++++++++++++++++++++
		// belt top
		translate([-length/2,((thickness+belt_thickness+teeth_height)/4)-teeth_height,width-belt_width])
			cube([length,belt_thickness,belt_width+1]);

		// tooth top
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4),width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++


		//+++++++++++++++++++++++++++++++++++++++
		// belt button
		translate([-length/2,((thickness+belt_thickness+teeth_height)/4)-(teeth_height+8.7),width-belt_width])
			cube([length,belt_thickness,belt_width+1]);

		// tooth button
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4)-7.2,width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++


		translate([0,1,width+1]) rotate([180,0,0])
			cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);
	}
}






// from thingiverse.com/thing:9347
module roundedRect(size, radius)
{
	x = size[0]-radius;
	y = size[1];
	z = size[2];
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
  		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
			circle(r=radius);

		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
			circle(r=radius);

		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
			circle(r=radius);

		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
			circle(r=radius);
	}
}

