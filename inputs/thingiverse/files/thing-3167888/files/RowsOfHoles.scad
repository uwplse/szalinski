// Detail size (2.0 nice, 1.0 pretty smooth, 0.5 very smooth)
$fs=2.00;   // [0.5:0.1:3.0]

// Number of groups of holes
groups = 2; //[1:10]

// Number of rows in each group
rows_per_group = 2; //[1:10]

// Number of holes in each row
holes_per_row = 7;  //[1:100]

// Hole shape
hole_shape = "wallhoriz";    //[cylinder,hemisphere,wallhoriz,wallvert]

// Outer diameter of hole
outer_diameter = 32;    //[1:100]

// Spacing between adjacent holes
between_holes = 13;     //[0:100]

// Extra spacing between groups, as a fraction of row spacing
group_extra_spacing_fraction = 0.5;     //[0:1.0]

// Height (or thickness) of the rack
h = 35;     //[5:100]

// Thickness of the floor
floor_thickness = 2;    //[0:4]

// Radius of rounding to soften edges of rack
fillet = 3; //[0:10]

/* Hidden */
$fa=0.01;
block = outer_diameter + between_holes;
extrahoriz= (hole_shape=="wallvert") ?sqrt(2.0)*between_holes:0;
extravert = (hole_shape=="wallhoriz")?sqrt(2.0)*between_holes:0;
horiz = holes_per_row*(block+extrahoriz);
vertpergroup = (rows_per_group+group_extra_spacing_fraction)*(block+extravert);
vert = (groups*vertpergroup) - group_extra_spacing_fraction*(block+extravert);


difference()
{
    minkowski()
    {
        cube([horiz, vert, h-2*fillet]);
        sphere(r=fillet);
    }

    // If wall-mounting, horiz rotates the holes away from the X axis and
    // thus doesn't require any Y axis adjustment.  vert rotates the holes
    // towards the Y axis, which means we need to shift them some extra
    // distance along X to keep things "centered".
    translate([block/2+extrahoriz,block/2,floor_thickness-fillet])
    for (t = [0:groups-1])
    {
        translate([0, t*vertpergroup, 0])
        for (d = [0:holes_per_row-1])
        {
            translate([d*(block+extrahoriz),0,0])
            for (r = [0:rows_per_group-1])
            {
                translate([0,r*(block+extravert),0])
                if (hole_shape == "cylinder")
                {
                    cylinder(d=outer_diameter,h=2*h,$fn=outer_diameter+2);
                }
                else if (hole_shape == "hemisphere")
                {
                    translate([0,0,h-floor_thickness])
                    sphere(d=outer_diameter);
                }
                else if (hole_shape == "wallhoriz")
                {
                    rotate([-45,0,0])
                    translate([0,-outer_diameter/2,0])
                    cylinder(d=outer_diameter,h=2*h,$fn=outer_diameter+2);
                }
                else if (hole_shape == "wallvert")
                {
                    rotate([0,-45,0])
                    translate([outer_diameter/2,0,0])
                    cylinder(d=outer_diameter,h=2*h,$fn=outer_diameter+2);
                }
            }
        }
    }
}

