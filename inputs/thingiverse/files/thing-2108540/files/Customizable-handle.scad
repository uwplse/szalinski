// Diameter of hole for the hex wrench
hex_size = 2.75;

// Increase slot size by this amount
hole_delta = 0.2;

// Diameter of the handle
handle_diameter = 25;

// Overall length of the handle
handle_length = 60; //[35:100]

handle(hex_size);

module handle(hex_size)
{
	hex_radius = (hex_size + hole_delta) / 2;
	hex_size = hex_size + hole_delta;
	handle_radius = handle_diameter / 2;
	knurl_offset = handle_radius * 1.2;
	//handle_height = 50; // moved to customizer. See below
    handle_height=handle_length-12.5;
	slot_width = 1.2 * handle_radius;
	zip_tie_back = 0.6 * handle_radius;
	slot_bottom = 15;
    z_adjust = hole_delta*1.5; // printing a supported overhand will shrink the horizontal slot in the z-dimension, requiring an additional offset in adition to the already-applied hole_delta. 

	$fn=40;									// Control quality of mesh

	hole_radius = hex_radius + .2;	// Give a little more room for small hole

	difference()
	{
		union()
		{
			cylinder(h = 5, r1 = handle_radius, r2 = handle_radius);
			translate(v=[0, 0, 5])
				cylinder(h = handle_height - 5, r = handle_radius);
			translate(v=[0, 0, handle_height])
				sphere(handle_radius);
		}

		for (angle = [30:60:360])
			translate(v=[knurl_offset * cos(angle), knurl_offset * sin(angle), 0])
				cylinder(h = handle_height + handle_radius, r = handle_radius / 2.7);

		// Shaft hole
		cylinder(h = handle_height + handle_radius, r = hole_radius);

		// Small cone at bottom
		cylinder(h = 2, r1 = hole_radius + .6, r2 = hole_radius);

		// Slot for the wrench
		translate(v=[0, -hex_size / 2, slot_bottom])
			cube(size = [handle_radius, hex_size, handle_height + handle_radius]);

		// Slot for bend in wrench
		translate(v=[0, -hex_size / 2, slot_bottom - 1.5 * hex_size])
			cube(size = [1.5 * hex_size, hex_size, 2 * hex_size]);

        // Wrench rotation slot
        translate(v=[0,0, slot_bottom])
        difference(){
            
            cylinder(h = hex_size+z_adjust, r1 = handle_radius, r2 = handle_radius);  
            
            translate(v=[-handle_radius,0,0])
            cube(handle_radius);
            translate(v=[-handle_radius,-handle_radius,0])
            cube(handle_radius);
            translate(v=[0,-handle_radius,0])
            cube(handle_radius);
        }
        
// Bend rotation slot
        translate(v=[0, 0, slot_bottom - 1.5 * hex_size])
            difference(){
            cylinder(h=2*hex_size,r2=norm([1.5*hex_size,hex_size]), r1=hex_size);
                
            translate(v=[-2*hex_size,0,0])
            cube(2*hex_size);
            translate(v=[-2*hex_size,-2*hex_size,0])
            cube(2*hex_size);
            translate(v=[0,-2*hex_size,0])
            cube(2*hex_size);
            }
        rotate([0,0,90]) 
            translate(v=[0, -hex_size / 2, slot_bottom - 1.5 * hex_size])
                cube(size = [1.5 * hex_size, hex_size, 2 * hex_size]);
            
        // Lock slot
        rotate([0,0,90])    
        translate(v=[0, -hex_size / 2, slot_bottom])
			cube(size = [handle_radius, hex_size, hex_size*2]); 
        translate(v=[0, 0, slot_bottom+2*hex_size])
            rotate([-90,0,0])
                cylinder(h=handle_radius, d=hex_size); 
    
    // for the next subtractions, an arbitrary parameter that doesn't have a good name
    x=handle_radius / 6.0;        
            
    // Subtract a tourous to make it look like a screwdriver 
    translate(v=[0,0, slot_bottom/2])
    rotate_extrude(convexity = 10)
            translate([handle_radius, 0, 0])
                circle(r =x); 
    // the following extra tauri makes it look smooter, basically a fake, easier way of filleting. Values are arbitrary
    translate(v=[0,0, slot_bottom/2])
    rotate_extrude(convexity = 10)
            translate([handle_radius*1.085, 0, 0])
                circle(r =x*1.38);
    translate(v=[0,0, slot_bottom/2])
    rotate_extrude(convexity = 10)
            translate([handle_radius*1.15, 0, 0])
                circle(r =x*1.625);     
        
	}
}

