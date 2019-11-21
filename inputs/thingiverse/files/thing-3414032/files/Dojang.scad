$fn = 90;

// Type of dojang: 1 - Square, 2 - Circular
TYPE = 2; 

// Font to use. I recommend using a bold font so it prints better. The font will be system dependent. On Ubuntu 18.04, "NanumMyeongjo:style=Bold" is a good font
FONT = "NanumMyeongjo:style=Bold";

// Name to put on Dojang. The name will be centered and cropped to the size of the Dojang
NAME1 = "정민주";

// 2nd line of name. Optional. Set to "" to exclude. 
NAME2 = "";

// Text Height
TH = 3;

// Width of the Dojang. Diameter if a circular dojang. Length of a side if its square
W = 30;

// Height of Dojang. 
H = 45;

// Border Thickness
BORDER = 3;

// X Resize - Set to resize value for X direction, W-3*BORDER is a good value. Set to 0 to not resize
XRESIZE = W-3*BORDER;

// Y Resize - Set to resize value for Y direction, W-3*BORDER is a good value. Set to 0 to not resize
YRESIZE = W-3*BORDER;
//YRESIZE = 0;

// Y Offset - Set to 0 if only 1 line name. Set to an appropriate offset in mm if 2 line name. 5 is a good default.
YOFFSET = 0;
//YOFFSET = 5;


module name () {
    mirror([1,0,0])
        translate([0,YOFFSET,H-TH/2-0.01])
        resize([XRESIZE,YRESIZE,TH])
        linear_extrude(height = TH+0.01, center = true, convexity = 10, twist = 0) {    
            text(NAME1, halign="center", valign="center", font=FONT);
            if (NAME2 != "") {
                translate([0,-15,0])
                    text(NAME2, halign="center", valign="center", font=FONT);
            }
        }
}


name();
if (TYPE == 1) { // Square stamp
    translate([0,0,(H-TH)/2]) cube([W, W, H-TH], center=true);    
    difference () {
        translate([0,0,H/2]) cube([W, W, H], center=true);    
        translate([0,0,H/2]) cube([W-BORDER, W-BORDER, H*1.5], center=true);    
    }    
} else if (TYPE == 2) { // Circular stamp
    translate([0,0,(H-TH)/2]) cylinder(d=W, h=H-TH, center=true);    
    difference () {
        translate([0,0,H/2]) cylinder(d=W, h=H, center=true);    
        translate([0,0,H/2]) cylinder(d=W-BORDER, h=H*1.5, center=true);    
        }
} 
