//CUSTOMIZER VARIABLES

// The width of the stand when looking from the front
stand_width = 50;

// The depth of the spot in which the stood object sits
bottom_depth = 24;

// The height of the stand measured up the backrest
backrest_height = 80;

// The angle that the stood object leans back
lean_angle = 17;

// The distance between the points of contact when the stand is leaned back
base_distance = 40;

// The height at which the prop intersects with the backrest
join_height = 40;

// The height of the lip
lip_height = 6;

// The thickness of all parts of the stand
structure_thickness = 3;

// Whether to place an edge holder on the side(s) of the stand
edge_holder = 0; // [0:None, 1:Left, 2:Right, 3:Both]

//CUSTOMIZER VARIABLES END

module stand(width=stand_width, depth=bottom_depth, height=backrest_height, angle=lean_angle, base=base_distance, join=join_height, lip=lip_height, thickness=structure_thickness, edge=edge_holder) {
    backrest_top = [0,height,0];
    backrest_bottom = [0,0,0];
    holder_front = [depth+thickness,0,0];
    lip_top = [holder_front[0],lip,0];
    lip_bottom = [holder_front[0],-(depth+thickness)*tan(angle),0];
    prop_join = [0,join,0];
    prop_bottom = [-cos(angle)*base,sin(angle)*base,0];
    prop_angle = atan2(cos(angle)*base,join-sin(angle)*base);
    fillet_angle = prop_angle/2;
    fillet_end = [-tan(prop_angle)*thickness,prop_join[1]-thickness,0];
    fillet_join = [prop_join[0],fillet_end[1]-tan(fillet_angle)*(tan(prop_angle)*thickness),0];
    strut_end = [prop_bottom[0]+cos(90-prop_angle)*thickness,prop_bottom[1]+sin(90-prop_angle)*thickness,0];
    strut_join = [0,thickness,0];

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
                //translate([prop_join[0],max(prop_join[1], 0),prop_join[2]]) circle(d=thickness);
                translate(prop_bottom) circle(d=thickness);
            }
            // Fillet
            hull() {
                translate(fillet_join) circle(d=thickness);
                translate(fillet_end) circle(d=thickness);
            }
            // Strut
            hull () {
                translate(strut_join) circle(d=thickness/2);
                translate(strut_end) circle(d=thickness/2);
            }
            // Holder
            hull() {
                translate(backrest_bottom) circle(d=thickness);
                translate(holder_front) circle(d=thickness);
            }
            // Lip
            hull() {
//                translate(holder_front) circle(d=thickness);
                translate(lip_top) circle(d=thickness);
                translate(lip_bottom) circle(d=thickness);
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

module stand_smooth() {
    // Make smoother curved surfaces by generating the stand scaled
    // up 16x, then scaling back by 1/16.
    scale([1/16, 1/16, 1/16])  {
        stand(width=stand_width*16, depth=bottom_depth*16, height=backrest_height*16,
              angle=lean_angle, base=base_distance*16, join=join_height*16,
              lip=lip_height*16, thickness=structure_thickness*16, edge=edge_holder);
    }
}

module stand_rotated() {
    // Rotate so that the biggest surfaces fall on the X-axis, which
    // is easier to move for many 3D printers. Have the front faces
    // face in the -Y direction which means they can be easily
    // observed during printing on many printers.
    rotate([0,0,-90]) stand_smooth();
}

stand_rotated();
