/* [outer Dimensions] */

// (mm)
Outer_x = 30;
// (mm)
Outer_y = 40;
// (mm)
Outer_height = 15;

wall = 2;

cover_size = 2;

// Difference between wall and screwholder outer wall
offset_screwholder = 1;


/* [Screws] */

// Diameter of the screw (mm)
screw_diameter = 3.1;     // 2,5mm screw

// Diameter of the nuts you want to insert (mm)
nut_diameter = 6;

nut_radius = nut_diameter / 2;

// Height of the hole for the nut
nut_height = 3;    

// Hexagonal shape
acc_nut = 6;    


screw_radius = screw_diameter / 2;     



housing_radius = screw_radius + wall;


// Move Screw in or out
offset = -1;


mode = 0; // [0: Print with connected Base, 1: Print with both Cover and Base]

part = 0; // [0: Print all, 1: Print only Case, 2: Print only Cover]

move = 1; // [0: Don't move Cover, 1: Move Cover next to Case]



x = Outer_x;
y = Outer_y;
h = Outer_height;

module roundedRect_Base(size, radius)
{
	x = size[0];
	y = size[1];

	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+radius, (-y/2)+radius, 0])
		circle(r=radius);
	
		translate([(x/2)-radius, (-y/2)+radius, 0])
		circle(r=radius);
	
		translate([(-x/2)+radius, (y/2)-radius, 0])
		circle(r=radius);
	
		translate([(x/2)-radius, (y/2)-radius, 0])
		circle(r=radius);
	}
}


module roundedWall_Base(size, wall, radius)
    {        
    x = size[0];
    y = size[1];
    
    
    difference()
        {            
        roundedRect_Base([x, y], radius, $fn=50);
        roundedRect_Base([x-2*wall, y-2*wall], radius, $fn=50);
        }    
    }



if ((part == 0) || (part == 1))
    {
    difference()
        {
        union()
            {
            if (mode == 0)
                linear_extrude(cover_size)
                    {
                    roundedRect_Base([x, y], housing_radius, $fn=50);
                    translate([x/2-housing_radius+offset, y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([x/2-housing_radius+offset, -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
                    }
            linear_extrude(h)
            difference()
                {
                union()
                    {
                    roundedWall_Base([x, y], wall, housing_radius, $fn=50);
                    
                    translate([x/2-housing_radius+offset, y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
                    translate([x/2-housing_radius+offset, -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
                    }
                translate([x/2-housing_radius+offset, y/2-housing_radius+offset])circle(screw_radius, $fn=50);
                translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset])circle(screw_radius, $fn=50);
                translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset)])circle(screw_radius, $fn=50);
                translate([x/2-housing_radius+offset, -(y/2-housing_radius+offset)])circle(screw_radius, $fn=50);
                }
            }//
        translate([x/2-housing_radius+offset,    y/2-housing_radius+offset, h-nut_height-cover_size]   )cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
        translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset, h-nut_height-cover_size]   )cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
        translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset), h-nut_height-cover_size])cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
        translate([x/2-housing_radius+offset,    -(y/2-housing_radius+offset), h-nut_height-cover_size])cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
        
        if (mode == 1)
            {
            translate([x/2-housing_radius+offset,    y/2-housing_radius+offset, cover_size]   )cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
            translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset, cover_size]   )cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
            translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset), cover_size])cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
            translate([x/2-housing_radius+offset,    -(y/2-housing_radius+offset), cover_size])cylinder(r=nut_radius, h=nut_height, $fn=acc_nut);
            }
        }
    }




a = (move) ? x + 10 + 2*offset : 0;
b = (move) ? 0 : h + cover_size;
c = (move) ? 0 : 180;
    


translate([a, 0, b])rotate([0, c, 0])
if ((part == 0) || (part == 2))
    {

    linear_extrude(cover_size)
    difference()
        {
        union()
            {
            roundedRect_Base([x, y], housing_radius, $fn=50);
            
            translate([x/2-housing_radius+offset, y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
            translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset])circle(housing_radius+offset_screwholder, $fn=50);
            translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
            translate([x/2-housing_radius+offset, -(y/2-housing_radius+offset)])circle(housing_radius+offset_screwholder, $fn=50);
            }
        translate([x/2-housing_radius+offset, y/2-housing_radius+offset])circle(screw_radius, $fn=50);
        translate([-(x/2-housing_radius+offset), y/2-housing_radius+offset])circle(screw_radius, $fn=50);
        translate([-(x/2-housing_radius+offset), -(y/2-housing_radius+offset)])circle(screw_radius, $fn=50);
        translate([x/2-housing_radius+offset, -(y/2-housing_radius+offset)])circle(screw_radius, $fn=50);
        }
    }
