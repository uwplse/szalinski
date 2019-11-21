// Chip width: 42mm
// Chip length: 62mm
// Chip height: 13mm


label="C.H.I.P";
hole_radius=0; // [0,3]

/* [Hidden] */
$fa=.5;
$fs=.5;
case_width=42;
case_length=62;
case_height=15;
wall=2;
air_gap=3;


//Draw the box lid
module lid()
{
    difference()
    {
        translate([-wall - .5, -wall - 3, case_height + wall])
            cube([case_width + wall * 4 + 2, case_length + wall * 4 + 3, case_height/2]);
        translate([0,0,0])
             cube([case_width + wall*2 + 1, case_length + wall + 1, case_height + wall + air_gap]);
     translate([case_width/2 + 6, 3, case_height * 1.5 + wall - 2])
        rotate([0,0,90])
            linear_extrude(3) text(label, font="DejaVu Sans Mono:style=Bold");
    }
}

module face()
{
    difference()
    // 8 x 15 for the usb
    // up 7 from bottom plane
    //inset 9 from left of bottom case
    {
        translate([0, -wall - 1.01, 0])
           
        cube([case_width + wall * 2 + 1, wall + 1, case_height + wall]);
        translate([case_width + wall * 2 - 24, -wall - 1.02, 7])
            cube([15, wall +1.04, 8]);
        translate([17, 0, 10])
            rotate([90,0,0])
                cylinder(r=hole_radius, h=wall*2);
        translate([wall, -wall - 2, 4.5])
            cube([10, wall * 2, 8]); 


    }
}
lid();
face();


