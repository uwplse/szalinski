/*[Fan guard]*/
// fan guard radius(Effective defense radius)
fanguard_radius=70; //[65:100]
// Fanguard vine width
fanguard_width=2.5; //[1.5:0.5:10]
// Fanguard vine height
fanguard_height=3;  //[2.0:0.5:5]
// Select Fanguard Type
fanguard_armType=3;  //[0:3]

/*[Other checks]*/
// Performs best flip when printing
isInvert=false;
// The optimal angle for folding
isFineFolding=true;
// See the overlapping state when folded
isDebug=false;

/*[Hagger size]*/
width_upper=19.0;   //[17.0:0.1:21.0]
width_lower=14.5;   //[12.5:0.1:16.5]
length_upper=6.5;   //[5.0:0.1:8.0]
length_lower=4.0;   //[2.5:0.1:5.5]
length_lock=26.5;   //[25.0:0.1:28.0]



//
//rot_finefolding=isFineFolding ? atan(1.5/16) : 0;
//rot_finefolding=isFineFolding ? atan(fanguard_height/40) : 0;
rot_finefolding=isFineFolding ? atan(fanguard_height/40) : 0;

module upperLock() {
    ldeg1=atan(0.5/6.25);
    ldeg2=atan(0.6/6.25);
    ldeg3=atan(0.5/3);
    
    intersection() {
        translate([-9.5,-1,-6.25])
        cube([13,15,7.5]);
        
        rotate([0,ldeg1,0])
        union() {
            difference() {
                union() {
                    translate([-11.25,0,-7])
                    cube([7.75,1.5,8]);
                    
                    translate([-3.5,5,-7])
                    intersection() {
                        cylinder(h=8,r=5);
                        translate([0,-6,-1])
                        cube([6,6.5,10]);
                    }
                    
                    translate([0,5,-7])
                    cube([1.5,length_upper-3,8]);
                }
                
                translate([-4,5.5,-8])
                cylinder(h=10,r=4);
                
                translate([-11.25,0,-7])
                cube([-2,5,8]);
            }
            
            translate([0,length_upper,0])
            union() {
                difference() {
                    translate([0,0,-7])
                    cube([1.5,6,8]);
                    
                    translate([0,1.5,0])
                    rotate([-ldeg2,0,0])
                    translate([0,1.5,0])
                    rotate([0,0,-ldeg3])
                    translate([-2,0,-8])
                    cube([2,5,10]);
                }

                translate([0,1.5,0])
                rotate([-ldeg2,0,0])
                translate([-2,0,-7])
                cube([3,1.5,8]);
            }
        }
    }
}

module lowerLock() {
    ldev21=atan(1/1.5);
    ldev22=atan(0.75/7.5);
    ldev23=atan(0.25/7.5);
    ldev24=atan(0.5/8);
    ldev25=atan(0.75/8);
    
    intersection() {
        translate([-10,-5,-7.5])
        cube([15,15,7.5]);

        rotate([0,ldev22,0])
        translate([0,0,-8.75])
        union() {
            difference() {
                union() {
                    translate([-7.25,-2,0])
                    cube([6.75,1.5,10]);
                    translate([-0.5,0,0])
                    cylinder(h=10, r=2);
                }
                
                translate([-1,0.5,1])
                union() {
                    rotate([0,-ldev24,0]) {
                        rotate([-ldev24,0,0])
                        cylinder(h=8, r1=1.0, r2=1.5);
                        
                        translate([-2,-1,-2])
                        cube([2,2,12]);
                    }
                    
                    rotate([-ldev24,0,0])
                    translate([-1,0,-2])
                    cube([2,2,12]);
                }
            }
            
            translate([0,0,10])
            intersection() {
                translate([-1,0,-11])
                cube([4,10,12]);
                
                translate([0,length_lower-4,0])
                rotate([-ldev22,0,0])
                translate([-0.5,0,-10])
                difference() {
                    translate([0,-4,0])
                    cube([2,10,10]);
                    
                    translate([-0.5,-4.5,-1])
                    cube([1,8,12]);
                    
                    translate([0,4.5,0])
                    rotate([0,0,-ldev21])
                    translate([-5,-1,-1])
                    cube([5,10,12]);
                }
            }
        }
    }
}


module guardB31(plength) {
    lra=fanguard_radius+50;
    union() {
        difference() {
            union() {
                intersection() {
                    circle(fanguard_radius);
                    union() {
                        rotate([0,0,-140])
                        square(lra);
                        rotate([0,0,-130])
                        square(lra);
                    }
                }
                intersection() {
                    circle(fanguard_radius);
                    rotate([0,0,-90])
                    square(lra);
                    rotate([0,0,-130])
                    square(lra);
                }
            }
        }
        translate([-10.5,-20,0])
        square([21,40]);
    }            
}
module guardB32(plength) {
    lra=fanguard_radius+50;
    union() {
        difference() {
            union() {
                intersection() {
                    scale([(1-(10/fanguard_radius)),(1+(20/fanguard_radius)),0])
                    circle(fanguard_radius);
                    union() {
                        rotate([0,0,-140])
                        square(lra);
                        rotate([0,0,-130])
                        square(lra);
                    }
                }
                intersection() {
                    scale([(1-(12/fanguard_radius)),(1+(20/(fanguard_radius+fanguard_width))),0])
                    circle(fanguard_radius);
                    rotate([0,0,-90])
                    square(lra);
                    rotate([0,0,-130])
                    square(lra);
                }
            }
            rotate([0,0,-50])
            translate([0,-fanguard_radius,0])
            rotate([0,0,90-5])
            square([100,100]);
        }
        translate([-10.5,-20,0])
        square([21,40]);
    }            
}
module guardB33(plength) {
    lra=fanguard_radius+50;
    union() {
        difference() {
            union() {
                intersection() {
                    lsx1=(1-(11/fanguard_radius));
                    lsy1=(1+(25/(fanguard_radius+fanguard_width)));
                    scale([lsx1,lsy1,0])
                    circle(fanguard_radius);
                    rotate([0,0,-140])
                    square(lra);
                    translate([(sin(165)*lsy1*fanguard_radius)-lra,-lra,0])
                    square(lra);
                }
                intersection() {
                    scale([(1-(10/fanguard_radius)),(1+(18/(fanguard_radius+fanguard_width))),0])
                    circle(fanguard_radius);
                    rotate([0,0,-90])
                    square(lra);
                    rotate([0,0,-130])
                    square(lra);
                }
            }
            rotate([0,0,-50])
            translate([0,-fanguard_radius,0])
            rotate([0,0,90-5])
            square([100,100]);
        }
        translate([-10.5,-20,0])
        square([21,40]);
    }            
}
module guardB3() {
    // guard
//    lra=fanguard_radius+10;
    lgr=8;
    ldeg1=atan(0.5/6.25);
    
    translate([0,0,-fanguard_height])
    difference() {
        linear_extrude(height=fanguard_height, convexity=10)
        difference() {
            offset(r=lgr)
            offset(r=-lgr)
            if (fanguard_armType==1) { guardB31(); }
            else if (fanguard_armType==2) { guardB32(); }
            else if (fanguard_armType==3) { guardB33(); }

            offset(r=lgr-fanguard_width)
            offset(r=-lgr)
            difference() {
                if (fanguard_armType==1) { guardB31(); }
                else if (fanguard_armType==2) { guardB32(); }
                else if (fanguard_armType==3) { guardB33(); }
                translate([-50,-7.6,0])
                square([100,40]);
            }
        }
//        %circle(fanguard_radius);

        translate([-25,-4,-1])
        cube([50,30,20]);

        translate([0,-7.5,fanguard_height])
        rotate([0, rot_finefolding, 0]) //
        rotate([13,0,0])
        union() {
            translate([-width_upper/2,0,0])
            rotate([0,-ldeg1,0])
            translate([4,4,-18])
            union() {
                cylinder(h=20,r=4);
                translate([0,-4,0])
                cube([6,8,20]);
                translate([-4,0,0])
                cube([4,4,20]);
            }

            translate([width_upper/2,0,0])
            rotate([0,ldeg1,0])
            translate([-4,4,-18])
            union() {
                cylinder(h=20,r=4);
                translate([-6,-4,0])
                cube([6,8,20]);
                translate([0,0,0])
                cube([4,4,20]);
            }
        }
    }
}



module Properaguard() {
    $fn=144;

    //color("DodgerBlue")
    union() {
        // guard
        if (fanguard_armType>0) guardB3();
        
        // Hagger
        difference() {
            translate([0,-9,0])
            intersection() {
                translate([-15,-5,-50])
                cube([30,30,50]);
                
                rotate([0, rot_finefolding, 0])
                rotate([13, 0, 0])
                union() {
                    translate([-3.25,-1,-length_lock])
                    cube([6.5,3.5,length_lock+0.5]);
                    
                    translate([width_upper/2,0,0])
                    upperLock();
                    mirror([1,0,0])
                    translate([width_upper/2,0,0])
                    upperLock();
                    
                    difference() {
                        union() {
                            translate([width_lower/2,2,7.5-length_lock])
                            lowerLock();
                            mirror([1,0,0])
                            translate([width_lower/2,2,7.5-length_lock])
                            lowerLock();
                        }
                        rotate([-13, 0, 0])
                        translate([-15,-15,7.5-length_lock])
                        cube([30,30,10]);
                    }
                }
            }
        }
    }
}



rotate([0,isInvert ? 180 : 0,0])
if (!isDebug) {
    Properaguard();
} else {
    translate([0,10,0]) {
        // front
        translate([-22,0,0])
        rotate([0,0,180-30])
        rotate([-10,0,0])
        rotate([0, -rot_finefolding, 0])
        Properaguard();
        translate([22,0,0])
        rotate([0,0,180+30])
        rotate([-10,0,0])
        rotate([0, -rot_finefolding, 0])
        Properaguard();
    }

    translate([0,-10,0]) {
        // rear
        translate([-16,0,0])
        rotate([-7,0,0])
        rotate([0, -rot_finefolding, 0])
        Properaguard();
        translate([16,0,0])
        rotate([-7,0,0])
        rotate([0, -rot_finefolding, 0])
        Properaguard();
    }
}