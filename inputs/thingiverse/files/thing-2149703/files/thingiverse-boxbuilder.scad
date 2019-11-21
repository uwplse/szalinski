use <MCAD/boxes.scad>

// Choose Part
part = "both"; // [first:Case Only,second:Cover Plate Only,both:Both]

// Width of the case
width = 270;

// Depth of the case
depth = 150;

// Height of the case
height = 75;

// Material thickness of the case and plates
material_thickness = 5;

// Corner radius of rounded corners
corner_radius = 5;

// Hole offset
hole_offset = 10; //[1:14]

// Hole diameter
hole_diameter = 10;

print_part();

module print_part() {
	if (part == "first") {
		base();
	} else if (part == "second") {
		plate();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both(){
	base();
	translate([0,0,height])
		plate();
}

module base(){
	// All dimensions in mm
	x = width;
	y = depth;
	z = height;

	union(){
		for (i=[ [hole_offset,hole_offset, 0],
				[hole_offset,y-hole_offset, 0],
				[x-hole_offset,hole_offset, 0],
				[x-hole_offset,y-hole_offset, 0] ])
			{
			translate(i){
				linear_extrude(height=z){
					difference(){
						circle(r=(hole_diameter));
						circle(r=(hole_diameter/2));
					}
				}
			}
		}
		difference(){
			translate([x/2, y/2, height/2]){
			  roundedBox([x, y, height], 5, true);
			}
			translate([material_thickness, material_thickness, 0]) {
				linear_extrude(height=z)
				square(size = [x-(material_thickness*2), y-(material_thickness*2)], center = false);
		   	}
		}
	}
}


module plate(){
	// All dimensions in mm
	x = width;
	y = depth;
	z = material_thickness;

	difference() {
		// create the base
		translate([x/2, y/2, z/2]){
		  roundedBox([x, y, z], corner_radius, true);
		}
		// Create 4 holes
		for (i = [ [hole_offset,hole_offset, -10],
			[hole_offset,y-hole_offset, -10],
			[x-hole_offset,hole_offset, -10],
			[x-hole_offset,y-hole_offset, -10] ])
		{
			translate(i) {
				linear_extrude(height = z + 10)
				circle(r=(hole_diameter/2));
			}
		}
	}
}
