// pencil clip & protector for notebook with band closure
// version 0.2.0
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

/*[(elastic) band]*/
elastic_band_width = 6; // [4:0.1:15]
elastic_band_height = 1; // [0.5:0.1:2]

/*[pencil]*/
pencil_diameter = 7.3; // [5:0.1:15]
pencil_tip_height = 16; // [10:25]

/*[clips]*/
top_clip = "yes"; // [yes,no]
second_clip = "yes"; // [yes,no]
second_clip_pull = "no"; // [yes,no]

/*[Hidden]*/
// speed vs. resolution
$fn = 60; // looks like this can't be modified on thingiverse

pencil_inner_radius = pencil_diameter/2;
pencil_outer_radius = pencil_inner_radius + 1;
pencil_clip_tip_height = pencil_tip_height + 1;
clip_connector_height = 8;

//------------------------------------------------------------------
// Main

if(top_clip=="yes")
{
    clip(true);
    
    if(second_clip=="yes")
    {
        if((elastic_band_width+2) > (pencil_outer_radius*2+2))
        {
            translate([0,elastic_band_width+4,0])
            {
                clip(false);
            }
        }
        else
        {
            translate([0,pencil_outer_radius*2+2,0])
            {
                clip(false);
            }
        }
    }
}
else
{
    if(second_clip=="yes")
    {
        clip(false);
    }
}

//------------------------------------------------------------------
// Module

module clip(top)
{
    difference()
    {
        // shell
        union()
        {
            cylinder(h=clip_connector_height, r1=pencil_outer_radius, r2=pencil_outer_radius, center=false);
            translate([0,(elastic_band_width/-2)-1,0])
            {
                cube([pencil_outer_radius+elastic_band_height+0.5,elastic_band_width+2,clip_connector_height],center=false);
            }
            
            if(top)
            {
                translate([0,0,clip_connector_height])
                {
                    cylinder(h=pencil_clip_tip_height, r1=pencil_outer_radius, r2=2.2, center=false);
                }
            }
        }
        
        // remove inner
        union()
        {
            cylinder(h=clip_connector_height, r1=pencil_inner_radius, r2=pencil_inner_radius, center=false);
            translate([pencil_inner_radius+0.5,elastic_band_width/-2,0])
            {
                cube([elastic_band_height,elastic_band_width,clip_connector_height+pencil_clip_tip_height],center=false);
            }
            
            translate([pencil_outer_radius*-1,elastic_band_height*-1,0])
            {
                cube([pencil_outer_radius*2,elastic_band_height*2,clip_connector_height+pencil_clip_tip_height],center=false);
            }
            
            if(top)
            {
                translate([0,0,clip_connector_height])
                {
                    cylinder(h=pencil_clip_tip_height, r1=pencil_inner_radius, r2=1.2, center=false);
                }
            }
            else if(second_clip_pull == "no")
            {
                linear_extrude(height = clip_connector_height+pencil_clip_tip_height, twist = 0)
                {
                    polygon(points=[[pencil_outer_radius,0], [pencil_outer_radius*-1,pencil_outer_radius], [pencil_outer_radius*-1,pencil_outer_radius*-1]]);
                }
            }
            
        }
    }
}
