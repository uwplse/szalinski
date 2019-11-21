// Thumbwheel for nuts, suitable for M3 nyloc and M3 standard nuts
// by Andy Gock
//
// With rounded thingies on the outside for gripping
//
// The nut recess should be a tight fit and will need a press
// vice or a hammer to fit the nut inside. A bit of superglue
// is also a good idea prior to fitting.

pi = 3.1427*1;

// To change between M3 standard nut or nyloc, we need to change the variables:
// knob_height, nut_height

// use 4.00 for standard nut, 5.20 for full nyloc
knob_height = 5.2; 
knob_diameter = 8.0;
knurl_count = 4;
knurl_diameter = 0.7 * knob_diameter * pi / knurl_count;
nut_width_flats = 5.50;

// set to 1 to make an array of 4 thumbwheels, set to 0 for just one thumbwheel
make_quad_array = 1; 

// This height determines the recess for the nut to press into
// Make this a little less than the actual nut height as we want
// a little bit of nut sticking out
// Note: 2.44mm is actual nut height for M3 half nut, 3.85mm is actual nut height for M3 nyloc
// use 2.00 for standard nut, use 3.20 for nyloc
nut_height = 2.00; 
// use 4.0 for a M3 screw thread
hole_diameter = 4.0; 

// Don't change, this is for the rendering of difference() to look nice
diff_fudge = 0.1*1;

$fn = 16*1;

// one nut
translate([0,0,0])
	thumbwheel();

if (make_quad_array == 1) {
	// make array of nuts (not including first one)
	
	translate([knob_diameter+knurl_diameter+1,0,0])
		thumbwheel();

	translate([0,knob_diameter+knurl_diameter+1,0])
		thumbwheel();
		
	translate([knob_diameter+knurl_diameter+1,knob_diameter+knurl_diameter+1,0])
		thumbwheel();

}

module thumbwheel(knob_height=knob_height, knob_diameter=knob_diameter, knurl_count=knurl_count, nut_width_flats=nut_width_flats, nut_height=nut_height, hole_diameter=hole_diameter) {

	difference() {

		union() {

			// make main cylinder
			cylinder(h=knob_height, r1=knob_diameter/2, r2=knob_diameter/2);

			// make other cylinders
			for (i = [0:(knurl_count-1)])
			{
				translate([knob_diameter/2 * sin(i*360/knurl_count), knob_diameter/2 * cos(i*360/knurl_count),0])
					cylinder(h=knob_height, r1=knurl_diameter/2, r2=knurl_diameter/2);
			}

		}

		// cut out for the nut hole
		translate([0,0,knob_height-nut_height])
			hexagon_prism( nut_height+diff_fudge, (nut_width_flats/2) / sin(60));

		// center hole for the screw to go through
		translate([0,0,-diff_fudge])
			cylinder(h = knob_height*2, r1=hole_diameter/2, r2=hole_diameter/2);

	}

}

module hexagon_prism(height,radius)
{
  linear_extrude(height=height) circle(r=radius,$fn=6);
}
