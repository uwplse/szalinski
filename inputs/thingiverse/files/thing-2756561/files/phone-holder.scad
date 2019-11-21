//built and tested with OpenSCAD version 2018.01.06 (git 3473eb1) 
//last modified January 14th, 2018

// (phone width [default: Moto Z2 Play + Moto Turbopower battery pack mod]) :
pwidth = 76.51; 
// (phone height [default: Moto Z2 Play + Moto Turbopower battery pack mod]) :
pheight = 156.2; 
// (phone thickness [default: Moto Z2 Play + Moto Turbopower battery pack mod]) :
pthick = 11.5; 

// (usb-type C port hole height) :
uheight = 8; //
// (usb type C port hole width) :
uwidth = 20; //
// (usb type C z-offset due to Moto Turbopower battery pack mod) :
uzoffset = 1.8; //
// (radius of type C port hole) :
urad = 3; //

// (center-to-center x-offset of usb type-c port and audio jack port) :
uaxoffset = 20; 
azoffset = uzoffset; //audio jack z-offset due to Moto Turbopower battery pack mod
// (radius of audio jack port, set to zero to eliminate) :
arad = 5; 
// (subtraction thickness, do not change) :
athick = 40; //subtraction thickness

// (padding, used to create thickness of external case relative to phone dimensions) :
pad = 4; //
// (radii of large corners) :
crad = 5; //
// (internal radii) :
irad = 1.5; //
// (tolerance to help fit of phone) :
tol = 1; //
// (width of brim that holds phone inside at the edges/bottom of screen) :
brim = 1.5; //

// (number of iterations for curved edges, lower for faster render time) :
fnsphere = 20; //

difference() {
    difference() {
        difference() {
            difference() {
                difference() {    
                    //EXTERNAL SHAPE
                    linear_extrude(height = pthick + pad + tol, center = true) {
                        offset(r=crad, $fn=fnsphere) {
                            square([pwidth + pad - 2*crad + tol,pheight + pad - 2*crad + tol], center = true);
                        }
                    }
                    //CUTOUT FOR PHONE
                    translate([0,pad/2,0]) rotate(a=[90,90,0]) linear_extrude(height = pheight+pad, center = true) {
                        offset(r=irad, $fn=fnsphere) {
                             square([pthick + tol - 2*irad,pwidth + tol - 2*irad], center = true);
                        }
                    }
                }
                //CUTOUT FOR SCREEN
                translate([0,4*brim,2*pad]) linear_extrude(height = pthick + 2*pad + brim, center = true) {
                    offset(r=crad, $fn=fnsphere) {
                         square([pwidth - 2*crad - 2*brim,pheight - 2*crad - 2*brim], center = true);
                    }
                }
            }
            //USB PORT
            translate([0,-pheight/2,uzoffset]) rotate(a=[90,90,0]) linear_extrude(height = uwidth, center = true) {
                offset(r=urad, $fn=fnsphere) {
                     square([uheight-2*urad,uwidth-2*urad], center = true);
                }
            }
        }
        //AUDIO PORT
        translate([uaxoffset,-pheight/2,azoffset]) rotate(a=[90,90,0]) linear_extrude(height = athick, center = true) {
             circle(r = arad, center = true, $fn=fnsphere);
        }
    }
    //Cut off top to make it less than full phone height
    translate([0,pheight*2*0.6,0]) cube([pwidth*2,pheight*2,pthick*2], center = true);
}

