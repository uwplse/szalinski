thickness = 5;
height = 20;
layer_factor = 5; // [1:90]
tip_sharp_factor = 10; 

// Given a `radius` and `angle`, draw a sector from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the sector radius
//     angle - the sector angle
module a_quarter_sector(radius, angle) {
    intersection() {
        circle(radius, $fn=96);
        
        polygon([[0, 0], [radius, 0], [radius, radius * sin(angle)], [radius * cos(angle), radius * sin(angle)]]);
    }
}

// Given a `radius` and `angle`, draw a sector from `angles[0]` degree to `angles[1]` degree. 
// Parameters: 
//     radius - the sector radius
//     angles - the sector angles
module sector(radius, angles) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;

    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_sector(radius, angle_difference);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            sector(radius, [0, 90]);
            rotate(90) a_quarter_sector(radius, angle_difference - 90);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            sector(radius, [0, 180]);
            rotate(180) a_quarter_sector(radius, angle_difference - 180);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            sector(radius, [0, 270]);
            rotate(270) a_quarter_sector(radius, angle_difference - 270);
       }
}

// The heart is composed of two semi-circles and two isosceles trias. 
// The tria's two equal sides have length equals to the double `radius` of the circle.
// That's why the `solid_heart` module is drawn according a `radius` parameter.
// 
// Parameters: 
//     radius - the radius of the semi-circle 
//     tip_factor - the sharpness of the heart tip
module solid_heart(radius, tip_factor) {
    offset_h = 2.2360679774997896964091736687313 * radius / 2 - radius * sin(45);
	tip_radius = radius / tip_factor;
	
    translate([radius * cos(45), offset_h, 0]) rotate([0, 0, -45])
    hull() {
        circle(radius, $fn = 96);
		translate([radius - tip_radius, -radius * 2 + tip_radius, 0]) 
		    circle(tip_radius, center = true, $fn = 96);
	}
	
	translate([-radius * cos(45), offset_h, 0]) rotate([0, 0, 45]) hull() {
        circle(radius, $fn = 96);
		translate([-radius + tip_radius, -radius * 2 + tip_radius, 0]) 
		    circle(tip_radius, center = true, $fn = 96);
	}
}

// The equation of an ellipse.
//
// Parameters:
//      major_axe - length of the major axe 
//      minor_axe - length of the minor axe 
//      a - an independent parameter which increases from 0 to 360
function eclipse_y(major_axe, a) = major_axe * cos(a);
function eclipse_z(minor_axe, a) = minor_axe * sin(a);

// Create one side of the eclipse heart.
//
// Parameters:
//      major_axe - length of the major axe 
//      minor_axe - length of the minor axe 
//      layer_factor - the layer_factor, from 1 to 90
//      tip_factor - the sharpness of the heart tip
module eclipse_heart_one_side(major_axe,  minor_axe, layer_factor, tip_factor) {
	for(a = [0 : layer_factor : 90]) {
		heart_height = eclipse_y( minor_axe, a) ;
		prev_heart_thickness = a == 0 ? 0 : eclipse_z(major_axe, a - layer_factor); 
		
		linear_height = eclipse_z(major_axe, a) - prev_heart_thickness;
		linear_scale = eclipse_y( minor_axe, a + layer_factor) / heart_height;
		
		translate([0, 0, prev_heart_thickness]) 
			linear_extrude(linear_height, scale = linear_scale) 
				solid_heart(heart_height, tip_factor);
	}
}

// Create an eclipse heart.
//
// Parameters:
//      major_axe - length of the major axe 
//      minor_axe - length of the minor axe 
//      layer_factor - the layer_factor, from 1 to 90
//      tip_factor - the sharpness of the heart tip
module eclipse_heart(major_axe,  minor_axe, layer_factor, tip_factor) {
	eclipse_heart_one_side(major_axe,  minor_axe, layer_factor, tip_factor);
	mirror([0, 0, 1]) eclipse_heart_one_side(major_axe,  minor_axe, layer_factor, tip_factor);
}

eclipse_heart(thickness / 2, height / 3.12, layer_factor, tip_sharp_factor);


