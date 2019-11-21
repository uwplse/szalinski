// This is an overshot card cutter die.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution+non-commercial licen
// This design was inspired by TATV Canada's Youtube video:
// https://www.youtube.com/watch?v=-jKdXI_qDwc
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:3054657

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define hole length in mm
hole_length=100.0;

// Define hole diameter in mm
hole_diameter=18.67;

// Define washer outside diameter in mm
insert_diameter=30.0;

// Define washer height in mm
insert_height=3.0;
     
// Define head height in mm
head_height=25.0;

// Define gap height in mm
gap=6.0;

// Define corner radius in mm
corner_radius=6.0;

// Define L-N-L bushing diameter in mm
bushing_diameter=24.5;

// Define modified bushing height in mm
bushing_height=39.62;

// Define lug offset in mm
lug_offset=31.5;

// Define bushing lug_length in mm
lug_length=27.35;

// Define lug height in mm
lug_height=8.62;

// Define bushing lug_width in mm
lug_width=6.68;

module lug()
{
    intersection()
    {
        union()
        {
            translate([0,0,lug_height/2-2]) cylinder(r1=lug_length/2,r2=bushing_diameter/2,h=2,center=true);
            translate([0,0,-2.0]) cylinder(r=lug_length/2,h=lug_height-2,center=true);
        }
        cube([lug_length,lug_width,lug_height],center=true);
    }
}

module head()
{
    difference()
    {
        hull()
        {
            translate([0,0,0]) cylinder(r=(insert_diameter+10)/2,h=head_height,center=true);
            translate([-((insert_diameter+10)/2-corner_radius),(insert_diameter+10)/2-corner_radius,0]) cylinder(r=corner_radius,h=head_height,center=true);
            translate([-((insert_diameter+10)/2-corner_radius),-((insert_diameter+10)/2-corner_radius),0]) cylinder(r=corner_radius,h=head_height,center=true);
        }
        union()
        {
            // Remove material to create cutting gap
            translate([((insert_diameter+10)-hole_diameter)/2,0,0]) cube([(insert_diameter+10),(insert_diameter+10),gap],center=true);
            // Remove material for insert
            translate([0,0,(gap+insert_height)/2]) cylinder(r=insert_diameter/2,h=insert_height+0.5,center=true);
            // Remove material for bevel edge of hole
            translate([0,0,-head_height/2]) cylinder(r1=(hole_diameter+corner_radius)/2,r2=hole_diameter/2,h=gap,center=true);
        }
    }
}

module hole()
{
    union()
    {
        translate([0,0,0]) cylinder(r=hole_diameter/2,h=hole_length,center=true);
        translate([0,0,-(hole_length-head_height)/2]) cylinder(r=(insert_diameter+10)/2,h=head_height,center=true);
    }
}

difference()
{
    union()
    {
        // Render bushing body
        cylinder(r=bushing_diameter/2,h=bushing_height,center=false);
        translate([0,0,lug_offset+lug_height/2])
        {
            rotate([0,0,0])   lug();
            rotate([0,0,60])  lug();
            rotate([0,0,120]) lug();
        }
        // Render cutting die body
        translate([0,0,-(head_height)/2]) head();
    }
    // Drill a hole
    #cylinder(r=hole_diameter/2,h=hole_length,center=true);
}