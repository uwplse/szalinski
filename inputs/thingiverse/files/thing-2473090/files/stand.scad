//CUSTOMIZER VARIABLES

// The width of the stand when looking from the front
stand_width = 50;

// The depth of the spot in which the stood object sits
bottom_depth = 50;

// The height of the stand measured up the backrest
backrest_height = 150;

// The angle that the stood object leans back
lean_angle = 20;

// The distance between the points of contact when the stand is leaned back
base_distance = 100;

// The height at which the prop intersects with the backrest
join_height = 100;

// The height of the lip
lip_height = 10;

// The thickness of all parts of the stand
structure_thickness = 15;

// Whether to place an edge holder on the side(s) of the stand
edge_holder = 0; // [0:None, 1:Left, 2:Right, 3:Both]

//CUSTOMIZER VARIABLES END

module stand(width=stand_width, depth=bottom_depth, height=backrest_height, angle=lean_angle, base=base_distance, join=join_height, lip=lip_height, thickness=structure_thickness, edge=edge_holder) {
    backrest_top = [-(thickness/2),height-(thickness/2),0];
    backrest_bottom = [-(thickness/2),-(thickness/2),0];
    holder_front = [depth+(thickness/2),-(thickness/2),0];
    lip_top = [depth+(thickness/2),lip -(thickness/2),0];
    prop_join = [-(thickness/2),join-(thickness/2),0];
    prop_bottom = [-cos(angle) * base + (thickness/2),sin(angle) * base - (thickness/2),0];
    
    // Add some width to accomodate the edges, if included
    total_width = width + ((edge == 1 || edge == 3) ? thickness : 0) + ((edge == 2 || edge == 3) ? thickness : 0);
    
    // Flip the whole thing over for easier printing if there's a holder on the left side
    rotate_all = edge == 1 ? [0, 180, 0] : [0, 0, 0];
    translate_all = edge == 1 ? [0, 0, total_width] : [0, 0, 0];

    translate(translate_all) rotate(rotate_all) {
        linear_extrude(height = total_width)
        {
            // Backrest
            hull() {
                translate(backrest_top) circle(d=thickness);
                translate(backrest_bottom) circle(d=thickness);
            }
            // Stand
            hull() {
                translate(prop_join) circle(d=thickness);
                translate([prop_join[0],max(prop_join[1]-thickness/2, -thickness/2),prop_join[2]]) circle(d=thickness);
                translate(prop_bottom) circle(d=thickness);
            }
            // Holder
            hull() {
                translate(backrest_bottom) circle(d=thickness);
                translate(holder_front) circle(d=thickness);
            }
            // Lip
            hull() {
                translate(holder_front) circle(d=thickness);
                translate(lip_top) circle(d=thickness);
            }
        }
        // Left edge holder
        if (edge == 1 || edge == 3) {
            translate([0, 0, total_width - thickness]) linear_extrude(height = thickness)
            hull() {
                translate(backrest_top) circle(d=thickness);
                translate(backrest_bottom) circle(d=thickness);
                translate(holder_front) circle(d=thickness);
                translate(lip_top) circle(d=thickness);
            }
        }
        // Right edge holder
        if (edge == 2 || edge == 3) {
            linear_extrude(height = thickness)
            hull() {
                translate(backrest_top) circle(d=thickness);
                translate(backrest_bottom) circle(d=thickness);
                translate(holder_front) circle(d=thickness);
                translate(lip_top) circle(d=thickness);
	        }
        }
    }
}

stand();
