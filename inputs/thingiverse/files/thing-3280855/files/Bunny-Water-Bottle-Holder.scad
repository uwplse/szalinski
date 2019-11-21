bottle_diam = 52;
bottle_flat = 52;

holder_z = 44;
holder_y = 48;

cage_bar_diam = 2;
cage_bar_spacing = 22;

width = 2.5;

Holder_offset = 0;
Holder_angle = 0;


module Bottle () {
    difference() {
        circle(d=bottle_diam,$fn=100);
        translate ([(bottle_diam-bottle_flat)/2 - bottle_diam/2,0,0]) square([(bottle_diam-bottle_flat),bottle_diam],true);
    }
}

module Bootle_Holder () {
    linear_extrude (holder_z/2) difference () {
        circle(d=bottle_diam+width*2,$fn=100);
        Bottle();
        translate ([bottle_diam/2,0,0]) square(bottle_diam/1.75,true);
    }
    
    
}

module Support_Holder () {
    linear_extrude (width) square([holder_z,holder_y],true);
    translate ([0,0,-Holder_offset+width/2]) linear_extrude (width+cage_bar_diam+width/2 + Holder_offset) circle(d=cage_bar_spacing-cage_bar_spacing/5,$fn=100) ;
    translate ([0,0,cage_bar_diam+width]) difference () {
        linear_extrude (width) square([holder_z,holder_y],true);
        linear_extrude (width) rotate ([0,0,45]) translate ([cage_bar_spacing/2-cage_bar_spacing/10+100/2,0,0]) square(100,true);
        linear_extrude (width) rotate ([0,0,45+180]) translate ([cage_bar_spacing/2-cage_bar_spacing/10+100/2,0,0]) square(100,true);
    }
}

module Holder () {
    translate ([Holder_offset,0,0]) rotate ([0,Holder_angle,0]) Bootle_Holder ();
    translate ([Holder_offset,0,0]) rotate ([0,Holder_angle,0]) mirror ([0,0,1]) Bootle_Holder();
    translate ([-bottle_diam/2,0,0]) rotate ([0,-90,0]) Support_Holder();
}

Holder();
