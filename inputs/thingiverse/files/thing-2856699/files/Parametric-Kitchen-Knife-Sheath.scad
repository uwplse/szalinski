// parametric knife sheath
// original by Steve Pendergrast (vorpal)
// https://www.thingiverse.com/thing:125109
//
// remix by BikeCyclist: Introducing holding ridge and oblique cut-off at grip
// https://www.thingiverse.com/thing:2856699

// length: the length of the blade from handle to tip
// maxwidth: the maximum width of the blade
// tipwidth:  the width near the tip, zero means it comes to a point
// thickness: maximum thickness of the blade
// show:  0 = do not put a window to show the blade style
// has_ridges: 0 = do not add ridges to the sheath to hold the knife by friction
// grip_cutoff_angle:  the angle of the mouth of the sheet at the grip (off the vertical)
//
// all measurements are in mm

//CUSTOMIZER VARIABLES

//	Knife length, mm
knife_length = 115;	//	[25:350]

//	Knife Max Blade width, mm
knife_width = 18;	//	[10:100]

//	Knife thickness, mm
knife_thickness = 1.5;	//	[1:5]

// Show knife through window?
knife_show = 1; // [0:No, 1:Yes]

// Sheath has ridges to hold the knife more securely?
has_ridges = 1; // [0:No, 1:Yes]

// Angle of the sheath at the grip (0 = vertical) [0:75]
grip_cutoff_angle = 20;

//CUSTOMIZER VARIABLES END

$fn = 80*1;  // while debugging reduce this to 20 to save time

wall = 2*1;
pad = 2*1;

rotate([0,0,45])
	parasheath(length=knife_length, maxwidth=knife_width, thickness=knife_thickness, show=knife_show);


module parasheath(length=200, maxwidth=25, thickness=2, show=1) {

    difference() {

        union () {

            difference() {

                // first make an oversized blade, oversized by 2 times the wall thickness

                blade(len=length+wall+pad,maxwid=maxwidth+pad+2*wall,thick=thickness+2*wall);

                translate([wall+0.2,-0.1,wall]) 
                    blade(len=length+0.1+pad, maxwid=maxwidth+pad, thick=thickness);

            }
            
            if (has_ridges)
            for (i = [-1, 1])
                translate([wall + 0.2 + knife_thickness/2, 0, wall + knife_width/2 + pad/2]) 
                    translate ([i * knife_thickness/2, 0, 0])
                        rotate ([-90, 0, 0])
                            scale ([1, 2, 1])
                                cylinder (d = knife_thickness / 2, h = length/2);
            
        }
        
        if (show)
            translate([thickness+wall,length-2*maxwidth,wall]) 
                    cube([100,wall+maxwidth,maxwidth]);

        rotate ([-grip_cutoff_angle, 0, 0])
            translate([0, -100, 0]) 
                    cube([200,200,200], center=true);
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