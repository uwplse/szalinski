// Input variables
seg_thk=45;     // Width of spool between flanges
inner_rad=25;   // Radius of spool hub
width=17;       // Required width of segment
arc=120;        // segment length in degrees

// Calculated variables
outer_rad=inner_rad+width;  // New spool hub radius
wall=1.6;
clear_thk=seg_thk+2;
ang=(180-arc)/2;

// Overall definition
$fa=1;

// Cut away half of a cylinder
module CutHalf(y_off,extra_thk)
{
translate([0,-1*y_off,0])
    cube([outer_rad*2,inner_rad*2,seg_thk+extra_thk],true);
}

{
difference()
    {
    cylinder(seg_thk,r=outer_rad,center=true);   // New hub 

    union()
        {
        cylinder(seg_thk+2,r=inner_rad,center=true);    // Loose existing hub
        rotate([0,0,ang]) CutHalf(inner_rad,2);     // Loose one side
        rotate([0,0,-ang]) CutHalf(inner_rad,2);    // And the other
        difference()    // Now hollow out the segment
            {
            cylinder(seg_thk+2,r=outer_rad-wall,center=true);
                
            union()
                {
                cylinder(seg_thk+4,r=inner_rad+wall,center=true);
                rotate([0,0,ang]) CutHalf(inner_rad-wall,4);
                rotate([0,0,-1*ang]) CutHalf(inner_rad-wall,4);
                }
            }
        }
    }

}

