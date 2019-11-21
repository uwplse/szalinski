//  Amount of edges of the hole through the spring
$fn = 6;

//  Radius of the hole through the spring
radius = 3.4;

//  Dimension of the spring
base = 10.2;

//  Height of the base plates of the spring
baseHeight = 1;

//  Thickness of the spring
thickness = 0.3;

//  Length of the spring
length = 50;

//  Amount of leaves in the spring
amount = 33;

module spring(){
    leaveHeight = (length - 2 * baseHeight) / amount;
    ty = thickness / (2 * cos(atan(leaveHeight / base)));
    tx = thickness / (sin(atan(leaveHeight / base)));
    tolerance = 0.001;
    
    difference(){
        translate([-1/2 * base, 0, -1/2 * base]){
            cube([base, length, base]);
        }
        rotate([-90, -30, 0]){
            translate([0, 0, -0.1]){
                cylinder(r = radius, h = length + 0.2);
            }
        }
        translate([0, baseHeight, 0]){
            for(i = [1:amount]){
                rotate([0, i * 180, 0]){
                    translate([0, (i - 1) * leaveHeight, -(1/2 * base + 0.1)]){
                        linear_extrude(height =  base + 0.2){
                            polygon(    points  =   [   [-1/2 * base - tolerance, -tolerance],
                                                        [1/2 * base - tx, 0],
                                                        [-1/2 * base - tolerance, leaveHeight - ty]  ],
                                        paths   =   [[0,1,2]]   );
                            polygon(    points  =   [   [1/2 * base + tolerance, -tolerance],
                                                        [1/2 * base + tolerance, leaveHeight],
                                                        [-1/2 * base + tx, leaveHeight]  ],
                                        paths   =   [[0,1,2]]   );
                        }
                    }
                }
            }
        }
    }
}

spring();