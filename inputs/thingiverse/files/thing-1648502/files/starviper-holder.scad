include <stanley_container.scad>
include <starviper_box.scad>

stanley_container(2,2,height=44.5);
translate([0,53.5-1,0]) cube([39*2, 2, 29]);


module dial_and_card_holder() {
    difference() {
        union() {
            difference() {
                cube([76,52.5,40]);
                translate([0,1,0]) cube([29,51.5,41]);
            }
        }
        // Dial
        translate([52.5,26.25,32]) cylinder(9,22.5,22.5,$fn=100);
        // Stand
        translate([34.9,4.75,19]) cube([40.5,43,23]);
        //Piece storage
        translate([34.9,8.75,0]) cube([40.5,35,50]);
    }
}

translate([0,55,-2]) rotate([0,0,270]) starviper();
translate([0,52.5,0]) dial_and_card_holder();

// 62 long
// Cabin: 8 dia, 29 deep
// back laser: 6 wide, 22 deep
// side laser: 3 dia, 21 deep, 41 apart
// 9.5 wide, 9.5 long, 30 deep

//15 long, 4 wide, 6 deeper, 15 from cabin

// 40 x 35 x 2.2 per card
// 45 dia, 4.4 thick, 7.1 in center