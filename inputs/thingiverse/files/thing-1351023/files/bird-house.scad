house_length = 150;
wall_thickness = 1.5;
door_radius = 27.5;
door_above_floor = 30;
door_ring_radius = 4;
hang_ring_radius = 5;
air_holes = "YES"; // [YES, NO]

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the arc radius 
//     angle - the arc angle 
//     width - the arc width 
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=48); 
            circle(radius, $fn=48);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

// Given a `radius` and `angles`, draw an arc from `angles[0]` degree to `angles[1]` degree. 
// Parameters: 
//     radius - the arc radius 
//     angles - the arc angles 
//     width - the arc width
module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

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

// 2D module, composed of a semi-circle and a square. The square's length is equal to the circle radius.
//
// Parameters: 
//     house_radius - the semi-circle radius of the house
module bird_house_2d_contour(house_radius) {
    sector(house_radius, [0, 180], 1);
    translate([0, -house_radius / 2, 0]) 
	    square([house_radius * 2, house_radius], center = true);
}

// The brid house with no top. The door radius is 1/2 `house_radius`. 
// The house depth is double `house_radius`. 
// Choose a suitable `door_ring_radius` for your bird's claw size.
//
// Parameters: 
//     house_radius - the semi-circle radius of the house
//     door_ring_radius - the ring radius on the door
//     wall_thickness - the wall thicnkess.
module bird_house_body(house_radius, door_radius, door_above_floor, door_ring_radius, wall_thickness) {
    house_depth = house_radius * 2;
	
	difference() {
	    // create the room
		linear_extrude(house_depth) 
			bird_house_2d_contour(house_radius);
			
		translate([0, 0, wall_thickness]) 
			linear_extrude(house_depth - wall_thickness * 2) 
				bird_house_2d_contour(house_radius - wall_thickness);
				
		// remove the top
        translate([0, -house_radius + wall_thickness, 0]) rotate([90, 0, 0]) 
		    linear_extrude(wall_thickness * 2) 
		        translate([-house_radius, 0, 0]) 
				    square(house_radius * 2);
				
		// create a door
		translate([0, door_radius - door_above_floor, wall_thickness]) 
		    linear_extrude(house_depth) 
			    circle(door_radius);
	}    

	// create the door ring
	translate([0, door_radius - door_above_floor, house_radius * 2]) 
		rotate_extrude(convexity = 10) 
			translate([door_radius + door_ring_radius, 0, 0]) 
				circle(door_ring_radius, $fn = 24);													
}

// The top cover of the bird house. 
// 
// Parameters: 
//     length - the length of the cover side
//     wall_thickness - the wall thicnkess.
module bird_house_cover(length, wall_thickness) {
    spacing = 0.6;
	five_wall_thickness = wall_thickness * 5;
	scale = 0.95;
	
	// the outer cover
	difference() {
		linear_extrude(five_wall_thickness)
			square(length, center = true);
				
		linear_extrude(five_wall_thickness, scale = scale) 
			square(length - wall_thickness * 2, center = true);
	}

	// the inner cover
	linear_extrude(five_wall_thickness, scale = scale)
		square(length - (wall_thickness + spacing) * 2, center = true);
}

// The hang ring of the bird house. 
// 
// Parameters: 
//     ring_radius - the radius of the hang ring
//     house_radius - the semi-circle radius of the house
//     wall_thickness - the wall thicnkess.
module hang_ring(ring_radius, house_radius, wall_thickness) {
    offset = (house_radius - 0.525 * wall_thickness) / 0.475 / 2;
	
    translate([offset, -house_radius - wall_thickness * 2, offset]) 
	    rotate([0, 90, -90]) 
	        linear_extrude(wall_thickness * 2) 
		        arc(ring_radius, [0, 180], wall_thickness * 2);
}

// A bird house. 
// The door radius is 1/2 `house_radius`. 
// The house depth is double `house_radius`. 
// Choose a suitable `door_ring_radius` for your bird's claw size.
// 
// Parameters: 
//     ring_radius - the radius of the hang ring
//     house_radius - the semi-circle radius of the house
//     door_ring_radius - the ring radius on the door. 
//     wall_thickness - the wall thicnkess.
module bird_house(house_length, door_radius, door_above_floor, hang_ring_radius, door_ring_radius, wall_thickness) {
    house_radius = house_length / 2;

    bird_house_body(house_radius, door_radius, door_above_floor, door_ring_radius, wall_thickness);

    length = (house_radius - 0.525 * wall_thickness) / 0.475;

    translate([0, -house_radius - wall_thickness * 4, house_radius])   
        rotate([-90, 0, 0]) 
            bird_house_cover(length, wall_thickness);

    hang_ring(hang_ring_radius, house_radius, wall_thickness);
    mirror([1, 0, 0]) 
	    hang_ring(hang_ring_radius, house_radius, wall_thickness);			
}

difference() {
	rotate([90, 0, 0])
		bird_house(house_length, door_radius, door_above_floor, hang_ring_radius, door_ring_radius, wall_thickness);

		
	if(air_holes == "YES") {
		// air holes	
		union() {
			translate([0, 0, -house_length / 3]) sphere(door_radius * 0.25);
			translate([house_length / 3, 0, -house_length / 3]) sphere(door_radius * 0.25);
			translate([-house_length / 3, 0, -house_length / 3]) sphere(door_radius * 0.25);

			translate([0, -house_length, -house_length / 2.5]) sphere(door_radius * 0.25);
			translate([house_length / 3, -house_length, -house_length / 3]) sphere(door_radius * 0.25);
			translate([-house_length / 3, -house_length, -house_length / 3]) sphere(door_radius * 0.25);
		}
	}
}

