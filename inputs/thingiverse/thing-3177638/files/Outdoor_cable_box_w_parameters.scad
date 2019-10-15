// Height of plug
plug_h = 120;
// Diameter of plug
plug_d = 60;
// Thickness of walls
wall = 2;
// width of the mount for screws
mount = 10;
// diameter of hole for screws
screw = 2;
// diameter of cable
cable = 12;

difference() {
    cube([plug_d+2*wall,plug_d+2*wall,plug_h+wall]);
    translate([wall,wall,-wall])
        cube([plug_d,plug_d,plug_h+wall]);
}

screw();
translate([plug_d+2*wall-mount,0,0])
    screw();
translate([0,plug_d+2*wall-mount,0])
    screw();
translate([plug_d+2*wall-mount,plug_d+2*wall-mount,0])
    screw();
translate([plug_d/2+2*wall,plug_d+2*wall-mount,0])
    screw();
translate([plug_d+2*wall-mount,plug_d/2+wall,0])
    screw();

module screw() {
    translate([0,0,wall])
        difference() {
            cube([mount,mount,20]);
            translate([mount/2,mount/2,0]) {
                cylinder(d=screw,h=10);
            }
        }
}