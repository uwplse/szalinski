/* [Box] */

box_width = 50;

box_lenght = 50;

box_height = 25;

box_right_connector = "tab"; // [none, tab, slot]

box_left_connector = "none"; // [none, tab, slot]

box_front_connector = "none"; // [none, tab, slot]

box_back_connector = "slot"; // [none, tab, slot]

add_brim = "yes"; // [yes, no]

brim_width = 6;

/* [Extra Configuration] */

box_thickness = 2;

box_connector_radius = 9;

box_connector_gap = 0.2;

brim_height = 0.2;

// Smoothness
$fn=100;

// preview[view:south, tilt:top diagonal]

render(convexity = 2) {
   pencil_box();
}


// Ugly code ahead //

// Create a rectangle and round the unused corners.
module rounded_rectangle(width, lenght, height) {
    corner_diameter = width <= lenght ? width/3 : lenght/3;
    corner_x = ((width/2)-(corner_diameter/2));
    corner_y = ((lenght/2)-(corner_diameter/2));
    corner2_x = (width/2)-corner_diameter;
    corner2_y = (lenght/2)-corner_diameter;
    union() {
        difference() {
            cube([width, lenght, height], center=true);
            // corner 1
            if (box_left_connector == "none" && box_front_connector == "none") translate([-corner_x,-corner_y,0]) cube([corner_diameter,corner_diameter,height], center=true);
            // corner 2
            if (box_left_connector == "none" && box_back_connector == "none") translate([-corner_x,corner_y,0]) cube([corner_diameter,corner_diameter,height], center=true);
            // corner 3
            if (box_right_connector == "none" && box_front_connector == "none") translate([corner_x,-corner_y,0]) cube([corner_diameter,corner_diameter,height], center=true);
            //corner 4
            if (box_right_connector == "none" && box_back_connector == "none") translate([corner_x,corner_y,0]) cube([corner_diameter,corner_diameter,height], center=true);
        }
        // corner 1
        if (box_left_connector == "none" && box_front_connector == "none") translate([-(corner2_x),-(corner2_y),0]) cylinder(height,corner_diameter,corner_diameter, center=true);
        // corner 2
        if (box_left_connector == "none" && box_back_connector == "none") translate([-(corner2_x),(corner2_y),0]) cylinder(height,corner_diameter,corner_diameter, center=true);
        // corner 3
        if (box_right_connector == "none" && box_front_connector == "none") translate([(corner2_x),-(corner2_y),0]) cylinder(height,corner_diameter,corner_diameter, center=true);
        // corner 4
        if (box_right_connector == "none" && box_back_connector == "none") translate([(corner2_x),(corner2_y),0]) cylinder(height,corner_diameter,corner_diameter, center=true);
    }
}

// Create the box, removing the area for the slots.
module box(width, lenght, height, thickness) {
    slot_x = (width/2)-box_connector_radius+(thickness*2);
    slot_y = (lenght/2)-box_connector_radius+(thickness*2);
    union() {
        difference() {
            difference() {
                rounded_rectangle(width, lenght, height);
                translate([0,0,thickness/2]) rounded_rectangle(width-(thickness*2), lenght-(thickness*2), height-thickness);
            }
            if (box_right_connector == "slot") translate([slot_x,0,0]) cylinder(height, box_connector_radius,box_connector_radius, center=true);
            if (box_front_connector == "slot") translate([0,-slot_y,0]) cylinder(height, box_connector_radius,box_connector_radius, center=true);
            if (box_left_connector == "slot") translate([-slot_x,0,0]) cylinder(height, box_connector_radius,box_connector_radius, center=true);
            if (box_back_connector == "slot") translate([0,slot_y,0]) cylinder(height, box_connector_radius,box_connector_radius, center=true);
        }
        // Add brim to the box
        if (add_brim == "yes") {
            if (box_left_connector != "none" || box_front_connector != "none")
                translate([-(width/2),-(lenght/2),-((height/2)-(brim_height/2))]) cylinder(brim_height,brim_width,brim_width, center=true);
            if (box_left_connector != "none" || box_back_connector != "none")
                translate([-(width/2),(lenght/2),-((height/2)-(brim_height/2))]) cylinder(brim_height,brim_width,brim_width, center=true);
            if (box_right_connector != "none" || box_front_connector != "none")
                translate([(width/2),-(lenght/2),-((height/2)-(brim_height/2))]) cylinder(brim_height,brim_width,brim_width, center=true);
            if (box_right_connector != "none" || box_back_connector != "none")
                translate([(width/2),(lenght/2),-((height/2)-(brim_height/2))]) cylinder(brim_height,brim_width,brim_width, center=true);
        }
    }
}

// Add tabs and slots to the box.
module pencil_box() {
    slot_x = (box_width/2)-box_connector_radius+(box_thickness*2);
    slot_y = (box_lenght/2)-box_connector_radius+(box_thickness*2);
    tab_x = (box_width/2)+box_connector_radius-(box_thickness*2)+box_connector_gap;
    tab_y = (box_lenght/2)+box_connector_radius-(box_thickness*2)+box_connector_gap;

    union() {
        box(box_width, box_lenght, box_height, box_thickness);
        if (box_right_connector != "none") {
            if (box_right_connector == "slot") {
                union() {
                    difference() {
                        translate([slot_x,0,0]) cylinder(box_height, box_connector_radius,box_connector_radius, center=true);
                        translate([slot_x,0,0]) cylinder(box_height, box_connector_radius-box_thickness,box_connector_radius-box_thickness, center=true);
                        translate([box_width/2+box_connector_radius,0,0]) cube([box_connector_radius*2,box_connector_radius*2,box_height], center=true);
                    }
                    // Add brim
                    if (add_brim == "yes") translate([(box_width/2),0,-((box_height/2)-(brim_height/2))]) cylinder(brim_height,box_connector_radius,box_connector_radius, center=true);
                }
            } else {
                difference() {
                    translate([tab_x,0,0]) cylinder(box_height, box_connector_radius-box_thickness-box_connector_gap,box_connector_radius-box_thickness-box_connector_gap, center=true);
                    translate([tab_x,0,0]) cylinder(box_height, box_connector_radius-(box_thickness*2)-box_connector_gap,box_connector_radius-(box_thickness*2)-box_connector_gap, center=true);
                }
            }
        }
        if (box_front_connector != "none") {
            if (box_front_connector == "slot") {
                union() {
                    difference() {
                        translate([0,-slot_y,0]) cylinder(box_height, box_connector_radius,box_connector_radius, center=true);
                        translate([0,-slot_y,0]) cylinder(box_height, box_connector_radius-box_thickness,box_connector_radius-box_thickness, center=true);
                        translate([0,-(box_lenght/2+box_connector_radius),0]) cube([box_connector_radius*2,box_connector_radius*2,box_height], center=true);
                    }
                    // Add brim
                    if (add_brim == "yes") translate([0,-(box_lenght/2),-((box_height/2)-(brim_height/2))]) cylinder(brim_height,box_connector_radius,box_connector_radius, center=true);
                }
            } else {
                difference() {
                    translate([0,-tab_y,0]) cylinder(box_height, box_connector_radius-box_thickness-box_connector_gap,box_connector_radius-box_thickness-.2, center=true);
                    translate([0,-tab_y,0]) cylinder(box_height, box_connector_radius-(box_thickness*2)-box_connector_gap,box_connector_radius-(box_thickness*2)-box_connector_gap, center=true);
                }
            }
        }
        if (box_left_connector != "none") {
            if (box_left_connector == "slot") {
                union() {
                    difference() {
                        translate([-slot_x,0,0]) cylinder(box_height, box_connector_radius,box_connector_radius, center=true);
                        translate([-slot_x,0,0]) cylinder(box_height, box_connector_radius-box_thickness,box_connector_radius-box_thickness, center=true);
                        translate([-(box_width/2+box_connector_radius),0,0]) cube([box_connector_radius*2,box_connector_radius*2,box_height], center=true);
                    }
                    // Add brim
                    if (add_brim == "yes") translate([-(box_width/2),0,-((box_height/2)-(brim_height/2))]) cylinder(brim_height,box_connector_radius,box_connector_radius, center=true);
                }
            } else {
                difference() {
                    translate([-tab_x,0,0]) cylinder(box_height, box_connector_radius-box_thickness-box_connector_gap,box_connector_radius-box_thickness-box_connector_gap, center=true);
                    translate([-tab_x,0,0]) cylinder(box_height, box_connector_radius-(box_thickness*2)-box_connector_gap,box_connector_radius-(box_thickness*2)-box_connector_gap, center=true);
                }
            }
        }
        if (box_back_connector != "none") {
            if (box_back_connector == "slot") {
                union() {
                    difference() {
                        translate([0,slot_y,0]) cylinder(box_height, box_connector_radius,box_connector_radius, center=true);
                        translate([0,slot_y,0]) cylinder(box_height, box_connector_radius-box_thickness,box_connector_radius-box_thickness, center=true);
                        translate([0,box_lenght/2+box_connector_radius,0]) cube([box_connector_radius*2,box_connector_radius*2,box_height], center=true);
                    }
                    // Add brim
                    if (add_brim == "yes") translate([0,(box_lenght/2),-((box_height/2)-(brim_height/2))]) cylinder(brim_height,box_connector_radius,box_connector_radius, center=true);
                }
            } else {
                difference() {
                    translate([0,tab_y,0]) cylinder(box_height, box_connector_radius-box_thickness-box_connector_gap,box_connector_radius-box_thickness-box_connector_gap, center=true);
                    translate([0,tab_y,0]) cylinder(box_height, box_connector_radius-(box_thickness*2)-box_connector_gap,box_connector_radius-(box_thickness*2)-box_connector_gap, center=true);
                }
            }
        }
    }
}
