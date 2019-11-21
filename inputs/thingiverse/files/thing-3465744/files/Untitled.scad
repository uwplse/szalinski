$fn = 200;
distance = 22;

length = 30;
curveHeight = 2;
mainR= 12.6;
mainThickness = 1.5;
discR = 25;
discHeight = 2.5 + curveHeight;
boltHoleR1 = 5;
boltHoleR2 = 2.5;
totalDiscR = discR + 5;
angleDegrees = 4;

bottomDiscHeight = length - (curveHeight * 2) - 5;

module cutoff() {
    difference() {
        sphere(d=curveHeight * 2,h=1);
        translate([-curveHeight,-curveHeight,0]) {
           cube([curveHeight * 2, curveHeight * 2, curveHeight], center = false);
        }
    }
 }

 module boltHole(r1, r2, height, position) {
    translate(position) {     
        cylinder(h = height / 2, r = r1, center = false);
        translate([0,0,height / 2]) {
            cylinder(h = height, r = r2, center = false);
        }
    }
}
 
module disc() {
    union() {
        difference() {
            translate([0, 0, 2]) {
                minkowski()
                {
                   cylinder(h = discHeight,r = discR ,center = false);
                    cutoff();
                   
                }
            }            
            
            
            //boltHole(boltHoleR1, boltHoleR2, discHeight, [distance - mainThickness, 0, 0]);
            boltHole(boltHoleR1, boltHoleR2, discHeight, [0, distance - mainThickness, 0]);
            //boltHole(boltHoleR1, boltHoleR2, discHeight, [-distance + mainThickness, 0, 0]);
            boltHole(boltHoleR1, boltHoleR2, discHeight, [0, -distance + mainThickness, 0]);
        }
        
        translate([0, 0, -5]) {
            rotate([0, angleDegrees, 0]) {
                cylinder(h = length,r = mainR + mainThickness ,center = false);
            }
        }
    }
}


!difference() {
    disc();
    
    translate([0, 0, -4]) {
        rotate([0, angleDegrees, 0]) {
            cylinder(h = length,r = mainR ,center = false);
        }
    }
    translate([-25, -25, -50]) {
        cube(50, center = false);
    }
      
}


 module boltHoleBig(r1, r2, height, position) {
    translate(position) {
        cylinder(h = height / 4, r = r1, center = false);
        translate([0,0,height / 4]) {
        cylinder(h = height, r = r2, center = false);
        }
    }
}


difference() {
    translate([70, 70, 0]) {
        cylinder(h = bottomDiscHeight, r = discR + 5, center = false);

    }
    translate([70, 70, 0]) {
        boltHoleBig(boltHoleR1, boltHoleR2, bottomDiscHeight, [distance, 0, 0]);
        boltHoleBig(boltHoleR1, boltHoleR2, bottomDiscHeight, [0, distance, 0]);
        boltHoleBig(boltHoleR1, boltHoleR2, bottomDiscHeight, [-distance, 0, 0]);
        boltHoleBig(boltHoleR1, boltHoleR2, bottomDiscHeight, [0, -distance, 0]);
        
        cylinder(h = bottomDiscHeight, r = mainR + mainThickness, center = false);
        
        translate([-50, 3 , bottomDiscHeight/2]) {
            rotate([0, 90, 45]) {
                #cylinder(h = 15, r = boltHoleR2, center = false);
                #cylinder(h = 40, r = boltHoleR2 / 2, center = false);
            }
        }
        translate([3, -50 , bottomDiscHeight/2]) {
            rotate([0, 90, 45]) {
                #cylinder(h = 15, r = boltHoleR2, center = false);
                #cylinder(h = 40, r = boltHoleR2 / 2, center = false);
            }
        }
        
        rotate([0, 0, 45]) {
            cube(size = [totalDiscR, totalDiscR, bottomDiscHeight], center = false);
        }
        rotate([0, 0, -45]) {
            cube(size = [totalDiscR, totalDiscR, bottomDiscHeight], center = false);
        }
    }
    

}