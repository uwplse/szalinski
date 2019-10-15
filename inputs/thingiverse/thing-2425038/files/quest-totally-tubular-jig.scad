// Quest Totally Tubular fin jig created by: Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons - share alike - attribution license

tube_dia = 20;
height = 25;
thickness = 2;

fillet_dia = 6;

tube_count = 6;

fudge_factor = 0.3;

$fs=0.2;
$fa=0.2;

difference() {
    union() {
        for(r=[0:360/tube_count:359]) {
            rotate([0,0,r]) translate([0,tube_dia+fudge_factor,0]) cylinder(height, d=tube_dia+thickness*2+fudge_factor);
        }
    }
    translate([0,0,-0.5]) {
        for(r=[0:360/tube_count:359]) {
            rotate([0,0,r]) translate([0,tube_dia+fudge_factor,0]) cylinder(height+1, d=tube_dia+fudge_factor);
            
        }
        cylinder(height+1, d=tube_dia*2+thickness*2+fudge_factor*2);
    }
}