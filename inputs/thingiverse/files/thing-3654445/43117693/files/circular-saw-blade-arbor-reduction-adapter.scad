// Circular saw blade arbor reduction adapter ring
// Default values are to fit a 20mm saw blade into a 16mm (5/8") arbor
// Adjust the defaults in the customizer view

/* [Saw Blade Arbor Reducer Bushing] */
blade_thickness=2.4; // [0.1:0.1:40]

// Arbor of the blade [mm]
outer_d=20; // [0.1:0.1:40]

// Arbor of the saw [mm]
inner_d=16; // [0.1:0.1:40]

// Bushing insertion easment [mm]
bevel=0.6; // [0:0.1:5]

/* [Hidden] */
$fn=128;
defeather=0.001;


assert(outer_d>inner_d);

intersection() {
    difference() {
        cylinder(d=outer_d, h=blade_thickness);
        translate([0,0,-defeather])
            cylinder(d=inner_d, h=blade_thickness+2*defeather);
    }
    
    cone_d = 2*outer_d - bevel;
    cone_z = (blade_thickness-bevel/2) - sqrt(cone_d*cone_d/4);
    
    color("red") translate([0, 0, cone_z])
        cylinder(d1=cone_d, d2=0, h=cone_d);
}
