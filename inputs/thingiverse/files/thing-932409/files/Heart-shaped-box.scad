// Heart shape box originally by Kit Wallace.
//   - https://github.com/KitWallace/openscad
// Adapted to stretch nicely, dimension better, and see Cross Section option.
// Also ready for Customizer



/* [Box ] */
// Height of Box.
External_Height = 50;
// Overall distance of heart, from point to top.
Width = 60;
// Thickness of the walls only.
Wall_thickness = 2;
// Base thickness. Sometimes thicker feels better.
Base_thickness = 4;
// Accentuate shape with Squash or Stretch (0.8-1.3 ideal).
Stretch = 1.2; //[0.5:0.05:2.0]

/* [Lid] */
// Sometimes a thicker lid feels better.
Lid_thickness = 4;
// Height of the inner lip that grips the box.
Lid_lip_height = 3;
// Larger numbers = Looser lid. Test for your printer.
Lid_fit_adj = 0.3; // [0:0.1:1]
// Useful while designing.
Show_Cross_section = "no"; //[yes, no]

/* [Hidden] */
lid_color = [0.8,0.8,0];
Delta = 0.1;  // for minkowski adds
Height = External_Height - 2*Delta - Wall_thickness;
square = Width*Width / (1.414*2*Width/3 + 1.414*2*Width/24) - 2*Wall_thickness;

echo(str("Internal height = ", Height - 1.5*Wall_thickness));

// These must be set to get a nice minkowski curve result.
$fa = 0.01;
$fs = 0.5;


module heart(square_width, height, stretch=1) {
	// make heart shape using square and two circles. Allow for squishing.
	radius = square_width/2;
	//rotate([0,0,-45])     // scale shape of heart 'naturally'
	scale([stretch,1,1])  // ..
	rotate([0,0,45])      // ..
		linear_extrude(height=height,convexity=3) {
			union() {
				square(square_width, square_width);
				translate([radius, square_width, 0]) circle(r=radius);
				translate([square_width, radius, 0]) circle(r=radius);
			}
		}
}


module heart_box(square_width, height, thick, stretch, lid_fit) {
	// Make a box with a lid. Allow for lid-fitting offset.
		difference() {
			minkowski(){
				heart(square_width, height, stretch);
				cylinder(r=thick,h=Delta); //thin so add only in sweep not height
			}
			// hollow out center
			translate([0,0,Base_thickness])
				heart(square_width, height+Delta, stretch);
		}
		// lid
		// rotate it to fit or position it for printing.
		t = (Show_Cross_section == "yes") ? [0,-square_width/2,height+Lid_thickness/2+Delta*2] : [0,0,0];
		r = (Show_Cross_section == "yes") ? [180,0,0] : [0,0,0];
		color(lid_color)
		translate(t) rotate(r)
		translate ([0,-square_width/2,0]) rotate([0,0,180]) {
			difference () { // recess the lid
			union () {
				minkowski(){
					heart(square_width, Lid_thickness, stretch);
					cylinder(r=thick,h=Delta);
				}
				// Lip
				translate([0,lid_fit,Lid_thickness-Delta])
					heart(square_width-lid_fit, Lid_lip_height, stretch);
			}
			// the recess in lid
			translate([0, thick-lid_fit/2, Lid_thickness-Delta])
				heart(square_width-lid_fit-thick, Lid_lip_height+Delta*2, stretch);
			}
		}
}



/// Build the Box.
if (Show_Cross_section == "yes") {
	// repo and show it cut in half
	difference() {
		heart_box(square, Height, Wall_thickness, Stretch, Lid_fit_adj);
		b_width = Width*2;
		translate([b_width/4+Delta,b_width/3,(Height+Lid_thickness)/2-Delta])
			cube(size=[b_width/2+Delta*2,b_width,Height+Lid_thickness], center=true);
	}
} else {
	// just the plain ready to print box
	heart_box(square, Height, Wall_thickness, Stretch, Lid_fit_adj);
};


//heart(square, Height, Stretch);


// mathematical variations for outline of curve:
// http://stackoverflow.com/questions/4478078/how-to-draw-a-heart-with-pylab
// https://en.wikipedia.org/wiki/Heart_%28symbol%29

// fat heart: (x2 + y2 - 1)3 - x2y3 = 0
// curvy:  16sin3t / (13cost - 5cos2t - 2cos3t - cos4t)
// same:   x = 16sin3t, y = 13cos.. etc
// lobed: x2 + (5y/4 - sqrt(abs(x)))2 = 1
// python: 
//		x = scipy.linspace(-2,2,1000)
//		y1 = scipy.sqrt(1-(abs(x)-1)**2)
//		y2 = -3*scipy.sqrt(1-(abs(x)/2)**0.5)

