//Manschette
height=40;
gap=0.2;
inner_diameter=14.2;   // fits perfectly with minimum clearance
outer_diameter=17;

//Arretier-Ring
height_ring=0.5;
width_ring=0.8;
position_ring=height/2;

//Manschette
difference() {
    cylinder(r=outer_diameter/2,h=height,$fn=12);
    translate([0,0,-1]) {
        cylinder(r=(inner_diameter+gap)/2,h=(height+2));
    };
}

//Arretier-Ring
translate([0,0,position_ring]) {
    difference() {
        cylinder(r=inner_diameter/2, h=height_ring);
        translate([0,0,-1]) {
            cylinder(r=(inner_diameter-width_ring)/2,h=height_ring+2);
        };
    }
}
