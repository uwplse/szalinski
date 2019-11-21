// Thickness of the bars
thickness=4;
// Length of the bars
length=190;
// Height of the bars
height=20;
// Crossing angle of the bars
angle=60;
// Tilt angle of the monitor
tiltangle=30;
// Thickness of the monitor
monitorthickness=15.875;
// Distance from the end of the bar to the crossing point
crossingPointDistance = 25;
// Sitting position from the monitor to the front of the bars
sittingPosition=20;
// What to print
part = "both"; //[lbar:Left Bar Only, rbar:Right Bar Only,both:Both left and right bars]

module foo() {}
$fn=40;
inch=25.4;
barangle=angle/2;
separation=2*sin(barangle)*(length-crossingPointDistance);

difference() {
    union() {
        if (part == "lbar" || part == "both") {
             difference() {
                rotate([0,0,-barangle]) bar();
                #translate([separation-thickness/2-2,0,0]) rotate([0,0,barangle]) translate([0,0,height/2-.5]) cube([thickness+2.5,length+1,height/2+1.5]);
            }
        }
        if (part == "rbar" || part == "both") {
            difference() {
                translate([separation-.25,0,0]) rotate([0,0,barangle]) bar();
                #rotate([0,0,-barangle]) translate([-thickness/2-1.25,0,-1]) cube([thickness+2.5,length+1,height/2+1.5]);
            }
        }
    }
    #translate([-40,sittingPosition,1.5+monitorthickness*sin(tiltangle)]) rotate([-tiltangle,0,0]) cube([separation+80, monitorthickness+1, height*3]);
}

module bar() {
    minkowski() {
        union() {
            translate([-thickness/2+1,1,1]) cube([thickness-2,length-2,height-2]);
            translate([thickness/2,2,0]) rotate([0,-90,0]) difference() {
                translate([height/2,-1,1]) cylinder(h=thickness-2, d=height-2);
                translate([0,-1,0]) cube([height+.01,height/2+.01,thickness+.01]);
            }
        }
        sphere(2);
    }
}