$fn=50;

// millimeters
// Actual cut hole width is intake_hold_width + wall_thickness
intake_hole_width=90;
intake_hole_height=90;
insert_depth=13;
outer_lip_width=15;
outer_lip_radius=6;

total_width = intake_hole_width + outer_lip_width * 2;
total_height = intake_hole_height + outer_lip_width * 2;

intake_filter_space=8;
screw_hole_radius=4/2;
screw_column_radius=screw_hole_radius + 1.5;
screw_hole_inset = 10.6 - outer_lip_radius - screw_hole_radius / 2;

vent_hole_height = 6;
vent_hole_spacing = 3;
vent_hole_count = floor(intake_hole_height / (vent_hole_height + vent_hole_spacing));

wall_thickness=2;

module vent_hole_punchout() {
    translate([-(vent_hole_height / 2), 0, -0.5]) {
        hull() {
            translate([vent_hole_height, vent_hole_height / 2, 0])
            cylinder(r=vent_hole_height / 2, h=wall_thickness + 2, center=false);
            
            translate([intake_hole_width, vent_hole_height / 2, 0])
            cylinder(r=vent_hole_height / 2, h=wall_thickness + 2, center=false);
        }
    }
}

module vent_hole_punchouts() {
    for (i = [0:(vent_hole_count - 1)]) {
        translate([0, i * (vent_hole_spacing + vent_hole_height), 0])
        vent_hole_punchout();
    }
}

module intake_exterior_plate() {
    translate([outer_lip_radius, outer_lip_radius, 0])
    minkowski() {
        cube([
            intake_hole_width + outer_lip_width * 2 - outer_lip_radius * 2,
            intake_hole_height + outer_lip_width * 2 - outer_lip_radius * 2,
            wall_thickness / 2]);
        cylinder(r=outer_lip_radius, h=wall_thickness / 2);
    }
}

module intake_exterior_punchout() {
    translate([outer_lip_radius + outer_lip_width, outer_lip_radius + outer_lip_width, -1])
    minkowski() {
        cube([
            intake_hole_width - outer_lip_radius * 2,
            intake_hole_height - outer_lip_radius * 2,
            wall_thickness]);
        cylinder(r=outer_lip_radius, h=wall_thickness);
    }
}

module insert() {
    difference() {
        translate([
            outer_lip_radius + outer_lip_width - wall_thickness, 
            outer_lip_radius + outer_lip_width - wall_thickness,
            -insert_depth
        ])
        minkowski() {
            cube([
                intake_hole_width - outer_lip_radius * 2 + wall_thickness * 2,
                intake_hole_height - outer_lip_radius * 2 + wall_thickness * 2,
                insert_depth / 2]);
            cylinder(r=outer_lip_radius, h=insert_depth / 2);
        }
        
        translate([
            outer_lip_radius + outer_lip_width, 
            outer_lip_radius + outer_lip_width,
            -insert_depth - 1
        ])
        minkowski() {
            cube([
                intake_hole_width - outer_lip_radius * 2,
                intake_hole_height - outer_lip_radius * 2,
                insert_depth]);
            cylinder(r=outer_lip_radius, h=insert_depth);
        }
    }
}

module screw_punchout() {
    translate([screw_hole_radius, screw_hole_radius, 0])
    cylinder(r=screw_hole_radius, h=wall_thickness + 1, center = false);
}

module screw_punchouts() {
    radius_diff = screw_column_radius - screw_hole_radius;
    
    translate([
            screw_hole_inset + radius_diff, 
            screw_hole_inset + radius_diff, 
            -0.5
    ])
    screw_punchout();
    
    translate([
        total_width - screw_hole_inset - screw_hole_radius * 2 - radius_diff, 
        screw_hole_inset + radius_diff, 
        -0.5
    ])
    screw_punchout();

    translate([
        screw_hole_inset + radius_diff, 
        total_height - screw_hole_inset - screw_hole_radius * 2 - radius_diff, 
        -0.5
    ])
    screw_punchout();

    translate([
        total_width - screw_hole_inset - screw_hole_radius * 2 - radius_diff,
        total_height - screw_hole_inset - screw_hole_radius * 2 - radius_diff, 
        -0.5
    ])
    screw_punchout();
}

module intake_exterior() {
    
    difference() {
        intake_exterior_plate();
        
        translate([
            outer_lip_width, 
            outer_lip_width + 
                (intake_hole_height - (vent_hole_count * vent_hole_height + 
                    (vent_hole_count - 1) * vent_hole_spacing)) / 2, 
            0])
        vent_hole_punchouts();
        
        screw_punchouts();  
    }
    
    translate([total_width / 2 - vent_hole_spacing / 2, 0, 0])
    cube([vent_hole_spacing, total_height, wall_thickness]);
    
    insert();
}

module screw_column() {
    translate([screw_column_radius, screw_column_radius, 0])
    difference() {
        cylinder(r=screw_column_radius, h=intake_filter_space, center=false);
        cylinder(r=screw_hole_radius, h=intake_filter_space + 1, center=false);
    }
}

module intake_interior_vent_shell() {
    translate([outer_lip_radius, outer_lip_radius, 0])
    difference() {
        minkowski() {
            cube([
                intake_hole_width + outer_lip_width * 2 - outer_lip_radius * 2,
                intake_hole_height + outer_lip_width * 2 - outer_lip_radius * 2,
                intake_filter_space + wall_thickness]);
            cylinder(r=outer_lip_radius, h=0.000000001);
        }
        
        translate([wall_thickness, wall_thickness, wall_thickness])
        minkowski() {
            cube([
                intake_hole_width + outer_lip_width * 2 
                    - outer_lip_radius * 2 - wall_thickness * 2,
                intake_hole_height + outer_lip_width * 2 
                    - outer_lip_radius * 2 - wall_thickness * 2,
                intake_filter_space + 1]);
            cylinder(r=outer_lip_radius, h=0.000000001);
        }
        
        translate([
            outer_lip_width - outer_lip_radius, 
            outer_lip_width - outer_lip_radius + 
                (intake_hole_height - (vent_hole_count * vent_hole_height + 
                    (vent_hole_count - 1) * vent_hole_spacing)) / 2, 
            0])
        vent_hole_punchouts();
        
        translate([-outer_lip_radius, -outer_lip_radius, 0])
        screw_punchouts();
    }
    
    translate([total_width / 2 - vent_hole_spacing / 2, 0, 0])
    cube([vent_hole_spacing, total_height, wall_thickness]);
}

module intake_interior_vent() {
    intake_interior_vent_shell();

    translate([
        screw_hole_inset, 
        screw_hole_inset, 
        wall_thickness
    ])
    screw_column();
    
    translate([
        total_width - screw_hole_inset - screw_column_radius * 2, 
        screw_hole_inset, 
        wall_thickness
    ])
    screw_column();

    translate([
        screw_hole_inset, 
        total_height - screw_hole_inset - screw_column_radius * 2, 
        wall_thickness
    ])
    screw_column();

    translate([
        total_width - screw_hole_inset - screw_column_radius * 2,
        total_height - screw_hole_inset - screw_column_radius * 2, 
        wall_thickness
    ])
    screw_column();    
}

intake_exterior();
translate([0, 0, -insert_depth - 15]) {
    intake_interior_vent();
}