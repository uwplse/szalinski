$fn=50;
//Generate the shifter block
gen_shifter =  true;

//Generate the cable stop
gen_CableStop = true;

//Generate Support for Cable Stop
gen_cblStp_support = true;

// The radius of the bar the bracket should fit.
bar_r = 12.5;

//The height of the bracket
bracket_height = 35;
// 3mm diameter hole
hinge_hole_rad = 1.8;

// 6.5mm diameter hole
clasp_hole_rad = 3.5;

//Cable stop offset in Degress
cblStp_off = -18;

//Radius of the Cable Stop hole
cblStp_r = 2.95;

//thickness to make cableStop
cblStp_h = 10;

//How far Cable stop should stick out
cblStp_out = 9;

//Amount the support bracket for the cable stop should extend downwards
cblStp_Sprt_height = cblStp_h / 2;

//Depth of the shifter base
shft_base_depth = 8;

//Side Length of shifter Base
shft_base_h = 11;

//Radius of hole for shifter base
shft_hole_r = 2.125;

//Radius of the peg on shifter
shft_peg_r = 4;

//length of the peg on shifter
shft_peg_l = 10;
module Bracket()
{
	// bracket
	union()
	{
		// half moon shape
		difference()
		{
			cylinder(bracket_height, bar_r + 5, bar_r + 5);
			translate([0,0,-10]) cylinder(bracket_height + 15, bar_r, bar_r);
			translate([-((bar_r  * 3) / 2),-1,-15]) cube([bar_r * 3,bar_r * 3,bracket_height+20]);
			//translate([bar_r - 3.5,-7,6]) cube([10,6,16]);	
		}

		// hinge tab
		difference()
		{
	//		translate([bar_r + 7,0,0]) cylinder(6,7,7);
	//		translate([bar_r + 7,0,-5]) cylinder(20,hinge_hole_rad,hinge_hole_rad);
            union()
			{
				translate([(bar_r),-6,0]) cube([10,5,bracket_height]);
				translate([(bar_r + 10),-1,bracket_height / 2]) rotate([90,0,0]) cylinder(5,6,6);
			}

			translate([(bar_r + 9.5),10,bracket_height / 2]) rotate([90,0,0]) cylinder(20,clasp_hole_rad,clasp_hole_rad);
            }

		// clasp tab
		difference()
		{
			union()
			{
				translate([-(bar_r + 10),-6,0]) cube([10,5,bracket_height]);
				translate([-(bar_r + 10),-1,bracket_height / 2]) rotate([90,0,0]) cylinder(5,6,6);
			}

			translate([-(bar_r + 9.5),10, bracket_height / 2]) rotate([90,0,0]) cylinder(20,clasp_hole_rad,clasp_hole_rad);
		}
	}
}


module CableStop(rotation, x,y,z)
{
   
    translate([x,y,z]) rotate(rotation)
        union()
        {
            translate([-(1.75 * cblStp_r), (cblStp_out  /2 ) - 1, 0])  cube([3.5 * cblStp_r, cblStp_out + 2, cblStp_h]);
            if (gen_cblStp_support)
            {
                l = cblStp_r * 3.5;
                w = 1.1 * cblStp_out + 2;
                h = cblStp_Sprt_height;
                translate([-(1.75 * cblStp_r), (cblStp_out  /2 ) - 2, cblStp_h]) polyhedron(
                   points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
                   faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
                   );
            }
            difference()
            {
                cylinder(cblStp_h, cblStp_r + 4, cblStp_r + 4);
                cylinder(cblStp_h - 3, cblStp_r,cblStp_r);
                cylinder(cblStp_h, 1.5 , 1.5);
            }
        }
}


module ShifterBlock(rotation,location)
{
     translate(location) rotate(rotation) 
        difference()
        {
            union()
            {
                cylinder(shft_peg_l, shft_peg_r,shft_peg_r);
                translate([0,0,-((shft_base_depth + 1.5) / 2)]) cube([shft_base_h,shft_base_h , shft_base_depth + 1.5], true);
            }
            translate([0,0, -(shft_base_depth+1.5)]) cylinder(shft_peg_l + shft_base_depth + 2, shft_hole_r, shft_hole_r);
        }    
}

Bracket();
if (gen_CableStop)
{
    color("green", 1.0) rotate(cblStp_off, [0,0,1]) CableStop([0,180,0],0, -(bar_r + cblStp_out + (2 * (cblStp_r + 2)) - 1),bracket_height - 1.5);
}
if (gen_shifter)
{
    ShifterBlock([90,0,0],[0,-(bar_r + shft_base_depth + 5), (shft_base_h / 2)+1]); 
}