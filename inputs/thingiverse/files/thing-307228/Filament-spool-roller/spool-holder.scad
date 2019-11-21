//3D printer filament spool holder
//2014, John Stäck (john@stack.se)
//Licensed under Creative Commons attribution share-alike

//Default dimensions are for 608 bearings (plain skateboard/inline bearings)

/* [Parameters] */

//Width of "buffers"
buffer_width = 1.5; 

//Distance between axle centers. 100mm is reasonable for 20cm diameter spools and works down to 12cm
axle_distance = 100;

//Wall thickness
thickness = 3.5;

//Width of walls outside of bearings
clearance = 1.5;

//Number of segments for circles
$fn=72;

/* [Bearing dimensions] */

//Bearing outer diameter
bearing_diameter = 22;

//Bearing width
bearing_width = 7;

//Bearing axle (inner) diameter
axle_diameter = 8;

//Diameter of bearing "inner tube", for washer/buffer
washer_diameter = 11.5;



total_width = thickness*2+bearing_width+buffer_width*2;
total_length = axle_distance + bearing_diameter + clearance*2;

module endplate()
{
	rotate([-90,0,0]) translate([0,-bearing_diameter/2-clearance-thickness,0]) {
	 	difference() {
			union() {
				//Circle to cover bearing
				cylinder(r=bearing_diameter/2+clearance, h=thickness);
			
				//"Leg"
				translate([-bearing_diameter/2-clearance,0,0])
					cube([bearing_diameter+clearance*2, bearing_diameter/2+clearance+thickness, thickness]);

				//Buffer/washer part, angled 45 degrees
				translate([0,0,thickness])
					cylinder(r1=(washer_diameter+buffer_width)/2,r2=washer_diameter/2,h=buffer_width);
			}
			//Center hole
			translate([0,0,-0.1])
				cylinder(r=axle_diameter/2,h=thickness+buffer_width+0.2);
		}
	}
}

//Endplates in four corners
endplate();
translate([axle_distance,0,0]) endplate();
translate([0,total_width,0]) rotate([0,0,180]) endplate();
translate([axle_distance,total_width,0]) rotate([0,0,180]) endplate();

//Bottom plate
translate([-bearing_diameter/2-clearance,0,0]) cube([total_length, total_width, thickness]);

//Edges along bottom plate
translate([-bearing_diameter/2-clearance,0,0]) cube([total_length, thickness, thickness*2]);
translate([-bearing_diameter/2-clearance,total_width-thickness,0]) cube([total_length, thickness, thickness*2]);