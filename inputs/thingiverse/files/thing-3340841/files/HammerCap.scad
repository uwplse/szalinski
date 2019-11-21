// The hight of the cap.
cap_hight=35;

// The length of the hammer face.
hammer_length=25;

// The length of the hammer face.
hammer_width=25;

// The thickness of the surrounding walls.
wall_thickness=3;       // [1:15]

// The thickness of the hammer cap face.
bottom_thickness = 3;  // [1:15]

difference()
{
    hull()
    {
        for(i=[0:4])
        {
            rotate([0, 0, i*90])
            {
                translate([((i%2)*hammer_length+((i+1)%2)*hammer_width)/2, (((i+1)%2)*hammer_length+(i%2)*hammer_width)/2, wall_thickness])
                {
                    sphere(wall_thickness);
                    translate([0, 0, cap_hight-2*wall_thickness])
                    {
                        sphere(wall_thickness);
                    }
                }
            }
        }
    }
    translate([-hammer_width/2, -hammer_length/2, bottom_thickness])
    {
        cube([hammer_width, hammer_length, cap_hight]);
    }
}