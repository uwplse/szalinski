// Height of magnets in mm
magnet_height=2;

// Big magnet diameter
big_magnet_dia = 13;

// Small magnet diameter
small_magnet_dia = 3.5;

// Number of small Magnets in the ring
no_small_magnets = 7;

// Wall thickness
wall_thickness = 0.5;

//How smooth you want the walls
fragments=40;

difference(){
    total_diameter=big_magnet_dia+2*small_magnet_dia+4*wall_thickness;
    cylinder(d=total_diameter, h=magnet_height, $fn=fragments);
    cylinder(d=big_magnet_dia, h=magnet_height, $fn=fragments);

    new_center=big_magnet_dia/2+small_magnet_dia/2+wall_thickness;
    for(angle=[0:(360/no_small_magnets):360]) {
        rotate([0,0,angle]) translate([new_center,0,0]) cylinder(d=small_magnet_dia,h=magnet_height, $fn=fragments/2);
    }
}