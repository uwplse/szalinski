/***********************************************************************************************************************************
'Shelfie' Do it yourself shelf and storage designer by: Mike Thompson 10/4/2015, http://www.thingiverse.com/mike_linus
Based on original concept idea from Milla Niskakoski http://www.thingiverse.com/thing:681835

v2 18/1/2017 - Added 'no internal bracing' option to allow panels to butt together and a corner radius cut-off option for wall mounting
v3 16/4/2017 - Fixed L and T Foot rendering for small cube sizes

Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.  Further 
information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB

I was very impressed with the simplicity and practicality of Milla's initial design, but ran into some major limitations when trying to
construct my own shelves.  The key issues I encountered were:
- No customisable thicknesses. Like may others, I wanted to use the scrap wood I had lying around rather than purchase new material.
- No mixed thicknesses. I wanted to use glass shelves with wood sides, but it wasn't possible unless they were the same thickness.
- No wall mounting bracket option.  Particularly for tall shelves, this is an important safety feature.
- No ability to alter the size of the bracket or the wall thickness to increase strength.
- No ability to attach a shelf midspan.  This is a big issue if you have long sections and want to add a shelf in-between.

Shelfie provides full control over all parameters so you can mix materials of any thickness, add wall mounts, alter the bracket size,
mid mount shelves, change the screw hole size etc. 

Note: incremental 0.01 values added to fix diplay anomalies when using preview (F5)

Instructions: select the bracket type and options to suit your particular materials below. 
************************************************************************************************************************************/

/**************************************************************************
Enter the values corresponding to your bracket requirements in this section
***************************************************************************/

/* [Bracket Options] */

//Bracket Type
bracket_type="L";//[L,T,X,L Foot,T Foot]
//Bracket cube size
bracket_size = 54;//54
//Thickness of Panel 1
panel_thickness = 16;
//Thickness of Panel 2
panel2_thickness = 16;
//Flip bracket for opposite orientation
flip = "false";//[false,true]
//Thickness of panel walls
wall_thickness = 3;
//Thickness of base (set to zero to remove base and allow mid-panel mounting on both panels)
base_thickness=5;
//Hole radius (set to 0 to remove)
hole_radius=2;
//Allow pass through for mid-panel mounting on a single panel
pass_through="false";//[false,true]
//Internal bracing (If removed, all internal bracing will be removed allowing panels to butt together)  
bracing="true";//[true,false]
//Add wall mount plate
wall_mount = "false";//[false,true]
//Corner radius of wall mount. Note: '0' will create a square corner. It is not recommended to set a radius higher than: (bracket_size - (wall_thickness *2) + panel_thickness)
wall_mount_corner_radius = 0;
/* [Hidden] */
$fn=50;

panel_depth=bracket_size-panel_thickness-(wall_thickness*2);
panel_depth2=bracket_size-panel2_thickness-(wall_thickness*2);

module L_piece()
{
    difference()
    {
        cube(bracket_size);
        union()
        {
            hull()//corner cutout
            {
                if(wall_mount=="true")
                {
                    translate([0,0,wall_thickness])
                    {
                        translate([-0.001,-0.001,-0.001])cube([10,10,bracket_size]);
                        translate([bracket_size-panel_thickness-(wall_thickness*2)-10,0,-0.01])cube([10,10,bracket_size]);
                        translate([-0.01,bracket_size-panel2_thickness-(wall_thickness*2)-10,-0.01])cube([10,10,bracket_size]);
                        translate([bracket_size-panel_thickness-(wall_thickness*2)-10,bracket_size-panel2_thickness-(wall_thickness*2)-10,0])cylinder(h=bracket_size,r=10);
                    }
                }
                else
                {
                    translate([-0.001,-0.001,-0.001])cube([10,10,bracket_size+0.01]);
                    translate([bracket_size-panel_thickness-(wall_thickness*2)-10,-0.01,-0.01])cube([10,10,bracket_size+0.02]);
                    translate([-0.01,bracket_size-panel2_thickness-(wall_thickness*2)-10,-0.01])cube([10,10,bracket_size+0.02]);
                    translate([bracket_size-panel_thickness-(wall_thickness*2)-10,bracket_size-panel2_thickness-(wall_thickness*2)-10,0])cylinder(h=bracket_size+0.02,r=10);
                }
            }
            if(wall_mount=="true")
            {
                translate([bracket_size/3,bracket_size/3,0])cylinder(r=hole_radius,h=wall_thickness+0.01); //cut hole in wall mount area
                
                difference() //cut corner radius from base wall mount area
                {
                    cube([wall_mount_corner_radius,wall_mount_corner_radius,wall_thickness]);
                    translate([wall_mount_corner_radius,wall_mount_corner_radius,0])cylinder(r=wall_mount_corner_radius, h= wall_thickness);
                }
            }
            //panel cutout
            if (bracing == "true")
            {
                translate([bracket_size-wall_thickness-panel_thickness,-0.01,base_thickness])cube([panel_thickness,panel_depth2,bracket_size-base_thickness+0.01]);
            }
            else
            {
                translate([bracket_size-wall_thickness-panel_thickness,-0.01,base_thickness])cube([panel_thickness,panel_depth2+wall_thickness+0.01,bracket_size-base_thickness+0.01]);            
            }
            //panel2 cutout
            if (pass_through=="true")
            {
                translate([-0.01,bracket_size-wall_thickness-panel2_thickness,base_thickness])cube([bracket_size+0.02,panel2_thickness,bracket_size-base_thickness+0.01]);
            }
            else
            {
                if (bracing == "true")
                {
                    translate([-0.01,bracket_size-wall_thickness-panel2_thickness,base_thickness])cube([panel_depth+0.01,panel2_thickness,bracket_size-base_thickness+0.01]);
                }
                else
                {
                    translate([-0.01,bracket_size-wall_thickness-panel2_thickness,base_thickness])cube([bracket_size-wall_thickness,panel2_thickness,bracket_size-base_thickness+0.01]);                
                }
            }
            //inside holes
            translate([panel_depth,panel_depth2/2,bracket_size/2])rotate([0,90,0])cylinder(h=wall_thickness+0.01,r=hole_radius);
            translate([panel_depth/2,panel_depth2+wall_thickness,bracket_size/2])rotate([90,0,0])cylinder(h=wall_thickness++0.01,r=hole_radius);
        }
    }
}

module T_piece()
{
    difference()
    {
        union()
        {
            L_piece();
            translate([(bracket_size*2)-(wall_thickness*2)-panel_thickness,0,0])mirror(0,1,0)L_piece();
        }
        union()
        {
            //repunch holes
            translate([panel_depth-0.5,panel_depth2/2,bracket_size/2])rotate([0,90,0])cylinder(h=(wall_thickness*2)+panel_thickness+1,r=hole_radius);
            //repunch internal walls if corner_salid is false
            if (bracing == "false" && pass_through == "false")
            {
                translate([-0.01,bracket_size-wall_thickness-panel2_thickness,base_thickness])cube([bracket_size+0.01,panel2_thickness,bracket_size-base_thickness+0.01]);
            }
        }
    }
}

module X_piece()
{
    difference()
    {
        union()
        {
            T_piece();
            translate([(bracket_size*2)-(wall_thickness*2)-panel_thickness,(bracket_size*2)-(wall_thickness*2)-panel2_thickness,0])rotate([0,0,180])T_piece();
        }
        union()
        {
            //repunch holes
            translate([panel_depth/2,panel_depth+panel_thickness+(wall_thickness*2),bracket_size/2])rotate([90,0,0])cylinder(h=(wall_thickness*2)+panel2_thickness+1,r=hole_radius);
            translate([(panel_depth/2)+bracket_size,panel_depth+panel_thickness+(wall_thickness*2),bracket_size/2])rotate([90,0,0])cylinder(h=(wall_thickness*2)+panel2_thickness+1,r=hole_radius);
            //repunch internal walls if corner_salid is false
            if (bracing == "false" && pass_through == "false")
            {
                translate([bracket_size-wall_thickness-panel_thickness,-0.01,base_thickness])cube([panel_thickness,bracket_size+0.01,bracket_size-base_thickness+0.01]);
            }
        }
    }
}

module L_foot()
{
    L_piece();
    translate([bracket_size,bracket_size+(bracket_size*0.60),0])mirror(0,0,1)rotate([90,0,0])
    hull()
    {
        cube(bracket_size/2);
        translate([0,0,bracket_size*0.60])cube([bracket_size,bracket_size,1]);
    }
}

module T_foot()
{
    T_piece();
    translate([bracket_size-wall_thickness-(panel_thickness/2),bracket_size+(bracket_size*0.60),0])mirror(0,0,1)rotate([90,0,0])
    hull()
    {
       translate([-bracket_size/4,0,0])cube(bracket_size/2);
       translate([-bracket_size/2,0,bracket_size*0.60])cube([bracket_size,bracket_size,1]);
    }
}

if (bracket_type=="L")
{
    if(flip=="true")
    {
        mirror()L_piece();
    }
    else
    {
        L_piece();
    }
}
if (bracket_type=="T")
{
    T_piece();
}
if (bracket_type=="X")
{
    X_piece();
}
if (bracket_type=="L Foot")
{
    if(flip=="true")
    {
        mirror()L_foot();
    }
    else
    {
        L_foot();
    }
}
if (bracket_type=="T Foot")
{
    T_foot();
}