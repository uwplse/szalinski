$fn=50;

// Clamp length
length_numeric_slider = 10; //[10:50]

// Clamp inner diameter
dia_numeric_slider = 13; //[5:50]

// Clamp wall thickness
wall_numeric_slider = 10; //[2:10]

// Embed a hex nut
nut_drop_down_box = 0; // [0:no, 1:yes]

// Hex nut diameter
nut_dia_numeric_slider = 9; // [5:30]

// Bolthole diameter
bolt_dia_numeric_slider = 5.5; // [3:20]

// Slit width
slit_width_numeric_slider = 2; // [1:5]

clamp(dia_numeric_slider, length_numeric_slider, wall_numeric_slider, nut_drop_down_box, nut_dia_numeric_slider, bolt_dia_numeric_slider, slit_width_numeric_slider);

module clamp(d1, h, wall, nuthole, nuthole_dia, bolt_dia, slit)
{
    outerdia = d1 + wall;

    difference() {
        hull() {
            cylinder(d=outerdia, h=h);
            translate([outerdia/2+1, -outerdia/2, h/2])
            rotate([0, 90, 90])
            cylinder(d=10, h=outerdia);
        }
        translate([0, 0, -1])
        cylinder(d=d1, h=h+2);

        translate([outerdia/2+1, -outerdia/2-1, h/2])
        rotate([0, 90, 90])
        cylinder(d=bolt_dia, h=outerdia+2);


        if (nuthole == 1) {
            translate([outerdia/2+1, -outerdia/2-0.1, h/2])
            rotate([0, 90, 90])
            cylinder(d=nuthole_dia, h=4, $fn=6);
        }
        translate([0, -slit/2, -1])
        cube([outerdia, slit, h+2]);

     }
    
}
