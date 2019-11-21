/* [Parts] */

// Select part to display (all will be printed)
part = "all"; //[core: Core, fe1: Front End 1, fe2: Front End 2, fw1a: Front End Whorl1a, fw1b: Front End Whorl1b, fw2a: Front End Whorl2a, fw2b: Front End Whorl2b, be1: Back End 1, be2: Back End 2, bw1a: Back End Whorl1a, bw1b: Back End Whorl1b, bw2a: Back End Whorl2a, bw2b: Back End Whorl2b, all: All Parts]

/* [Core and Mandrel] */

// Mandrel diameter
mandrel_diameter = 8; // [4:0.1:30]

// Length of the bobbin core from the inside face of one end to the other
core_visible_length = 109.5;  // [50:0.1:220]

// Diameter of the bobbin core
core_diameter = 22;  // [8:0.1:50]

// Length the bobbin core is inserted into the facing ends
core_recess_depth = 3;  // [2:0.1:20]

/* [Front End Main] */

// Diameter of inside front end
front_end_diameter = 79; // [50:0.1:200]

// Thickness of the inside front end
front_end_height = 6;  // [4:0.1:30]

// Groove thickness on inside front end (0 for none)
front_end_groove_height = 0;  // [0:0.1:4]

// Groove depth on inside front end from the outside diameter (0 for none)
front_end_groove_depth = 0; // [0:0.1:30]

// Extruding Bushing Distance
front_end_extruding_distance = 3.4; // [0:0.1:50]

/* [Front End Whorl #1] */

// Is there a first whorl on the front end and if so, how thick is it?
front_end_whorl1_height = 11.5; // [0:0.1:50]

// Diameter of the first whorl on the front end
front_end_whorl1_diameter = 32.0; // [0:0.1:200]

// Distance of the center of the groove on the first whorl from its inside face
front_end_whorl1_groove_center = 8.5; // [0:0.1:50]

// Thickness of the groove on the first whorl
front_end_whorl1_groove_height = 1.5; // [0:0.1:4]

// Depth of the groove on the first whorl
front_end_whorl1_groove_depth = 2.3; // [0:0.1:30]

/* [Front End Whorl #2] */

// Is there a second whorl on the front end and if so, how thick is it?
front_end_whorl2_height = 0; // [0:0.1:50]

// Diameter of the second whorl on the front end
front_end_whorl2_diameter = 0; // [0:0.1:200]

// Distance of the center of the groove on the second whorl from its inside face
front_end_whorl2_groove_center = 0; // [0:0.1:50]

// Thickness of the groove on the second whorl
front_end_whorl2_groove_height = 0; // [0:0.1:4]

// Depth of the groove on the second whorl
front_end_whorl2_groove_depth = 0; // [0:0.1:30]

/* [Back End Main] */

// Diameter of inside back end
back_end_diameter = 79; // [50:0.1:200]

// Thickness of the inside back end
back_end_height = 6; // [4:0.1:30]

// Groove thickness on inside back end (0 for none)
back_end_groove_height = 0;  // [0:0.1:4]

// Groove depth on inside back end (0 for none)
back_end_groove_depth = 0; // [0:0.1:200]

// Extruding Bushing Distance
back_end_extruding_distance = 3.4; // [0:0.1:50]

/* [Back End Whorl #1] */

// Is there a first whorl on the back end and if so, how thick is it?
back_end_whorl1_height = 11.5; // [0:0.1:50]

// Diameter of the first whorl on the back end
back_end_whorl1_diameter = 57.2; // [0:0.1:200]

// Distance of the center of the groove on the first whorl from its inside face
back_end_whorl1_groove_center = 6.6; // [0:0.1:50]

// Thickness of the groove on the first whorl
back_end_whorl1_groove_height = 2; // [0:0.1:4]

// Depth of the groove on the first whorl
back_end_whorl1_groove_depth = 2.3; // [0:0.1:30]

/* [Back End Whorl #2] */

// Is there a second whorl on the back end and if so, how thick is it?
back_end_whorl2_height = 0; // [0:0.1:50]

// Diameter of the second whorl on the back end
back_end_whorl2_diameter = 0; // [0:0.1:200]

// Distance of the center of the groove on the second whorl from its inside face
back_end_whorl2_groove_center = 0; // [0:0.1:50]

// Thickness of the groove on the second whorl
back_end_whorl2_groove_height = 0; // [0:0.1:4]

// Depth of the groove on the second whorl
back_end_whorl2_groove_depth = 0; // [0:0.1:30]

/* [Advanced] */

// Bobbin core wall thickness
core_wall_thickness = 5; // [1:0.1:30]

// Bore hole for core is larger than core diameter by this amount
core_allowance = 0.3; // [0:0.1:3]

// Bore hole for mandrel is larger than mandrel diameter by this amount
mandrel_allowance = 0.3;  // [0:0.1:3]

// Distance one piece of a whorl fits into another
whorl_groove_recess_depth = 1.5; // [0:0.1:3]

// Bore hole for groove recess is larger than the groove diameter by this amount
whorl_groove_allowance = 0.4;  // [0:0.1:3]

// Diameter of the support shaft for the whorls and any extrusion
whorl_support_diameter = 16; // [10:0.1:30]

// The bore hole for support shafts are larger than the support diameter by this amount
whorl_support_allowance = 0.3; // [0:0.1:3]

// Cylinder tapering factor
cylinder_tapering_factor = 3; // [0:0.1:10]

module whorl_inside(wh, wd, gh, gc, gd)
{
    difference()
    {
        union()
        {
            cylinder2(h=gc-(gh/2), d=wd);
            translate([0,0,gc-(gh/2)])
                cylinder(h=gh+whorl_groove_recess_depth, d=wd-(2*gd));
         }
         cylinder(h=gc+(gh/2)+whorl_groove_recess_depth, d=whorl_support_diameter+whorl_support_allowance);
    }
}

module whorl_outside(wh, wd, gh, gc, gd)
{
    difference()
    {            
        cylinder2(h=wh-(gc+(gh/2)), d=wd);
        cylinder(h=whorl_groove_recess_depth,d=wd-(2*gd)+whorl_groove_allowance);
        cylinder(h=wh-(gc-(gh/2)), d=whorl_support_diameter+whorl_support_allowance);
    }
}

module cylinder2(h,d)
{
    if (h>0)
    {
        translate([0,0,h/2])
        {
            difference()
            {
                resize(newsize=[d,d,d/(cylinder_tapering_factor/h*4)])
                    sphere(d=d);
                translate([0,0,h/2])
                    cylinder(h=d/(cylinder_tapering_factor/h*4),d=d);
                rotate(a=[0,180,0])
                    translate([0,0,h/2])
                        cylinder(h=d/(cylinder_tapering_factor/h*4),d=d);
            }
        }
    }
}

core_bore_diameter = core_diameter - (2*core_wall_thickness);
$fn = 128;

// fw2b, fw2a, fw1b, fw1a, fe2, fe1, core, be1, be2, bw1a, bw1b, bw2a, bw2b

fw2b_i = 0;
fw2a_i = 1;
fw1b_i = 2;
fw1a_i = 3;
fe2_i = 4;
fe1_i = 5;
core_i = 6;
be1_i = 7;
be2_i = 8;
bw1a_i = 9;
bw1b_i = 10;
bw2a_i = 11;
bw2b_i = 12;

part_height = [ 
    front_end_whorl2_height == 0 ? 0 : front_end_whorl2_height - (front_end_whorl2_groove_center+(front_end_whorl2_groove_height/2)), 

    front_end_whorl2_height == 0 ? 0 : front_end_whorl2_groove_center+(front_end_whorl2_groove_height/2)+whorl_groove_recess_depth,

    front_end_whorl1_height == 0 ? 0 : front_end_whorl1_height - (front_end_whorl1_groove_center+(front_end_whorl1_groove_height/2)), 

    front_end_whorl1_height == 0 ? 0 : front_end_whorl1_groove_center+(front_end_whorl1_groove_height/2)+whorl_groove_recess_depth,

    front_end_groove_height == 0 ? 0 : (front_end_height-front_end_groove_height)/2,

    front_end_groove_height == 0 ? front_end_height : (front_end_height+front_end_groove_height)/2,
    
    core_visible_length+(2*core_recess_depth),
    
    back_end_groove_height == 0 ? back_end_height : (back_end_height-back_end_groove_height)/2 + back_end_groove_height,
    
    back_end_groove_height == 0 ? 0 : (back_end_height-back_end_groove_height)/2,
    
    back_end_whorl1_height == 0 ? 0 : back_end_whorl1_groove_center+(back_end_whorl1_groove_height/2),
    
    back_end_whorl1_height == 0 ? 0 : back_end_whorl1_height - (back_end_whorl1_groove_center+(back_end_whorl1_groove_height/2)), 
    
    back_end_whorl2_height == 0 ? 0 : back_end_whorl2_groove_center+(back_end_whorl2_groove_height/2),
    
    back_end_whorl2_height == 0 ? 0 : back_end_whorl2_height - (back_end_whorl2_groove_center+(back_end_whorl2_groove_height/2)), 
    
];

part_offset = [
    front_end_whorl2_height == 0 ? 0 : part_height[0] - whorl_groove_recess_depth, 

    front_end_whorl2_height == 0 ? 0 : part_height[1],

    front_end_whorl1_height == 0 ? 0 : part_height[2] - whorl_groove_recess_depth, 

    front_end_whorl1_height == 0 ? 0 : part_height[3],

    front_end_groove_height == 0 ? 0 : part_height[4] - whorl_groove_recess_depth,

    part_height[5] - core_recess_depth,
    
    part_height[6] - core_recess_depth,
    
    part_height[7],
    
    back_end_groove_height == 0 ? 0 : part_height[8],
    
    back_end_whorl1_height == 0 ? 0 : part_height[9],
    
    back_end_whorl1_height == 0 ? 0 : part_height[10], 
    
    back_end_whorl2_height == 0 ? 0 : part_height[11],
    
    back_end_whorl2_height == 0 ? 0 : part_height[12]
];

part_start_height = [
    part_height[fw2b_i],
    part_height[fw2a_i]+part_offset[fw2b_i],
    part_height[fw1b_i]+part_offset[fw2b_i]+part_offset[fw2a_i],
    part_height[fw1a_i]+part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i],
    part_height[fe2_i] +part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i],
    part_height[fe1_i] +part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i],
    
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i]+part_offset[be1_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i]+part_offset[be1_i]+part_offset[be2_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i]+part_offset[be1_i]+part_offset[be2_i]+part_offset[bw1a_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i]+part_offset[be1_i]+part_offset[be2_i]+part_offset[bw1a_i]+part_offset[bw1b_i],
    part_offset[fw2b_i]+part_offset[fw2a_i]+part_offset[fw1b_i]+part_offset[fw1a_i]+part_offset[fe2_i]+part_offset[fe1_i]+part_offset[core_i]+part_offset[be1_i]+part_offset[be2_i]+part_offset[bw1a_i]+part_offset[bw1b_i]+part_offset[bw2a_i]
];

// core
if ((part == "core") || (part == "all"))
{
    translate([0, 0, part == "all" ? part_start_height[core_i] : 0])
    {
        difference()
        {
        cylinder(h=core_visible_length+(2*core_recess_depth), d=core_diameter);
        cylinder(h=core_visible_length+(2*core_recess_depth), d=core_bore_diameter);
        }
    }
} 

// front end
if (front_end_groove_height == 0)
{ // no groove on front end main
    if ((part == "fe1") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fe1_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
        {
            difference()
            {
                union()
                {
                    cylinder2(h=front_end_height, d=front_end_diameter);
                    translate([0,0,front_end_height])
                        cylinder(h=front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance,d=whorl_support_diameter);

                    difference()
                    {
                        cylinder(h=front_end_height+front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance,d=whorl_support_diameter);
                        cylinder(h=front_end_height+front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance,d=mandrel_diameter+mandrel_allowance);
                    }
                }
                cylinder(h=core_recess_depth, d=core_diameter+core_allowance);
                cylinder(h=front_end_height+front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance, d=mandrel_diameter+
        mandrel_allowance);
            }
        }
    }
    
    if (part == "fe2")
    {
        linear_extrude(height=1)
            text("unused");
    }
}
else
{ // groove on front end main

    // inner piece
    if ((part == "fe1") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fe1_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
        {
            difference()
            {
                union()
                {
                    cylinder2(h=(front_end_height-front_end_groove_height)/2, d=     front_end_diameter);
                    cylinder(h=(front_end_height-front_end_groove_height)/2 + front_end_groove_height + whorl_groove_recess_depth, d=front_end_diameter-(front_end_groove_depth*2));
                    cylinder(h=front_end_height + front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance,d=whorl_support_diameter);
                }
                cylinder(h=front_end_height + front_end_whorl1_height+front_end_whorl2_height+front_end_extruding_distance, d=mandrel_diameter+
        mandrel_allowance);
                cylinder(h=core_recess_depth, d=core_diameter+core_allowance);
            }
        }
    }
    
    // outer piece
    if ((part == "fe2") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fe2_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
        {
            difference()
            {
                cylinder2(h=(front_end_height-front_end_groove_height)/2, d=front_end_diameter);
                cylinder(h=whorl_groove_recess_depth,d=front_end_diameter-(front_end_groove_depth*2)+whorl_groove_allowance);
                cylinder(h=(front_end_height-front_end_groove_height)/2, d=whorl_support_diameter+whorl_support_allowance);
            }
        }
    }
}


if (front_end_whorl1_height != 0)
{
// front end whorl1a
    if ((part == "fw1a") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fw1a_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
            whorl_inside(front_end_whorl1_height, front_end_whorl1_diameter, front_end_whorl1_groove_height, front_end_whorl1_groove_center, front_end_whorl1_groove_depth);
    }

// front end whorl1b
    if ((part == "fw1b") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fw1b_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
            whorl_outside(front_end_whorl1_height, front_end_whorl1_diameter, front_end_whorl1_groove_height, front_end_whorl1_groove_center, front_end_whorl1_groove_depth);    
    }
}
else if ((part == "fw1a") || (part == "fw1b"))
{
    linear_extrude(height=1)
        text("unused");    
}

if (front_end_whorl2_height != 0)
{
// front end whorl2a
    if ((part == "fw2a") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fw2a_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
            whorl_inside(front_end_whorl2_height, front_end_whorl2_diameter, front_end_whorl2_groove_height, front_end_whorl2_groove_center, front_end_whorl2_groove_depth);
    }

// front end whorl2b
    if ((part == "fw2b") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[fw2b_i] : 0])
        rotate(a=[0,part == "all" ? 180 : 0,0])
            whorl_outside(front_end_whorl2_height, front_end_whorl2_diameter, front_end_whorl2_groove_height, front_end_whorl2_groove_center, front_end_whorl2_groove_depth);
    }
}
else if ((part == "fw2a") || (part == "fw2b"))
{
    linear_extrude(height=1)
        text("unused");    
}

// back end
if (back_end_groove_height == 0)
{ // no groove on back end main
    if ((part == "be1") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[be1_i] : 0])
        {
            difference()
            {
                union()
                {
                    cylinder2(h=back_end_height, d=back_end_diameter);
                    cylinder(h=back_end_height+ back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance,d=whorl_support_diameter);
                    difference()
                    {
                        cylinder(h=back_end_height+back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance,d=whorl_support_diameter);
                        cylinder(h=back_end_height+back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance,d=mandrel_diameter+mandrel_allowance);
                    }
                }
                cylinder(h=core_recess_depth, d=core_diameter+core_allowance);
                cylinder(h=back_end_height+back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance, d=mandrel_diameter+
        mandrel_allowance);
            }
        }
    }
    if (part == "be2")
    {
        linear_extrude(height=1)
            text("unused");    
    }
}
else
{ // groove on back end main

    // inner piece
    if ((part == "be1") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[be1_i] : 0])
        {
            difference()
            {
                union()
                {
                    cylinder2(h=(back_end_height-back_end_groove_height)/2, d=back_end_diameter);
                    cylinder(h=(back_end_height-back_end_groove_height)/2 + back_end_groove_height + whorl_groove_recess_depth, d=back_end_diameter-(back_end_groove_depth*2));
                    cylinder(h=back_end_height + back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance,d=whorl_support_diameter);
                }
                cylinder(h=back_end_height + back_end_whorl1_height+back_end_whorl2_height+back_end_extruding_distance, d=mandrel_diameter+mandrel_allowance);
                cylinder(h=core_recess_depth, d=core_diameter+core_allowance);
      
            }
        }
    }
    
    // outer piece
    if ((part == "be2") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[be2_i] : 0])
        {
            difference()
            {
                cylinder2(h=(back_end_height-back_end_groove_height)/2, d=back_end_diameter);
                cylinder(h=whorl_groove_recess_depth,d=back_end_diameter-(back_end_groove_depth*2)+whorl_groove_allowance);
                cylinder(h=(back_end_height-back_end_groove_height)/2, d=whorl_support_diameter+whorl_support_allowance);
            }
        }
    }
}


if (back_end_whorl1_height != 0)
{
// back end whorl1a
    if ((part == "bw1a") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[bw1a_i] : 0])
            whorl_inside(back_end_whorl1_height, back_end_whorl1_diameter, back_end_whorl1_groove_height, back_end_whorl1_groove_center, back_end_whorl1_groove_depth);
    }
    
// back end whorl1b
    if ((part == "bw1b") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[bw1b_i] : 0])
            whorl_outside(back_end_whorl1_height, back_end_whorl1_diameter, back_end_whorl1_groove_height, back_end_whorl1_groove_center, back_end_whorl1_groove_depth);    
    }

}
else if ((part == "bw1a") || (part == "bw1b"))
{
    linear_extrude(height=1)
        text("unused");    
}

if (back_end_whorl2_height != 0)
{
    if ((part == "bw2a") || (part == "all"))
    {
// back end whorl2a
        translate([0,0,part == "all" ? part_start_height[bw2a_i] : 0])
            whorl_inside(back_end_whorl2_height, back_end_whorl2_diameter, back_end_whorl2_groove_height, back_end_whorl2_groove_center, back_end_whorl2_groove_depth);
    }
    
// back end whorl2b
    if ((part == "bw2b") || (part == "all"))
    {
        translate([0,0,part == "all" ? part_start_height[bw2b_i] : 0])
            whorl_outside(back_end_whorl2_height, back_end_whorl2_diameter, back_end_whorl2_groove_height, back_end_whorl2_groove_center, back_end_whorl2_groove_depth);
    }
}
else if ((part == "bw2a") || (part == "bw2b"))
{
    linear_extrude(height=1)
        text("unused");    
}