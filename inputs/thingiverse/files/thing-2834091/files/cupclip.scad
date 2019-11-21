/*
@author: matt@misbach.org
@date: 3/6/2018

Description: Cup Clip
*/

letter="G";
textSize=7;
font="Arial Black";
opening=2;
$fn = 40;

	difference() {
		// Clip
		difference() {

			union() {
				// Monogram
				rotate([0,90,0])
					translate([-5,0,-10.5]) {
						linear_extrude(height=21)
							text(letter, size=textSize, font=font, halign="center", valign="center");
					}

				// Outer diameter
				cylinder(h=10, d=20);
			}

			// Inner diameter
			cylinder(h=10, d=17);
		}

		// Open end
		translate ([0,-10,3])
			cube([opening,10,15], true);
	}
