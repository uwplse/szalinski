// cable_connect
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

cable_diameter = 8; // [4:0.1:15]
clip_height = 10; // [5:25]

/*[Hidden]*/
// speed vs. resolution
$fn = 60; // looks like this can't be modified on thingiverse

cable_radius = cable_diameter/2;

//------------------------------------------------------------------
// Main
rotate([0, 0, 180])
{
    translate([(cable_radius+1)*-1,0,0])
    {
        ring();
    }
}

translate([(cable_radius+1)*-1,0,0])
{
    ring();
}

//------------------------------------------------------------------
// Module

module ring()
{
    difference()
    {
        cylinder(h=clip_height, r1=cable_radius+2, r2=cable_radius+2, center=false);
        
        union()
        {
            cylinder(h=clip_height, r1=cable_radius, r2=cable_radius, center=false);
            linear_extrude(height = clip_height, twist = 0)
            {
                polygon(points=[[cable_radius+0,0], [(cable_radius+2)*-1,cable_radius+2], [(cable_radius+2)*-1,(cable_radius+2)*-1]]);
            }
        }
    }
}
