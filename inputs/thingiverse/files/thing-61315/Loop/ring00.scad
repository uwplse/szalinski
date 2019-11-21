// Author: David Asabina <david@supr.nu>
// Date: March 9, 2013
// Project: Ring
// Description: The objective of this design is to offer
// sufficient volumetric space for the necessary electronic
// circuitry whilst keeping the design as ergonomically
// harmonic as possible

// Build a ring with the default finter diameter
// R_finger: radius of index finger in mm

// Radius of the index finger
finger_radius = 13; // [7:18]
// Thickness of the ring
ring_girth = 5; // [5:10]
// Width of the ring
ring_width = 18; // [16:30]
// Thickness of the ring's skin
skin_thickness = 1; // [1:2]

// Type of lobing on the ring
lobes = false; // [true:Single,false:Double]
// Radius of the primary lobe
primary_lobe_diameter = 9; // [1:10]
// Radius of the secondary lobe's end (only applicable is lobes is set to double lobed)
secondary_lobe_diameter = 12; // [1:10]
// Length of the lobe
lobe_length = 5; // [3:12]

// Generate cut-through of ring
cut="none"; // [side:Side,thru:See-through,none:None]

// Lenght of the circuit board located within primary lobe
pcb_length=27; // [8:30]
// Width of the circuit board located within primary lobe
pcb_width=16; // [8:20]
// Spacing between the outer skin of the ring and the circuit board
top_spacing_for_pcb=1; // [1:3]
// The amount of support struts for the circuit board
pcb_support_strut_count= 4; // [2:8]

// preview[view:west, tilt:side]
difference() {
		color("deepskyblue")
		ring(
			finger=finger_radius,
			girth=ring_girth,
			width=ring_width,
			block=true,
			single=lobes,
			thickness=skin_thickness,
			lobe=primary_lobe_diameter,
			lobe2=secondary_lobe_diameter,
			angle=120,
			lobelen=lobe_length,
			cols=pcb_support_strut_count,
			pcbheight=top_spacing_for_pcb,
			pcblen=pcb_length,
			pcbwidth=pcb_width);

		//rotate([0, 0, 180]) translate([-25, 0, -25]) cube(50, 50, 50);

		if(cut=="side") {
			translate([-ring_width, 0, 0]) cube(size=[ring_width, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2], center=true);
		}
		if(cut=="thru") {
			translate([-ring_width*5/4, 0, 0]) cube(size=[ring_width, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2], center=true);
			translate([ring_width*1/4, 0, 0]) cube(size=[ring_width, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2, (finger_radius+ring_girth+lobe_length+primary_lobe_diameter+secondary_lobe_diameter)*2], center=true);
		}
}

//inner(finger=f, girth=g, width=w, lobe=l, lobelen=ll, thickness=t, block=true, single=false);
module ring(
	finger=13,    // finger radius
	girth=5,      // the girth of the ring
	width=18,			// width of the ring
	lobe=13,      // the diameter of the lobe§
	lobe2=13,        // the diameter of the secondary lobe
	lobelen=10,// the length of the blocking lobe
	thickness=2,  // thickness of the casing
	block=true,   // blocking lips enable flag
	single=false, // single or double lobe mode
	angle=90,     // angle of secondary lobe
	struts=true,  // support truts enable flag
	cols=3,       // the amount of support strut cols
	colwidth=2,   // the width of the support struts
	spacing=1,    // outward spacing for pcb
	rows=3,       // the amount of support strut aligned through the width of the artefect per col
	pcblen=20,    // the pcb length
	pcbwidth=16,  // the pcb width
	pcbheight=1,  // the pcb width
)
{
	translate([-(width/2), 0, 0])
	{
		difference()
		{
			// construct the main form
			union()
			{
				// main frame of ring
				rotate([0, 90, 0])
				cylinder(h=width, r1=finger+girth, r2=finger+girth, center=true, $fn=100);

				if(block)
				{
					if(single)
					{
						translate([0, (finger+girth)/2, (finger+girth)/2])
						cube([width, finger+girth, (finger+girth)], center=true);

						lip(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, center=true);
					} else {
						translate([0, (finger+girth)/2, (finger+girth)/2])
						cube([width, finger+girth, (finger+girth)], center=true);

						lip(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, center=true);

						rotate([(90-angle),0,0])	
						translate([0, (finger+girth)/2, -(finger+girth)/2])
						cube([width, finger+girth, (finger+girth)], center=true);

						rotate([-angle,0,0])	
						lip(lobelen=lobelen, lobe=lobe2, finger=finger, girth=girth, width=width, center=true);
					}
				}
			}

			translate([0, 0, 0])
			rotate([0, 90, 0])
			cylinder(h=2*width, r1=finger, r2=finger, center=true, $fn=100);

			difference()
			{
				union()
				{
					if(lobe-(2*thickness)>=thickness || lobelen > lobe/3) {
						difference()
						{
							union()
							{	
								if(single) {
									if(block)
										innerlip(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, center=center, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, rows=rows, block=block);
								} else {
									if(block)
									{
										innerlip(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, center=center, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, rows=rows);

										rotate([-angle, 0, 0])
										innerlip(lobelen=lobelen, lobe=lobe2, finger=finger, girth=girth, width=width, center=center, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, rows=rows);
									}
								}
		
								rotate([0, 90, 0])
								cylinder(h=width-thickness, r1=(finger+girth)-thickness, r2=(finger+girth)-thickness, center=true, $fn=100);
		
							}
			
							if(block) {	
								if(struts) {	
									if(single) {
										innerlipstruts(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, pcblen=pcblen, pcbwidth=pcbwidth, rows=rows, spacing=spacing);
									} else {
										innerlipstruts(lobelen=lobelen, lobe=lobe, finger=finger, girth=girth, width=width, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, pcblen=pcblen, pcbwidth=pcbwidth, rows=rows, spacing=spacing);

										rotate([-angle, 0, 0])
										innerlipstruts(lobelen=lobelen, lobe=lobe2, finger=finger, girth=girth, width=width, thickness=thickness, struts=struts, cols=cols, colwidth=colwidth, pcbheight=pcbheight, pcblen=pcblen, pcbwidth=pcbwidth, rows=rows, spacing=spacing);
									}
								}	
							}	
						}
					} else {
						rotate([0, 90, 0])
						cylinder(h=width-thickness, r1=(finger+girth)-thickness, r2=(finger+girth)-thickness, center=true, $fn=100);
					}	
				}
				
				rotate([0, 90, 0])
				cylinder(h=width, r1=finger+thickness, r2=finger+thickness, center=true, $fn=100);
			}
		}
	}
}

module lip(lobelen, lobe, finger, girth, width, center)
{
	union() {
		// top lobe bar
		if(lobelen > lobe/2)
		{
			translate([0, finger+girth+(lobelen/2), finger+girth-(lobe/2)])
			cube([width, lobelen, lobe], center=true);
		
			// top lobe cylinder
			translate([0, finger+girth+lobelen, finger+girth-(lobe/2)])
			rotate([0, 90, 0])
			cylinder(h=width, r1=lobe/2, r2=lobe/2, center=true, $fn=100);
		} else {
			//translate([0, finger+girth+(lobe/6), finger+girth-(lobe/2)])
			translate([0, finger+girth+lobe/4, finger+girth-lobe/2])
			cube([width, lobe/2, lobe], center=true);
		
			// top lobe cylinder
			translate([0, finger+girth+lobe/2, finger+girth-(lobe/2)])
			rotate([0, 90, 0])
			cylinder(h=width, r1=lobe/2, r2=lobe/2, center=true, $fn=100);
		}
		
		if(lobe<=finger+girth)
		{
			difference() {
				// top lobe sub filler
				// translate([0, finger+girth+(lobe/6), finger+girth-(5*lobe/6)])
				translate([0, finger+girth, finger+girth-lobe])
				cube([width, lobe, lobe], center=true);
		
				translate([0, finger+girth+lobe/2, finger+girth-3*(lobe/2)])
				rotate([0, 90, 0])
				cylinder(h=width*2, r1=lobe/2, r2=lobe/2, center=true, $fn=100);
			}
		}
	}
}

module innerlip(lobelen, lobe, finger, girth, width, center, thickness, cols, colwidth, pcbheight, rows, struts)
{
  difference() {
	  union()
		{
			// main lobe extension hull
			translate([0,((finger+girth-thickness)/2),((finger+girth-thickness)/2)])	
			cube(size=[width-2*thickness,finger+girth-thickness,(finger+girth-thickness)], center=true);
		
			// lobe space	
			//translate([0,(finger+girth-thickness+lobelen/2)-1,finger+girth-(lobe/3)])
			//cube(size=[width-2*thickness, lobelen+2, lobe*2/3-2*thickness], center=true);
			translate([0,finger+girth,finger+girth-(lobe/2)])
			cube(size=[width-2*thickness, lobelen+lobe/2, lobe-2*thickness], center=true);

			//translate([0, finger+girth+lobe/3, finger+girth-3*(lobe/3)])
			translate([0,finger+girth+(lobe/2),finger+girth-(lobe/2)])
			rotate([0, 90, 0])
			cylinder(h=width-(2*thickness), r1=(lobe/2)-(thickness), r2=(lobe/2)-(thickness), center=true, $fn=100);
		}	
	}
}

module innerlipstruts(lobelen, lobe, finger, girth, width, center, thickness, cols, colwidth, pcbheight, rows, spacing=1, pcblen=20, pcbwidth=16)
{
	if(pcblen > finger+girth+lobelen+lobe/3){echo("PCB may be too long!");}
	if(pcbwidth > width-2*thickness){echo("PCB may be too wide!");}
	// the strut dimensions are the 1/2 dimension of column dimensions
	translate([0,lobe/3,0])
	if(struts)
	{
		// buld support cols
		echo(str("strut col span equals ", (finger+girth+lobelen)));
		if(cols>=2) {
			for(i = [0 : cols-1]) {
				//translate([((width-thickness)/2)-colwidth/2+1/2,(finger+girth-thickness+lobelen)-1+1/2-(i*(finger+girth+lobelen)/(cols-1)),finger+girth-(lobe/3)])
				translate([
					(pcbwidth/2), // x orientation
					(finger+girth-thickness+lobelen)-(i*pcblen/(cols-1)), // y orientation
					finger+girth-(lobe/3) // oriented in z center
				])
				union() {
					difference() {
						cube(size=[colwidth, colwidth, lobe*2/3-2*thickness+1], center=true);
	
						if(i==cols-1) {
							translate([0,0+(1+colwidth/2),((lobe*2/3)-(1*thickness))/2-pcbheight-spacing])
							cube(size=[colwidth+2, colwidth+2, pcbheight], center=true);
						} else {
						if(i==0) {
							translate([0,0-(1+colwidth/2),((lobe*2/3)-(1*thickness))/2-pcbheight-spacing])
							cube(size=[colwidth+2, colwidth+2, pcbheight], center=true);
						} else {
							translate([0,0,((lobe*2/3)-(1*thickness))/2-pcbheight-spacing])
							cube(size=[colwidth+2, colwidth+2, pcbheight], center=true);
						}}
					}
					translate([colwidth,0,0])
					cube(size=[colwidth, colwidth, lobe*2/3-2*thickness+1], center=true);
				}
	
				// middle support col on first and last struts set
				if(i == 0 || i == cols-1) {
					translate([0,(finger+girth-thickness+lobelen)-1+1/2-(i*pcblen/(cols-1)),finger+girth-(lobe/3)])
					difference() {
						cube(size=[colwidth, colwidth, lobe*2/3-2*thickness+1], center=true);

						translate([0,0,((lobe*2/3)-(1*thickness))/2-pcbheight-spacing])
						cube(size=[colwidth+2, colwidth+2, pcbheight], center=true);
					}
				}
			}
		}
	}
}
