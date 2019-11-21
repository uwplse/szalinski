// Diameter of hole for the hex wrench
hex_size = 2.2;


// Increase slot size by this amount
hole_delta = 0.15;

// Diameter of the handle
handle_diameter = 15;

handle_height = 40;

handle(hex_size);


//Diameter parameters for screw
screwSize = 3.1;
screwHead = 6;

text="M2";



module handle(hex_size)


{
    hex_radius = (hex_size + hole_delta) / 2;
	hex_size = hex_size + hole_delta;
	handle_radius = handle_diameter / 2;
	knurl_offset = handle_radius * 1.2;
	//handle_height = 50;
	slot_width = 1.2 * handle_radius;
	zip_tie_back = 0.6 * handle_radius;
	slot_bottom = 15;

	$fn=40;									// Control quality of mesh

	hole_radius = hex_radius + .2;	// Give a little more room for small hole




	rotate([0,0,180]){difference()
	{
		union()
		{
			cylinder(h = 5, r1 = handle_radius - 3, r2 = handle_radius);
			translate(v=[0, 0, 5])
				cylinder(h = handle_height - 5, r = handle_radius);
			translate(v=[0, 0, handle_height])
				sphere(handle_radius);
		}

		for (angle = [-30:-60:-300])
			translate(v=[knurl_offset * cos(angle), knurl_offset * sin(angle), 0])
				cylinder(h = handle_height + handle_radius, r = handle_radius / 2.7);
translate([0,0,-5]){               // Shifted all the cut features down by 5 so shorter handles can be handled without hitting the wrench as much
		// Shaft hole
		cylinder(h = handle_height + handle_radius, r = hole_radius);
        
        //Hole for the screw 
        translate([handle_radius/2.5,handle_diameter/2,slot_bottom+3/2+hex_size])rotate([90,0,0])cylinder(handle_diameter,d=screwSize-0.2);
    
        //Hole for the screwhead 
        translate([handle_radius/2.5,-handle_radius/1.75,slot_bottom+3/2+hex_size])rotate([90,0,0])cylinder(handle_diameter,d=screwHead);
    
        //Cutout to keep the material above the screwhead from needing support Leitnin
        intersection(){
        translate([handle_radius/2.5,-handle_radius/1.75,slot_bottom+3/2+hex_size])rotate([90,0,0])cylinder(handle_diameter,d=screwHead*2);
        translate([handle_radius/2.5,-handle_radius/1.75-handle_radius/1.5,slot_bottom+3/2+hex_size])rotate([45,0,0])cube([screwHead-1,10,10], center=true);
        }
        
        // Text
        
        font1 = "Liberation Sans:style=Bold"; // here you can select other font type
        content = text;

        rotate([0,0,45])translate ([handle_diameter/2-0.8,2,handle_height-10]) {
        rotate ([0,-90,180]) {
        linear_extrude(height = 1.5) {
        text(content, font = font1, size = handle_diameter/3, direction = "ltr", spacing = 1 );
        }
        }
        }

		// Small cone at bottom
		cylinder(h = 2, r1 = hole_radius + .6, r2 = hole_radius);

		// Slot for the wrench
		translate(v=[0, -hex_size /2, slot_bottom])
			cube(size = [handle_radius, hex_size, handle_height + handle_radius]);

//		// Slot for bend in wrench
		translate(v=[0, -hex_size / 2, slot_bottom - 1.5 * hex_size])
			cube(size = [1.5 * hex_size, hex_size, 2 * hex_size]);

		// Lower slot for zip-tie
//		translate(v=[zip_tie_back, -slot_width / 2, slot_bottom - 6])
//			cube(size=[3, slot_width, 3]);

		// Upper slot for zip tie
//		translate(v=[zip_tie_back, -slot_width / 2, slot_bottom + sin(60) * hex_size - 1])
//			cube(size=[3, slot_width, 3]);

		// Zip Tie Opening
//		translate(v=[zip_tie_back, slot_width / 4, slot_bottom - 6])
//			cube(size=[3, slot_width / 4, 6 + sin(60) * hex_size + 2]);
//
//		translate(v=[zip_tie_back, -slot_width / 2, slot_bottom - 6])
//			cube(size=[3, slot_width / 4, 6 + sin(60) * hex_size + 2]);
}
}
	}
}

