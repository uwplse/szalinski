// preview[view:northwest, tilt:bottomdiagonal]

/* [default values for el-cheapo hotpoint gas dryer timer potentiometer knob] */

// min width of the plastic walls.
clf_wall = 2; // plastic walls are 2mm

clf_shaft_diameter = 6.3; // the larger diameter of the potentiometer shaft
clf_shaft_notch_diameter = 5.0; // the diameter measuring 90degrees on the shaft notch (if it is a D shaped shaft. enter the same as above if not)
// height does not matter much for the male part, as it will pass trhu the whole part. So just enter a good height so that it reaches the latch on the bottom.
clf_partHeight = 35;
clf_diameter = 55;
clf_handle_height = 30;
clf_handle_diameter = 40;
clf_indicator_angle_from_notch = 0; // 0 if indicator faces notch, 180 if it faces away and so on.

use <knurledFinishLib_v2.scad>
clf_main();
module clf_main(){
	// body - hole
	difference(){
		// handle + rest of body
		union(){
			// regular handle
			cylinder( h=clf_partHeight, r=clf_handle_diameter/2);
			// knurled handle (requires https://www.thingiverse.com/thing:32122 )
			//knurl(k_cyl_hg=clf_partHeight, k_cyl_od=clf_handle_diameter, e_smooth=clf_wall*3);
			//knurled_cyl( clf_partHeight, clf_handle_diameter, 2, 2, 2, true, 10 );
			difference(){
				// base
				base_height=clf_partHeight-clf_handle_height;
				cylinder( h=base_height, r=clf_diameter/2);
				// notch
				color("green") rotate(clf_indicator_angle_from_notch) translate([0,(clf_diameter/2)-(clf_wall*2),base_height])
					cube( clf_wall*2, center=true);
			}
			
		}
		// the hole
		color("red") translate([0,0,-clf_wall])
		union(){
			// the hole is a cylinder with a notch removed from it
			difference(){
				// the main hole format
				union(){
					cylinder( h=clf_partHeight, r=clf_shaft_diameter/2 );
				}
				// the D shape "removed" from the hole
				union(){
					cs1=clf_shaft_diameter - clf_shaft_notch_diameter;
					color("green") translate( [ -clf_shaft_diameter/2, (clf_shaft_diameter/2)-cs1, 0] )
					cube( [clf_shaft_diameter, cs1, clf_partHeight], center=false);
				}
			}
		}
	}
}

