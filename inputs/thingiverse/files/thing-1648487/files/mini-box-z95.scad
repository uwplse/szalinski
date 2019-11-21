include <stanley_container.scad>
include <z-95.scad>

stanley_container(2,2,height=29);
//translate([0,53.5-1,0]) cube([39*2, 2, 29]);

module z95_holder() {
    difference() {
        translate([1,1,0]) cube([34,52.5,26]);
        translate([25,27,27.2]) rotate([180,0,180]) z95();;
    }
  
}

module stand_holder() {
    difference() {
        translate([78-41-2,1,1]) cube([42,53.5-2,12]);
        translate([55.5,26.75,0]) cylinder(14,6,6,$fn=50);
        translate([76-43,10,6]) cube([44,7,5]);
        translate([76-43,26.74-22,10]) cube([44,44,10]);
    }
}

module dial_and_card_holder() {
    difference() {
        translate([1,0,1]) cube([48,52.5,25]);
        translate([25.5,26.75,15]) cylinder(22,22.5,22.5,$fn=100);
        translate([48-37-5.5,26.75-42/2,2]) cube([37,42,27]);
        translate([25.5+12,26.75+14.5,0]) cylinder(27,10,10,$fn=100);
    }
    translate([1,26.75-1,1]) cube([47,2,2]);
}

z95_holder();
stand_holder();
translate([0,53.5,0]) dial_and_card_holder();
//
//40.5 x 40.2 x 4
//43.2 x 40.2 x 6
// 6 in to nubs
// 7.1 between nubs


// 40 x 35 x 2.2 per card
// 45 dia, 4.4 thick, 7.1 in center