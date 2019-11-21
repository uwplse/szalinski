// The length of the handle from where it meets the surface of the blade.
handle_length = 100;

// The handle style.
handle_style = "flared"; // [straight, conic, flared]

// The thickness of the handle at its thickest point, top to bottom when the blade is facing up/down.
handle_thickness = 30;

// The width of the handle at its widest point, measured left to right when the blade is facing up/down.
handle_width = 45;

// The distance the handle should be offset from the usual position where it meets the blade. A higher number makes the handle effectively shorter.
handle_offset = 10;

// The width of the blade at its widest point.
blade_width = 150;

// The length of the blade at its longest point.
blade_length = 160;

// The thickness of the blade.
blade_thickness = 6;

// The blade shape.
blade_shape = "oblong"; // [oval, pear, square, oblong]

// The blade texture.
blade_texture = "smooth"; // [smooth, pimpled, perforated]

/* [Hidden] */
$fs = 1;
$fa = 1;

module paddle(handle_length=100, handle_style="straight", handle_thickness=25, handle_width=35, handle_offset=0, blade_width=150, blade_length=160, blade_thickness=6, blade_shape="pear", blade_texture="smooth") {

    // Blade
    if ( "smooth" == blade_texture ) {
        blade_body(blade_width, blade_length, blade_thickness, blade_shape);
    }
    else if ( "pimpled" == blade_texture ) {
        blade_body(blade_width, blade_length, blade_thickness, blade_shape);
        
        intersection() {
            blade_body(blade_width, blade_length, blade_thickness + 1, blade_shape);
            
            translate([-blade_width / 2, -blade_length / 2, -(blade_thickness + 1 ) / 2]) {
                for ( col = [0 : 2 : blade_width] ) {
                    for ( row = [0 : 2 : blade_length] ) {
                        translate([col, row, 0]) cylinder(r=.5, h = blade_thickness + 1);
                    }
                }
            }
        }
    }
    else if ( "perforated" == blade_texture ) {
        difference() {
            blade_body(blade_width, blade_length, blade_thickness, blade_shape);
            
            translate([-blade_width / 2, -blade_length / 2, -(blade_thickness + 1 ) / 2]) {
                for ( col = [0 : 4 : blade_width] ) {
                    for ( row = [0 : 4 : blade_length] ) {
                        translate([col, row, 0]) cylinder(r=1, h = blade_thickness + 1);
                    }
                }
            }
        }
    }

    // Handle
    translate([0, -(blade_length / 2) + handle_offset + blade_thickness, 0]) rotate([90, 0, 0]) rotate([0, 0, 90]) {
        intersection() {
            union() {
                if ( "straight" == handle_style ) {
                    linear_extrude(handle_length) {
                        scale([1, handle_width / handle_thickness, 1]) {
                            circle(r=handle_thickness/2);
                        }
                    }
                }
                else if ( "conic" == handle_style ) {
                    translate([0, 0, handle_length]) rotate([0,180,0]) linear_extrude(handle_length, scale=[.75,.75]) scale([1, handle_width / handle_thickness, 1]) circle(r=handle_thickness/2);
                }
                else if ( "flared" == handle_style ) {
                    translate([0, 0, handle_length]) {
                        rotate([0,180,0]) {
                            scale([handle_thickness / handle_width, 1, 1]) {
                                flared_cone(handle_width / 2, handle_width / 2 / 2, handle_length );
                            }
                        }
                    }
                }
            }
            
            vertical_offset = sqrt( 2 * pow(handle_length / 2, 2)) - ( blade_thickness / 2 );
            
            translate([0, 0, vertical_offset]) rotate([0, 45, 0]) cube([handle_length, handle_length, handle_length], true); 
        }
    }
}

module blade_body(blade_width, blade_length, blade_thickness, blade_shape) {
    // Blade
    translate([0, 0, -blade_thickness / 2]) linear_extrude(blade_thickness) {
        if ( "oval" == blade_shape ) {
            scale([1, blade_length / blade_width, 1]) circle(r=blade_width/2);
        }
        else if ( "pear" == blade_shape ) {
            hull() {
                offset = blade_length - ( blade_width / 2 ) - ( blade_width / 2.2 );
                
                translate([0, -offset / 2, 0]) {
                    translate([0, offset, 0]) circle(r=blade_width / 2.2 );
                    circle(r=blade_width / 2);
                }
            }
        }
        else if ( "square" == blade_shape ) {
            square([blade_width, blade_length], true);
        }
        else if ( "oblong" == blade_shape ) {
            if ( blade_length > blade_width ) {
                hull() {
                    translate([0, -(blade_width / 2) + (blade_length / 2), 0]) circle(r=blade_width / 2);
                    translate([0, (blade_width / 2) - (blade_length / 2), 0]) circle(r=blade_width / 2);
                }
            }
            else {
                hull() {
                    translate([-(blade_length / 2) + (blade_width / 2), 0, 0]) circle(r=blade_length / 2);
                    translate([(blade_length / 2) - (blade_width / 2), 0, 0]) circle(r=blade_length / 2);
                }
            }
        }
    }
}

module flared_cone(r1, r2, h) {
    // Adapted from the pillar_rounded() module from http://www.thingiverse.com/thing:212041/
    // This only does half a pillar, so it's really a flared cone.
    rad_co=((r2-r1)*(r2-r1)+0.25*h*2*h*2)/(2*(r1-r2));
    
    rotate_extrude() {
        difference() {
            square([r1, h]);
            translate([r2+rad_co,h,0]) {
                circle(r=rad_co, $fa = 1);
            }
        }
    }
}

paddle(handle_length=handle_length, handle_style=handle_style, handle_thickness=handle_thickness, handle_width=handle_width, handle_offset=handle_offset, blade_width=blade_width, blade_length=blade_length, blade_thickness=blade_thickness, blade_shape=blade_shape, blade_texture=blade_texture);
