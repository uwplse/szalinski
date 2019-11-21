$fn = 100 + 0;


// wall thickness
ct = 2.0; // thickness
ang_h = 3.25 + 0; // height of angled part
ang_diff = 1.25 + 0; // r diff of angled part
stopper_w = 4 + 0;
// height of straight part of outside wall
outer_height = 8;
// number of pieces
num_pieces = 3;
// radius of outermost piece
outer_r = 25;
// tab vs. screw design
screw = 1; // [0: tab, 1: screw]
// minimum spacing between pieces
fudge = 0.3; 

pd = ang_h; // additional height of each level

module hollow_cone(cr, ch, diff){
	difference(){
		cylinder(r1=cr, r2=cr - diff, h= ch);
		translate([0,0,-0.005])
			cylinder(r1=cr-ct, r2=cr - ct - diff, h= ch + .01);
	}
}

module piece(rx, mh, outer, inner){
	hollow_cone(rx, ang_h, ang_diff);
	translate([0,0,0])
		hollow_cone(rx - ang_diff, mh + ang_h, 0);
	if (!inner){
//		rotate([0,0,90 * screw])
			difference(){
				translate([0,0,mh + ang_h])
					hollow_cone(rx - ang_diff, ang_h, ang_diff);
				if (!screw){
					union(){
						cube([stopper_w + 1,400, 400], center=true);
						cube([400, stopper_w + 1, 400], center=true);
					}
				}
				if(screw){
					translate([0,0,(mh + pd + ang_h * 2) / 2])
						linear_extrude(height = mh + pd + ang_h * 2, center = true, convexity = 10, twist = -90, $fn = 50)
						translate([(rx - ang_diff - ct - fudge) - (ang_diff + 0) / 2, 0, 0])
						square([ang_diff + fudge * 2,6], center=true);
					rotate([0,0,180])
						translate([0,0,(mh + pd + ang_h * 2) / 2])
						linear_extrude(height = mh + pd + ang_h * 2, center = true, convexity = 10, twist = -90, $fn = 50)
						translate([(rx - ang_diff - ct - fudge) - (ang_diff + 0) / 2, 0, 0])
						square([ang_diff + fudge * 2,6], center=true);
				}
			}
	}
	translate([0,0,mh + ang_h])
		hollow_cone(rx - ang_diff, ang_h, 0);
	translate([0,0,mh + ang_h])
		hollow_cone(rx - ang_diff, ang_h, -ang_diff);
	if (!outer){

		if (!screw){
			intersection(){
				translate([0,0,ang_h])
					hollow_cone(rx - ang_diff, ang_h, -ang_diff);
					union(){
						cube([stopper_w ,200, 200], center=true);
						cube([200, stopper_w , 200], center=true);
					}
			}
		}
		if (screw){
			intersection(){
				union(){
					translate([0,0, ang_h + ang_diff + 0.5])
						cylinder(r=rx, h=mh + ang_h * 2);
					translate([0,0, ang_h + 0.5])
						cylinder(r1 = rx - ang_diff, r2=rx, h=ang_diff);
				}
				union(){
					translate([0,0,(mh + pd + ang_h * 1) / 2])
						linear_extrude(height = mh + ang_h * 2, center = true, convexity = 10, twist = -90, $fn = 50)
						translate([rx - ang_diff / 2, 0, 0])
						square([ang_diff,4], center=true);
					rotate([0,0,180])
						translate([0,0,(mh + pd + ang_h * 1) / 2])
						linear_extrude(height = mh + ang_h * 2, center = true, convexity = 10, twist = -90, $fn = 50)
						translate([rx - ang_diff / 2, 0, 0])
						square([ang_diff,4], center=true);
				}
			}

		}
	}
}

module pieces_non_rec(){
	for (i = [1:num_pieces]){
		piece(outer_r - (ang_diff + ct + fudge) * (i - 1), outer_height + pd * (i - 1), i == 1, i == num_pieces, i == 1);
	}
}

pieces_non_rec();

