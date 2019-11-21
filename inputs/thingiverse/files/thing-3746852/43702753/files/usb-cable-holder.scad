// the number of cable holder ring pairs
number_of_rings = 6;
// whether or not to add a screw hole between each pair of cable holder rings
screw_holes = true;
// inner radius of the cable holder rings
inner_radius = 3;
// outer radius of the cable holder rings
outer_radius = 6;
// the vertical space between the cable holder rings
vertical_space_between_rings = 5;
// ring height
ring_height = 4;
// the height of the cutout of the cable holder rings
cutout_height = 4;
// cutout is a little distance from the back plate
cutout_offset = 1;
// the spacing between the cable holder ring pairs
horizontal_space_between_rings = 7;
// screw hole radius
screw_hole_radius = 1.5;
// backplate thickness
backplate_thickness = 3;
// number of facets (higher value takes longer to render but has better quality of cylinders)
$fn = 100;

// derived values
height = ring_height * 2 + vertical_space_between_rings;
width = outer_radius * 2 * number_of_rings + horizontal_space_between_rings * (number_of_rings - 1);
backplate_thickness_actual = max(backplate_thickness, outer_radius - inner_radius);

// draw the ring pairs
offset = outer_radius;
for (i = [0 : number_of_rings-1])
{
    translate([offset + i * (horizontal_space_between_rings + outer_radius * 2), -inner_radius])
    {
        // lower ring
        render()
        {
            draw_cut_ring(false);
        }
        // upper ring
        translate([0, 0, vertical_space_between_rings + ring_height])
        {
            render()
            {
                draw_cut_ring(true);
            }
        }
    }
}

difference()
{
    // draw backplate
    cube(size = [width, backplate_thickness_actual, height]);
    
    // draw screw holes
    if(screw_holes)
    {
        offset = 2 * outer_radius + 0.5 * horizontal_space_between_rings;
        for (i = [0 : number_of_rings - 2])
        {
            translate([offset + i * (horizontal_space_between_rings + outer_radius * 2), 0])
            {
                render()
                {
                    screw_hole();
                }
            }
        }
    }
}

module screw_hole()
{
    translate([0, backplate_thickness_actual + 0.1, height / 2])
    {
        rotate([90, 0, 0])
        {
            cylinder(r = screw_hole_radius, h = backplate_thickness_actual + 0.2);
        }
    }
}

module draw_cut_ring(right)
{
    difference()
    {
        draw_ring();
        translate([right ? 0 : -outer_radius, inner_radius - cutout_height - cutout_offset, 0])
        {
            cube(size = [outer_radius, cutout_height, ring_height]);
        }
    }
}

module draw_ring()
{
    difference()
    {
        cylinder(r = outer_radius, h = ring_height);
        cylinder(r = inner_radius, h = ring_height);
    }
}