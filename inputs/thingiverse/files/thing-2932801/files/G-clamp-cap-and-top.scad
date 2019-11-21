// C-clamp / G-clamp cap and top
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

/*[cap propertys]*/
cap = "yes"; // [yes,no]
inner_diameter = 19.5; // [10:0.1:30]
inner_height = 2.3; // [1.5:0.1:4.5]
bottom_and_wall_thickness = 1; // [0.5:0.1:2.5]
removability = "yes"; // [yes,no]

/*[top cap propertys]*/
top = "yes"; // [yes,no]
width = 18.4; // [10:0.1:30]
height = 4.7; // [2.5:0.1:9.5]
length = 25; // [15:0.5:40]
gap_width = 5.5; // [4:0.1:25]
shell = 1; // [0.5:0.1:2]

/*[Hidden]*/
// speed vs. resolution
$fn = 60; // looks like this can't be modified on thingiverse
gap = 0.2;
cap_inner_radius = inner_diameter/2 + gap;
cap_outer_radius = cap_inner_radius + bottom_and_wall_thickness;
clip_height = 3;

gap_pos = (width - gap_width)/2;

//------------------------------------------------------------------
// Main

if(cap=="yes")
{
    translate([-cap_outer_radius-3,0,0])
    {
        if(removability=="yes")
        {
            cap(true);
        }
        else
        {
            cap(false);
        }
    }
}

if(top=="yes")
{
    translate([3,0,length+shell])
    {
        rotate([270,0,0])
        {
            top_cap();
        }
    }
}

//------------------------------------------------------------------
// Modules

module top_cap()
{
    difference()
    {
        // shell
        union()
        {
            translate([shell,shell,0])
            {
                cube([width,length-shell,shell],center=false);
            }
            translate([shell,0,height+shell])
            {
                cube([width,length+shell,shell],center=false);
            }
            translate([shell,length,shell])
            {
                cube([width,shell,height],center=false);
            }
            translate([0,shell,shell])
            {
                cube([shell,length-shell,height+shell],center=false);
            }
            translate([width+shell,shell,shell])
            {
                cube([shell,length-shell,height+shell],center=false);
            }
            
            translate([shell,shell,shell])
            {
                rotate([0,90,0])
                {
                    cylinder(h=width, r1=shell, r2=shell, center=false);
                }
                cylinder(h=height+shell, r1=shell, r2=shell, center=false);
                sphere(shell);
            }
            translate([shell+width,length,shell])
            {
                rotate([0,-90,0])
                {
                    cylinder(h=width, r1=shell, r2=shell, center=false);
                }
                cylinder(h=height+shell, r1=shell, r2=shell, center=false);
                sphere(shell);
            }
            translate([shell,length,shell])
            {
                rotate([90,0,0])
                {
                    cylinder(h=length-shell, r1=shell, r2=shell, center=false);
                }
                cylinder(h=height+shell, r1=shell, r2=shell, center=false);
                sphere(shell);
            }
            translate([shell+width,shell,shell])
            {
                rotate([-90,0,0])
                {
                    cylinder(h=length-shell, r1=shell, r2=shell, center=false);
                }
                cylinder(h=height+shell, r1=shell, r2=shell, center=false);
                sphere(shell);
            }
            
            translate([gap_pos, 0, height+shell])
            {
                cube([gap_width+(2*shell),length+(1*shell),height-(0*shell)],center=false);
            }
        }
        
        // remove
        union()
        {
            translate([shell,0,shell])
            {
                cube([width,length,height],center=false);
                translate([gap_pos, 0, height])
                {
                    cube([gap_width,length,height],center=false);
                }
            }
        }
    }
}

module cap(bool_removability)
{
    difference()
    {
        // shell
        union()
        {
            translate([0, 0, bottom_and_wall_thickness])
            {
                cylinder(h=inner_height+clip_height, r1=cap_outer_radius, r2=cap_outer_radius, center=false);
            }
            
            cylinder(h=bottom_and_wall_thickness, r1=cap_inner_radius, r2=cap_inner_radius, center=false);
            
            rotate_extrude(convexity = 20)
            {
                translate([cap_inner_radius, bottom_and_wall_thickness, 0])
                {
                    circle(r = bottom_and_wall_thickness);
                }
            }
        }
        
        // remove
        union()
        {
            translate([0,0,bottom_and_wall_thickness])
            {
                cylinder(h=inner_height, r1=cap_inner_radius, r2=cap_inner_radius, center=false);
                translate([0,0,inner_height])
                {
                        cylinder(h=clip_height, r1=cap_inner_radius-0.5, r2=cap_inner_radius+(bottom_and_wall_thickness/2), center=false);
                }
                translate([0,0,inner_height])
                {
                    cylinder(h=0.5, r1=cap_inner_radius, r2=cap_inner_radius-0.5, center=false);
                }
            }
            
            if(bool_removability)
            {
                gapsize = (cap_inner_radius*2*PI)/6;
                
                for (angle = [0 : 360/3 : 359])
                {
                    rotate([0,0,angle])
                    {
                        translate([gapsize/-2,0,bottom_and_wall_thickness+inner_height*3/4])
                        {
                            cube([gapsize,cap_outer_radius,clip_height+inner_height*1/4],center=false);
                        }
                    }
                }
            }
        }
    }
}
