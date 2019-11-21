
coverDiameter = 52;
screwDiameter = 2.5;
screwHeadDiameter = 4;
screwPosition = 22.625;
hookWidth = 3;
hookDiameter = 12;
hookHeight = 11.5;
hookScrewDiameter = 6;

module cover(d, screwDiameter, screwHeadDiameter, screwPosition) {
    difference() {
        cylinder(r=d/2, h=2.5, $fn=75);
    
        for (rotate1 = [ 45 : 90 : 315 ]) {
            rotate([0,0,rotate1]) {
                translate([screwPosition,0,1]) {
                    cylinder(r=screwHeadDiameter/2, h=10, $fn=25);
                }
                translate([screwPosition,0,-1]) {
                    cylinder(r=screwDiameter/2, h=10, $fn=25);
                }
            }
        }
    }
}


module hook(w,d,h,holeRadius) {
    difference() {
        union() {
            translate([-w/2, -d/2, 0]) {
                cube([w,d,h]);
            }
            translate([0,0,h]) {
                rotate([0,90,0]) {
                    cylinder(r=d/2, h=w, center=true, $fn=100);
                }
            }
        }
        translate([0,0,h]) {
            rotate([0,90,0]) {
                cylinder(r=holeRadius, h=w+2, center=true, $fn=100);
            }
        }
    }
}

cover(d=coverDiameter, screwDiameter=screwDiameter, screwHeadDiameter=screwHeadDiameter, screwPosition=screwPosition);
hook(hookWidth,hookDiameter,hookHeight,hookScrewDiameter/2);
