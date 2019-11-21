WIDTH=91;
LENGTH=141;
HEIGHT=22;
WALL=1.5;
BOTTOM=3;

module paper_tray (w, b, h, d, bottom) {
    difference() {
           cube([w+d, b+d, h+bottom], center=true);
           translate([0,0, bottom]) cube([w, b, h], center=true);
           translate([0, 0.75*b, 0]) rotate([0,0,45]) cube([w, w,2*h], center=true);
           translate([0, -0.75*b, 0]) rotate([0,0,45]) cube([w, w,2*h], center=true);
           translate([-0.9*w, 0, 0]) rotate([0,0,45]) cube([w, w,2*h], center=true);
           translate([0.9*w, 0, 0]) rotate([0,0,45]) cube([w, w,2*h], center=true);
    }
}

paper_tray(w=WIDTH, b=LENGTH, h=HEIGHT, d=WALL, bottom=BOTTOM);
