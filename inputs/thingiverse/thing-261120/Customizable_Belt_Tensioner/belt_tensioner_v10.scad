
// 
// source: http://www.thingiverse.com/thing:10082
// made for customizer
// alexander@nischelwitzer.com
//


  //////////////////////////
 // Customizer Settings: //
//////////////////////////

// How long should the belt-tension be? (mm)
tensionLength   = 25;  // [20:50]

// How thick should the tension be? (mm) 
tensionThick = 4; // [2:10]

// How large is the belt width? (1/10 mm)
beltWidth = 65; // [30:100]


// How deep is the notch? (mm)
notchDepth = 2; // [1:10]

  //////////////////////
 // Static Settings: //
//////////////////////

module GoAwayCustomizer() {
// This module is here to stop Customizer from picking up the variables below
}

// ---------------------------------------------------


beltTensioner(beltWidth/10, 3, tensionLength, tensionThick, notchDepth);



module beltTensioner(belt_width, post_width, length, thickness, notch_depth)
{
	module _beltTensioner(width, length, thickness, post_width, notch_depth)
	{
		cutout_width = width - post_width + 2;
		cutout_length = (length - post_width * 3) / 2;
		cutout_thickness = thickness + 6;

		notch_width = width - post_width * 2;
		module cutout()
		{
			translate([post_width / 2 + 1, length / 2 - cutout_length / 2 - post_width, 0])
			{
				cube([cutout_width, cutout_length, cutout_thickness], center=true);
			}
		}
	
		module notch_cutout()
		{
			translate([0,  length / 2 - post_width / 2, thickness / 2 - notch_depth / 2 + 1])
			{
				cube([notch_width, post_width + 2, notch_depth + 2], center= true);
			}
		}
		difference()
		{
			// Main body	
			cube([width, length, thickness], center=true);
	
			// Notches for "S" shape
			union()
			{
					cutout ();
					mirror([1, 0, 0])
					{
						mirror([0, 1, 0])
						{
							cutout ();
						}
					}
	
					// Notches for belt guide
					notch_cutout();
					mirror([0, 1, 0])
					{
						notch_cutout();
					}
			}
		}
	}
	_beltTensioner(belt_width + post_width * 2, length, thickness, post_width, notch_depth);
}


