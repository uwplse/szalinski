$fn = 50;

// number of GU slots
gels = 5; // [5:12]
gel_width = 32 / 1;
gel_cut_width = 28 / 1;
gel_opening = 2 / 1;
gel_spacing = 10 / 1;

ladder_margin = 16 / 1;
ladder_length = gel_opening * gels + gel_spacing * (gels - 1) + ladder_margin * 2;
ladder_width = gel_width + gel_opening;
ladder_thickness = 4 / 1;
ladder_round = 1 / 1;

// diameter of front stem
stem_diameter = 46; // [44:50]
stem_radius = stem_diameter / 2;

zip_thickness = 1.5 / 1;
zip_width = 3.75 / 1;
zip_height = 4.25 / 1;

logo_head = 10 / 1;
logo_m_thick = 6 / 1;
logo_m_thin = 4 / 1;

// show logo (just for fun)
logo = "yes"; // [yes, no]

// add slot for second zip tie (recommended)
second_zip_tie = "yes"; // [yes, no]

module slot() {
    translate([0, 0, -(ladder_thickness / 2)]) {
        hull() {
            cube([gel_opening, gel_width, 0.01], true);
            translate([gel_opening, 0, ladder_thickness]) {
                cube([gel_opening, gel_cut_width, 0.01], true);
            }
        }
    }
}

module ladder() {
    difference() {
        union() {
            // initial ladder
            cube([ladder_length, ladder_width, ladder_thickness], true);
            
            // add on the front ring for the zip tie, make it a half ring
            translate([-ladder_length / 2 - ladder_margin * .75, 0, zip_height / 2]) {
                    difference() {
                        cylinder(ladder_thickness + zip_height, stem_radius * 1.15, stem_radius * 1.15, true);
                        translate([-stem_radius, 0, 0]) {
                            cube([stem_diameter, stem_diameter, stem_diameter], true);
                        }
                    }
            }        
        }
        
        translate([-(ladder_length / 2) - zip_thickness * 3 - ladder_margin * .75 + 4, 0, 0]) {
                cylinder(ladder_thickness * 5, stem_radius * .9, stem_radius * .9, true);
        }

        
         // remove sides
        translate([-ladder_length, ladder_width, 0]) {
            cube([ladder_length * 2, ladder_width, ladder_thickness * 5], true);
        }

        translate([-ladder_length, -ladder_width, 0]) {
            cube([ladder_length * 2, ladder_width, ladder_thickness * 5], true);
        }  
        

    }
    

    // round off the end of the ladder
    difference() {
        translate([ladder_length / 2 - stem_diameter * .8, 0, 0]) {
            cylinder(ladder_thickness, stem_diameter, stem_diameter, true);
        }
        translate([0, ladder_width, 0]) {
            cube([ladder_length * 10, ladder_width, ladder_thickness + .1], true);
        }
        translate([0, -ladder_width, 0]) {
            cube([ladder_length * 10, ladder_width, ladder_thickness + .1], true);
        }

        translate([-ladder_width, 0, 0]) {
                cube([ladder_width, ladder_width, ladder_width], true);
        }        
    }

}

module stemzip() {
    difference() {
        cylinder(zip_height, stem_radius * 1.03, stem_radius * 1.03, true);
        scale([.94, .94, .94 ]) {
            cylinder(zip_height * 2, stem_radius, stem_radius, true);
        }
    }
}


// showtime!
module main() {
    difference() {
        ladder();
        translate([-(ladder_length / 2 + stem_radius + ladder_margin) + zip_height - zip_thickness, 0, zip_height / 2]) {
            stemzip();
        }    
        for (offset = [0: gels]) {
            translate([(gel_opening + gel_spacing) * offset - ladder_length / 2 + ladder_margin * 1.75, 0, 0]) {
                if (offset < gels) {
                    slot();
                }
                
                if (second_zip_tie == "yes") {
                    if (offset == gels) {
                        translate([- (gel_spacing / 2) + 1, ladder_width / 2 - 8, 0]) {
                            rotate([60, 0, 0]) {
                                cube([zip_height, zip_width, ladder_thickness * 3], true);
                            }
                        }
                        translate([- (gel_spacing / 2) + 1, -ladder_width / 2 + 8, 0]) {
                            rotate([-60, 0, 0]) {
                                cube([zip_height, zip_width, ladder_thickness * 3], true);
                            }
                        }
                    }
                }
                
            }

        }
    }
}

module logo_half() {
    translate([0, -(logo_m_thick / 2 + 6), 0]) {    
        hull() {
            
            translate([-(logo_m_thick * 1), 4.5, 0]) {
                cube([logo_m_thick, logo_m_thick, logo_head], true);
            }
         
            translate([logo_m_thick + (logo_m_thick - logo_m_thin) / 2, 7, 0]) {
                cube([logo_m_thin, logo_m_thin, logo_head], true) {
                }
            }
        }
        translate([-(logo_m_thick * 1), 0, 0]) {
            cube([logo_m_thick, logo_m_thick, logo_head], true);
        }
        
        translate([0, 0, 0]) {
            cube([logo_m_thick * 3, logo_m_thick, logo_head], true);
        }
    }
}

module logo() {
    translate([0, logo_m_thick * 3 - 3, 0]) {
        cylinder(logo_head, 4.5, 4.5, true);
    }
    rotate([0, 0, -90]) {
        translate([0, logo_m_thin / 2, 0]) {
            logo_half();
        }
        translate([0, -(logo_m_thin / 2), 0]) {
            mirror([0, 1, 0]) {
                logo_half();
            }
        }
    }
}




difference() {
    union() {
        rotate([0, 0, -90]) {
            main();
        }

        if (logo == "yes") {
            // add the logo
            translate([0, ladder_length / 2 - ladder_margin - gel_spacing + 3, 2]) {
                scale([.3, .3, .3]) {
                    logo();
                }
            }
        }
    }



    translate([0, ladder_length / 2 + ladder_margin - zip_thickness * 3.3, ladder_thickness / 2 + .2]) {
        stemzip();
    }
}

