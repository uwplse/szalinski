lens_diameter = 58;       // outer diameter of cap

mount_height = 2;         // height of lip
mount_width = 4;          // width of ring
mount_base = 3;           // height of buckle
mount_lip_height = 0.1;   // lip tip height (to help secure cap)
mount_lip_width = 0.2;    // width of lip tip (to help secure cap)

buckle_gap = 5;           // gap for strap
buckle_width = 42;        // strap width
buckle_thickness = 4;     // thickness of buckle

filled_buckle = false;    // fill the buckle center?
circle_sides = 70;        // number of sides for circles



union()
{
    buckle();
    capmount();
}




module buckle()
{
    buckle_inner = lens_diameter/2 + mount_width + buckle_gap;
    buckle_outer = buckle_inner + buckle_thickness;

    squared_inner = buckle_width;
    squared_outer = buckle_width + 2*buckle_thickness;

    squared_offset = sqrt(pow(buckle_outer,2) - pow(squared_outer/2,2));

    linear_extrude(height=mount_base) union()
    {
        // the arc portion of the buckle
        intersection()
        {
            square([buckle_outer*4, squared_outer], center=true);
            difference()
            {
                circle(buckle_outer, $fn=circle_sides);
                circle(buckle_inner, $fn=circle_sides);
            }
        }

        // the squared-length portion of the buckle
        difference()
        {
            square([squared_offset*2, squared_outer], center=true);
            square([squared_offset*2, squared_inner], center=true);
        }
    }
}

module capmount()
{
    lip_height = mount_base + mount_height;

    cap_outer = lens_diameter/2 + mount_width;
    cap_inner = lens_diameter/2 - mount_width;

    union()
    {
        // the base of the lens cap mount
        linear_extrude(height=mount_base) difference()
        {
            circle(cap_outer, $fn=circle_sides);
            if (!filled_buckle) circle(cap_inner, $fn=circle_sides);
        }

        // generate extra base support if it's not filled
        if (!filled_buckle) for(i=[-45,45])
            linear_extrude(height=mount_base) rotate(i)
                square([lens_diameter, mount_width], center=true);

        // generate the cap friction mount and extra securing lip
        difference()
        {
            linear_extrude(height=lip_height) 
                circle(cap_outer, $fn=circle_sides);
            linear_extrude(height=lip_height) 
                circle(lens_diameter/2 - mount_lip_width, $fn=circle_sides);
            linear_extrude(height=lip_height - mount_lip_height) 
                circle(lens_diameter/2, $fn=circle_sides);
        }
    }
}