Dproximal = 22;
Dmiddle = 19;
ring_thickness = 3;
width_ratio = 2;
ring_angle = 60;
$fn = 50;

translate([0,0,(ring_thickness*width_ratio)/2]) {
    // proximal ring, lays flat
    translate([(Dproximal + ring_thickness)/2,0,0]) {
        rotate_extrude() {
            translate([(Dproximal + ring_thickness)/2,0,0]) {
                scale([1,width_ratio,1]) {
                    circle(d=ring_thickness);
                };
            };
        };
    };
    
    // middle ring, at angle
    rotate([0,-ring_angle,0]) {
        translate([(Dmiddle + ring_thickness)/2,0,0]) {
            rotate_extrude() {
                translate([(Dmiddle + ring_thickness)/2,0,0]) {
                    scale([1,width_ratio,1]) {
                        circle(d=ring_thickness);
                    };
                };
            };
        };
    };
    
    //joining cylinder
    translate([0,(Dproximal + Dmiddle)/6,0]) {
        rotate([90,0,0]) {
            cylinder(h=(Dproximal + Dmiddle)/3, d=ring_thickness*width_ratio);
        };
    };
};