/* [Customize] */

// the words that will appear on your tag.
tag_text = "IMOGEN";
// the font to render
font_name = "Nunito"; // [Roboto,Bungee,Noto Sans,Nunito,Oswald]
// the font size
font_size=6;


// preview[view:south, tilt:top]

// Model - Start

bold_font_name = str(font_name,":style=Bold");

//Arial Rounded MT Bold is a great 3d printer font. Sadly not available on thingiverse
//bold_font_name = "Arial Rounded MT Bold";
module build_key() { 
    difference() {
        union() {
            cylinder(h = 5, r1 = 20, r2 = 20, center = true);
            rotate_extrude(convexity = 10, $fn=100) {
            translate([20, 0, 0]) {
                circle(r = 4, $fn = 100);
                }
            }
            translate([0,60,0]) {
                rotate([90,0,0]) {
                    cylinder(h = 80, r1 = 4, r2 = 4, center = true, $fn=100);
                }
            }
            translate([0,102,0]) {
                rotate([90,0,0]) {
                    cylinder(h = 5, r1 = 2, r2 = 2, center = true, $fn=100);
                }
            }
            translate([0,104.5,0]) {
                sphere(r=2, $fn=100);
            }

            translate([0,92,-1.5]) {
                cube([10,8,3]);
            }

            translate([0,85,-1.5]) {
                cube([10,4,3]);
            }
            linear_extrude(height = 5) {
                text(tag_text,font=bold_font_name, size=font_size, valign="center",halign="center");
                }
        }
        translate([0, -13,0]) {
            cylinder(h=5, r1=3, r2=3, center=true, $fn=100);
        }
    }
}


module build_half(top_view) {
    difference() {
        rotate([0,(top_view==true) ? 180 : 0,0]) {
            build_key();
        }
        translate([-30,-30,-30]) {   
            cube([60,150,30]);
        }
    }
}

//build_half(true);
build_half(false);