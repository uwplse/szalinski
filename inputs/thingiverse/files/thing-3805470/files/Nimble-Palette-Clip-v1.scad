
$fa=.25;
$fs=.25;

// VARS

wall_thickness=2;
slop=.4;

// mounting bolts and towers
bolt_head_diameter=5;
bolt_head_height=2.6;
bolt_tower_byclamp_diameter=7.12;
bolt_tower_alone_diameter=6.15;
bolt_tower_height=8-1-bolt_head_height; // actually 7.8-8.1 incl head
cap_height=2;
bolt_head_hole_diameter=bolt_head_diameter+slop*2;
bolt_tower_byclamp_hole_diameter=bolt_tower_byclamp_diameter+slop*2;
bolt_tower_alone_hole_diameter=bolt_tower_alone_diameter+slop*2;

// grommet
grommet_overall_radius=11.8/2;
grommet_inner_radius=8/2;
grommet_hole_radius=4.6/2;
grommet_rounding_radius=1.5;
grommet_lip_height=grommet_rounding_radius; // happens to be this thick
grommet_burger=2; // the gap between lips, like the burger thickness between the buns
grommet_overall_height=grommet_rounding_radius*2+grommet_burger;

// funnel
outgoing_radius=4/2;
grommet_probe_radius=8.8/2;
grommet_probe_thickness=1.6;
grommet_cavity_radius=grommet_overall_radius+slop*2;
stem_length=5;
stem_radius=outgoing_radius+wall_thickness;
funnel_radius=grommet_cavity_radius+wall_thickness;
grommet_cavity_height=slop+grommet_lip_height+(grommet_burger-grommet_probe_thickness)/2;
outgoing_clearance=max(3,funnel_radius-stem_radius); // <=45*

// breech
breech_above_bolts=2;
breech_finger_clearance=5;

// funnel_holder
funnel_holder_inner_radius=stem_radius+slop;
funnel_holder_outer_radius=funnel_holder_inner_radius+wall_thickness;
funnel_holder_length=stem_length;
funnel_holder_rise=bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance;

// bolt and filament triangle
between_filament_and_bolt_byclamp=11.5;
between_filament_and_bolt_alone=10.3;
between_bolts=18.5;
filament_diameter=1.75;
// from the perspective of the filament hole, looking toward clamp
oncenter_left=between_filament_and_bolt_alone+bolt_head_diameter/2+filament_diameter/2;
oncenter_right=between_filament_and_bolt_byclamp+bolt_head_diameter/2+filament_diameter/2;
oncenter_opposite=between_bolts+bolt_head_diameter;
echo("oncenter_left is ", oncenter_left, "; oncenter_right is ", oncenter_right, "; oncenter_opposite is ", oncenter_opposite);
//left_angle=acos((pow(oncenter_left,2)+pow(oncenter_opposite,2)-pow(oncenter_right,2))/2*oncenter_left*oncenter_opposite);
left_angle=acos((pow(oncenter_left,2)+pow(oncenter_opposite,2)-pow(oncenter_right,2))/(2*oncenter_left*oncenter_opposite));
echo("left_angle is ", left_angle);
right_angle=acos((pow(oncenter_right,2)+pow(oncenter_opposite,2)-pow(oncenter_left,2))/(2*oncenter_right*oncenter_opposite));
echo("right_angle is ", right_angle);
// now use that to calculate the height of the triangle at the filament hole, which will be Opposite for both angles at bolts
// we'll use this to calculate the plane shift angle
// sin(left_angle)=x/oncenter_left
oncenter_filament_to_bolt_axis=sin(left_angle)*oncenter_left;
echo("oncenter_filament_to_bolt_axis is ", oncenter_filament_to_bolt_axis);
left_rotation=180-90-left_angle;
right_rotation=180-90-right_angle;

// sleeve clamp hook
sleeve_clamp_radius_upper=10.7/2;
sleeve_clamp_radius_lower=16.8/2;
across_clamp_and_near_bolt=18.9;
between_clamp_and_far_bolt=13.6;
across_camp_and_its_nut=14.2; // smaller upper upper?
sleeve_clamp_bolt_clearance=3;
oncenter_clamp_to_near=across_clamp_and_near_bolt-sleeve_clamp_radius_upper-bolt_head_diameter/2;
oncenter_clamp_to_far=between_clamp_and_far_bolt+sleeve_clamp_radius_upper+bolt_head_diameter/2;
sleeve_clamp_hook_hole_radius=sleeve_clamp_radius_upper+slop;
sleeve_clamp_hook_outer_radius=sleeve_clamp_hook_hole_radius+wall_thickness*3;
sleeve_clamp_hook_height=sleeve_clamp_bolt_clearance-slop;
sleeve_clamp_hook_altitude=bolt_tower_height+bolt_head_height;
sleeve_clamp_hook_angle=acos((pow(oncenter_clamp_to_near,2)+pow(oncenter_opposite,2)-pow(oncenter_clamp_to_far,2))/(2*oncenter_clamp_to_near*oncenter_opposite));
sleeve_clamp_hook_rotation=180-sleeve_clamp_hook_angle-right_angle;
echo("sleeve_clamp_hook_angle is ", sleeve_clamp_hook_angle, "; sleeve_clamp_hook_rotation is ", sleeve_clamp_hook_rotation);

// MAIN

// funnel
translate([40,0,stem_length+outgoing_clearance+grommet_cavity_height+grommet_probe_thickness]) rotate([180,0,0]) funnel();
// clip
enchilada();
    
// MODULES

module enchilada() {
    
    translate([0,0,funnel_holder_rise]) funnel_holder();
    rotate([0,0,left_rotation]) {
        // left bolt anchor (standalone)
        translate([0,oncenter_left,0]) {
            bolt_head_anchor(bolt_tower_alone_hole_diameter);
        }
        // left connector
/*
        translate([-2,funnel_holder_inner_radius,0]) {
            cube([4,oncenter_left-bolt_tower_alone_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
        }
*/
        hull() {
            intersection() {
                translate([0,0,funnel_holder_rise]) funnel_holder();
                translate([-3,funnel_holder_inner_radius,0]) {
                    cube([6,oncenter_left-bolt_tower_alone_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
                }
            }
            intersection() {
                translate([0,oncenter_left,0]) {
                    bolt_head_anchor(bolt_tower_alone_hole_diameter);
                }
                translate([-3,funnel_holder_inner_radius,0]) {
                    cube([6,oncenter_left-bolt_tower_alone_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
                }
            }
        }

    }
    rotate([0,0,-right_rotation]) {
        // right bolt anchor (by clamp)
        translate([0,oncenter_right,0]) {
            rotate([0,0,sleeve_clamp_hook_rotation]) difference() {
                bolt_head_anchor(bolt_tower_byclamp_diameter);
                // cut out side for bolt to enter
                translate([0,min(oncenter_clamp_to_near,sleeve_clamp_radius_lower+slop),0]) {
                    cylinder(r=sleeve_clamp_radius_lower+slop, h=bolt_tower_height+bolt_head_height);
                }
            }
            // cap
            translate([0,0,bolt_tower_height+bolt_head_height]) {
                cylinder(d=bolt_tower_byclamp_diameter+2*wall_thickness, h=sleeve_clamp_hook_height);
            }
            // clamp hook
            rotate([0,0,sleeve_clamp_hook_rotation]) {
                translate([0,oncenter_clamp_to_near,sleeve_clamp_hook_altitude]) {
                    hook();
                }
            }
        }
        // right connector
/*
        translate([-1,funnel_holder_inner_radius,0]) {
            cube([4,oncenter_right-bolt_tower_byclamp_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
        }
*/
        hull() {
            intersection() {
                translate([0,0,funnel_holder_rise]) funnel_holder();

                translate([-3,funnel_holder_inner_radius,0]) {
                    cube([6,oncenter_right-bolt_tower_byclamp_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
        }
                
            }
            intersection() {
                translate([0,oncenter_right,0]) {
                    bolt_head_anchor(bolt_tower_byclamp_diameter);
                }
                translate([-1.5,funnel_holder_inner_radius,0]) {
                    cube([4.5,oncenter_right-bolt_tower_byclamp_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
                }
            }
        }

    }

}

module hook() {
    difference() {
        cylinder(r=sleeve_clamp_hook_outer_radius, h=sleeve_clamp_hook_height);
        cylinder(r=sleeve_clamp_hook_hole_radius, h=sleeve_clamp_hook_height);
        // cut out a piece to make it a hook
        rotate([0,0,0]) {
            translate([-sleeve_clamp_hook_outer_radius,0,0]) {
                cube([sleeve_clamp_hook_outer_radius,sleeve_clamp_hook_outer_radius,sleeve_clamp_hook_height]);
            }
/*
            translate([-sleeve_clamp_hook_outer_radius*2+sleeve_clamp_hook_hole_radius/2,0,0]) {
                cube([sleeve_clamp_hook_outer_radius*2,sleeve_clamp_hook_outer_radius,sleeve_clamp_hook_height]);
            }
*/
        }
    }
}

/*
        rotate([0,0,30]) {
            translate([-sleeve_clamp_hook_outer_radius*1.75,sleeve_clamp_hook_hole_radius/4,0]) {
                cube([sleeve_clamp_hook_outer_radius*2,sleeve_clamp_hook_outer_radius*2,sleeve_clamp_hook_height]);
//                cylinder(r=sleeve_clamp_hook_hole_radius, h=sleeve_clamp_hook_height);            }
*/

module three_amigos() {
    translate([0,0,funnel_holder_rise]) funnel_holder();
    rotate([0,0,left_rotation]) {
        translate([0,oncenter_left,0]) {
            bolt_head_anchor(bolt_tower_alone_hole_diameter);
        }
        // connector
        translate([-2,funnel_holder_inner_radius,0]) {
            cube([4,oncenter_left-bolt_tower_alone_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
        }
    }
    rotate([0,0,-right_rotation]) {
        translate([0,oncenter_right,0]) {
            difference() {
                bolt_head_anchor(bolt_tower_byclamp_diameter);
                translate([-10,-7,0]) cube([10,14,10]);
            }
        }
        // connector
        translate([0,funnel_holder_inner_radius,0]) {
            cube([4,oncenter_right-bolt_tower_byclamp_hole_diameter/2-funnel_holder_inner_radius,bolt_tower_height+bolt_head_height+breech_above_bolts+breech_finger_clearance+funnel_holder_length]);
        }
    }
}

module funnel_holder() {
    difference() {
        cylinder(r=funnel_holder_outer_radius, h=funnel_holder_length);
        cylinder(r=funnel_holder_inner_radius, h=funnel_holder_length);
    }
}

module bolt_anchor_test() {
    difference() {
        bolt_head_anchor(bolt_tower_byclamp_diameter);
        translate([-10,-10,0]) cube([20,10,10]);
    }
    translate([oncenter_opposite,0,0]) bolt_head_anchor(bolt_tower_alone_hole_diameter);
    translate([bolt_tower_byclamp_hole_diameter/2,0,0]) cube([23.5-bolt_tower_byclamp_hole_diameter,bolt_tower_byclamp_hole_diameter/2,bolt_tower_height+bolt_head_height]);
}

module bolt_head_anchor(tower_diameter) {
    // tower ring
    difference() {
        cylinder(d=tower_diameter+2*wall_thickness, h=bolt_tower_height);
        cylinder(d=tower_diameter, h=bolt_tower_height);
    }
    // head ring
    translate([0,0,bolt_tower_height]) {
        difference() {
            cylinder(d=tower_diameter+2*wall_thickness, h=bolt_head_height);
            cylinder(d=bolt_head_hole_diameter, h=bolt_head_height);
        }
    }
    // cap
/*
    translate([0,0,bolt_tower_height+bolt_head_height]) {
            cylinder(d=tower_diameter+2*wall_thickness, h=cap_height);
    }    
*/
}

module funnel_and_grommet_test() {
    difference() {
        union() {
            funnel();
            translate([0,0,stem_length+outgoing_clearance+slop]) grommet();
        }
        translate([-20,-40,0]) cube(40);
    }
}


module funnel2D() {
    // stem
    difference() {
        square([stem_radius,stem_length]);
        square([outgoing_radius,stem_length]);
    }
    // funnel
    polygon([   [outgoing_radius,stem_length],
                [grommet_cavity_radius,stem_length+outgoing_clearance],
                [funnel_radius,stem_length+outgoing_clearance],
                [stem_radius,stem_length]
            ]);
    // grommet cavity
    translate([grommet_cavity_radius,stem_length+outgoing_clearance]) square([funnel_radius-grommet_cavity_radius,grommet_cavity_height]);
    // grommet probe
    translate([grommet_probe_radius,stem_length+outgoing_clearance+slop+grommet_lip_height+(grommet_burger-grommet_probe_thickness)/2]) square([funnel_radius-grommet_probe_radius,grommet_probe_thickness]);
}

module funnel() {
    rotate_extrude() {
        funnel2D();
    }    
}

module grommet() {
    rotate_extrude() {
        // curved edges
        translate([grommet_overall_radius-grommet_rounding_radius,0]) {
            translate([0,grommet_rounding_radius]) rotate([0,0,-90]) grommet_quarter_circle();
            translate([0,grommet_burger+grommet_rounding_radius]) translate([0,0]) rotate([0,0,0]) grommet_quarter_circle();
        }
        // 
        translate([grommet_hole_radius,0]) {
            square([grommet_overall_radius-grommet_rounding_radius-grommet_hole_radius,grommet_rounding_radius]);
            translate([0,grommet_burger+grommet_rounding_radius]) square([grommet_overall_radius-grommet_rounding_radius-grommet_hole_radius,grommet_rounding_radius]);
        }
        translate([grommet_hole_radius,grommet_rounding_radius]) square([grommet_inner_radius-grommet_hole_radius,grommet_burger]);
    }
}

module grommet_quarter_circle()  {
    difference() {
        circle(r=grommet_rounding_radius);
        translate([-grommet_rounding_radius,-grommet_rounding_radius]) {
            square([grommet_rounding_radius,2*grommet_rounding_radius]);
            square([2*grommet_rounding_radius,grommet_rounding_radius]);
        }
    }
}
