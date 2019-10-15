use <../libraries/rounding.scad>;

len = 80;
width = 10;
thickness = 2;
clip_height = 15;
hole_dia = 5;
rod_dia = 4.3;
{
clip_gap = rod_dia / 1.5;
clip_thickness = max(clip_gap * 2, clip_gap * 1.5 + 4);
difference() {
    cube([len+clip_thickness, width, thickness], center=true);
    cylinder(d=hole_dia, h=thickness+0.1, center=true, $fn=20);
}

module clip(width, height, gap) {
    translate([0, 0, height/2]) {
        difference() {
          translate([-clip_thickness/2, -width/2, -height/2-thickness])
          rotate([90, 0, 90])
            round([width, height+thickness, clip_thickness], 2, center=true, $fn=20);
            cube([gap, width+0.1, height+0.1], center=true);
            rotate([90, 0, 0]) {
                cylinder(d=gap*1.5, h=width+0.1, center=true, $fn=20);
            }
        }
    }
}

for (dir = [-1, 1]) {
    translate([dir*len/2, 0, thickness/2]) {
        clip(width, clip_height, clip_gap);
    }
}
}