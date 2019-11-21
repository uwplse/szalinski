// Macbook Pro Customizable Cable Dock
// by knarfishness, 01/30/16

//CUSTOMIZER VARIABLES

/* [Outer Wall Values] */

// The width (long side) of the dock module
outer_width = 90; // [80:120]
// The depth (short side) of the dock module
outer_depth = 12; // [10:20]
// The height (distance from laptop) of the dock module
outer_height = 30; // [20:50]
// How much to smooth the outer corners
outer_radius = 2; // [0.01:6]


/* [Power Adapter Settings] */

// Slot width
power_width = 17.15; // [17:18]
// Slot depth
power_depth = 5.25; // [5:7]
// Slot height
power_height = 13; // [10:15]
// Corner Smoothing
power_radius = 1; // [0.01:2]
// Cable width
power_cablewidth = 1.5; // [1.0:3.0]
// X-Offset (this should not need to change)
power_xoffset = 34;


/* [Video Port #1 Settings] */

// Slot width
videoA_width = 12; // [10:15]
// Slot depth
videoA_depth = 9; // [8:12]
// Slot height
videoA_height = 18.5; // [17:20]
// Corner smoothing
videoA_radius = 1; // [0.01:2]
// Cable width
videoA_cablewidth = 2.5; // [1.0:3.0]
// X-Offset (this should not need to change)
videoA_xoffset = 16;


/* [Video Port #2 Settings] */

// Slot width
videoB_width = 12; // [10:15]
// Slot depth
videoB_depth = 9; // [8:12]
// Slot height
videoB_height = 18.5; // [17:20]
// Corner smoothing
videoB_radius = 1; // [0.01:2]
// Cable width
videoB_cablewidth = 2.5; // [1.0:3.0]
// X-Offset (this should not need to change)
videoB_xoffset = 1;


/* [USB Port Settings] */

// Slot width
usb_width = 17; // [15:20]
// Slot depth
usb_depth = 6; // [4:8]
// Slot height
usb_height = 25; // [23:27]
// Corner smoothing
usb_radius = 0.5; // [0.01:2]
// Cable width
usb_cablewidth = 3; // [1.0:3.0]
// X-Offset (this should not need to change)
usb_xoffset = -18;


/* [(Optional) Audio Port Settings] */

// Generate a space for the audio port?
generate_audio = "Yes"; // [Yes,No]
// Slot width
audio_width = 5; // [3:7]
// Slot depth
audio_depth = 5; // [3:7]
// Slot height
audio_height = 15; // [10:20]
// Corner smoothing
audio_radius = 3; // [0.01:4]
// Cable width
audio_cablewidth = 1.5; // [1.0:3.0]
// X-Offset (this should not need to change)
audio_xoffset = -36;

//CUSTOMIZER VARIABLES END


// untweakable variables
power_zoffset = outer_height - power_height;
power = [power_width,power_depth,power_height,power_radius,power_cablewidth,power_xoffset,power_zoffset];

videoA_zoffset = outer_height - videoA_height;
videoA = [videoA_width,videoA_depth,videoA_height,videoA_radius,videoA_cablewidth,videoA_xoffset,videoA_zoffset];

videoB_zoffset = outer_height - videoB_height;
videoB = [videoB_width,videoB_depth,videoB_height,videoB_radius,videoB_cablewidth,videoB_xoffset,videoB_zoffset];

usb_zoffset = outer_height - usb_height;
usb = [usb_width,usb_depth,usb_height,usb_radius,usb_cablewidth,usb_xoffset,usb_zoffset];

audio_zoffset = outer_height - audio_height;
audio = [audio_width,audio_depth,audio_height,audio_radius,audio_cablewidth,audio_xoffset,audio_zoffset];


module outerShell() {
	roundedRect([ outer_depth, outer_width, outer_height ], outer_radius);
}

module smallerOuterShell() {
	translate([0,8,0])
	roundedRect([ outer_depth, outer_width-10, outer_height ], outer_radius);
}


// width, depth, height, radius, cablewidth, xoffset, zoffset
module port(name) {
	translate([0, name[5], name[6]-1]) 
		roundedRect([name[1], name[0], name[2]+2], name[3]);

	translate([-outer_depth/9, name[5]-(name[4]*2/2), -1])
		cube([outer_depth, name[4]*2, outer_height+2], center=false);

}


// module videoA
// module videoB
// module usb
// module audio

module ports5() {
	port(power);
	port(videoA);
	port(videoB);
	port(usb);
	port(audio);
}

module ports4() {
	port(power);
	port(videoA);
	port(videoB);
	port(usb);
}

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    }
}

module build()
{
	if(generate_audio == "Yes")
	{
		difference() {
			outerShell();
			ports5();
		}
	}
	else 
	{
		difference() {
			smallerOuterShell();
			ports4();
		}
	}
}

build();

