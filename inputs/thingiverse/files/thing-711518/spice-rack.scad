//The diameter of the container you wish to hold in mm.  Add ~0.5mm to account for print tolerances
container_diameter = 40.5; // [40:55]
//The height of the back of the holder
back_height = 25;  // [20:40]
//The number of containers
containers = 5; // [1:10]
//The height of the front portion
front_height = 12.5;  //[10:20]
//Hole in the bottom (this does aid in accessing spices)
bottom_opening = "yes"; //[yes, no]
//whether to have a fully enclosed tube or have an opening in the front
front_opening = "yes"; //[yes, no]
//If you want a full back (sturdier holder) use yes, for less plastic, try no
large_back = "yes"; //[yes, no]

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
cont_dia = container_diameter;
thickness = 1.5;

module spice_container(){
	cylinder(h=back_height, r=cont_dia/2);
}


// parts that holds the spice container
module support(thickness, cont_dia, bottom_opening, front_opening){
	height = back_height;
	radius = thickness + cont_dia/2;
	back_factor = 2;


	union(){
		difference(){
			hull(){
				cylinder(h=height, r=radius);
				if (large_back == "yes") {
					translate([-radius, -radius*(back_factor/2), 0])
							cube(size=[thickness*2, radius*back_factor,height]);
				}
				else {
					translate([-radius, -radius*(1/2), 0])
							cube(size=[thickness*2, radius,height]);
				}
			}
			translate([0, 0, thickness]) spice_container();
			if (front_opening == "yes"){
				translate([0,-cont_dia/2, front_height])
						cube(size=[cont_dia, cont_dia, back_height]);
			}
			if (bottom_opening == "yes"){
				cylinder(h=back_height, r=cont_dia/3);
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
				translate([head_h-thickness-cont_dia/2, 0, back_height*2/3])
					rotate([0, 270, 0]) screw(head_d1, d1, d2, head_h, length, true);
			}
		}
	}
}
