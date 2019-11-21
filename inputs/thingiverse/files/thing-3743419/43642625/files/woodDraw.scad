x = 50;
y_block = 25;
z_block = 30;
y_plate = 10;
z_plate = 100;
z_plate_hole = 80;
wide_plate_hole = 6;
shallow_plate_hole = 3;
hole_offset = 10;
diameter = 6.5;

rotate(180) union() {
    block(x, y_block, z_block, hole_offset, diameter);
    translate([0, - y_block/2 + y_plate/2, z_block]) plate(x, y_plate, z_plate, wide_plate_hole, shallow_plate_hole, z_plate_hole);
}

module block(x = 50, y = 25, z = 30, of = 10, diameter = 6.5) {
    translate([0, -y / 2, 0]) difference() {
        translate([-x/2, 0, 0]) cube([x, y, z], false);
        translate([0, of + (y-of)/2, -z * 0.5]) cylinder($fn = 90, r = diameter / 2, h=z * 2, center=false);
    }
}

module plate(x = 50, y = 10, z = 100, wide = 6, shallow = 3, z_hole = 80) {
    difference() {
        translate([-x/2, -y/2, 0]) cube([x, y, z], center=false);
        rotate(180) translate([0, 0, (z - z_hole) / 2]) linear_extrude(z_hole) translate([-wide/2, y/2, 0]) polygon(points = [
            [0, 0],
            [0, y/2],
            [wide, y/2],
            [wide, 0],
            [wide/2 + shallow/2, -y],
            [wide/2 + shallow/2, -y * 1.5],
            [wide/2 - shallow/2, -y * 1.5],
            [wide/2 - shallow/2, -y]
        ]);
    }
}