//
// Parametric spool bracket
//
// by Egil Kvaleberg
//
// Some spool types (measurements are approximate):
//
//   Standard 1kg plastic: 52 mm
//   Medium 1kg plastic: 38 mm
//   Small plastic 19.5 mm
//   Large 1kg paper/metal: 58 mm
//   Small 1kg plstic: 32 mm
//   Paper/plastic 1kg centre: 30.5 inset by 25, outer 72 mm
//
//*****************************************************************************
// Adjustables

// The spool center hole diameter
spool = 52.0;   // in mm

// Axle diameter	
axle_d = 6.0;	   // in mm   

// Arm height
arm_h = 18.0;    // in mm     

wall = 1*2.0;     // wall thickness

flange = 1*4;
flange_h = 1*3;		

ridge = 1*1.0;    // at end of arms

arm_w = axle_d + 2*wall;   // arm_width (can be set to other values)

fudge = 1*0.1; 

//*****************************************************************************
// View and printing

view(); 

module rounded_cube(d, y, z) 
{
	cyl_r = d/2 - ridge;
	intersection ( ){
		union () {
			cylinder(r = cyl_r, h = z, $fn=100);
			translate([0, 0, z-ridge]) cylinder(r1 = cyl_r, r2 = cyl_r+ridge, h=ridge, $fn=100);
		}
		translate([-d/2, -y/2, 0]) cube([d, y, z]);
	}
}

module add_flange(do)
{
	x = (do) ? spool+2*flange : 0;
	translate([-x/2, -arm_w/2, 0]) cube([x, arm_w, flange_h]);	
}

module add_arm()
{
	union () {
		rounded_cube(spool, arm_w, arm_h);	
		add_flange(true);
	}
}

module sub_arm()
{
	translate([0, 0, -fudge]) rounded_cube((spool-2*ridge)-2*wall, arm_w-2*wall, arm_h+2*fudge);	
}

module view()
{
	union () {
		difference () {
			union () {
				add_arm();
				rotate ([0, 0, 90]) add_arm();
				rotate ([0, 0, 45]) add_flange(spool > 6*axle_d); // only add flange if it makes sense
				rotate ([0, 0, 135]) add_flange(spool > 6*axle_d);
			}
			union () {
				sub_arm();
				rotate ([0, 0, 90]) sub_arm();
				translate([0, 0, -fudge])  cylinder(r = axle_d/2, h = arm_h+2*fudge, $fn=20); // centre hole
			}
		}
		difference ( ){
			translate([-arm_w/2, -arm_w/2, 0]) cube([arm_w, arm_w, arm_h]); // centre	piece
			translate([0, 0, -fudge])  cylinder(r = axle_d/2, h = arm_h+2*fudge, $fn=20); // axle hole
		}
	}
}


//*****************************************************************************
