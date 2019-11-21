//Outside Shape
outside_shape = 3; // [1:Cylinder, 2:Square, 3:Polygon]

//Inside Shape
inside_shape = 2; // [1:Cylinder, 2:Square, 3:Polygon]

//Outside Polygon sides
outside_polysides = 5; // [5:20]

//Inside Polygon sides
inside_polysides = 5; // [5:20]

//Height
height=8; // [5:50]

//Diameter of Inner Polygon
inside_diameter = 4;

//Diameter of Outer Polygon
outside_diameter = 8;



/* [Hidden] */
$fn=60;


	if (outside_shape == 1){
		if (inside_shape == 1){
			cyl_cyl();
		} else if (inside_shape == 2){
			cyl_squ();
		} else if (inside_shape == 3){
			cyl_poly();
		} else{
			cyl_cyl();
		}
	} else if (outside_shape == 2){
		if (inside_shape == 1){
			squ_cyl();
		} else if (inside_shape == 2){
			squ_squ();
		} else if (inside_shape == 3){
			squ_poly();
		} else{
			squ_cyl();
		}
	} else if (outside_shape == 3){
		if (inside_shape == 1){
			poly_cyl();
		} else if (inside_shape == 2){
			poly_squ();
		} else if (inside_shape == 3){
			poly_poly();
		} else{
			poly_cyl();
		}
	} else{
		cyl_cyl();
	}


//Cylinders

module cyl_cyl(){

	difference() {
	
		cylinder(height,outside_diameter/2,outside_diameter/2);
		cylinder(height,inside_diameter/2,inside_diameter/2);
	
	}

}

module cyl_squ(){

	difference() {
	
		cylinder(height,outside_diameter/2,outside_diameter/2,true);
		translate([-inside_diameter/2,-inside_diameter/2,-height/2])cube([inside_diameter,inside_diameter,height]);
	
	}

}

module cyl_poly(){

	difference() {
	
		cylinder(height,outside_diameter/2,outside_diameter/2);
		linear_extrude(height) circle(inside_diameter/2,$fn=inside_polysides);	
	
	}

}

//Squares

module squ_cyl(){

	difference() {
	
		translate([-outside_diameter/2,-outside_diameter/2,0])cube([outside_diameter,outside_diameter,height]);
		cylinder(height,inside_diameter/2,inside_diameter/2);
	
	}

}

module squ_squ(){

	difference() {
	
		cube([outside_diameter,outside_diameter,height]);
		translate([outside_diameter/2 - inside_diameter/2,outside_diameter/2 - inside_diameter/2,0])cube([inside_diameter,inside_diameter,height]);
	
	}

}

module squ_poly(){

	difference() {
	
		translate([-outside_diameter/2,-outside_diameter/2,0])cube([outside_diameter,outside_diameter,height]);
		linear_extrude(height) circle(inside_diameter/2,$fn=inside_polysides);	
	
	}

}

//Polygons

module poly_cyl(){

	difference() {
	
		linear_extrude(height) circle(outside_diameter/2,$fn=outside_polysides);
		cylinder(height,inside_diameter/2,inside_diameter/2);
	
	}

}

module poly_squ(){

	difference() {
	
		linear_extrude(height) circle(outside_diameter/2,$fn=outside_polysides);
		translate([-inside_diameter/2,-inside_diameter/2,0])cube([inside_diameter,inside_diameter,height]);
	
	}

}

module poly_poly(){

	difference() {
	
		linear_extrude(height) circle(outside_diameter/2,$fn=outside_polysides);
		linear_extrude(height) circle(inside_diameter/2,$fn=inside_polysides);	
	
	}

}
