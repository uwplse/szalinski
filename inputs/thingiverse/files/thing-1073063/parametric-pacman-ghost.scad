
$fn = 30 ;

outer_diameter = 30 ;
inner_diameter = 28 ;

height_body = 30 ;

eye_diameter = 5 ;
eye_angle = 45 ;
eye_height = height_body * 3 / 4 ;

skirt_size = 8 ;
skirt_number = 8 ;

head_hole = false ;
head_hole_diameter = 5.2 ;

// body

difference() {
	cylinder (h = height_body, r = outer_diameter/2) ;
	translate ([0,0,-0.1]) cylinder (h = height_body+0.2, r = inner_diameter/2) ;

// eyes
	translate ([0,0,eye_height]) rotate ([90,0,-eye_angle/2]) cylinder (h=outer_diameter, r = eye_diameter/2) ;
	translate ([0,0,eye_height]) rotate ([90,0,eye_angle/2]) cylinder (h=outer_diameter, r = eye_diameter/2) ;

// skirt
	for (i= [1:360/skirt_number:360]) {
		rotate([90,270,i]) cylinder ($fn = 3, r = skirt_size, h = outer_diameter/2+0.1) ;
	} // for

} 


// head

difference () {
	translate ([0,0,height_body]) sphere(r = outer_diameter/2) ;
	translate ([0,0,height_body]) sphere(r = inner_diameter/2) ;
	cylinder (h = height_body, r = outer_diameter/2) ;

	// head hole
	if (head_hole){
		translate([0,0,height_body+(inner_diameter/2)-0.2]) cylinder (r = head_hole_diameter/2, h = outer_diameter-inner_diameter+0.3) ;
	}
}

