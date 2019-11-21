

$fn= 128*1;

// Length of clock hand in mm
length = 120; // [10:200]
// Minutes or hours clock hand
clockhandType = "minutes"; // ["minutes", "hours"]

module streched_circle(d, s) {
    //d is diameter of circle, s is length of the part in the middle
    hull() {
        translate([0, -s/2, 0]) half_circle(d);
        rotate([0,0,180]) translate([0,-s/2,0]) half_circle(d);
    }
}

module half_circle(d) {
        difference() {
        scale([1,0.9, 1]) circle(d=d);
        translate([0,d/2,0]) square(size=d, center=true);
    }
}



module hole_shape_hours() {
    //shape of the hole of the clock hand for hours
    difference() {
        circle(d=10);
        circle(d=5.2);
    }
}

module hole_shape_minutes() {
    //minutes clock hand
    difference() {
        streched_circle(6, 4);
        streched_circle(3, 1.8);
    }
}


module pointer(h, length) {
    d=8;
    yf = length/(1.5*d);

    difference() {
        linear_extrude(h) {
            hull() {
                translate([0,d*yf,0]) scale([1, yf, 5]) circle(d=d);
                    scale([1, 1, 5]) circle(d=d+2);
                }
        }

    difference() {
        hull() {
            linear_extrude(h) children();
            }
        linear_extrude(h) children(); 
    }

    }

}

if (clockhandType == "minutes") {
    pointer(h=1, length=length) {hole_shape_minutes();}
}

if (clockhandType == "hours") {
    pointer(h=2, length=length) {hole_shape_hours();}
 }







