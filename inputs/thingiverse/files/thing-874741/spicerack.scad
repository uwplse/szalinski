container_diameter = 48; // [14:55]
bottom_opening = "yes"; //[yes, no]
front_opening = "yes"; //[yes, no]
containers = 3; // [1:5]

// preview[view:south, tilt:top diagonal]

/* [Hidden] */
// Spice rack
$fn=100;

// Screw
head_d1 = 6.5;
d1 = 2.7;
d2 = 2;
head_h = 2.75;
length= 10;

module screw(head_d1, d1, d2=d1, head_h, length, countersunk=false){
	union(){
		if (countersunk)
			cylinder(h = head_h, r1 = head_d1/2, r2 = d1/2);
		else
			cylinder(h = head_h, r = head_d1/2);

		translate([0, 0, head_h])
			cylinder(h = length, r1 = d1/2, r2 = d2/2);
	}
}

// reference Spice container
cont_max_height = 120;
cont_min_height = 50;
cont_dia = container_diameter;
thickness = 2;

module spice_container(){
	cylinder(h=cont_max_height, r=cont_dia/2);
}


// parts that holds the spice container
module support(thickness, cont_dia, bottom_opening, front_opening){
	height = cont_min_height * 0.8;
	radius = thickness + cont_dia/2;
	back_factor = 1; //defines the width of the flat back

	union(){
		difference(){
			hull(){
				cylinder(h=height, r=radius);
				translate([-radius, -radius*(back_factor/2), 0])
					cube(size=[thickness*2, radius*back_factor,height]);
			}
			translate([0, 0, thickness]) spice_container();
			if (front_opening == "yes"){
				translate([9*cont_dia/10, cont_dia, thickness * 4 + cont_dia/2.5]){
					rotate([90, 0, 0]){
						spice_container();
					translate([-cont_dia/2, 0, 0])
						cube(size=[cont_dia, cont_dia, cont_max_height]);
						
					}	
				}
			}
			if (bottom_opening == "yes"){
				cylinder(h=cont_max_height, r=cont_dia/3);
			}
		}
	}

}

//spice_container();

rotate([0, 0, 270]) union(){
	for (i=[0:containers-1]){
		translate([0, (cont_dia+thickness)*i, 0,]){
			difference(){
				support(thickness, cont_dia, bottom_opening, front_opening);
				translate([head_h-thickness-cont_dia/2, 0, cont_min_height/2])
					rotate([0, 270, 0]) screw(head_d1, d1, d2, head_h, length, true);			}
		}
	}
}

