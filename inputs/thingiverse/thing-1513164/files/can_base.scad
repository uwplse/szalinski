// http://www.thingiverse.com/thing:1513164
// Customisable Can Base


// extra size for a tight fit
extra_size = 1.5; 
 // general thickness
thickness = 1;
// Rim Height
rim_h = 3.10;
// Can Diameter
can_dia = 52.75;
// Groove Diameter
groove_dia = 51.0;
// Groove Height
groove_h = 1.25;

// smoothing
$fn = 50;
// padding for manifold (ignore)
pad = 0.001; 


module lowerbase() {
    o_dia = can_dia + thickness*2 + extra_size;
    o_h = rim_h + thickness + extra_size/2;
    i_dia = can_dia + extra_size;
    i_h = rim_h+thickness*2+pad+ extra_size/2;


    difference() {
        cylinder(d=o_dia, h=o_h);
        translate([0,0,thickness]) cylinder(d=i_dia, h=i_h);
    }
}

module upperbase() {
    o_dia = can_dia + thickness*2 + extra_size;
    o_h = groove_h;
    i_dia = groove_dia + extra_size;
    i_h = groove_h+pad*2;
    
    difference() {
        cylinder(d=o_dia, h=o_h);
        translate([0,0,-pad]) cylinder(d=i_dia, h=i_h);
    }
}

lowerbase();
translate([0,0,rim_h + thickness]) upperbase();