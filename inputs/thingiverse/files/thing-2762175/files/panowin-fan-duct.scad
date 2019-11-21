
objHeight = 36.15;
objWidth = 60;
objThick = 5;
objLeftThick = 15.5;
rBottom = 15;
rTop = 10;
holeR1 = 8.5;
holeR2 = 13;
M3NutThick = 2.7;

module obj1(objHeight, objWidth, objThick, objLeftThick, rBottom, rTop, holeR1, holeR2) {
    difference() {
        union() {
            translate([rBottom,0,rBottom]) {
                rotate([270,0,0]) {
                    cylinder(r=rBottom, h=objHeight, $fn=100);
                }
            }
            translate([objWidth-objHeight/2, objHeight/2, 0]) {
                cylinder(h=objThick, r=objHeight/2, $fn=100);
            }
            translate([rBottom,0,0]) {
                cube([(objWidth-objHeight/2)-rBottom, objHeight, objThick]);
            }
        }
        translate([-1,-1,objLeftThick]) {
            cube([(rBottom+rTop)*4+1,objHeight+2,objLeftThick+rBottom*2+1]);
        }
        translate([rTop+rBottom,-1,rTop+objThick]) {
            rotate([270,0,0]) {
                cylinder(r=rTop, h=objHeight+2, $fn=100);
            }
        }
        translate([objWidth-objHeight/2, objHeight/2, holeBallX+objThick]) {
            sphere(r=holeBallR, $fn=100);
        }
    }
}

holeBallX = (holeR2*holeR2 - holeR1*holeR1 - objThick*objThick) / (2.0*objThick);
holeBallR = sqrt(holeBallX*holeBallX + holeR2*holeR2);

translate([0,0,objHeight]) {
    rotate([270,0,0]) {
        difference() {
            union() {
                obj1(objHeight, objWidth, objThick, objLeftThick, rBottom, rTop, holeR1, holeR2);
                translate([1, objHeight-1.5-15.5-1, objLeftThick]) {
                    cube([10.5+2, 15+2, 3]);
                }
                translate([0,objHeight/2-5, objLeftThick-10]) {
                    cube([4,10,10]);
                }
            }
            translate([1,1,1]) {
                obj1(objHeight-2, objWidth-2, objThick-2, objLeftThick-2, rBottom-2, rTop+1, holeR1+1, holeR2+1);    
            }
            translate([2,objHeight-1.5-15.5,objLeftThick-2]) {
                cube([10.5,15,objLeftThick+1]);
            }
            translate([objWidth-objHeight/2, objHeight/2, -1]) {
                difference() {
                    cylinder(r=holeR1+5, h=2.01);
                    translate([0,0,-1]) {
                        cylinder(r1=holeR1, r2=holeR1+2.5, h=3.01);
                    }
                }
            }
            translate([-1,objHeight/2,objLeftThick-7.5]) {
                rotate([0,90,0]) {
                    cylinder(r=3.5/2, h=8, $fn=25);
                }
            }
            translate([1,objHeight/2,objLeftThick-7.5]) {
                rotate([0,90,0]) {
                    cylinder(r=6.5/2, h=M3NutThick, $fn=6);
                }
            }
            translate([1,objHeight/2-(6.5/2*sqrt(3)*0.5), objLeftThick-7.5-6.5/2]) {
                cube([M3NutThick,6.5/2*sqrt(3),6.5/2]);
            }
        }
    }
}
