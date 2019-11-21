// Radius of sphere in mm
sphere_radius=25; // [2:100]

// Calibration step: Set this to 0 and print a sphere.  squish_height is around half the difference between the sphere's diameter at the equator, and at the poles.
squish_height = .3;

// The diagonal of the hole, from center of the sphere to edge (usually 1mm less than sphere)
hole_max = sphere_radius-20; //[0:sphere_radius-1] 

//Resolution of sphere (number of line segments around its equator)
//Experiment with 20, then print at 100 
resolution = 100;

// Bevel height around hemisphere and around the pin
bevel_height = .6;

// Radius of hole minus radius of pin.
clearance = 0.35;

output = "pin"; //[pin,hemisphere]

/* [Hidden] */
hole_radius = hole_max*cos(45);
hole_height = hole_radius;


if(output == "hemisphere") {
		translate([0,0,squish_height]) rotate([180,0,0]) 
			difference() {
			difference() {
				union() {
					sphere(sphere_radius, $fn=resolution);
					cylinder(h=squish_height,r=sphere_radius, $fn=resolution);
				}

				translate([0,0,squish_height]){
					cylinder(h=sphere_radius,r=sphere_radius,$fn=resolution);
				}
				translate([0,0,-bevel_height+squish_height]){ 
					difference() {
						cylinder(h=bevel_height,r=sphere_radius,$fn=resolution);
						cylinder(h=bevel_height,r1=sphere_radius,r2=sphere_radius-bevel_height,$fn=resolution);
					}
				}

			}

			translate([0,0,-hole_height*.99+squish_height]){ 
				cylinder(h=hole_height,r=hole_radius,$fn=resolution);
			}

			translate([0,0,-bevel_height+squish_height]){
				cylinder(h=bevel_height,r1=hole_radius, r2=hole_radius+bevel_height,$fn=resolution);
			}	
		
		}
}
else if( output == "pin"){
	translate([0,0,bevel_height]){
	union() {
			cylinder(h=(hole_height-bevel_height-clearance)*1.4,r=hole_radius-clearance,$fn=resolution);
		translate([0,0,-bevel_height]) {
			cylinder(h=bevel_height,r2=hole_radius-clearance,r1=hole_radius-clearance-bevel_height,$fn=resolution);		
}
		translate([0,0,(hole_height-bevel_height-clearance)*1.4*.99]) {
			cylinder(h=bevel_height,r1=hole_radius-clearance,r2=hole_radius-clearance-bevel_height,$fn=resolution);
		}
	}
}
}
