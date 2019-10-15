lenght = 115;               // [50:5:200]
width = 75;                 // [50:5:200]
height = 145;               // [50:5:200]

wall_thickness = 2.4;       // [0.5:0.1:5]
bottom_thickness = 1.6;     // [0.5:0.1:5]

/* [Hidden] */

$fa = 2;
e = 0.01;

cornerD = 11;
outD = (lenght*lenght + (width-20)*(width-20)) / (width-20);

module vol(h, cornerD, cornerOfs, outD, outOfs)
{
    intersection()
    {
        hull()
        {
            translate([cornerOfs/2, cornerOfs/2, 0]) cylinder(height, d=cornerD);
            translate([lenght - cornerOfs/2, cornerOfs/2, 0]) cylinder(height, d=cornerD);
            translate([cornerOfs/2, width - cornerOfs/2, 0]) cylinder(height, d=cornerD);
            translate([lenght - cornerOfs/2, width - cornerOfs/2, 0]) cylinder(height, d=cornerD);
        }

        translate([lenght, width-outOfs/2, 0]) cylinder(height, d=outD);
    }
}

difference()
{
    vol(height, cornerD, cornerD, outD, outD);
    translate([0, 0, bottom_thickness]) vol(height, cornerD - 2*wall_thickness, cornerD, outD - 2*wall_thickness, outD);
    translate([lenght - wall_thickness-e, width/2, height-22]) rotate([0, 90, 0]) cylinder(wall_thickness+2*e, d=25);
}

