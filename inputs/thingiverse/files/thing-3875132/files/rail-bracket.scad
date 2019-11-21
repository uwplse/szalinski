// the diameter of the rail to be used (mm)
rail_diameter=20; // [5:100]

// the required width of this bracket (mm)
bracket_width=10; // [5:100]

// the diameter of the screws to be used (mm)
screw_diameter=4; // [1:0.5:10]

// whether to add a countersink to the screw holes
countersunk="yes"; // [yes, no]

/* [Hidden] */
thickness=rail_diameter*0.1;
screw_head_diameter=screw_diameter*2;
adjusted_bracket_width = screw_head_diameter >= bracket_width ? screw_head_diameter+2 : bracket_width;
base_width=2+screw_head_diameter+(rail_diameter/2)+thickness;

$fn=100;


difference(){
    union(){
        difference(){
            union(){
                difference(){
                    cylinder(h=adjusted_bracket_width, d=rail_diameter+2*thickness);
                    translate([0,0,-1]){
                        cylinder(h=adjusted_bracket_width+2, d=rail_diameter);
                    }
                }
                difference(){
                    base_plate();
                    base_plate_fillet();
                    mirror([0,1,0]){
                        base_plate_fillet();
                    }
                }
            }
            translate([rail_diameter/2-1, -thickness/4, -1]){
                cube(size=[thickness+2, thickness/2, adjusted_bracket_width+2]);
            }
        }
        
        main_loop_fillet();
        mirror([0,1,0]){
            main_loop_fillet();
        }
    }

    screw_hole();
    mirror([0,1,0]){
        screw_hole();
    }
}

module base_plate(){
    translate([rail_diameter/2, -base_width]){
        cube(size=[thickness, base_width*2, adjusted_bracket_width]);
    }
}
module base_plate_fillet(){
    difference(){
        translate([rail_diameter/2-0.1, -base_width-0.1, -0.1]){
            cube(size=[thickness+0.2, thickness/2+0.1, thickness/2+0.1]);
        }
        translate([rail_diameter/2-0.2, -base_width+thickness/2, thickness/2]){
            rotate([0,90,0]){
                cylinder(h=thickness+0.4, d=thickness);
            }
        }
    }


    difference(){
        translate([rail_diameter/2-0.1, -base_width-0.1, adjusted_bracket_width-thickness/2+0.1]){
            cube(size=[thickness+0.2, thickness/2+0.1, thickness/2+0.1]);
        }
        translate([rail_diameter/2-0.2, -base_width+thickness/2, adjusted_bracket_width-thickness/2]){
            rotate([0,90,0]){
                cylinder(h=thickness+0.4, d=thickness);
            }
        }
    }
}

module screw_hole(){
    translate([rail_diameter/2+thickness+0.1, base_width-(screw_head_diameter/2)-1, adjusted_bracket_width/2]){
        rotate([0,-90,0]){
            if(countersunk == "yes"){
                cylinder(h=thickness+0.2, d1=screw_diameter, d2=screw_head_diameter);
            } else {
                cylinder(h=thickness+0.2, d=screw_diameter);
            }
        }
    }
}

module main_loop_fillet(){
    fillet_diameter=3;
    fillet_origin_distance=(rail_diameter/2)+thickness+(fillet_diameter/2);
    fillet_angle=asin(((rail_diameter/2)-(fillet_diameter/2))/fillet_origin_distance);

    difference(){
        union(){
            translate([(rail_diameter/2)-thickness, thickness/2, 0]){
                cube(size=[thickness, fillet_origin_distance*cos(fillet_angle)-thickness/2, adjusted_bracket_width]);
            }
            rotate([0,0,-fillet_angle]){
                cube(size=[fillet_diameter/2, fillet_origin_distance, adjusted_bracket_width]);
            }

        }
        translate([0,0,-1]){
            cylinder(h=adjusted_bracket_width+2, d=rail_diameter);
        }
        translate([rail_diameter/2-(fillet_diameter/2), fillet_origin_distance*cos(fillet_angle), -1]){
            cylinder(h=adjusted_bracket_width+2, d=fillet_diameter);
        }
    }
}