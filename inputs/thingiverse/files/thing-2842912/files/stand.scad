// ball stand 
// version 0.2.2 
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

/*[ball stand]*/
number_of_legs = 4; // [3:100]
height = 40; // [1:100]
diameter_bottom = 10; // [1:50]
diameter_top = 6; // [1:50]
center_offset = 5; // [-50:50]

/*[Hidden]*/
$fn = 60; // looks like this can't be modified on thingiverse

// object cration
radius_bottom = diameter_bottom/2;
radius_top = diameter_top/2;
cylinder_cathetus_hight = height-(radius_bottom + radius_top);
cylinder_hight = sqrt(cylinder_cathetus_hight*cylinder_cathetus_hight*2);

//------------------------------------------------------------------
// Main

for (leg_angle = [0 : 360/number_of_legs : 360])
{
    if(leg_angle!=360)
    {
        rotate([0,0,leg_angle])
        {
            leg();
        }
    }
}

//------------------------------------------------------------------
//Module

module leg()
{
    rotate([45,0,45])
    {
        translate([0,0,center_offset])
        {
            translate([0,0,-cylinder_hight/2])
            {
                sphere(r = radius_bottom);
            }
            translate([0,0,-cylinder_hight/2])
            {
                cylinder(h = cylinder_hight, r1 = radius_bottom, r2 = radius_top);
            }
            translate([0,0,cylinder_hight/2])
            {
                sphere(r = radius_top);
            }
        }
    }
}
