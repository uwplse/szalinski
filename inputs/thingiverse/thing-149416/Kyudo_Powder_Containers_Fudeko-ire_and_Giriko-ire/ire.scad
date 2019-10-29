// Which parts would you like to see?
part = "both"; // [container:Container Only,lid:Lid Only,both:Both Container and Lid]

// What type of container would you like to make?
variant = 30; // [22:Giriko-ire(22mm),30:Fudeko-ire(30mm),35:Large Fudeko-ire(35mm)]
variant_radius=variant/2;

// How many sides?
shape = 8; // [8:Eight sides,12:Twelve sides,100:Round]

// How thick should the walls be? (mm)
wall_thickness = 2; // [1:4]

// Diameter of the string hole. (mm)
string_hole_diameter = 3; // [0:No hole,1:1mm,1.5:1.5mm,2:2mm,3:3mm,4:4mm,5:5mm]

// Diameter of the hole.
hole_diameter = 2; // [0:No hole,1:1mm,1.5:1.5mm,2:2mm,3:3mm,4:4mm,5:5mm]

// How much tolerance between the lid and container?
tolerance = 0.05; // [0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2,0.3,0.4,0.5]

angle_between_holes = shape==100?45:(360/shape);

half_angle_between_holes=angle_between_holes/2;

hole_radius = hole_diameter==0?0:hole_diameter/2;
string_hole_radius = string_hole_diameter==0?0:string_hole_diameter/2;

height = variant*2.5;
segment = height/3;
overlap = segment-(string_hole_diameter+4);


print_part();

module print_part() {
	if (part == "container") {
		container();
	} else if (part == "lid") {
		lid();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both() {
	translate([-(variant_radius+1), 0, 0]) container();
	translate([variant_radius+1, 0, 0]) lid();
}

module container() {
	difference(){
		union(){
			//outer shape
			cylinder(r=variant_radius, h=segment*2, $fn=shape); 
			//overlap cylinder
			translate([0, 0, segment*2]) cylinder(r=variant_radius-(wall_thickness+1+tolerance), h=overlap, $fn=50);
		}
		// inside of container
		translate([0, 0, string_hole_diameter+5])cylinder(r=variant_radius-(wall_thickness+1+tolerance)-2, h=(segment*2)+overlap+2, $fn=50);
		// hole
		translate([0, 0, segment*2+(segment/3)]) rotate([90,0,half_angle_between_holes+angle_between_holes+90]) cylinder(r=hole_radius, h=variant_radius+1, $fn=20);
		// marker
		translate([0, 0, segment*2-(segment/3)]) rotate([90,0,half_angle_between_holes+angle_between_holes+90]) translate([0,0,variant_radius-2]) cylinder(r=hole_radius, h=variant_radius+1, $fn=20);
		// string hole
		translate([0, 0, string_hole_radius+2]) rotate([90,0,half_angle_between_holes]) cylinder(r=string_hole_radius, h=variant+1,center=true, $fn=20);

	}
}

module lid() {
	difference(){
		// outer shape
		cylinder(r=variant_radius, h=segment, $fn=shape);
		// cut-out cylinder
		translate([0, 0, string_hole_diameter+4]) cylinder(r=variant_radius-(wall_thickness+1), h=overlap+1, $fn=50);
		// hole 
		translate([0, 0, segment/3*2]) rotate([90,0,half_angle_between_holes+90]) cylinder(r=hole_radius, h=variant_radius+1, $fn=20);
		// string hole
		translate([0, 0, string_hole_radius+2]) rotate([90,0,half_angle_between_holes]) cylinder(r=string_hole_radius, h=variant+1,center=true, $fn=20);
	}
}

