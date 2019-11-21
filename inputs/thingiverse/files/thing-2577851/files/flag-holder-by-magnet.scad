angle=30;
poleR = 4.5;
h1=100;
numberOfMagnets = 6;
magnetR = 2.7;
magnetThick = 2.4;

rotate([90,0,0]) {
    difference() {
        union() {
            cube([(poleR+2)*2*cos(angle),(poleR+2)*2+0,h1]);
            translate([(poleR+2)*cos(angle),poleR+2+0/2,(poleR+2)*sin(angle)]) {
                rotate([0,angle,0]) {
                    cylinder(r=poleR+2, h=h1, $fn=100);
                }
            }
            translate([0,0,h1]) {
                rotate([0,60,0]) {
                    cube([h1/sin(180-30-angle)*sin(angle),(poleR+2)*2+0,2]);
                }
            }
        }
        translate([(poleR+2)*cos(angle),poleR+2+0/2,(poleR+2)*sin(angle)]) {
            rotate([0,angle,0]) {
                cylinder(r=poleR, h=h1+1, $fn=100);
            }
        }
        for (i=[1:1:numberOfMagnets]) {
            translate([magnetThick, poleR+2+0/2, h1*i/(numberOfMagnets+1)]) {
                rotate([0,-90,0]) {
                    cylinder(r=magnetR, h=magnetThick+1, $fn=100);
                }
            }
        }
    }
}
