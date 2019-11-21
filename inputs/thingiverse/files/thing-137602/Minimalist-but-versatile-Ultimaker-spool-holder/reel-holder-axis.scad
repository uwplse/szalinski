
// internal diameter (make it tight)
tube_d=7.8;
// wall thickness around the rod
tube_wall_th=4;
// length of the wall around the rod
base_rod_len=12;
// nut diameter with enough freeplay
tube_nut_d=15;
// nut heigth with enough freeplay
tube_nut_h=6.7;

// optional support (zero to disable)
support_th=0.4;

/* [Hidden] */

tol=0.1+0;

hook_wall_th= 6+0;
hook_sx=12+0;
hook_dist_z=27+0;
hook_dist_y=26+0;
hook_tab_sz=14+0;
hook_notch_sx=6+0;
hook_notch_sz=5+2+0;
hook_notch_skew=0.5+0;

plate_additional_z= 8+0;

hook_plate_sy= hook_dist_y+hook_wall_th+2;
hook_plate_sz= hook_dist_z + hook_tab_sz + plate_additional_z;

module um_reel_hook_plate()
{
	module one_arm()
	{
		hull()
		{
			translate([-(hook_wall_th-1)/2,hook_wall_th/2,0])
				cylinder(r=(hook_wall_th-1)/2, h=tol, $fs=1);
			translate([0,0,hook_sx])
				cube([hook_sx, hook_wall_th, hook_tab_sz-hook_sx]);
		}

		// The notch
		translate([hook_sx-hook_notch_sx,0,hook_tab_sz])
		{
			hull()
			{
				cube([hook_notch_sx, hook_wall_th, tol]);
				translate([hook_notch_skew,hook_notch_skew,hook_notch_sz-tol])
					cube([hook_notch_sx-hook_notch_skew, hook_wall_th-hook_notch_skew*2, tol]);
			}
		}
	}

	// Hook body
	difference()
	{
		union()
		{
			// 4 hooks
			translate([hook_wall_th-tol,-hook_wall_th/2, plate_additional_z/2])
				for(z=[0,1])
					translate([0,0,z*hook_dist_z])
						for(y=[-1,+1])
							translate([0,y*hook_dist_y/2,0])
								one_arm();

			// Plate
			difference()
			{
				// Rounded main plate
				hull()
				{
					for(y=[-1,+1]) hull()
					{
						for(z=[0,+1])
						translate([0,y*(hook_plate_sy-hook_wall_th)/2, hook_wall_th/2+z*(hook_plate_sz-hook_wall_th)])
							rotate([0,90,0])
							{
								translate([0,0,hook_wall_th/2])
									sphere(r=hook_wall_th/2, $fs=1);
								translate([0,0,hook_wall_th/2])
									cylinder(r=hook_wall_th/2, h=hook_wall_th/2);
							}
					}
				}

				// Leave room for the nylock nuts (make it mountable!)
				translate([-tol,0,hook_plate_sz/2])
				for(z=[-1,+1]) scale([1,1,z])
					translate([0,0,hook_plate_sz/2])
				{
					rotate([0,90,0])
						hull()
					{
						cylinder(r=8/2, h=hook_wall_th+2*tol);
						translate([plate_additional_z,0,0])
							cylinder(r=8/2, h=hook_wall_th+2*tol);
					}
				}

			}

		}
	}
	
	// Rod mount
	translate([tol,0,hook_plate_sz/2]) rotate([0,-90,0])
	{
		cylinder(r1=min(tube_d/2,tube_nut_d/2)+tube_wall_th+2,r2=tube_d/2+tube_wall_th,h=base_rod_len);
		for(r=[30,-30,180-30,180+30]) rotate([0,0,r])
			hull()
			{
				translate([tube_d/2+tube_wall_th - tube_wall_th,0,0])
					cylinder(r=tube_wall_th,h=base_rod_len,$fs=1);
					
				translate([hook_plate_sz/2 - (tube_wall_th)*1.414,0,0])
					cylinder(r=tube_wall_th/2, h=tol);
			}
	}
}



rotate([0,0,180]) // for a better cooling when printer on an UM!!

difference()
{
	difference()
	{
		um_reel_hook_plate();
		translate([hook_wall_th+tol,0,hook_plate_sz/2])
			rotate([0,-90,0])
				cylinder(r=tube_d/2,h=base_rod_len+tube_d+2*tol);
	}
	translate([hook_wall_th - tube_nut_h - tol,0,hook_plate_sz/2])
		rotate([0,90,0])
			cylinder(r=tube_nut_d/2, h= tube_nut_h+2*tol, $fn=6);

}

// Make it printer friendly
if(support_th>0)
	intersection()
	{
		translate([-50,-50,0]) cube([100,100,100]);
		
		for(y=[-1,1]) scale([1,y,1]) translate([0,hook_plate_sy*0.4+0.96,-1]) rotate([38.3,0,0])
			translate([-hook_wall_th+tol,-support_th/2,0])
				hull()
				{
					cube([20+hook_wall_th,support_th,tol]);
					translate([0,0,hook_plate_sz/2 - tube_d/2 - tube_wall_th + 6])
						cube([base_rod_len+hook_wall_th,support_th,tol]);
				}
	}
