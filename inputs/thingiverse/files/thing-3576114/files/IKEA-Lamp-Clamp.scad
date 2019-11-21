/**
 * Replacement for a clamp of an IKEA Lamp
 */
wall = 2;
width = 12;
base_length = 18;
d = 4;
glass = 7;
offset = 28;

rotate([0,-90,0]) {
    cube([width,base_length,wall]);
    translate([0,0,-wall])
    cube([wall,base_length+offset,wall]);

    translate([width/2,2,0])
        cylinder(d1=d,d2=d/2,h=6);

    translate([width/2,base_length,6])
        rotate([90,0,0])
            cylinder(d1=d,d2=d/2,h=5);

    hull(){
        translate([0,base_length,0])
            cube([width,wall,10]);
        translate([0,base_length+wall+offset,-wall])
            cube([width, glass+wall, wall]);
    }

    translate([0, base_length+wall+offset+glass,-wall-glass-wall])
        cube([width, wall, glass+wall]);

    translate([0, base_length+glass/2+offset,-wall-glass-wall])
        cube([width, glass/2+wall, wall]);
}