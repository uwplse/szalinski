wall_width = 2;

case_height = 12.6;
case_width = 74;
case_length = 120; // 115.2 USB2

bottom_case_height = 6.6;
bottom_wall_width = 3;

top_case_height = case_height - bottom_case_height;

clearance = 0.4;

screw_diameter = 2.5;
screw_head_diameter = 6;
screw_head_height = 2.2;

usb2_hole_offset = 7;
usb3_hole_offset = 5;
usb2_hole_width = 13;
usb3_hole_width = 17;

// 0: closed, 1: expanded, 2: bottom, 3: top
view = 0;

// 2: USB 2.0, 3: USB 3.0
usb_type = 3;

////////////////////////////////////////////////////////////////////

if (view != 3) {
    bottom();
}

if (view == 3) {
    top();
}

if (view == 1) {
    translate([case_width+20,0,0]) {
        top();
    }
}

if (view == 0) {
    translate([case_width+2*wall_width,0,20]) {
        rotate(180, [0,1,0]) {
            top ();
        }
    }
}

////////////////////////////////////////////////////////////////////

module top () {
    difference() {

        // outer box
        union() {

            cube ([case_width+2*wall_width, case_length+wall_width, top_case_height+bottom_wall_width]);
            
            // Screw holders
            translate([-screw_diameter/2-wall_width,screw_diameter/2+wall_width,0]) {
                translate([0,-screw_diameter/2-wall_width,0]) {
                    cube([screw_diameter+wall_width, screw_diameter+2*wall_width, top_case_height+bottom_wall_width]);
                }
                cylinder(h=top_case_height+bottom_wall_width, d=screw_diameter+2*wall_width, $fn=64);
            }
            translate([-screw_diameter/2-wall_width,case_length-screw_diameter/2,0]) {
                translate([0,-screw_diameter/2-wall_width,0]) {
                    cube([screw_diameter+wall_width, screw_diameter+2*wall_width, top_case_height+bottom_wall_width]);
                }
                cylinder(h=top_case_height+bottom_wall_width, d=screw_diameter+2*wall_width, $fn=64);
            }
            
            translate([case_width+screw_diameter/2+3*wall_width,screw_diameter/2+wall_width,top_case_height+bottom_wall_width]) {
                    rotate(180, [0,1,0]) {

                        translate([0,-screw_diameter/2-wall_width,0]) {
                            cube([screw_diameter+wall_width, screw_diameter+2*wall_width, top_case_height+bottom_wall_width]);
                        }
                        cylinder(h=top_case_height+bottom_wall_width, d=screw_diameter+2*wall_width, $fn=64);
                }
            }
            translate([case_width+screw_diameter/2+3*wall_width,case_length-screw_diameter/2,top_case_height+bottom_wall_width]) {
                rotate(180, [0,1,0]) {
                    translate([0,-screw_diameter/2-wall_width,0]) {
                        cube([screw_diameter+wall_width, screw_diameter+2*wall_width, top_case_height+bottom_wall_width]);
                    }
                    cylinder(h=top_case_height+bottom_wall_width, d=screw_diameter+2*wall_width, $fn=64);
                }
            }

        }
        
        // HDD (inner) box
        translate ([wall_width,wall_width,bottom_wall_width]) {
            cube ([case_width, case_length+clearance, top_case_height+clearance]);
        }
        
        // USB cable hole
        if (usb_type == 3) {
            translate([case_width-usb3_hole_offset+wall_width-usb3_hole_width,-clearance,bottom_wall_width]) {
                cube ([usb3_hole_width, wall_width+2*clearance, top_case_height+clearance]);
            }
        } else {
            translate([case_width-usb2_hole_offset+wall_width-usb2_hole_width,-clearance,bottom_wall_width]) {
                cube ([usb2_hole_width, wall_width+2*clearance, top_case_height+clearance]);
            }
        }
        
        // Ventilation holes
        offet = 30;
        holes = 5;
        step = case_width / holes;
        for (y =[offet:step:(holes-1)*step+offet]) {
            translate([case_width/2+wall_width,y,-clearance]) {
                linear_extrude(height = top_case_height+2*clearance) {
                    resize([case_width-20,10])circle(d=20,$fn=64);
                }
            }
        }
        
        // Screw holes
        translate([-screw_diameter/2-wall_width,screw_diameter/2+wall_width,-clearance]) {
            cylinder(d=screw_diameter, h=top_case_height+bottom_wall_width+2*clearance, $fn=64);
            cylinder(d=screw_head_diameter, h=screw_head_height+clearance, $fn=64);
        }
        translate([-screw_diameter/2-wall_width,case_length-screw_diameter/2,-clearance]) {
            cylinder(d=screw_diameter, h=top_case_height+bottom_wall_width+2*clearance, $fn=64);
            cylinder(d=screw_head_diameter, h=screw_head_height+clearance, $fn=64);
        }
        translate([case_width+screw_diameter/2+3*wall_width,screw_diameter/2+wall_width,-clearance]) {
            cylinder(d=screw_diameter, h=top_case_height+bottom_wall_width+2*clearance, $fn=64);
            cylinder(d=screw_head_diameter, h=screw_head_height+clearance, $fn=64);
        }
        translate([case_width+screw_diameter/2+3*wall_width,case_length-screw_diameter/2,-clearance]) {
            cylinder(d=screw_diameter, h=top_case_height+bottom_wall_width+2*clearance, $fn=64);
            cylinder(d=screw_head_diameter, h=screw_head_height+clearance, $fn=64);
        }
    }

    // Screw holes support
    translate([-screw_diameter/2-wall_width,screw_diameter/2+wall_width,0]) {
        difference() {
            cylinder(d=screw_diameter+0.5, h=screw_head_height, $fn=64);
            translate([0,0,-clearance]) {
                cylinder(d=screw_diameter, h=screw_head_height+2*clearance, $fn=64);
            }
        }
    }
    translate([-screw_diameter/2-wall_width,case_length-screw_diameter/2,0]) {
        difference() {
            cylinder(d=screw_diameter+0.5, h=screw_head_height, $fn=64);
            translate([0,0,-clearance]) {
                cylinder(d=screw_diameter, h=screw_head_height+2*clearance, $fn=64);
            }
        }
    }
    translate([case_width+screw_diameter/2+3*wall_width,screw_diameter/2+wall_width,0]) {
        difference() {
            cylinder(d=screw_diameter+0.5, h=screw_head_height, $fn=64);
            translate([0,0,-clearance]) {
                cylinder(d=screw_diameter, h=screw_head_height+2*clearance, $fn=64);
            }
        }
    }
    translate([case_width+screw_diameter/2+3*wall_width,case_length-screw_diameter/2,0]) {
        difference() {
            cylinder(d=screw_diameter+0.5, h=screw_head_height, $fn=64);
            translate([0,0,-clearance]) {
                cylinder(d=screw_diameter, h=screw_head_height+2*clearance, $fn=64);
            }
        }
    }
}
module bottom() {
    difference() {

        // outer box
        union() {

            cube ([case_width+2*wall_width, case_length+wall_width, bottom_case_height+bottom_wall_width]);
            
            // Screw holders
            translate([-screw_diameter/2-wall_width,screw_diameter/2+wall_width,0]) {
                ear();
            }
            translate([-screw_diameter/2-wall_width,case_length-screw_diameter/2,0]) {
                ear();
            }
            
            translate([case_width+screw_diameter/2+3*wall_width,screw_diameter/2+wall_width,bottom_case_height+bottom_wall_width]) {
                    rotate(180, [0,1,0]) {
                        ear();
                }
            }
            translate([case_width+screw_diameter/2+3*wall_width,case_length-screw_diameter/2,bottom_case_height+bottom_wall_width]) {
                rotate(180, [0,1,0]) {
                    ear();
                }
            }
        }
        
        // HDD (inner) box
        translate ([wall_width,wall_width,bottom_wall_width]) {
            cube ([case_width, case_length+clearance, bottom_case_height+clearance]);
        }
        
        // USB cable hole
        if (usb_type == 3) {
            translate([usb3_hole_offset+wall_width,-clearance,bottom_wall_width]) {
                cube ([usb3_hole_width, wall_width+2*clearance, bottom_case_height+clearance]);
            }
        } else {
            translate([usb2_hole_offset+wall_width,-clearance,bottom_wall_width]) {
                cube ([usb2_hole_width, wall_width+2*clearance, bottom_case_height+clearance]);
            }
        }
        
        // Ventilation holes
        offet = 30;
        holes = 5;
        step = case_width / holes;
        for (y =[offet:step:(holes-1)*step+offet]) {
            translate([case_width/2+wall_width,y,-clearance]) {
                linear_extrude(height = bottom_case_height+2*clearance) {
                    resize([case_width-20,10])circle(d=20,$fn=64);
                }
            }
        }
        
        // Screw holes
        translate([-screw_diameter/2-wall_width,screw_diameter/2+wall_width,bottom_wall_width]) {
            cylinder(d=screw_diameter, h=bottom_case_height+clearance, $fn=64);
        }
        translate([-screw_diameter/2-wall_width,case_length-screw_diameter/2,bottom_wall_width]) {
            cylinder(d=screw_diameter, h=bottom_case_height+clearance, $fn=64);
        }
        translate([case_width+screw_diameter/2+3*wall_width,screw_diameter/2+wall_width,bottom_wall_width]) {
            cylinder(d=screw_diameter, h=bottom_case_height+clearance, $fn=64);
        }
        translate([case_width+screw_diameter/2+3*wall_width,case_length-screw_diameter/2,bottom_wall_width]) {
            cylinder(d=screw_diameter, h=bottom_case_height+clearance, $fn=64);
        }
    }

    // Hanger
    translate([-screw_diameter/2-wall_width-0.2,screw_diameter/2+wall_width+6.,0]) {
        hanger(315);
    }
    translate([-screw_diameter/2-wall_width-0.2,case_length-screw_diameter/2-6.2,0]) {
        hanger(225);
    }
    translate([case_width+screw_diameter/2+3*wall_width+0.2,screw_diameter/2+wall_width+6.2,0]) {
        hanger(45);
    }
    translate([case_width+screw_diameter/2+3*wall_width-0.2,case_length-screw_diameter/2-6.2,0]) {
        hanger(135);
    }
 }

module hanger(rotation) {
    difference() {
        union() {
            rotate(rotation, [0,0,1]) {
                cylinder(d=9, h=bottom_wall_width, $fn=64);
                translate([-4.5,0,0]) {
                    cube ([9, 10, bottom_wall_width]);
                }
            }
        }
        translate([0,0,-clearance]) {
            cylinder(d=screw_diameter+2*clearance, h=bottom_wall_width+2*clearance, $fn=64);
        }
    }
}

module ear() {
    translate([0,-screw_diameter/2-wall_width,0]) {
        cube([screw_diameter+wall_width, screw_diameter+2*wall_width, top_case_height+bottom_wall_width]);
    }
    cylinder(h=top_case_height+bottom_wall_width, d=screw_diameter+2*wall_width, $fn=64);
}
