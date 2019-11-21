//  GEOMETRIC VASE,
//  by Garrett Goss, 2018, published 01/02/2019
//

TYPE = 0; //[0:"mirrored herringbone",1:"mirrored",2:"spiral herringbone",3:"spiral"]
TWIST_ANGLE = 60;
ROTATION_ANGLE = 10;
TAPER_SCALE_1 = 1.2;
TAPER_SCALE_2 = 1.4;

// preview[tilt:top_diagonal]

/* [Hidden] */

TWIST_ANGLE_2 = TYPE==0 ? -TWIST_ANGLE : TYPE==2 ? -TWIST_ANGLE : TWIST_ANGLE;
MIRROR = TYPE==0 ? 1 : TYPE==1 ? 1 : 0;

// Create base shape
module base(){
    minkowski(){
        difference(){
            circle(d=200,$fn=16);
            for (i=[1:7]) rotate([0,0,i*360/7]) translate([120,0,0]) rotate([0,0,180]) circle(d=145,$fn=15);
        }
    circle(3, $fn=8);
    }
}

module bottom_half(){
    linear_extrude(height=100, convexity=10, twist=TWIST_ANGLE, slices=30, scale=TAPER_SCALE_1) 
        base();
}

module top_half(){
    linear_extrude(height=100, convexity=10, twist=TWIST_ANGLE_2, slices=30, scale=TAPER_SCALE_2) 
        projection(cut=true) 
            translate([0,0,-100]) 
                bottom_half(); 
}

// Stack bottom_half() and top_half()
module herringbone(){
    top_half();
    translate([0,0,-100]) 
        bottom_half();
}

// Overlay herringbone() and a mirrored copy for a fun geometrical effect
translate([0,0,100]){
    union(){
        herringbone();
        mirror([MIRROR,0,0])
            rotate([0,0,ROTATION_ANGLE])
                herringbone();
    }
}