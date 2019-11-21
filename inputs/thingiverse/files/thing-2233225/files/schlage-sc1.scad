// Schlage SC1 w/ Label - by Ben Wyrosdick
// Based on Physical Keygen - by Nirav Patel <http://eclecti.cc>
//
// Generate a duplicate of a Schlage SC1 key by changing the variables below.  
// If you don't know the key code, you can measure the key and compare the numbers at:
// http://web.archive.org/web/20050217020917fw_/http://dlaco.com/spacing/tips.htm

// This allows us to work in imperial measurements but output metric for the STL
function mm(i) = i*25.4;

/* [Cuts] */
// cut closest to tip of key
cut_1 = 1; //[0:9]

//
cut_2 = 5; //[0:9]

//
cut_3 = 3; //[0:9]

//
cut_4 = 6; //[0:9]

//
cut_5 = 3; //[0:9]

// cut closest to grip/bow of key
cut_6 = 9; //[0:9]

/* [Label] */
// will be embossed into the key
label = "Lake";
//depth of the lettering
textDepth = 1;
// size of the font
textSize = 6;
// font to use
textFont = "Times"; // [Arial,Times,Helvetica,Courier,Futura]

/* [hidden] */
fudge = 0.005;
$fn = 100;

module rounded(size, r) {
    union() {
        translate([r, 0, 0]) cube([size[0]-2*r, size[1], size[2]]);
        translate([0, r, 0]) cube([size[0], size[1]-2*r, size[2]]);
        translate([r, r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, r, 0]) cylinder(h=size[2], r=r);
        translate([r, size[1]-r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, size[1]-r, 0]) cylinder(h=size[2], r=r);
    }
}

module bit() {
    w = mm(1/4);
    difference() {
        translate([-w/2, 0, 0]) cube([w, mm(1), w]);
        translate([-mm(7/256), 0, 0]) rotate([0, 0, 135]) cube([w, w, w]);
        translate([mm(7/256), 0, 0]) rotate([0, 0, -45]) cube([w, w, w]);
    }
}

// Schlage SC1 5 pin key.  The measurements are mostly guesses based on reverse
// engineering some keys I have and some publicly available information.
module sc1(bits) {
    // You may need to adjust these to fit your specific printer settings
    thickness = mm(0.080);
    length = mm(1.2187);
    width = mm(.335);
    
    shoulder = mm(.231);
    pin_spacing = mm(.156);
    depth_inc = mm(.015);
    
    // Handle size
    h_l = mm(1);
    h_w = mm(1);
    h_d = mm(1/16);
    difference() {
        // blade and key handle
        union() {
            translate([-h_l, -h_w/2 + width/2, 0]) rounded([h_l, h_w, thickness], mm(1/4));
            intersection() {
                // cut a little off the tip to avoid going too long
                cube([length - mm(1/64), width, thickness]);
                translate([0, mm(1/4), thickness*3/4]) rotate([0, 90, 0]) cylinder(h=length, r=mm(1/4), $fn=64);
            }
        }
        
        // chamfer the tip
        translate([length, mm(1/8), -fudge]) {
            rotate([0, 0, 45]) cube([10, 10, thickness+2*fudge]);
            rotate([0, 0, 225]) cube([10, 10, thickness+2*fudge]);
        }
        
        // put in a hole for keychain use
        translate([-h_l + mm(3/16), width/2, -fudge]) cylinder(h=thickness+2*fudge, r=mm(1/8));
        
        // write text on Key
        translate([-h_l / 2 + mm(3/16)/2, width/2, 1-fudge])
        rotate([180,0,-90])
        linear_extrude(height = textDepth)
        text(label, size = textSize, font = textFont, valign="center", halign="center");
        
        // cut the channels in the key.  designed more for printability than accuracy
        union() {
            translate([-h_d, mm(9/64), thickness/2]) rotate([62, 0, 0]) cube([length + h_d, width, width]);
            translate([-h_d, mm(7/64), thickness/2]) rotate([55, 0, 0]) cube([length + h_d, width, width]);
            translate([-h_d, mm(7/64), thickness/2]) cube([length + h_d, mm(1/32), width]);
        }
        
        translate([-h_d, width - mm(9/64), -fudge]) cube([length + h_d, width - (width - mm(10/64)), thickness/2]);
        translate([-h_d, width - mm(9/64), thickness/2]) rotate([-110, 0, 0]) cube([length + h_d, width, thickness/2]);
        
        intersection() {
            translate([-h_d, mm(1/32), thickness/2]) rotate([-118, 0, 0]) cube([length + h_d, width, width]);
            translate([-h_d, mm(1/32), thickness/2]) rotate([-110, 0, 0]) cube([length + h_d, width, width]);
        }
        
        // Do the actual bitting
        for (b = [0:5]) {
            translate([shoulder + b*pin_spacing, width - bits[b]*depth_inc - fudge, 0]) bit();
        }
    }
}

// Flip the key over for easy printing
rotate([180, 0, 0]) sc1([cut_6,cut_5,cut_4,cut_3,cut_2,cut_1]);
