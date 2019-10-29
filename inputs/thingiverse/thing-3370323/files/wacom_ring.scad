$fn = 50;
ring_inner=9.2;
ring_width=9;
ring_thickness=1.6;
ring_outer=ring_inner+ring_thickness;
ring_block = ring_outer;
magnet_radius = 3.355;
magnet_height= 1.65;
magnet_margin = (ring_width-magnet_radius*2)/2;




module ring() {
    difference() {
        cylinder(h = ring_width,r = ring_outer, center = true);
        cylinder(h = ring_width*1.4,r = ring_inner, center = true);
        
    };
};

module block(){
    difference() {
        translate([0,0,ring_width/2*-1]) 
            cube([ring_block, ring_block, ring_width]);
        cylinder(h = ring_width*1.4,r = ring_inner, center = true);

    };
};


     
module ringBlock(){
    union(){
        ring();
        block();
    };
};


module finalRing(){
    difference(){
        ringBlock();
        rotate([0,90,0])
            translate ([0,ring_outer-magnet_radius-magnet_margin,ring_outer-magnet_height]) 
                cylinder(h = magnet_height+1, r = magnet_radius);
    };
};


finalRing();