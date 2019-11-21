// Input variables
seg_thk = 63;       // Width of spool between flanges
inner_dia = 65;     // Radius of spool hub
wall = 1.6;         // 4 runs @ 0.4 nozzle
hole_dia = 2;       // Filament fix hole

width = 22.5;     // Required width of segment
arc = 120;      // segment length in degrees

// Calculated variables
inner_rad = inner_dia/2;
outer_rad = inner_rad+width;    // New spool hub radius
clear_thk = seg_thk+2;          // extra thick for cuts to work
ang = (180-arc)/2;

// Overall definition
$fa=1;

// Cut away half of a cylinder
module CutHalf(y_off,extra_thk)
{
translate([0,-y_off,0])
    cube([outer_rad*2,inner_rad*2,seg_thk+extra_thk],true);
}
// Which halves to cut
module trim()
{
    for (cut = [-ang,ang]) rotate(cut) children();
}

// Program
difference()
    {
    cylinder(h=seg_thk,r=outer_rad,center=true);   // New hub 

    cylinder(h=seg_thk+2,r=inner_rad,center=true);    // Loose existing hub
    trim() CutHalf(inner_rad,2);     // Loose sides
    translate([0,inner_rad+2*wall,0]) rotate([-90,0,0])
        cylinder(d=hole_dia,h=width,$fn=30);
    difference()    // Now hollow out the segment
        {
        cylinder(h=seg_thk+2,r=outer_rad-wall,center=true);

        cylinder(h=seg_thk+4,r=inner_rad+wall,center=true);
        trim() CutHalf(inner_rad-wall,4);
        }
    }
