// Copyright (C) 2016-2017 - Olivier Podevin <hillheaven@free.fr>
//
// Content: A fully parameterizable funnel with handle.
//
//
// The script below has the following parameters:
//      - Overall thickness (neck tip is thinner than the funnel body and handle).
//      - Funnel body : height, min and max diameter.
//      - Funnel neck height and diameter.
//      - Handle diameter.
//
//  Advices while printing: nothing special.
//
// This file is an OpenSCAD script, see <http://www.openscad.org/> for details
//
// This work is licensed under the Creative Commons Attribution 4.0
// International license. To view a copy of this license, visit
// <http://creativecommons.org/licenses/by/4.0/>.

// Parameters in millimeters
thickness=1.6; // Overall thickness (neck tip is thinner than the funnel body and handle).
diam_body_max=50; // Funnel body max diameter
diam_body_min=10; // Funnel body min diameter
body_height=25; // Funnel body height (without neck)
neck_height=20; // Funnel neck height
diam_neck=6; // Neck tip diameter.
handle_diam=15; // Handle diameter. If equals 0 => no handle.

module funnel(thickness, diam_body_max, diam_body_min, body_height, neck_height, diam_neck, handle_diam) {
    union() {
        // Body
        difference() {
            cylinder(d1=diam_body_max, d2=diam_body_min, h=body_height, $fn=128);
            translate([0,0,-.1])
                cylinder(d1=diam_body_max-thickness*2, d2=diam_body_min-thickness*2, h=body_height+.2, $fn=128);
        }
    
        // neck
        translate([0,0,body_height])
            difference() {
                union() {
                    cylinder(d1=diam_body_min, d2=diam_neck, h=neck_height-thickness/2,$fn=64);
                    // Amincissement du goulot
                    translate([0,0,neck_height-thickness/2])
                        cylinder(d1=diam_neck, d2=0, h=diam_neck/2, $fn=64);
                }
                translate([0,0,-.1])
                    cylinder(d1=diam_body_min-thickness*2,d2=diam_neck-thickness,h=neck_height+.2,$fn=64);
                // Suppression pointe amincissement du goulot
                translate([-10,-10,neck_height])
                    cube([20,20,20]);
        }
        
        // Poignee
        if (handle_diam > 0) {
            handle_thickness = 1.5+(thickness*diam_body_max)/80;

            // rh = rayon poignee
            rh=handle_diam/2; 
            // theta = angle du corps de l'entonnoir avec l'axe Z
            theta = atan((diam_body_max/2-diam_body_min/2)/body_height);
            // P = distance entre le centre de la poignee et l'enveloppe du corps de l'entonnoir en // à l'axe X
            p=sqrt(rh*rh+rh*tan(theta)*rh*tan(theta));
            // s= delta de la pente du corps de l'entonnoir sur l'axe X (body_height étant le delta sur l'axe Z).
            s=diam_body_max/2-diam_body_min/2;
            // q = distance entre l'axe de début de pente du corps de l'entonnoir // a Z et l'enveloppe du corps de l'entonnoir
            q=(body_height-rh)*s/body_height;
            // offset_handle =  distance entre l'axe du centre de l'entonnoir et le centre de la poignee
            offset_handle = q + p + diam_body_min/2 - thickness;
        difference() {
            // handle body
                translate([0,handle_thickness/2,0]) {
                    difference() {
                        union() {
                            rotate([0,0,180])
                                translate([-offset_handle,0,0])
                                    cube([offset_handle,handle_thickness,handle_diam]);
                            rotate([90,0,0])
                                translate([offset_handle,handle_diam/2,0])
                                    cylinder(d=handle_diam, h=handle_thickness,$fn=64);
                        }
                            rotate([90,0,0])
                                translate([offset_handle,handle_diam/2,-.1])
                                    cylinder(d=handle_diam-thickness*2, h=handle_thickness+.2,$fn=64);
                    }
                }
         
                // Substract inner body cone
                translate([0,0,-.1])
                    cylinder(d1=diam_body_max-thickness, d2=diam_body_min-thickness, h=body_height+.2, $fn=128);
                // Substract inner neck cone
                translate([0,0,body_height-.1])
                    cylinder(d1=diam_body_min-thickness,d2=diam_neck-thickness,h=neck_height+.2,$fn=64);
                // Substract handle lower exceedind matter
                translate([-250,-250,-250])
                    cube([500, 500, 250]);
                // Thining neck's tip
                translate([0,0,body_height + neck_height-diam_neck/2])
                    cylinder(d1=diam_neck*2, d2=0, h=diam_neck, $fn=64);
            }
        } // fin poignee
    }
}

module main() {
   
    funnel(thickness, diam_body_max, diam_body_min, body_height, neck_height, diam_neck, handle_diam);
}

main();