// couch beer holder (beer spider? beer octopus? beer rocket?)
// dec 2017, /u/gmarsh23 on reddit
// CC BY-SA V4.0

// segments to divide circles and legs into
// more segments = better circles, but slower rendering and (maybe) slower printing time
center_fn = 180;
leg_fn = 60;
// 'nudge', used to make preview look better.
nudge = 0.01;

// thickness of bottom below can
can_cutout_bottom_thickness = 2;
// can cutout diameter and bottom/top chamfers
can_cutout_dia = 68;
can_cutout_bottom_chamfer = 3;
can_cutout_top_chamfer = -1;

// bottom hole, set _enable to 0 to disable
bottom_hole_enable = 1;
bottom_hole_dia = 36;
bottom_hole_bottom_chamfer = -0.5;
bottom_hole_top_chamfer = -0.5;

// center section
center_wall_thickness = 3;
center_dia = can_cutout_dia + (center_wall_thickness*2);
center_height = 70;
center_top_chamfer = 1;
center_bottom_chamfer = 0.5;

// legs - made by hulling two chamfered cylinders together
// uncomment this line to see what an individual leg looks like
//!leg();

leg_count = 7;
leg_outer_dia = 10;
leg_outer_height = 2;
leg_outer_offset = 90;
leg_inner_dia = 25;
leg_inner_height = 50;
leg_bottom_chamfer = 0.5;
leg_top_chamfer = 0.5;




couchbeer();

module couchbeer() {
    difference() {
        union() {
            center();
            legs();
        }
        can_cutout();
    }
}

module legs() {
    leg_angles = [0:(360/leg_count):359];
    for (a=leg_angles) rotate([0,0,a]) leg();
}


module center() {
    chamfered_cylinder(c1=center_bottom_chamfer,c2=center_top_chamfer,d=center_dia,h=center_height,$fn=center_fn);
}

module can_cutout() {
    // can itself
    translate([0,0,can_cutout_bottom_thickness])
        chamfered_cylinder(d=can_cutout_dia,h=center_height-can_cutout_bottom_thickness+nudge,c1=can_cutout_bottom_chamfer,c2=can_cutout_top_chamfer,$fn=center_fn);
    // circle in base
    
    if (bottom_hole_enable) {
        translate([0,0,-nudge])
            chamfered_cylinder(c1=bottom_hole_bottom_chamfer,c2=bottom_hole_top_chamfer,d=bottom_hole_dia,h=can_cutout_bottom_thickness+(2*nudge),$fn=center_fn);
    }
}

module leg() {
    hull() {
        translate([leg_outer_offset,0,0])
            chamfered_cylinder(c1=leg_bottom_chamfer,c2=leg_top_chamfer,d=leg_outer_dia,h=leg_outer_height,$fn=leg_fn);
        chamfered_cylinder(c1=leg_bottom_chamfer,c2=leg_top_chamfer,d=leg_inner_dia,h=leg_inner_height,$fn=leg_fn);
    }
}

module chamfered_cylinder(d=10,h=10,c1=1,c2=1,$fn=$fn) {
    
    local_nudge = 0.001;
    
    c1a = abs(c1);
    c2a = abs(c2);
    
    cylinder(d1=(d-2*c1),d2=d,h=c1a,$fn=$fn);
    translate([0,0,c1a-local_nudge]) cylinder(d=d,h=h-c1a-c2a+(2*local_nudge),$fn=$fn);
    translate([0,0,h-c2a])
        cylinder(d2=(d-2*c2),d1=d,h=c2a,$fn=$fn);
}
