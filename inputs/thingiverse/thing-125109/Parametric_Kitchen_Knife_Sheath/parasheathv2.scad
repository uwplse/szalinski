// parametric knife sheath

// length: the length of the blade from handle to tip
// maxwidth: the maximum width of the blade
// tipwidth:  the width near the tip, zero means it comes to a point
// thickness: maximum thickness of the blade
// show:  0 = do not put a window to show the blade style
//
// all measurements are in mm

//CUSTOMIZER VARIABLES

//	Knife length, mm
knife_length = 100;	//	[25:350]

//	Knife Max Blade width, mm
knife_width = 25;	//	[10:100]

//	Knife thickness, mm
knife_thickness = 2.0;	//	[1:5]

// Show knife through window?
knife_show = 1; // [0:No, 1:Yes]

//CUSTOMIZER VARIABLES END

$fn = 50*1;  // while debugging reduce this to 20 to save time

wall = 2*1;
pad = 2*1;

rotate([0,0,45])
	parasheath(length=knife_length, maxwidth=knife_width, thickness=knife_thickness, show=knife_show);


module parasheath(length=200, maxwidth=25, thickness=2, show=1) {

	difference() {

		// first make an oversized blade, oversized by 2 times the wall thickness

		blade(len=length+wall+pad,maxwid=maxwidth+pad+2*wall,thick=thickness+2*wall);

		translate([wall+0.2,-0.1,wall]) 
			blade(len=length+0.1+pad, maxwid=maxwidth+pad, thick=thickness);

		if (show) {
			translate([thickness+wall,length-2*maxwidth,wall]) 
			 		cube([100,wall+maxwidth,maxwidth]);
		}
	}

}

module blade(len=200, maxwid=25, tipwid=5, thick=2) {

	union() {
		intersection() {
				// first make a cube
				cube([thick, len, maxwid]);
	
				translate([0,len-maxwid,maxwid]) 
					rotate([0,90,0]) 
						cylinder(r=maxwid,h=thick*3,center=true);
		}

		cube([thick,len-maxwid,maxwid]);
	}
}