//--------------------------------------------------
// Model rocket fin alignment tool generator
//
// For openSCAD 15.03-2, and Thingiverse Customizer
//
// Written by Erik Ness 2016/12/30
//
// erik@nessnation.com
//--------------------------------------------------


//--------------------------------------------------
//        User-entered parameters
//
//  Formatted for thingiverse customizer.
//
// NOTE:  I converted the inch parameters to mm
// and then turned off inches mode because the
// thingiverse customizer freaked out when I used
// inches, even though openscad works fine.
//
// NOTE2:  Thingiverse customizer also freaks out
// if you type trailing zeros, like 1.0 or 1.10,
// so don't do that!
//--------------------------------------------------

// Dimensions are inches?  (If yes, output is scaled by 25.4 in xyz)
use_inches            = 0;      // [0:No,1:Yes]

// Rocket body outside diameter:
rocket_od             = 76.2;

// Number of fins:
rocket_num_fins       = 4;  // [3:6]

// Rocket fin thickness:
rocket_fin_thick      = 3.175;

// Tool thickness:
tool_thick            = 2.54;

// Tool height:
tool_height           = 17;

// Tool fin length (extension from rocket body):
tool_fin_len          = 32;

// Glue keepout diameter:
tool_glue_keepout_dia = 10;

// Slop for rocket body dia and fin thickness:
tool_slop             = 0.127;




/* [Hidden] */
$fn = 100;

draw_fin_len          = rocket_od / 2 + tool_fin_len * 2;
fin_angle             = 360/rocket_num_fins;
delta_angle_glue      = asin(  (rocket_fin_thick/2 + tool_slop)
                             / (rocket_od/2 + tool_slop)
                            );
final_scale           = use_inches ? 25.400 : 1.000;


scale([final_scale,final_scale,final_scale])
    difference()
    {
        union()
        {
            // Tool main arc (around rocket body):
            cylinder(  tool_height
                     , d=rocket_od+tool_slop+2*tool_thick
                     , center=true
                    );

            for (a=[0 : fin_angle : 359])
            {
                rotate([0,0,a])
                    translate([rocket_od/2+tool_slop+tool_fin_len/2,0,0])
                        cube(  [  tool_fin_len
                                , rocket_fin_thick+2*tool_slop+2*tool_thick
                                , tool_height
                               ]
                             , center=true
                            );

                for (a2=[-delta_angle_glue, delta_angle_glue])
                    rotate([0,0,a+a2])
                        translate([rocket_od/2 + tool_slop, 0, 0])
                            cylinder( h=tool_height
                                     ,d=tool_glue_keepout_dia+tool_slop+2*tool_thick
                                     ,center=true
                                    );
            }
        }

        // Erase rocket body and fins:
        rocket_with_slop();
        
        // Erase extra copies of tool:
        pie_wedge(  tool_height * 1.1
                  , rocket_od+draw_fin_len
                  , 360-fin_angle
                 );
    }






// Rocket body and fins: (plus slop)
// These are subtracted from the tool:
module rocket_with_slop()
{
    // Rocket body:
    cylinder(  tool_height*1.1
             , d=rocket_od+tool_slop
             , center=true
            );

    for (a=[0 : fin_angle : 359])
    {
        // Fin:
        rotate([0,0,a])
            translate([draw_fin_len/2,0,0])
                cube(  [  draw_fin_len*1.1
                        , rocket_fin_thick+2*tool_slop
                        , tool_height*1.1
                       ]
                     , center=true
                    );
        
        // Glue keepout cylinder:
        for (a2=[-delta_angle_glue, delta_angle_glue])
            rotate([0,0,a+a2])
                translate([rocket_od/2 + tool_slop, 0, 0])
                    cylinder( h=tool_height*1.1
                             ,d=tool_glue_keepout_dia+tool_slop
                             ,center=true
                            );
    }
}





// Draws a pie wedge h units tall, r units in radius,
// starting at angle=0, going to angle=a
module pie_wedge(h,r,a)
{
    // This would work if the angle parameter was obeyed by openscad,
    // but for that you need an openscad version from 2016 or later
    // and these are currently pre-release (as of December 2016).
    //
    //    rotate_extrude(angle=a,convexity = 10)
    //        translate([r, 0, 0])
    //            square([r,h],true);
    
    
    
    // So instead, here's a really stupid "pie wedge":
    sub_angle = a/10;
    for (a2=[0 : sub_angle/2 : a*0.91])
    {
        x1 = cos(a2) * r;
        y1 = sin(a2) * r;

        x2 = cos(a2+sub_angle) * r;
        y2 = sin(a2+sub_angle) * r;
        
        linear_extrude(height=h, center=true)
            polygon(points=[[0,0],[x1,y1],[x2,y2],[0,0]]);
    }
}
