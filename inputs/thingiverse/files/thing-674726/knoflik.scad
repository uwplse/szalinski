/* [Dimensions] */

//Button diameter
button_diameter=45;

//Button height
button_height=5;

/* [Holes] */

//Number of holes
num_holes=6; 

//Diameter of individual holes
hole_diameter=4;

//Distance of holes from the center
inner_radius=9;

/* [Other] */

//type of the border
border_type="round"; //[square, round]

//additional height of the border
extra_border=2;

//Smoothness (complexity) of the model
smoothness=20; //[4:200]


module button_holes(num_holes=num_holes, ring_radius=inner_radius, hole_diameter=hole_diameter, hole_height=height) {
		for (i=[1:num_holes]) {
  			rotate([0,0,360/num_holes*i])
			translate([ring_radius,0,-1])
  				cylinder(r=hole_diameter/2, h=hole_height+2);
		}
}


module button(button_diameter=45, button_height=5, extra_border=2, 
    smoothness=0, 
    border_type="square", num_holes=4, ring_radius=10, hole_diameter=4) {

	border_diameter=button_height+extra_border;

	difference() {
		if (border_type=="round") {
		union() {
			cylinder(r=(button_diameter-border_diameter)/2, h=button_height, $fn=smoothness);

			rotate_extrude($fn=smoothness)
			translate([(button_diameter-border_diameter)/2, border_diameter/2])
        		circle(r=(button_height+extra_border)/2);
		}
		} else {
		union() {
  	  		cylinder(r=button_diameter/2, h=button_height, $fn=smoothness);

			rotate_extrude($fn=smoothness)
			translate([button_diameter/2-border_diameter, 0])
				square([border_diameter, border_diameter]);
		}
		}

		button_holes(
			num_holes=num_holes,
			ring_radius=ring_radius,
			hole_diameter=hole_diameter,
			hole_height=button_height
			);
	}
}

button(
	button_diameter=button_diameter, 
	button_height=button_height,
	border_type=border_type, 
	extra_border=extra_border, 
	smoothness=smoothness,
	num_holes=num_holes,
	ring_radius=inner_radius,
	hole_diameter=hole_diameter
	);


