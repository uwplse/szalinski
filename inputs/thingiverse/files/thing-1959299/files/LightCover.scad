// modify the variable below:

bottom_plate_x= 110;		// X dimension of the bottom plate
bottom_plate_y= 55;			// Y dimension of the bottom plate
bottom_plate_z= 2;			// Z dimension of the bottom plate

screw_pos= 3;				// distance hole perimeter --> X bottom plate edge
screw_hole= 3;				// screw hole center

diff_x= 12;					// distance X dome edge --> X bottom plate edge (should be bigger then screw_pos + screw_hole)
diff_y= 2;					// distance Y dome edge --> Y bottom plate edge

dome_z= 20;					// Z dimension of the dome from top of bottom plate
dome_width= 2.5;				// dome width

support_dimension= 1;		// needed to create dome supports

enable_printing_supports= 0;// put 0 to disable the dome supports
number_supports= 5;			// define the number of supports needed

// ---------------------------- //


module bottom_plate()
{
	// ---------------------------- //
	// variables declaration (don't touch it!)
	dome_x= bottom_plate_x - diff_x;
	dome_y= bottom_plate_y - diff_y;
	// ---------------------------- //
	
	difference()
	{
		// full ellipse plate + lateral screw holes
		difference()
		{
			// full ellipse plate
			resize(newsize=[bottom_plate_x,bottom_plate_y,bottom_plate_z]) cylinder(h=100, r=100, center=true ,$fn=100);
			// lateral screw holes
			for(i=[[(bottom_plate_x/2-screw_pos),0,0], [-(bottom_plate_x/2-screw_pos),0,0]])
			{
				translate(i) cylinder(h=bottom_plate_z, r=screw_hole/2, center=true ,$fn=100);
			}
		}
		// ellipse hole
		resize(newsize=[(dome_x-dome_width), (dome_y-dome_width), bottom_plate_z]) cylinder(h=100, r=100, center=true ,$fn=100);
	}
}



module dome()
{
	// ---------------------------- //
	// variables declaration (don't touch it!)
	dome_x= bottom_plate_x - diff_x;
	dome_y= bottom_plate_y - diff_y;
	// ---------------------------- //
	
	difference()
	{
		difference()
		{
			// external ellipsoid
			resize(newsize=[dome_x,dome_y,dome_z]) sphere(r=100, fn=100);
			// internal ellipsoid (external ellipsoid dimensions - dome_width)
			resize(newsize=[(dome_x-dome_width), (dome_y-dome_width), (dome_z-dome_width)]) sphere(r=100, fn=100);
		}
		// cut the bottom half of the ellipsoid and create an hollow dome
		translate([0,0,-dome_z/2]) resize(newsize=[dome_x,dome_y,dome_z]) cylinder(h=100, r=100, center=true ,$fn=100);
	}
}

module dome_supports()
{
	// ---------------------------- //
	// variables declaration (don't touch it!)
	dome_x= bottom_plate_x - diff_x;
	dome_y= bottom_plate_y - diff_y;
	step= (10-1.01)/number_supports;
    
    // ---------------------------- //
    // intersecate the supports and the external ellipsoid to avoid support to be bigger then the object
    intersection()
    {
        for(i=[1.01:(step):10])
        {
            // create the supports as hollow cylinder
            difference()
            {
                // external cylinder
                translate([0, 0, dome_z/2]) resize(newsize=[(dome_x-dome_width)/i*2, (dome_y-dome_width)/i*2, (dome_z)]) cylinder(h=100, r=100, center=true ,$fn=100);
                // internal cylinder
                translate([0, 0, dome_z/2]) resize(newsize=[(dome_x-dome_width)/i*2-support_dimension, (dome_y-dome_width)/i*2-support_dimension, (dome_z)]) cylinder(h=100, r=100, center=true ,$fn=100);
            }
        }
        // external ellipsoid
        resize(newsize=[dome_x,dome_y,dome_z]) sphere(r=100, fn=100);

    }
        
}

module light_cover()
{
	translate([0,0,bottom_plate_z]) dome();
	translate([0,0,bottom_plate_z/2]) bottom_plate();
	if (enable_printing_supports == 1)
	{
		union()
		{
			translate([0,0,bottom_plate_z]) dome_supports();
			dome_supports();
		}
	}

}

light_cover();