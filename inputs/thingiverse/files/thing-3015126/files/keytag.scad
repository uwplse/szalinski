$fn = 100;

string = "5-8505";
string_size = 6;

size_x = 43;
size_y = 20;
size_z = 3;
border = 1.5;
concavity = 1;
roundness = 5;

// position relative to top-left
hole = 4.5;
hole_x = 0;
hole_y = 0;
hole_border = 1.5;

module rounded_cube(r, dims, center)
{
    translate([r, r, 0])
    linear_extrude(dims.z)
        minkowski()
        {
            square([dims.x-r*2, dims.y-r*2], center);
            circle(r);
        }
}

module tag()
{
    difference()
    {
        union()
        {
            difference()
            {
                rounded_cube(roundness+border, [size_x, size_y, size_z], false);
                translate([border, border, size_z-concavity])
                    rounded_cube(roundness,
                                [size_x-border*2, size_y-border*2, concavity],
                                false);
            }
            translate([hole_x+hole/2, size_y-hole_y-hole/2, 0])
                cylinder(size_z, d=hole+hole_border*2, false);
        }
        translate([hole_x+hole/2, size_y-hole_y-hole/2, 0])
            cylinder(size_z, d=hole, false);
    }
}

module infotext()
{
    linear_extrude(size_z)
        text(string, string_size, "Comic Sans MS");
}

tag();
translate([border+hole+hole_x+hole_border,
            size_y-string_size-border-hole-hole_y-hole_border,
            0])
    infotext();
