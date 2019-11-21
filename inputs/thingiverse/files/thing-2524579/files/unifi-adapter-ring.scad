// variables that control the sizes of the adapter
tube_bump_diameter=8;
tube_height=20; // change this to adjust offset from ceiling
tube_inside_diameter=62;
tube_inside_radius=tube_inside_diameter/2;
tube_outside_diameter=70;
tube_outside_radius=tube_outside_diameter/2;
tube_width=tube_outside_radius-tube_inside_radius;
unifi_screw_hole_depth=15;
unifi_screw_hole_diameter=3.25;
ceiling_screw_hole_diameter=3.5;
ceiling_hole_depth=5;
ceiling_inside_hole_diameter=69.85;  // 2.75"
ceiling_inside_hole_radius=ceiling_inside_hole_diameter/2;
ceiling_outside_hole_diameter=88.9; // 3.5"
ceiling_outside_hole_radius=ceiling_outside_hole_diameter/2;
ceiling_tab_depth=10;

// hollow_cylinder
module hollow_cylinder(inside_diameter,outside_diameter,height) {
    difference() {
        cylinder(height,d1=outside_diameter,d2=outside_diameter,center=yes);
        translate([0,0,-1]) {
            cylinder(height+2,d1=inside_diameter,d2=inside_diameter,center=yes);
        }
    }
}

// holes
module hole(depth,diameter) {
    color( "black" ) {
        cylinder(depth,d1=diameter,d2=diameter,center=yes);
    }
}

// unifi mounting holes
module unifi_holes() {
    radius_from_center=tube_inside_diameter/2;
    height_from_center=tube_height-unifi_screw_hole_depth+1;
        
    translate([0,0,height_from_center]) {
        translate([radius_from_center,0,0]) {
            hole(unifi_screw_hole_depth+1,unifi_screw_hole_diameter);
        }
        translate([-radius_from_center,0,0]) {
            hole(unifi_screw_hole_depth+1,unifi_screw_hole_diameter);
        }
        translate([0,radius_from_center,0]) {
            hole(unifi_screw_hole_depth+1,unifi_screw_hole_diameter);
        }
        translate([0,-radius_from_center,0]) {
            hole(unifi_screw_hole_depth+1,unifi_screw_hole_diameter);
        }
    }
}

// ring_inside_bumps
module ring_inside_bumps() {
    tube_inside_radius=tube_inside_diameter/2;
    
    translate([tube_inside_radius,0,0]) {
        cylinder(tube_height,d1=tube_bump_diameter,d2=tube_bump_diameter,center=yes);
    }
    translate([-tube_inside_radius,0,0]) {
        cylinder(tube_height,d1=tube_bump_diameter,d2=tube_bump_diameter,center=yes);
    }
    translate([0,tube_inside_radius,0]) {
        cylinder(tube_height,d1=tube_bump_diameter,d2=tube_bump_diameter,center=yes);
    }
    translate([0,-tube_inside_radius,0]) {
        cylinder(tube_height,d1=tube_bump_diameter,d2=tube_bump_diameter,center=yes);
    }
}

// ceiling_holes
module ceiling_holes() {
    translate([(ceiling_outside_hole_diameter/2),0,-1]) {
        hole(ceiling_hole_depth+2,ceiling_screw_hole_diameter);
    }
    translate([-(ceiling_outside_hole_diameter/2),0,-1]) {
        hole(ceiling_hole_depth+2,ceiling_screw_hole_diameter);
    }
    translate([0,(ceiling_outside_hole_diameter/2),-1]) {
        hole(ceiling_hole_depth+2,ceiling_screw_hole_diameter);
    }
    translate([0,-(ceiling_outside_hole_diameter/2),-1]) {
        hole(ceiling_hole_depth+2,ceiling_screw_hole_diameter);
    }
}

// ring_outside_bumps
module ring_outside_bumps() {
    translate([(ceiling_outside_hole_diameter/2),0,0]) {
        cylinder(ceiling_hole_depth,d1=ceiling_tab_depth,d2=ceiling_tab_depth);
    }
    translate([-(ceiling_outside_hole_diameter/2),0,0]) {
        cylinder(ceiling_hole_depth,d1=ceiling_tab_depth,d2=ceiling_tab_depth);
    }
    translate([0,(ceiling_outside_hole_diameter/2),0]) {
        cylinder(ceiling_hole_depth,d1=ceiling_tab_depth,d2=ceiling_tab_depth);
    }
    translate([0,-(ceiling_outside_hole_diameter/2),0]) {
        cylinder(ceiling_hole_depth,d1=ceiling_tab_depth,d2=ceiling_tab_depth);
    }
}

// ring
module ring() {
     difference() {
        union() {
            hollow_cylinder(tube_inside_diameter,tube_outside_diameter,tube_height);
            ring_inside_bumps();
        }
        unifi_holes();
    }
}

// outside_bump_join
module outside_bump_join() {
    outside_bump_join_height=ceiling_tab_depth;
    bump_joiner_x_offset=tube_inside_radius+(tube_width/2);
    outside_bump_join_width=ceiling_outside_hole_radius-bump_joiner_x_offset;
    outside_bump_join_depth=ceiling_hole_depth;
    
    translate( [bump_joiner_x_offset,-(outside_bump_join_height/2),0] ) {
        cube( size=[outside_bump_join_width,outside_bump_join_height,outside_bump_join_depth] );
    }
}

// outside_bump_joins
module outside_bump_joins() {
    outside_bump_join();
    rotate(90) outside_bump_join();
    rotate(180) outside_bump_join();
    rotate(270) outside_bump_join();
}

// create the final object
union() {
    ring();
    difference() {
        union() {
            ring_outside_bumps();
            outside_bump_joins();
        }
        ceiling_holes();
    }
}