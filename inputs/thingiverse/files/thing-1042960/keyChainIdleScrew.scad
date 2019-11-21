//  The amount of edges in every circle
$fn = 50;

//  The outer radius of the cylinder
Ro = 5.5;

//  The inner radius of the cylinder
Ri = 5;

//  The bottom outer radius, the whole thing will be scaled to this
Rb = 2;

//  The height of the cylinder
H = 30;

//  The depth of the cut out for the driver
depth = 1;

//  The height of the tapering part of the top of the driver
tapered = 0.66;

//  The decrease in dimension of the top part
decrease = 0.3;

//  The radius of the fillet at the bottom of the driver
fillet = 0.34;

//  The width of the base of the driver, must be smaller than 2 * Ri
driverBaseWidth = 1;

//  The length of the base of the driver, must be smaller than 2 * Ri
driverBaseLength = 8;

//  The height of the keychain hole
keyChainHeight = 3;

//  The radius of the keychain hole
keyChainRadius = 1.5;

module keyChainIdleScrewDriver(){
    delta = 0.0001;
    union(){
        difference(){
            cylinder(r1 = Rb, r2 = Ro, h = H);
            translate([0,0,H - depth]){
                cylinder(r1 = (Ro - Rb) / H * (H - depth) + Rb - Ro + Ri, r2 = Ri, h = depth + 0.1);
            }
            translate([0, -Ro - 0.1, keyChainHeight]){
                rotate([-90,0,0]){
                    cylinder(r = keyChainRadius, h = 2 * Ro + 0.2);
                }
            }
        }        
        translate([0,0,H - depth]){
            union(){
                difference(){
                    cube([driverBaseWidth + 2 * fillet, driverBaseLength + 2 * fillet, 2 * fillet], center = true);
                    translate([0,0, 2 * fillet]){
                        minkowski(){
                            difference(){
                                cube([driverBaseWidth + 4 * fillet, driverBaseLength + 4 * fillet, 2 * fillet], center = true);
                                cube([driverBaseWidth + 2 * fillet, driverBaseLength + 2 * fillet, 2 * fillet], center = true);
                            }
                            sphere(r = fillet);
                        }
                    }
                }
                translate([-driverBaseWidth / 2, -driverBaseLength / 2, 0]){
                        cube([driverBaseWidth, driverBaseLength, depth - tapered]);
                }
                translate([-driverBaseWidth / 2, -driverBaseLength / 2, depth - tapered]){
                    hull(){
                        cube([driverBaseWidth, driverBaseLength, delta]);
                        translate([decrease, decrease, tapered]){
                            cube([driverBaseWidth - 2 * decrease, driverBaseLength - 2 * decrease, delta]);
                        }
                    }
                }
            }
        }
    }
}

keyChainIdleScrewDriver();


        
        
