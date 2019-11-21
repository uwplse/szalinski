// parametric round plain washer

outside_diameter = 10.0;
inside_diameter = 4.5;
height = 10.0;

module washer() {
	translate([0,0,height/2]) {
		difference() {
			cylinder(h=height, r1=outside_diameter/2, r2=outside_diameter/2, center=true, $fn=outside_diameter*3);
			translate([0,0,-2])
				cylinder(h=height+5, r1=inside_diameter/2, r2=inside_diameter/2, center=true, $fn=outside_diameter*3);
		}
	}
}

washer();