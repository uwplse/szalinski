
// translate([34,-2,8]) rotate([90,0,0]) cylinder(h=14, d=3, $fn=30);  //measuring rod

depth = 23.5;
depth2 = 20.5;
height = 15.5;
height2 = 13;
radius = 16.8;
radius2 = radius - 1.5;
degrees = 60;
degrees2 = degrees + 5;

depth3 = 23.5;
depth4 = 20.5;
height3 = 15.5;
height4 = 13;
radius3 = 16.8;
radius4 = radius3 - 1.5;
degrees3 = 62;
degrees4 = degrees3 + 8;

height5 = 23.5;
height6 = 20;
depth5 = 15.5;
depth6 = 13;
radius5 = 28.5;
radius6 = radius5 - 1.5;
degrees5 = 90;
degrees6 = degrees5 + 8;

union() {
translate([1.5,34,6.5]) rotate([90,0,0]) cylinder(d=3, h=10, $fn=30);
translate([67.5,34,6.5]) rotate([90,0,0]) cylinder(d=3, h=10, $fn=30);
}
translate([0,24,3.5]) cube([3,10,3]);
translate([66,24,3.5]) cube([3,10,3]);
translate([29,8,5]) cube([11,2,23.5]);
    difference() {
            cleat();
            translate([10,67.3,9]) rotate([0,90,0]) cylinder(d=4, h=50, $fn=30);
    }
            translate([0,22.5,5]) switchMounts();
            translate([0,14.2,5]) switchMounts();
            translate([69,24.5,5]) rotate([0,0,180]) switchMounts();
            translate([69,16.2,5]) rotate([0,0,180]) switchMounts();
            linear_extrude(5) unit();
            translate([32.5,14.2,5]) rotate([0,0,90]) radialEntry();
            difference() {
            leftDuct();
            translate([9.5,9.5,5]) rotate([0,0,0]) cylinder(d=10,h=10, $fn=30);
            }
            translate([14,7.15,6.5]) rotate([0,0,211]) cube([8,1,21]);
            difference() {
            rightDuct();
            translate([59.5,9.5,5]) rotate([0,0,0]) cylinder(d=10,h=10, $fn=30);
            }
            translate([60,4.2,6.5]) rotate([0,0,150]) cube([8,1,21]);
            difference() {
            translate([0,-2,0]) rotate([0,0,0]) flipDown();
            translate([-5,-60,3]) rotate([0,90,0]) cylinder(h=20, d=3.2, $fn=30);  //52+8
            translate([-5,-44,3]) rotate([0,90,0]) cylinder(h=20, d=3.2, $fn=30);  //52-8
            }
            translate([-2.2,-36.3,5]) rotate([0,0,0]) tunnel2();
            difference() {
            translate([57.7,-2,0]) rotate([0,0,0]) flipDown();  
            translate([52.7,-60,3]) rotate([0,90,0]) cylinder(h=20, d=3.2, $fn=30);  //52+8
            translate([52.7,-44,3]) rotate([0,90,0]) cylinder(h=20, d=3.2, $fn=30);  //52-8
}       
            translate([55.6,-36.3,5]) rotate([0,0,0]) tunnel2();

module flipDown() {
        translate([-2.15,-34.2,0]) rotate([0,90,0]) flipArc();
}
module rightDuct() {
     union() {
            translate([69,-0.1,33.5]) rotate([0,180,0]) spinArc();
            //translate([59.5,9.5,5]) cylinder(h=24,d=12,$fn=30);
            translate([55.6,-9.6,5]) rotate([0,0,60]) tunnel();
            translate([54.3,-10.3,0]) rotate([0,0,151]) spinArc2();
    }
}
module leftDuct() {
    union() {
            translate([0,0,0]) rotate([0,0,0]) spinArc();
            translate([5.8,4,5]) rotate([0,0,300]) tunnel();
            translate([14.6,-10.3,0]) rotate([0,0,270.2]) spinArc2();
    }
}
module cleat() {
            translate([13.8,63.3,5]) cube([2,8,8]);
            translate([31,63.3,5]) cube([7,8,8]);
            translate([53.2,63.3,5]) cube([2,8,8]);
}
module flipArc() {
            difference() {
            translate([0,0,0]) rotate([0,0,0]) arc5();
            translate([1,0,1]) rotate([0,0,0]) arc6();
            }
}
module spinArc() {
            difference() {
            translate([13.6,10,5]) rotate([0,0,90]) arc1();
            translate([13.6,10,6.5]) rotate([0,0,91.5]) arc2();
            }
}
module spinArc2() {
            difference() {
            translate([0,0,5]) rotate([0,0,0]) arc3();
            translate([0,0,6.5]) rotate([0,0,0]) arc4();
            }
}
module tunnel () {
            difference() {
            translate([0,0,0]) rotate([0,0,0]) cube([15.5,10,23.5]);
            translate([1.5,0,1.5]) rotate([0,0,0]) cube([12.5,12,20.5]);
            }
}
module tunnel2 () {
            difference() {
            translate([0,0,0]) rotate([0,0,0]) cube([15.5,26,23.5]);
            translate([1.5,0,1.5]) rotate([0,0,0]) cube([12.5,34,20.5]);
            }
}
module carriage() {
        difference() {
            square([69,71.3]);
            translate([3,26,0]) square([4,8]);
            translate([62,26,0]) square([4,8]);
            translate([9.5,9.5,0]) circle(d=5.3, $fn=90);
            translate([59.5,9.5,0]) circle(d=5.3, $fn=90);
            translate([9.5,51.5,0]) circle(d=7.3, $fn=90);
            translate([59.5,51.5,0]) circle(d=7.3, $fn=90);
    }
}
module sinkPlate() {
        difference() {
            translate([-2,0,0]) square([73,36]);
            translate([24.5,14.3,0]) circle(d=12, $fn=90);   
            translate([43,14.3,0]) circle(d=12, $fn=90);
            translate([33.8,17.5,0]) circle(d=3.3, $fn=30);
            translate([25,6,0]) circle(d=3.3, $fn=30);
            translate([42,6,0]) circle(d=3.3, $fn=30);
        }
}
module switchMounts() {
        difference() {
            translate([0,0,0]) cube([15,2,17]);
            translate([4,3,7.25]) rotate([90,0,0]) cylinder(h=3.2, d=2.5, $fn=30);
            translate([4,3,13.75]) rotate([90,0,0]) cylinder(h=3.2, d=2.5, $fn=30);
        }
}
module BLTouch() {
                translate([34.5,5,0]) circle(d=10, $fn=90);
                translate([25.5,-1.5,0]) circle(d=3.4, $fn=90);
                translate([43.5,-1.5,0]) circle(d=3.4, $fn=90); 
}
module unit() {
difference() { 
    union() {
                    carriage(); 
                    translate([0,-36,0]) sinkPlate();
                    //translate([53.5,96,0]) rotate([0,0,180]) sinkPlate();
                }
                translate([-0.3,-4,0]) BLTouch();
        }
}     
   
module radialEntry() {
    difference() {
        translate([-4.5,-22,0]) cube([14.8,40,23.5]);
        translate([-4.5, 1.5, 1.5]) cube([14.8,15.2,20.5]);
        translate([-4.5, -20.7, 1.5]) cube([14.8,15.2,20.5]);
        translate([7.4, 6, 0]) cube([4,4,3]);
        translate([7.4, 6, 20.5]) cube([4,4,3]);
        translate([7.4, -15.5, 0]) cube([4,4,3]);
        translate([7.4, -15.5, 20.5]) cube([4,4,3]);
    }
}

module arc1() {
render() {
      difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius - height, 0, 0])
                        square([height,depth]);           
                // Cut half off
                translate([0,-(radius+1),-.5]) 
                    cube ([radius+1,(radius+1)*2,depth+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees])
                translate([0,-(radius+1),-.5]) 
                    cube ([radius+1,(radius+1)*2,depth+1]);           
        }
    }
}
module arc2() {
render() {
     difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius2 - height2, 0, 0])
                        square([height2,depth2]);           
                // Cut half off
                translate([0,-(radius2+1),-.5]) 
                    cube ([radius2+1,(radius2+1)*2,depth2+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees2])
                translate([0,-(radius2+1),-.5]) 
                    cube ([radius2+1,(radius2+1)*2,depth2+1]);           
        }
    }
}
module arc3() { 
render() {
     difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius3 - height3, 0, 0])
                        square([height3,depth3]);           
                // Cut half off
                translate([0,-(radius3+1),-.5]) 
                    cube ([radius3+1,(radius3+1)*2,depth3+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees3])
                translate([0,-(radius3+1),-.5]) 
                    cube ([radius3+1,(radius3+1)*2,depth3+1]);           
        }
    }
}
module arc4() {
render() {
     difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius4 - height4, 0, 0])
                        square([height4,depth4]);           
                // Cut half off
                translate([0,-(radius4+1),-.5]) 
                    cube ([radius4+1,(radius4+1)*2,depth4+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees4])
                translate([0,-(radius4+1),-.5]) 
                    cube ([radius4+1,(radius4+1)*2,depth4+1]);           
        }
    }
}
module arc5() {
render() {
     difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius5 - height5, 0, 0])
                        square([height5,depth5]);           
                // Cut half off
                translate([0,-(radius5+1),-.5]) 
                    cube ([radius5+1,(radius5+1)*2,depth5+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees5])
                translate([0,-(radius5+1),-.5]) 
                    cube ([radius5+1,(radius5+1)*2,depth5+1]);           
        }
    }
}
module arc6() {
render() {
     difference() {
                // Outer ring
                rotate_extrude($fn = 100)
                    translate([radius6 - height6, 0, 0])
                        square([height6,depth6]);           
                // Cut half off
                translate([0,-(radius6+1),-.5]) 
                    cube ([radius6+1,(radius6+1)*2,depth6+1]);           
                // Cover the other half as necessary
                rotate([0,0,180-degrees6])
                translate([0,-(radius6+1),-.5]) 
                    cube ([radius6+1,(radius6+1)*2,depth6+1]);           
        }
    }
}

