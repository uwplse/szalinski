$fn=120;
gear_number_teeth=11;
external_diameter_teeth=20;
internal_diameter_teeth=16;
teeth_thickness=2.5;
gear_height=22;

square_size=16;
square_height=8;

big_ring_diameter=29;
big_ring_height=2.8;

small_ring_diameter=22.5;
small_ring_height=4;

collar_height=0;

module enveloppe() {
//cylinder(d=external_diameter_teeth,h=gear_height+collar_height);
    for(i=[0:360/gear_number_teeth:360]) 
        rotate([0,0,i]) 
        translate([-teeth_thickness/2,0,collar_height]) 
            cube([teeth_thickness,external_diameter_teeth/2,gear_height/*+collar_height*/]);
    
    cylinder(d=internal_diameter_teeth,h=gear_height+collar_height);
translate([0,0,-small_ring_height]) cylinder(d=small_ring_diameter,h=small_ring_height);
translate([0,0,-small_ring_height-big_ring_height])cylinder(d=big_ring_diameter,h=big_ring_height);
translate([-square_size/2,-square_size/2,-small_ring_height-big_ring_height-square_height]) cube([square_size,square_size,square_height]);
}

module env2() {
difference() {
    enveloppe();
    translate([0,0,-50]) cylinder(h=50,d=4.5);
    translate([0,0,-small_ring_height-big_ring_height-square_height+4]) cylinder(h=1.1,d1=4.5,d2=8);
    translate([0,0,-small_ring_height-big_ring_height-square_height+5]) cylinder(h=50,d=8);
}
}

 
module jonction() {
intersection() {
    translate([0,0,-97+collar_height+gear_height]) cylinder(d1=140,d2=12,h=100);
    env2();
}
}


    jonction();
//    translate([0,0,-25]) cube([50,50,50]);

