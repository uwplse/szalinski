w = 3;
radius = 30;

translate([-w / 2, 0, 0]) cube([w, radius, 5]);
translate([0, 0, 0]) rotate([0, 0, 120]) cube([w, radius - (w / 2), 5]);
translate([(w * sin(30) / sin(60)) / 2 , w, 0]) rotate([0, 0, 240]) cube([w, radius - (w / 2), 5]);
