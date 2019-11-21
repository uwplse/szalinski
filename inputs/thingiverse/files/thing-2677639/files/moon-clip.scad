// This is a Moon Clip.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2677639

/* [Main] */

// Define type of output
shape=1; // [0:2D for Laser or Water Jet Cutting,1:3D for printing]

// Define inner shape
inner_shape=0; // [0:for polygon,1:for round]

// Define number of faces (more faces for smoother surfaces)
$fn=100;

// Define thickness in mm
thickness=1.0;

// Define number of rounds
num_rounds=6;

// Define outside diameter in mm
outside_diameter=28.0;

// Define inside diameter in mm
inside_diameter=10.0;

// Define notch diameter in mm
notch_diameter=8.5;

// Define center-to-center notch offset in mm
notch_offset=12.0;

// Define slot width in mm
slot_width=0.5;

// Define slot length in mm
slot_length=6.0;

// Define slot offset in mm
slot_offset=outside_diameter/2-slot_length/2;

module outer_body2d()
{
    circle(outside_diameter/2,true);
}

module polygon_inner_body2d()
{
    $fn=(num_rounds);
    rotate([0,0,(360/num_rounds)/2])
    circle(inside_diameter/2,true);
}

module round_inner_body2d()
{
    rotate([0,0,(360/num_rounds)/2])
    circle(inside_diameter/2,true);
}

module notch2d()
{
    #translate([notch_offset,0.0]) circle(notch_diameter/2,true);
    //translate([1.0*outside_diameter,0.0]) square(notch_diameter,true);
}
module slot2d()
{
    translate([slot_offset,0.0]) square([slot_length,slot_width],true);
}

module outer_body3d()
{
    cylinder(h=thickness,r=outside_diameter/2,center=true);
}

module polygon_inner_body3d()
{
    $fn=(num_rounds);
    rotate([0,0,(360/num_rounds)/2])
    cylinder(h=thickness+1,r=inside_diameter/2,center=true);
}

module round_inner_body3d()
{
    rotate([0,0,(360/num_rounds)/2])
    cylinder(h=thickness+1,r=inside_diameter/2,center=true);
}

module notch3d()
{
    translate([notch_offset,0.0,0.0]) cylinder(h=thickness+1,r=notch_diameter/2,center=true);
    //translate([1.0*outside_diameter,0.0,thickness/2]) square(notch_diameter,true);
}
module slot3d()
{
    translate([slot_offset,0.0,0])
    rotate(90,0,0)
    #cube([slot_width,slot_length,thickness+1],center=true);
    // Add cylinder at end of slot to round corners for stress relief
}

if(shape==0)
{
    difference()
    {
        outer_body2d();
        union()
    {
        if(inner_shape==1)
        {
            round_inner_body2d();
        }
        if(inner_shape==0)
        {
            polygon_inner_body2d();
        }
            for(angle=[0:360/num_rounds:360])
            {
                rotate([0,0,angle]) notch2d();
                rotate([0,0,angle+360/(2*num_rounds)]) slot2d();
            }
        }
    }
}

if(shape==1)
{
    difference()
    {
        outer_body3d();
        union()
    {
            if(inner_shape==1)
            {
                round_inner_body3d();
            }
            if(inner_shape==0)
            {
                polygon_inner_body3d();
            }
            for(angle=[0:360/num_rounds:360])
            {
                rotate([0,0,angle]) notch3d();
                rotate([0,0,angle+360/(2*num_rounds)]) slot3d();
            }
        }
    }
}