//  Measure for smoothness
$fn = 50;

//  Tolerance on the radius
tolerance = 0.1;

motorRadius = 24 / 2;
motorLength = 31;
wallThickness = 1;
cutOutRadius = 6 / 2;
//  Amount of holes for screws
screwMounts = 2;
//  Distance from holes to ax
screwAx = 17.2 / 2;
screwRadius = 2 / 2;

//  Mount opened on the top, 0 for no, 1 for yes
topOpen = 0;    //  [1, 0]

module motorMount(){
    difference(){
        translate(  [   -(motorRadius + wallThickness + tolerance),
                        0,
                        -(motorRadius + wallThickness + tolerance)]){
            cube(   [   2 * (motorRadius + wallThickness + tolerance),
                        motorLength + wallThickness,
                        2 * (motorRadius + wallThickness + tolerance)],
                    center = false);
        }
        if(topOpen == 1){
            translate(  [   -(motorRadius + tolerance),
                            -0.1,
                            0]){
                cube(   [   2 * (motorRadius + tolerance),
                            motorLength + 0.1,
                            2 * (motorRadius + wallThickness + tolerance)],
                        center = false);
            }
        }
        rotate([-90,0,0]){
            translate([0,0,-0.1]){
                cylinder(r = motorRadius + tolerance, h = motorLength + 0.1);
                cylinder(r = cutOutRadius + tolerance, h = motorLength + wallThickness + 0.2);
            }
            for(i = [1:screwMounts]){
                rotate([0,0,360 / screwMounts * i + 90]){
                    translate([0,screwAx,0]){
                        cylinder(r = screwRadius + tolerance, h = motorLength + wallThickness + 0.2);
                    }
                }
            }
        }
    }
}

motorMount();