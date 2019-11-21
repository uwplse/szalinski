use <utils/build_plate.scad>
use <write/Write.scad>

//----------------------------------------------------------------------------
// Customize and print your own Raspberry Pi top for  
// http://www.thingiverse.com/thing:440268
// 
// by Erwin Ried (2014-08-26)
// http://www.thingiverse.com/eried/things

//---[ USER Customizable Parameters ]-----------------------------------------

/* [Logo] */

// Scale
logo_width = 100; //[10:200]

// Scale
logo_height = 100; //[10:200]

logo_horizontal_align  = 0; //[-50:50]

logo_vertical_align  = 0; //[-100:100]

// Simple high contrast images work better
logo_image = "image-surface.dat"; // [image_surface:150x150]

// Where the logo slices the cover
logo_image_depth  = 100; //[0:200]

// Intensity of the logo surface
logo_image_intensity  = 20; //[1:100]

/* [Features] */
// The top cover can have a hole to peek into the status leds of your Pi
status_led_hole = 0; // [1:Hole,2:Full,0:None]

// Slot for the camera ribbon cable
camera_ribbon_hole = 0; // [1:Slot,0:None]

header = -1; // [0:Text,-1:None]

footer = -1; // [0:Text,-1:None]

/* [Header] */
header_fontface = "Letters"; //["Letters":Basic,"BlackRose":BlackRose,"orbitron":Orbitron,"knewave":Knewave,"braille":Braille]
header_text  = "This is MY";
header_size  = 6; //[3:24]
header_vertical_align  = 0; //[-40:10]
header_rotation  = 0; //[-180:180]
header_type  = 2.85; //[2.85:Embossed,3:Raised]

/* [Footer] */
footer_fontface = "orbitron"; //["Letters":Basic,"BlackRose":BlackRose,"orbitron":Orbitron,"knewave":Knewave,"braille":Braille]
footer_text  = "Raspberry Pi";
footer_size  = 5; //[3:24]
footer_vertical_align  = 0; //[-10:40]
footer_rotation  = 0; //[-180:180]
footer_type  = 2.85; //[2.85:Embossed,3:Raised]

//---[ Build Plate ]----------------------------------------------------------

/* [Build plate] */
//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

//----------------------------------------------------------------------------

/* [Hidden] */
header_fontface_dxf = str("write/",header_fontface,".dxf");
footer_fontface_dxf = str("write/",footer_fontface,".dxf");

//----------------------------------------------------------------------------

if(status_led_hole<2)
{
	draw_top(11,42.5);
}
else
{
	draw_top(11+4,42.5+4);
}

module draw_top(len, pos)
{
	union()
	{
		difference()
		{
			base();
			if(status_led_hole>0)
			{
				// Add status led hole
				translate([22.25,-pos,-1])
					cube([2,len,5]);
			}

			if(camera_ribbon_hole>0)
				translate([-28,-15,-1])
					cube([20,1,5]);
			
			// Top text
			if(header_type<3 && header==0)
			{
				translate([0,35+header_vertical_align,header_type])
					write(header_text,h=header_size,t=0.5,center=true,font=header_fontface_dxf,rotate=header_rotation);
			}
			
			// Center logo
			translate([logo_horizontal_align,logo_vertical_align,-0.1-(logo_image_depth/10)])
				scale([logo_width/300, logo_height/300, logo_image_intensity])
					surface(file=logo_image, center=true, convexity=10);

			// Bottom text
			if(footer_type<3 && footer==0)
				translate([0,-35+footer_vertical_align,footer_type])
					write(footer_text,h=footer_size,t=0.5,center=true,font=footer_fontface_dxf,rotate=footer_rotation);
		}
		// Top text
		if(header_type>=3 && header==0)
			translate([0,35+header_vertical_align,header_type])
				write(header_text,h=header_size,t=0.5,center=true,font=header_fontface_dxf,rotate=header_rotation);

		// Bottom text
		if(footer_type>=3 && footer==0)
			translate([0,-35+footer_vertical_align,footer_type])
				write(footer_text,h=footer_size,t=0.5,center=true,font=footer_fontface_dxf,rotate=footer_rotation);
	}
}

//----------------------------------------------------------------------------

// Case top cover
w = 88; l = 56.5; h = 2.85; // Base
pw = 11; pl = 3; dist = 12.25; // Small tabs

module base()
{
	union()
	{
		difference()
		{
			translate([0,0,h/2])
				cube([l,w,h],true);
			
			// Rounding the base
			translate([l/2,w/2,0])
				rotate(180)
					round_border(1,h);
			
			translate([-l/2,w/2,0])
				rotate(-90)
					round_border(1,h);
			
			translate([l/2,-w/2,0])
				rotate(90)
					round_border(1,h);
			
			translate([-l/2,-w/2,0])
				round_border(1,h);
			
		}
		
		// Add the tabs to the left side
		tab();
		rotate(180)
			tab();
		
		// Opposite side tabs
		translate([0,0,h])  
			rotate([0,180,0])
			{
				tab();
				rotate(180)
					tab();
			}
	}
}

module round_border(size,height)
{
	difference()
	{
		translate([-size,-size,-0.5])
			cube([2,2,height+1]);
		translate([size,size,-0.5])
			cylinder(height+1,size,size,false,$fn=360);
	}
}

module tab()
{
	translate([l/2+pl,dist,0])
		rotate(90)
		{
			difference()
			{
				cube([pw,pl+1,h]);
				round_border(1,h);
				
				translate([pw,0,0])
					rotate(90)
						round_border(1,h);
			}
		}
}
