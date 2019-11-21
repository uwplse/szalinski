// Tool to enable the marking of centers of a board.
// Specifically useful for centers of plank edges

// Author:
// Jan 2018
// Derived from:
//  - TikiLuke - https://www.thingiverse.com/thing:2199356

/*  [ Dimensions ] */
// Inside length (mm) (The thickest object to fit)
Max_width = 50;  // [10:300]
// Alignment Post Diameter (mm)
Post_diameter = 4; //[2:12]
//
Post_Height = 4;  // [4:20]
//
Thickness = 3; // [2:10]
// Marking hole(mm)
Center_hole_diameter = 3; // [1:6]
// Show dimension in mm and inches
Show_dimensions = true; // [true,false]


/* [ Hidden ]  */
Delta = 0.1;
cyl_res = 80;
//

// for labelling
function inches(mm) = round(mm / 25.4 * 100)/100.0; // 2 decimal accuracy


module rounded_end(dia, height) {
	cylinder(h=height, d=dia, $fn=cyl_res, center=true);
}

module support(side=-1) {
	// side == -1,1
	dia = Post_diameter/4; // stringers are thinner
	hull() {
		translate([Post_diameter/2, side*Max_width/2, 0])
			cylinder(h=Thickness, d=dia, $fn=8, center=true);
		translate([-Post_diameter/2, -side*Max_width/2, 0])
			cylinder(h=Thickness, d=dia, $fn=8, center=true);
	}
}

module marker() {
	// primary box with rounded ends
	difference() {
		union() {
			cube([Post_diameter*2, Max_width, Thickness], center=true);
			// rounded ends
			translate([0,Max_width/2,0])
				rounded_end(Post_diameter*2, Thickness);
			translate([0,-Max_width/2,0])
				rounded_end(Post_diameter*2, Thickness);
		}
		// cutout center
		cube([Post_diameter, Max_width, Thickness+Delta*2], center=true);
	}
	// add posts
	Ypos = Thickness/2+Post_Height/2;
	translate([0,Max_width/2+Post_diameter/2, Ypos-Delta])
		rounded_end(Post_diameter, Post_Height);
	translate([0,-Max_width/2-Post_diameter/2, Ypos-Delta])
		rounded_end(Post_diameter, Post_Height);
	// hole in middle
	difference() {
		union() {
			// central Bar
			cube([Post_diameter*2-Delta*2, Post_diameter, Thickness], center=true);
			// angled support bars
			support(1);
			support(-1);
		}
		// subtract hole
		cylinder(h=Thickness+Delta*2, d=Center_hole_diameter, $fn=cyl_res, center=true);
	}
}



marker();
if (Show_dimensions) { // add text
	textSize = Post_diameter;
	label = str(Max_width,"mm  =   ",inches(Max_width),"in");
	color("orange")
	translate([Post_diameter*2, 0.0 ])
	rotate([0,0,90])
	linear_extrude(height = Thickness/2) 
		text(text = label,  size = textSize, halign="center", valign="top");
}

