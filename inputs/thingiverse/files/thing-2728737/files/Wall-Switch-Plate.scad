/* [Switches] */

// Type of the first switch in the gang.
switch1_type=1; // [1:Decora,2:Toggle,3:Blank]
// Optional label over the first switch.  Leave blank for no label.
switch1_label="LIGHT";
// Type of the second switch in the gang.  "None" results in this and all further switch types/labels being ignored
switch2_type=0; // [0:None,1:Decora,2:Toggle,3:Blank]
// Optional label over the switch.  Leave blank for no label.
switch2_label="";
// Type of the second switch in the gang.  "None" results in this and all further switch types/labels being ignored
switch3_type=0; // [0:None,1:Decora,2:Toggle,3:Blank]
// Optional label over the switch.  Leave blank for no label.
switch3_label="";
// Type of the second switch in the gang.  "None" results in this and all further switch types/labels being ignored
switch4_type=0; // [0:None,1:Decora,2:Toggle,3:Blank]
// Optional label over the switch.  Leave blank for no label.
switch4_label="";

/* [ Plate Details ] */

// The height, in mm, of the plate. The width is determined from the height on the basis of a 2-gang plate width matching the height.  Standard US plates are 114.3mm high.  Non-standard (oversized) plates come in different heights, and may include values such as 127, 139.7, etc. 127mm is a nice slightly oversized plate
plate_height = 127;

// The depth of the plate is the distance between the wall and the outmost edge of the plate.  Standard US plates are 3.96875mm deep.  Oversized plates usually are a bit deeper.  The deeper plates allow for switches that don't mount quite perfectly flush with the wall or gang boxes that stick out slightly, but might require slightly longer mounting screws.
plate_depth = 6.4; 

// How thick should the plastic be printed for the wall plate.  This has nothing to do with printer layer height (or any other slicer settings.)  A smaller value will result in a more hollow (but flimsy) wall plate.  In that case, supports will likely be needed when printing (unless you flip the plate face down when printing.)  A value equal to or greater than the plate_depth will result in a solid chunk of plastic (and somewhat negates the point of having a greater than standard plate_depth due to no hollow space.)
plastic_thickness = 2; // [1.5:.2:4]

// If set to emboss, any labels will be raised from the plate by 1mm.  If set to inset, the labels will be inset in the plate by 1mm.  The embossing usually extrudes nicer lettering, but requires that the plate be printed with the face up (and will require supports.)  If the labels are inset, the object can be flipped so the face prints against the print bed. (or, you can not use labels at all, in which case this setting has no effect.)
emboss_or_inset_labels=1; // [0:inset,1:emboss]


/* [Advanced] */

// the radius (not diameter) of the screw holes.  Should probably be left as 1.7.
screw_hole_radius = 1.7;

// For standard screws that are NOT meant to be countersunk (but the head rests outside the plate), set screw_head_radius to 0.  Otherwise, screw_head_radius should be the radius (not diameter) of the widest part of the screw head, and screw_head_depth is the depth of the screw head before the threads.  (distance between the top of the head and first thread.)  The defualt values of 3.25 (radius) and 2.3 (depth) work well with standard oval head screws.
screw_head_radius = 3.25;
screw_head_depth = 2.3; // this is ignored if screw_head_radius is 0


// Most FDM printers aren't really precise when printing empty space within a solid area (such as switch holes, screw holes, etc.)  Often times, the  empty spaces end up being very slightly smaller than the design.  Set hole_expansion to a positive number to the holes to be designed that much bigger than normal.  This often requires a bit of testing.  Start with 1 and print just the first couple of layers.  Measure the resulting screw holes.  If the screw holes are too big, reduce the hole_expansion.  If they are too small, raise it. 
hole_expansion = 0.5; 

/* [hidden] */

// vectors for switch types are ordered as:  width, height, screw hole gap (0 for a single hole with no gap, -1 for no holes), height(from center) for text labels
switch_decora = [ 33.3375, 66.675, 96.8375, 37 ];
switch_toggle = [ 10.31875, 23.8125, 60.325, 39 ];
switch_blank = [ 0, 0, 83.34375, 0 ];

gang_cnt = switch2_type == 0 ? 1 : switch3_type == 0 ? 2 : switch4_type == 0 ? 3 : 4;

gang_types = [ [], switch_decora, switch_toggle, switch_blank];


gangs = (0 == switch2_type) ? [[gang_types[switch1_type], switch1_label]] :
    (0 == switch3_type) ? [[gang_types[switch1_type], switch1_label], [gang_types[switch2_type], switch2_label] ] :
        (0 == switch4_type) ? [[gang_types[switch1_type], switch1_label], [gang_types[switch2_type], switch2_label], [gang_types[switch3_type], switch3_label] ] :
            [[gang_types[switch1_type], switch1_label], [gang_types[switch2_type], switch2_label], [gang_types[switch3_type], switch3_label], [gang_types[switch4_type], switch4_label] ];
    
// ------
$fn = 75;
gang_gap = 0 + 46.0375; // constant
plate_width = plate_height + ((len(gangs) - 2) * gang_gap);

// ---

module draw_screw_hole()
{
    base_r = screw_hole_radius + (hole_expansion * .5);
   // just draw a hole, centered
    cylinder(r = base_r, h =plate_depth*2, center = true, $fn=6);    
    
    if (0 == screw_head_radius)
    {
        translate([0,0,plate_depth]) 
            cylinder(r = base_r, h=(plastic_thickness - 1)*2, center = true);
    }
    else
    {
        cs_r = screw_head_radius + (hole_expansion * .5);
        hull()
        {
            //screw_counter_radius
            // screw_counter_depth
            translate([0,0,plate_depth+0.0001])
                cylinder(r=cs_r, h=0.1, center=true);
            
            translate([0,0,plate_depth-screw_head_depth/2]) 
                cylinder(r=base_r, h=(screw_head_depth), center=true);
        }
        
    }
}

// need something to handle cases where the plastic thickness is too thin
// to handle the full "depth" of a countersunk screw hole
//
// So, this module will draw a "shell" around a screw hole 
module draw_screw_hole_with_shells()
{
    if (screw_hole_radius)
    {
        r = (screw_head_radius) +  (hole_expansion * .5) ;
        r2 = (screw_hole_radius) +  (hole_expansion * .5);
        difference() 
        {
            // hard-coded 1.5mm thickness for the screw hole shell
            resize([r*2+1.5, r*2+1.5, 0]) 
            {
                draw_screw_hole();
                cylinder(r = r2, h = plate_depth *2, center = true);    
    
            }
            
            //draw_screw_hole();
            translate([0,0, -screw_head_depth-1]) 
                cube([r*2, r*2,plate_depth*2], center=true);
            
        }
    }
}


module draw_switch ( v )
{
   // draw things centered!
   
   // main hole
   if (v[0] && v[1])
   {
      cube([v[0] + hole_expansion, v[1] + hole_expansion, plate_depth*2.1], center = true);
   }
   if (-1 != v[2])
   {
      if (0 != v[2])
      {
         translate([0, v[2]/2, 0]) draw_screw_hole();
         translate([0, -(v[2]/2), 0]) draw_screw_hole();
         
      }
      else
      {
         draw_screw_hole();
      }
   }
}


module draw_screw_hole_shells()
{
	translate([  -(len(gangs)-1)*gang_gap/2, 0, 0])
	{
		for (i = [0 : len(gangs)-1])
		{
			translate([i*gang_gap, 0, 0])
            {
                if (-1 != gangs[i][0][2])
                {
                    if (0 != gangs[i][0][2])
                    {
                        translate([0, gangs[i][0][2]/2, -.1])
                            draw_screw_hole_with_shells();
                        translate([0, -(gangs[i][0][2]/2), -.1])
                            draw_screw_hole_with_shells();
                    }
                    else
                    {
                        draw_screw_hole_with_shells();
                    }
                }
            }
		}
	}
}

module draw_switch_labels(emboss=true)
{
	translate([  -(len(gangs)-1)*gang_gap/2, 0, plate_depth - .001])
	{
		for (i = [0 : len(gangs)-1])
		{
            if (gangs[i][1])
            {
                switch_type = gangs[i][0];
                
                translate([i*gang_gap, switch_type[3], emboss ? 0 : -1]) 
                    linear_extrude(height = 1.001)
                    {
                        text(gangs[i][1], 
                             font = "Liberation Sans:style=Regular",
                            //font  = "Liberation Serif:style=Regular",
                            // font="Arial:style=Normal", 
                            //font="Liberation Mono:style=Regular",
                            size=6, spacing=1.1,
                            halign="center", 
                            valign="baseline");
                    }
            }
		}
	}
}

module draw_all_switches()
{
// draws all the switches, left to right.  The left edge will be at X axis 0, while the Y axis is centered

	translate([  -(len(gangs)-1)*gang_gap/2, 0, 0])
	{
		for (i = [0 : len(gangs)-1])
		{
            //switch_type = switch_decora;
            
			translate([i*gang_gap, 0, 0]) 
                draw_switch(gangs[i][0]);
		}
	}
}

module outer_plate(recurse=true)
{
    difference()
    {
        hull()
        {
            a = .75; // 1
            b = a*2;
            
            translate([-plate_width/2 + plate_depth, 0,0]) 
                rotate(a=270, v=[1,0,0])
                    cylinder(r=plate_depth, 
                        h=(plate_height - plate_depth*b), 
                        center=true);
            
            translate([plate_width/2 - plate_depth, 0,0]) 
                rotate(a=270, v=[1,0,0])
                    cylinder(r=plate_depth, 
                        h=(plate_height - plate_depth*b), 
                        center=true);

            translate([0, plate_height/2 - plate_depth,0]) 
                rotate(a=90, v=[0,1,0])
                    cylinder(r=plate_depth, 
                        h=(plate_width - plate_depth*b), 
                        center=true);
            
            translate([0, -plate_height/2 + plate_depth, 0])
                rotate(a=90, v=[0,1,0])
                    cylinder(r=plate_depth, 
                        h=(plate_width - plate_depth*b), 
                        center=true);

            cube([plate_width, plate_height, 1], center=true);
        }
        // draw a cube that differences off the back of the plate
        translate([0,0, -plate_depth*.5]) 
            cube([plate_width+1, plate_height+1, 
                  plate_depth+0.0001], 
                 center=true);
        if (recurse)
            translate([0,0,-plastic_thickness]) 
                resize([plate_width-plastic_thickness*2, 
                        plate_height-plastic_thickness*2, 0]) 
                    outer_plate(false);
        
    }
}



difference()
{
	// draw the main plate (centered vertically, but not centered horiz)
	
	//cube([plate_width, plate_height, 1], center=true);
    union()
    {
        outer_plate();
        draw_screw_hole_shells();
        
        if (emboss_or_inset_labels) draw_switch_labels();
    }
    if (!emboss_or_inset_labels) draw_switch_labels(false);
	//draw (remove, actually) the switches
    draw_all_switches();
}


