

// inner diameter in mm (hose outer diameter)
inner_diameter = 7.8;

//holder ring thickness in mm
holder_thickness = 4;

//holder width in mm (height of 3d print actually)
holder_width = 6;

//pin length in mm
pin_length = 150;

//bottom pin width in mm
ping_bottom_width = 2;

//length of pin slope
slope_length = 80;

//holder arc in degrees
holder_arc=140;

$fn=50;

holder_ring();
pin();


module pin() {
	difference() {
		translate([-pin_length,-inner_diameter/2 -holder_thickness ,-holder_width/2])
			cube([pin_length, holder_thickness, holder_width]);
		translate([-pin_length,-inner_diameter/2 -holder_thickness -0.1 ,-holder_width/2+ping_bottom_width])
			rotate([0,-asin((holder_width-ping_bottom_width)/slope_length),0])
	  			cube([slope_length, holder_thickness+0.2, holder_width]);
	}
	
}

module holder_ring () {

	difference() {
		cylinder(d=inner_diameter+2*holder_thickness,h=holder_width, center=true);
		cylinder(d=inner_diameter,h=holder_width+ 0.2, center=true);
		translate([0,0,-holder_width/2-0.1])
			arc(inner_diameter+20, holder_width + 0.2, inner_diameter+20, holder_arc);

	}
	rotate([0,0,-190+holder_arc])
		translate([-inner_diameter/2 -holder_thickness/2,0,0])
			cylinder(d=holder_thickness,h=holder_width, center=true);
}


module arc( height, depth, radius, degrees ) {
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}
 