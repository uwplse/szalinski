// parametric knife sheath
// original by Steve Pendergrast (vorpal)
// https://www.thingiverse.com/thing:125109
//
// remix v4 by BikeCyclist: Bugfix for better walls with windows at high grip cutoff angles
// remix v3 by BikeCyclist: Bugfix (windows in thick walls) as suggested by Laurie, improved use of thingiverse customizer interface, better walls with windows at high grip cutoff angles
// remix v2 by BikeCyclist: Parametric wall thickness, shorter ridges, better symmetry
// remix v1 by BikeCyclist: Introducing holding ridge and oblique cut-off at grip
// https://www.thingiverse.com/thing:2856699

// length: the length of the blade from handle to tip
// maxwidth: the maximum width of the blade
// tipwidth:  the width near the tip, zero means it comes to a point
// thickness: maximum thickness of the blade
// has_windows:  0 = do not put in windows to show the blade and simplify cleaning
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
knife_thickness = 1.5;

//	Wall thickness, mm
wall_thickness = 0.5;

// Show knife through windows?
has_windows = 1; // [0:No, 1:Yes]

// Number of windows per side
number_of_windows = 10; // [1:25]

// Sheath has ridges to hold the knife more securely?
has_ridges = 0; // [0:No, 1:Yes]

// Angle of the sheath at the grip (0 = vertical) [0:75]
grip_cutoff_angle = 20;

//CUSTOMIZER VARIABLES END

$fn = 80*1;  // while debugging reduce this to 20 to save time

wall = 2*wall_thickness;
pad = 2*1;

translate ([0, 0, knife_width + 2 * wall + pad])
    rotate ([0, 180, 0])
        parasheath (length = knife_length, maxwidth = knife_width, thickness = knife_thickness, windows = has_windows);


module parasheath(length=200, maxwidth=25, thickness=2, windows=1) {

    difference() {

        union () {

            difference() {

                // first make an oversized blade, oversized by 2 times the wall thickness
                blade(len = length + wall + pad, maxwid = maxwidth + pad + 2 * wall, thick = thickness + 2 * wall);

                translate([0, 0, wall]) 
                    blade(len = length + 0.1 + pad, maxwid = maxwidth + pad, thick = thickness);

            }
            
            if (has_ridges)
            for (i = [-1, 1])
                translate([0, 0, wall + knife_width/2 + pad/2]) 
                    translate ([i * knife_thickness/2, 0, 0])
                        rotate ([-90, 0, 0])
                            scale ([1, 2, 1])
                                cylinder (d = knife_thickness / 2, h = length/8);
            
        }
        
        if (windows)
            intersection ()
            {
                {
                    straight_length = length - maxwidth * sin (grip_cutoff_angle);
                    for (j = [-1, 1])
                        for (i = [1 : number_of_windows])
                            translate([j * (wall + thickness), maxwidth * sin (grip_cutoff_angle) + straight_length/number_of_windows * i + straight_length/(4 * number_of_windows) * j, maxwidth/2 + wall + pad/2]) 
                                    cube([2 * (wall + thickness), straight_length/(2 * number_of_windows), maxwidth + pad], center = true);
                }
                
                translate([0, 0, wall]) 
                    blade(len = length + 0.1 + pad - wall, maxwid = maxwidth + pad, thick = 2 * thickness + 4 * wall);
            }

        rotate ([-grip_cutoff_angle, 0, 0])
            translate([0, -100, 0])
                    cube([200,200,200], center=true);
    }
    
    /* Ensure windows don't cut through the mouth edges of the sheath */
    if (windows)
        difference ()
        {
            maxwid = maxwidth + pad + 2 * wall;
            
            hull ()
            {
                rotate ([-grip_cutoff_angle, 0, 0])
                    translate([0, 0, 0.5 * maxwid / cos (grip_cutoff_angle)])
                        cube ([thickness + 2 * wall, 0.01, maxwid / cos (grip_cutoff_angle)], center = true);
                
                translate([0, wall / cos (grip_cutoff_angle), 0])
                    rotate ([-grip_cutoff_angle, 0, 0])
                        translate([0, 0, 0.5 * maxwid / cos (grip_cutoff_angle)])
                            cube ([thickness + 2 * wall, 0.01, maxwid / cos (grip_cutoff_angle)], center = true);
            }
            
            hull ()
            {
                translate([0, -wall / cos (grip_cutoff_angle), 0])
                    rotate ([-grip_cutoff_angle, 0, 0])
                        translate([0, 0, 0.5 * maxwid / cos (grip_cutoff_angle)])
                            cube ([thickness, 0.01, (maxwidth + pad) / cos (grip_cutoff_angle)], center = true);
                
                translate([0, 2 * wall / cos (grip_cutoff_angle), 0])
                    rotate ([-grip_cutoff_angle, 0, 0])
                        translate([0, 0, 0.5 * maxwid / cos (grip_cutoff_angle)])
                            cube ([thickness, 0.01, (maxwidth + pad) / cos (grip_cutoff_angle)], center = true);
            }
        }
}

module blade (len = 200, maxwid = 25, tipwid = 5, thick = 2) 
{
    translate ([-thick/2, 0, 0])
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