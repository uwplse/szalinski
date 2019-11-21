/* [Design Variables] */
//in mm
height = 20;
//in mm (set to measured value, clearance is added)
shaft_diameter =  6.1;
//in mm (set to measured value, clearance is added)
D_width = 4.7;
//in mm
outer_diameter = 36;
//in mm
wall_thickness = 3;
//in mm
inner_diameter = 14;
//in mm
shaft_length = 11;
//in mm
plunge_depth = 3;
//in mm
clearance_height = 8;

/* [Cosmetic Settings] */
no_sides =9;
//in mm (0 for no chamfer)
top_chamfer=1.5;

/* [Zero Pointer] */
with_pointer = "yes"; // [yes,no]
//in mm
point_size = 5;
//degrees clockwise from the flat side
point_angle = 90; 

/* [Additional Features] */
extra_feature="scollops"; // [none,scollops,taps,cutaway]
number_of_features=3;
//degrees
offset_angle=-30;

tap_height=3*1;
clearance = 0.1*1;
stiffener_thickness = 2*1; // mm
$fn = 	100*1;

module knob() {
	difference() {
		difference(){
			union() {
				difference() {
					overall_knob();
					hollow_torus();
				}
				internal_supports();
			}
			D_shaft_hole();
		}
		internal_clearance();
	}
}

module overall_knob() {
	union() {
		translate([0,0,top_chamfer]) cylinder(h=height-top_chamfer, r=outer_diameter/2, $fn=no_sides);
		cylinder(h=top_chamfer, r1=-top_chamfer+outer_diameter/2, r2=outer_diameter/2, $fn=no_sides);
		translate([0,0,height]) cylinder(h=(plunge_depth), r=(inner_diameter/2));
	}
}

module hollow_torus() {
	translate([0,0,(wall_thickness)]) difference() {
		cylinder(h=height, r=(outer_diameter/2)-wall_thickness);
		translate([0,0,-1]) cylinder(h=height+2, r=inner_diameter/2);
	}
}

module internal_supports() {
	translate([0,0,(top_chamfer+height)/2]) cube(size=[outer_diameter-wall_thickness, stiffener_thickness, height-top_chamfer], center=true);
	translate([0,0,(top_chamfer+height)/2]) cube(size=[stiffener_thickness, outer_diameter-wall_thickness, height-top_chamfer], center=true);
}

module D_shaft_hole() {
	rotate([0,0,-90-point_angle]) {
		translate([0,0,(height-shaft_length)]) difference() {
			cylinder(h=(shaft_length+plunge_depth+2), r=(shaft_diameter+clearance)/2);
			translate([-shaft_diameter/2,((D_width+clearance)-shaft_diameter/2),-1]) cube(size=[shaft_diameter+clearance,shaft_diameter+clearance,shaft_length+plunge_depth+4]);
		}
	}
}

module internal_clearance() {
	translate([0,0,height-clearance_height]) difference() {
		cylinder(h=height, r=(outer_diameter/2)-wall_thickness);
		translate([0,0,-1]) cylinder(h=height+2, r=inner_diameter/2);
	}
}

module scollop() {
	rotate([0,0,offset_angle]) {
		for (i=[0:number_of_features]) {
				rotate([0,0,(360/number_of_features)*i]) translate([-outer_diameter/2,(outer_diameter/2)+(height/8)-(wall_thickness),height/3]) rotate([0,90,0]) cylinder(h=outer_diameter, r=height/8);
		}
	}
}

module scollop_wall() {
	intersection() {
		translate([0,0,top_chamfer]) cylinder(h=height-top_chamfer, r=outer_diameter/2, $fn=no_sides);
		rotate([0,0,offset_angle]) {
			for (i=[0:number_of_features]) {
				rotate([0,0,(360/number_of_features)*i]) translate([-outer_diameter/2,(outer_diameter/2)+(height/8)-(wall_thickness),height/3]) rotate([0,90,0]) cylinder(h=outer_diameter, r=(height/8)+wall_thickness);
			}
		}
	};
}

module taps() {
	difference() {
		for (i=[0:number_of_features]) {
			rotate([0,0,(360/number_of_features)*i+offset_angle]) {
				minkowski() {
					hull() {
						translate([0,0,0]) cylinder(h=tap_height*2, r=1);
						translate([-outer_diameter/1.25,0,0]) cylinder(h=tap_height, r=outer_diameter/10);
					}
					translate([0,0,tap_height]) sphere(r=tap_height/2, $fn=5);
				}
			}
		}
		cylinder(h=height, r=(outer_diameter/2)-wall_thickness);
	}
}

if(extra_feature=="scollops") {
	difference() {
		scollop_wall();
		scollop();
	}
	difference() {
		knob();
		scollop();
	}
} else if(extra_feature=="taps") {
	knob();
	taps();
} else if(extra_feature=="cutaway") {
	difference() {
		knob();
		translate([0,0,-1]) cube([1000,1000,1000]);
	}
}else {
	knob();
}

if(with_pointer=="yes") {
	// zero marker
	translate([outer_diameter/2,0,0]) {
		polyhedron(
			points=[
				[point_size,0,height],[-wall_thickness/3,-point_size/2,height],[-wall_thickness/3,point_size/2,height],
				[0,0,top_chamfer]
			],
			triangles=[
				[0,1,2],
				[0,3,1],
				[0,2,3],
				[2,1,3]
			]
		);
	}
}
