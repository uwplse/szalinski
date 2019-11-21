tier_one_radius=150;
tier_one_height=25;
tier_one_number_of_holes=40;
tier_one_holes_offset=90;
tier_two_radius=75;
tier_two_height=75;
tier_two_number_of_holes=20;
tier_two_holes_offset=37;
fillet_radius=10;
roundover_radius=5;
fillet=true;
roundover=true;
divots=true;
draft_angle=3;

module fillet_module() {
    translate([0,0,tier_one_height]) {
        rotate_extrude(angle=360) {
            translate([tier_two_radius-(tan(draft_angle)*(tier_one_height+fillet_radius)),0]) {
                difference() {
                    square(fillet_radius);
                    translate([fillet_radius,fillet_radius]) circle(fillet_radius);
                }
            }
        }
    }
}

module roundover_module(radius,height) {
    translate([0,0,height]) {
        rotate_extrude(angle=360) {
            translate([radius-(tan(draft_angle)*(height-roundover_radius)),0]) {
                difference() {
                    translate([-roundover_radius,-roundover_radius]) square(roundover_radius);
                    translate([-roundover_radius,-roundover_radius]) circle(roundover_radius);
                }
            }
        }
    }
}

difference() {
    union() {
        cylinder(r=tier_one_radius,h=tier_one_height,r2=tier_one_radius-(tan(draft_angle)*tier_one_height));
        cylinder(r=tier_two_radius,h=tier_two_height,r2=tier_two_radius-(tan(draft_angle)*tier_two_height));
        if (fillet) {
            fillet_module();
        }
    }
    union() {
        if (divots) {
            for (a=[0:(360/tier_one_number_of_holes):360]) {
                rotate([0,0,a]) translate([tier_one_holes_offset,0,tier_one_height-1]) cylinder(r1=0,r2=2,h=2);
            }
            for (a=[0:(360/tier_two_number_of_holes):360]) {
                rotate([0,0,a]) translate([tier_two_holes_offset,0,tier_two_height-1]) cylinder(r1=0,r2=2,h=2);
            }
            if (roundover) {
                roundover_module(tier_one_radius,tier_one_height);
                roundover_module(tier_two_radius,tier_two_height);
            }
        }
    }
}