//
// Swag Paper Clip / Bookmark
//
//   text or logo is set using the SPC_text.png image
//
//   all measurements are in mm
//
//
// top circle radius
tr = 10;
// top circle offset (distance from centerline)
to = 10;
// top hole radius
hr = 5;
// top hole offsets
hx = 1;
hy = 1.25;

// bottom circle radius
br = 6.5;
// bottom circle distance (distance from top circle diagonal)
bd = 56;
// triangle top offsets
ot = 18;
// triangle bottom offsets
ob = 4;

// outside clip width
ow = 3;
// outside clip distance to inner
od = 2.5;

// clip thickness
ch = 1;

// text sizing in text() statement

// facet settings to make more accurate circles
$fa = 6;
$fs = 1;

	difference() {
	// extrude the 2D clip object
	linear_extrude(height = ch, center = false)

		difference() {

			// create the overall object
			union() {
				// bottom circle
				translate([bd, 0, 0])
					circle(br);
				// top circles
				translate([0, to, 0])
					circle(tr);
				translate([0, -to, 0])
					circle(tr);
				// body triangle
				polygon(points=[[0, ot],[0, -ot],[bd, -ob],[bd, ob]]);
			}

			//exclude the bottom hole
			translate([bd, 0, 0])
				circle(br - ow);

			//exclude the top holes
			translate([hx, to + hy, 0])
					circle(hr);
			translate([hx, -to - hy, 0])
					circle(hr);

			// top diagonal
			polygon(points=[[0, ot-ow-od],[0, ot-ow],
				  [bd, ob-ow],[bd, ob-ow-od]]);

			// bottom diagonal
			polygon(points=[[0, -ot + ow + od],[0, -ot + ow],
				  [bd, ow-ob],[bd, ow+od-ob]]);

		}
				// finally, "subtract" the text using the SPC_text image
			translate([0.65, 3.8, 5])
				mirror([0,1,0])
					scale([0.117, 0.117, 0.117])
						surface(file = "SPC_text.png", center = false, convexity = 30,invert = true);

	}
