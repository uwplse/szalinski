/*
 * Configurable Desktop Device Holder
 *
 * by 4iqvmk, 2018-12-20
 * https://www.thingiverse.com/4iqvmk/about
 * 
 * Licenced under Creative Commons Attribution - Share Alike 4.0 
 *
 * version 1.00 - initial version
*/

/* [Hidden] */

inch2mm = 0.3048/12*1000;
mm2inch = 12/0.3048/1000;
$fn=30;

/* [Parameters] */

// mm
thickness = 3;

// mm
holeOffset = 10;

// mm
bendRadius = 10;

// mm
holeFilletRadius = 10;

// mm
deviceLength = 165;

// mm
deviceWidth = 50;

// mm
deviceThickness = 17;

// mm
plugWidth = 30;

// mm
plugLength = 30;

// deg
leanAngle = 55;

/* [Hidden] */

/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

make(thickness, holeOffset, bendRadius, holeFilletRadius, deviceLength, 
    deviceWidth, deviceThickness, plugWidth, plugLength, leanAngle);



module make(_thickness, _holeOffset, _bendRadius, _holeFilletRadius, _deviceLength, 
    _deviceWidth, _deviceThickness, _plugWidth, _plugLength, _leanAngle) {

    balanceMargin = 0.1;
    cutoutN = 2.5;
        
    cosL = cos(leanAngle);
    sinL = sin(leanAngle);

    // height of the lowest part of the device
    // to keep the plug off the desk surface
    baseHeight = _plugLength*sinL;
    
    // depth of the shelf the bottom of the device sits on
    shelfDepth = 2*_thickness + (0.5 + sinL)*_deviceThickness;
        
    echo("shelfDepth=", shelfDepth);
    
    // height of the lip at the front of the shelf
    lipHeight = _thickness + _deviceThickness * cosL;

    // x,y coordinates of the centroid of the device
    deviceCG_x = _thickness + 0.5*_deviceThickness*sinL + 0.5*_deviceLength*cosL;
    deviceCG_y = baseHeight + 0.5*_deviceThickness*cosL + 0.5*_deviceLength*sinL;
        
    // x,y coordinates of the lower corner of the upper support point
    support_x = deviceCG_x + 0.5*_deviceThickness*sinL - balanceMargin*_deviceLength*cosL;
    support_y = deviceCG_y - 0.5*_deviceThickness*cosL - balanceMargin*_deviceLength*sinL;
    
    // x coordinate of base rear support point
    base_x = deviceCG_x + balanceMargin*_deviceLength;

    // x,y coordinates of circle center
    circle_x = base_x;
    circle_y = bendRadius+_thickness;

    X1 = support_x;
    Y1 = support_y;
    X0 = circle_x;
    Y0 = circle_y;
            
    D = sqrt(pow(X1-X0,2) + pow(Y1-Y0,2));
    R = bendRadius;
    L = sqrt(D*D - R*R);
    denom = (L*L + R*R);
    sinT = ( R * (X1-X0) + L * (Y1-Y0))/denom;
    cosT = (-L * (X1-X0) + R * (Y1-Y0))/denom;
    
    // x,y coordinates of tangent point from back support to inside of rear bend circle
    back_x = support_x + L*cosT;
    back_y = support_y - L*sinT;
    
    backAngle = atan2(sinT, cosT);

    difference () {
        linear_extrude(height = _deviceWidth, center = false){
            side_profile();
        }
        
        translate([0, baseHeight+_thickness, _deviceWidth/2]) {
            rotate(a = 90, v = [1, 0, 0]) {
                linear_extrude(height = baseHeight + 2*_thickness, center = false, scale=[1,1]) {
                    plug_cutout_profile();
                }
            }
        }

        translate([0, baseHeight, _deviceWidth/2]) {
            rotate(a = -90, v = [1, 0, 0]) {
                linear_extrude(height = (2*thickness+lipHeight), center = false, scale=[1,1.5]) {
                    plug_cutout_profile();
                }
            }
        }
        
        rotate(a = 90, v = [1, 0, 0]) {
            translate([0,0,-_thickness/2]) {
                linear_extrude(height = 2*_thickness, center = true) {
                    bottom_cutout_profile();
                }
            }
        }

        translate([back_x, back_y, 0]) {
            rotate(a = 180-backAngle, v = [0, 0, 1]) {
                rotate(a = 90, v = [1, 0, 0]) {
                    translate([0,0,_thickness/2]) {
                        linear_extrude(height = 2*_thickness, center = true) {
                            back_cutout_profile();
                        }
                    }
                }
            }
        }
                
    }

    module side_profile() {
        
        soften_profile(_thickness*0.49){
        
            union() {
                
                translate([0,baseHeight - _thickness,0]) {
                    square([shelfDepth, _thickness], center=false);
                }
                
                translate([0,baseHeight-_thickness,0]) {
                    square([_thickness, lipHeight+_thickness], center=false);
                }

                translate([shelfDepth-_thickness,0,0]) {
                    square([_thickness, baseHeight], center=false);
                }

                translate([shelfDepth/2-_thickness,0,0]) {
                    square([base_x - (shelfDepth/2-_thickness), _thickness], center=false);
                }
                
                translate([circle_x,circle_y,0]) {

                    difference() {
                        difference() {
                            circle(r = bendRadius+_thickness, center=false);
                            circle(r = bendRadius, center=false);
                        
                        }
                        
                        difference() {
                            
                            circle(r = bendRadius*2);
                            polygon([[0,0], [0, -4*bendRadius], [4*bendRadius, -4*bendRadius], [sin(backAngle)*4*bendRadius, cos(backAngle)*4*bendRadius], [0,0]]);
                            
                        }
                        
                    }
                }

                translate([back_x,back_y,0]) {
                    rotate(a = 90-backAngle, v = [0,0,1]) {
                        square([_thickness, L], center=false);
                    }
                }

            }
        }
    }
    
    module plug_cutout_profile() {
        super_ellipse([2*shelfDepth - 4*thickness, _plugWidth], center=true, n=cutoutN);
    }
    
    module bottom_cutout_profile() {
        
        cutout_len = base_x - shelfDepth+_thickness - 2*_holeOffset;
        cutout_width = _deviceWidth - 2*_holeOffset;
        
        cutoutCenter_x = (shelfDepth+_thickness + base_x)/2;
        
        translate([cutoutCenter_x, _deviceWidth/2, 0]) {
            super_ellipse([cutout_len, cutout_width], center=true, n=cutoutN);
        }
    }

    module back_cutout_profile() {
        
        cutout_len = L - 2*_holeOffset;
        cutout_width = _deviceWidth - 2*_holeOffset;
        
        cutoutCenter_x = _holeOffset + cutout_len/2;
        
        translate([cutoutCenter_x, _deviceWidth/2, 0]) {
            super_ellipse([cutout_len, cutout_width], center=true, n=cutoutN);
        }
    }
}


module super_ellipse(dims, center=true, n=2) {
    
    m = 20;
    
    points = concat([[0,0]], [for (k = [0:m])  [dims[0]/2*pow(cos(k/m*90), 2/n), dims[1]/2*pow(sin(k/m*90), 2/n)] ]);

    union() {
        polygon(points = points);
        mirror(v=[1,0,0]) { polygon(points = points);}
        mirror(v=[0,1,0]) { polygon(points = points); }
        mirror(v=[1,0,0]) { mirror(v=[0,1,0]) { polygon(points = points); } }
    }
}

module soften_profile(radius) {
    offset(r=0.5*radius) {
        offset(r=-1.5*radius) {
            offset(r=1.0*radius) {
                children();
            }
        }
    }
}
