length = 120;
diameter = 300;
// feel free to use directly the angle
angle = asin(length / diameter);


module rail_main(length) {
    poly = [[0,0],[0,8],[3,8],[3,7],[4,7],[7,5.25],[9,5.25],[9,2.75],[7,2.75],[4,1],[3,1],[3,0]];
    rotate([90,-90,180]) linear_extrude(length) polygon(poly);
}

module rail_curved(angle, diameter) {
    poly = [[0,0],[0,8],[3,8],[3,7],[4,7],[7,5.25],[9,5.25],[9,2.75],[7,2.75],[4,1],[3,1],[3,0]];
    translate([-diameter+8,0,0])
    rotate_extrude(angle = angle, $fn = 300)
    translate([diameter,0,0])
    rotate([0,0,90]) 
    polygon(poly);
}

module rail_endpoint_right() {
    poly = [[0,2],[0,6],[3,6],[3,4],[9,4],[9,2.75],[7,2.75],[4,2],[3,2]];
    rotate([90,-90,180]) linear_extrude(8) polygon(poly);
}

module rail_endpoint_left() {
    poly = [[3,8],[3,4],[9,4],[9,2.75],[7,2.75],[4,1],[3,1]];
    rotate([90,-90,180]) linear_extrude(8) polygon(poly);
    // support
    translate([-1.5,0,0]) cube([8,1,3], false);
}

module attach_poly(h) {
    linear_extrude(h) polygon([[0,0],[2,1.9],[6,1.9],[8,0]]);
}

module attach(l) {
    union() {
        difference() {
            union() {
                cube([41,l,1.5], false);
                cube([41,3,3], false);
                difference() {
                    translate ([7.5,-4,0]) cube([36,6,3], false);
                    translate ([12,-4.11,-0.5]) attach_poly(4);
                }
                translate ([16,-4,0]) cylinder(3,1.95,1.95,false, $fn = 80);
                translate ([28,-3.3,0]) mirror([0,1,0]) attach_poly(3);
            }
            translate ([32,-4,-0.5]) cylinder(4,2,2,false, $fn = 80);
        }
        translate ([12,0,3]) cylinder(2,2.5,2.5,false, $fn = 80);
        translate ([20,0,3]) cylinder(2,2.5,2.5,false, $fn = 80);
        translate ([28,0,3]) cylinder(2,2.5,2.5,false, $fn = 80);
        translate ([36,0,3]) cylinder(2,2.5,2.5,false, $fn = 80);
    }
}

module full_endpoint() {
    translate([0,-8,0]) rail_endpoint_left();
    translate([40,-8,0]) rail_endpoint_right();
    attach(10);
}

module barreau() {
    translate([-2,-11,0]) cube([36,6,1.5], false);
}

module main() {

    rail_curved(angle, diameter);
    translate([40,0,0]) rail_curved(angle, diameter+40);
    
    full_endpoint();

    translate([-diameter,0,0]) 
    rotate([0,0,angle]) 
    translate([diameter+40+cos(angle)*8,sin(angle)*-8,0]) rotate([180,180,0]) full_endpoint();
    
    translate([-diameter,0,0]) 
    rotate([0,0,angle/2]) 
    translate([diameter+cos(angle/2)*8,0,0]) barreau();
}

rotate([0,0,90]) main();

