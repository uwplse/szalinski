$fn=50; 

// angle of the opening, 0 is horizontal
ANGLE=30;  // [0:73]

// scale in per cent, e.g.100, 85.0, 72.2, 61.4, 52.2, 44.4, 37.7, 32.0
SCALE=100;

scale([SCALE/100,SCALE/100,SCALE/100]) m(ANGLE);

module m(w=30)
    {
    difference() {
        sphere(d=200);
        sphere(d=200 -3/SCALE*100);
        rotate([w,0,0]) translate([0,0,160]) cube([200,200,200],center=true);
        translate([0,0,-185]) cube([200,200,200],center=true);
        }

    rotate([w,0,0])
        difference() {
            translate([0,0,160-200/2]) cylinder(d=160, h=4,center=true);
            translate([0,0,160-200/2]) cylinder(d=160 -5/SCALE*100, h=5,center=true);
            }
    translate([0,0,-185+200/2]) cylinder(d=105, h=2,center=true);
    }