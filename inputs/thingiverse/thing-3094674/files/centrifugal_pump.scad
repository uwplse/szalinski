/**************************************************************************\
|*                                                                        *|
|*                   Customizable Centrifugal Pump                        *|
|*                                                                        *|
|*                               by Svenny                                *|
|*                                                                        *|
|*          source: https://www.thingiverse.com/thing:3094674             *|
|*                                                                        *|
\**************************************************************************/

/* [General] */
// rendering precission
$fn = 60;
wall_thickness = 1.6;
view = "parts"; /* [parts, assembly_preview] */

/* [Engine settings] */
shaft_d = 2.1;
// diameter of engine body
engine_d1 = 20.2;
// smaller size of "flat" engine; use value bigger than engine_d1 for round engine
engine_d2 = 15.2;
// diameter of bearing case on engine forhead (must fit the hole in body)
engine_head_d = 6.2;
// height of the rim holding engine
engine_hold_h = 12;

/* [Size] */
// outer diameter of the body
centrifuge_d = 28;
// outer height of the body
centrifuge_h = 15;
// spacing between the propeller and body
propeller_offset = 1;
// radius of propeller blade curvature
propeller_blade_r = 14;
prop_d = centrifuge_d - 2*wall_thickness - 2*propeller_offset;
prop_h = centrifuge_h - 2*wall_thickness - 2*propeller_offset;

/* [Input and Output] */
suction_d = 10;
suction_inner_d = 8;
suction_h = 6;
output_d = 6;
output_inner_d = 5;
output_l = 6;

module propeller() {
    intersection() {
        difference() {
            union() {
                cylinder(d=prop_d, h=wall_thickness);
                cylinder(d=shaft_d+1.5*wall_thickness, h=prop_h);
                for(angle=[0:90:350])
                    rotate(angle)
                    translate([-propeller_blade_r+wall_thickness/2, 0, 0])
                    difference() {
                        intersection() {
                            cylinder(r=propeller_blade_r, h=prop_h);
                            translate([0, -propeller_blade_r, 0])
                            cube(propeller_blade_r);
                        }
                        cylinder(r=propeller_blade_r-wall_thickness, 
                                 h=3*prop_h, center=true);
                    }
            }
            cylinder(d=shaft_d, h=3*prop_h, center=true);
            translate([0,0,prop_h])
            scale([prop_h/suction_d, prop_h/suction_d, 0.7])
            sphere(d=prop_h);
        }
        cylinder(d=prop_d, h=prop_h);
    }
}

module body() {
    body_h = centrifuge_h-wall_thickness;
    difference() {
        union() {
            cylinder(d=centrifuge_d, h=body_h);
            hull() {
                translate([centrifuge_d/2-0.8*body_h, 0, 0])
                cube([0.8*body_h, centrifuge_d/2, body_h]);
                translate([(centrifuge_d-output_d)/2,
                           (centrifuge_d+body_h-output_d)/2,
                           body_h/2])
                sphere(d=output_d);
            }
            translate([(centrifuge_d-output_d)/2, 
                       (centrifuge_d+body_h-output_d)/2,
                       body_h/2])
            rotate([-90, 0, 0])
            cylinder(d=output_d, h=output_inner_d/2+output_l);
        }
        translate([0,0,wall_thickness])
        cylinder(d=centrifuge_d-2*wall_thickness, h=centrifuge_h-wall_thickness);
        cylinder(d=engine_head_d, h=3*wall_thickness, center=true);
        
        hull() {
            translate([centrifuge_d/2-0.8*body_h+wall_thickness, 0, wall_thickness])
            cube([0.8*body_h-2*wall_thickness, centrifuge_d/2, body_h-2*wall_thickness]);
            translate([centrifuge_d/2-output_d/2, 
                       (centrifuge_d+body_h-output_d)/2, 
                       body_h/2])
            sphere(d=output_inner_d);
        }
        translate([(centrifuge_d-output_d)/2,
                   (centrifuge_d+body_h-output_d)/2,
                   body_h/2])
        rotate([-90, 0, 0])
        cylinder(d=output_inner_d, h=output_inner_d/2+2*output_l);
    }
}

module engine_hold() {
    difference() {
        cylinder(d=centrifuge_d, h=wall_thickness/2);
        cylinder(d=engine_head_d, h=3*wall_thickness, center=true);
    }
    difference() {
        intersection() {
            cylinder(d=engine_d1+1.4*wall_thickness, h=engine_hold_h);
            cube([2*engine_d1, engine_d2+1.4*wall_thickness, 2*engine_hold_h], 
                 center=true);
        }
        intersection() {
            cylinder(d=engine_d1, h=3*engine_hold_h, center=true);
            cube([2*engine_d1, engine_d2, 3*engine_hold_h], center=true);
        }
    }
}

module lid() {
    difference() {
        union() {
            cylinder(d=centrifuge_d, h=wall_thickness);
            cylinder(d=suction_d, h=suction_h+wall_thickness);
        }
        cylinder(d=suction_inner_d, 3*(suction_h+wall_thickness), center=true);
    }
}

module parts() {
    body();
    translate([1.2*centrifuge_d, 0, 0]) propeller();
    translate([1.2*centrifuge_d, -1.2*centrifuge_d, 0]) lid();
    translate([0, -1.2*centrifuge_d, 0]) engine_hold();
}

module assembly_preview() {
    body();
    translate([0, 0, wall_thickness+propeller_offset]) propeller();
    translate([0, 0, 1.5*centrifuge_h]) lid();
    mirror([0,0,1]) translate([0, 0, 5*propeller_offset]) engine_hold();
}

if(view == "parts")
    parts();
else
    assembly_preview();