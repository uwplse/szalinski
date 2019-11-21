$fa = 1;
$fs = 0.5;

// 8mm deep inset, ~3.4mm glass, 4.5mm deep 
depth = 4.5; 
// 3mm diameter wood screws
screw = 3; 

module clip(depth, screw) {
    difference() {
        union() {
            cube([22.86, 12.7, 5]);
            translate([14.86, 0, 0])
              cube([8, 12.7, 5 + depth]);
        }
        
        translate([6.35, 6.35, 2.5])
          cylinder(r=screw/2, h=6, center=true);
    }
}


clip(depth=depth, screw=screw);