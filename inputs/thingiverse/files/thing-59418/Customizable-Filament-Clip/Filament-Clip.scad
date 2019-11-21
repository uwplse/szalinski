//Customizable Filament Clip by Dealmann


//Diameter of your filament.
fc_filament=3;

//Thickness of your spool.
fc_spool=2;

//In case your spool has a rim.
fc_rim=0;

//Length of the clips "arms".
fc_length=10;

//Width of the clip.
fc_width=3;

//Thickness of the clip.
fc_thickness=2;





difference()
	{
		union()
			{
				cube([fc_thickness, fc_length, fc_width]);

				translate([fc_thickness+fc_rim+fc_spool+1, 0, 0])
				cube([fc_thickness, fc_length, fc_width]);

				translate([fc_thickness+(fc_rim+fc_spool+1)/2, fc_length,0])
				cylinder(r=fc_thickness+(fc_rim+fc_spool+1)/2, h=fc_width, $fn=24);

				difference()
					{
						translate([fc_thickness,0.5+fc_rim/2+fc_spool*0.05,0])
						cylinder(r=0.5+fc_rim/2+fc_spool*0.05,h=fc_width, $fn=24);

						translate([fc_thickness-(0.5+fc_rim/2+fc_spool*0.05+1),0,-1])
						cube([0.5+fc_rim/2+fc_spool*0.05+1,(0.5+fc_rim/2+fc_spool*0.05)*2,fc_width+2]);
					}
				
				difference()
					{
						translate([fc_thickness+fc_rim+fc_spool+1,0.5+fc_rim/2+fc_spool*0.05,0])
						cylinder(r=0.5+fc_rim/2+fc_spool*0.05,h=fc_width, $fn=24);

						translate([fc_thickness+fc_rim+fc_spool+1,0,-1])
						cube([0.5+fc_rim/2+fc_spool*0.05+1,(0.5+fc_rim/2+fc_spool*0.05)*2,fc_width+2]);
				
					}

				translate([-fc_filament*1.5,fc_length-(fc_filament+2),0])
				cube([fc_filament*1.5,fc_filament+2,fc_width]);

			}
		translate([fc_thickness+(fc_rim+fc_spool+1)/2, fc_length,-1])
		cylinder(r=(fc_rim+fc_spool+1)/2, h=fc_width+2, $fn=24);

		translate([fc_thickness,fc_length-(fc_thickness+(fc_rim+fc_spool+1)/2),-1])
		cube([fc_rim+fc_spool+1, fc_thickness+(fc_rim+fc_spool+1)/2, fc_width+2]);

		translate([-fc_filament/2,fc_length-fc_filament/2-1,-1])
		cylinder(r=fc_filament/2, h=fc_width+2, $fn=24);

		translate([-fc_filament*1.5-1,fc_length-fc_filament*0.75-1,-1])
		cube([fc_filament+1,fc_filament*0.75,fc_width+2]);
	}