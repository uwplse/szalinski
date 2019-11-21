// Inner diameter (all measurements in mm)
inner_diameter = 50;

// Outer diameter
outer_diameter = 54;

// Width of the flat back
back_width = 28;

// Depth of the flat back (how far does the back stick out)
back_depth = 2;

// Total height
height = 60;

// Front cutout width
cutout_width = 20;

// How round do you want it to be?
facets=100;

// Magnet diameter
magnet_diameter = 13;

// Magnet depth
magnet_depth = 4;

// Distance of the magnets from the top and bottom 
edge_distance = 3;

difference()
{
    //make the outer shell
    union()
    {
        // round part
        cylinder(h = height, r = outer_diameter/2, $fn=facets);
        
        // flat back
        translate([-back_width/2,-outer_diameter/2-back_depth,0]) cube([back_width,outer_diameter/2,height]);
    }      
    // hollow out the cylinder
    cylinder(h = height, r = inner_diameter/2, $fn=facets);
    
    // cut the slot in the front
    translate([-cutout_width/2,outer_diameter/4,0]) cube([cutout_width,cutout_width,height]);

    //Magnet 1
    translate([0,-outer_diameter/2-back_depth,magnet_diameter/2+edge_distance]) rotate ([270,0,0])cylinder(h = magnet_depth, r = magnet_diameter/2);
    
    //Magnet 2
    translate([0,-outer_diameter/2-back_depth,height-magnet_diameter/2-edge_distance]) rotate ([270,0,0])cylinder(h = magnet_depth, r = magnet_diameter/2);

   
}