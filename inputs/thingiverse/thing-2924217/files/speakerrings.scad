// Speaker ring generator
// Code remix from https://www.thingiverse.com/thing:451253
//
// Use to make speaker rings for 5, 5.25, 6, 6.5, 6.75, 8, 10, 12, 15, 18, 21 inch speakers (sizes dependent on 3D printer capabilities, maybe use CNC for larger speaker spacers)
//
// preview[view:south, tilt:top]
//
/* [Unit adjustment] */
// Choose from mm, cm, or inch 
units_entered = 25.4;//[1:mm, 10:cm, 25.4:inch]

/* [Spacer Ring Sizing] */
// inner diameter (e.g. Speaker cutout diameter), set to just a little larger than the speaker cutout.  Default is for 6.5 inch ring.
d_inner= 5.375;

// outer diameter, (Speaker ring outer diameter)
d_outer= 6.75;

// height of adapter, (Common heights are .25, .5, .75, 1 inch)
h = 1.0;

/* [Hidden] */
// inner tolerance substract from wall)
i_inner = 0;
// outer tolerance in mm (substract from wall)
i_outer = 0;

//
// This code from https://www.thingiverse.com/apps/customizer/run?thing_id=1483876
/* [Flush Mounting Trim Ring] */

// Width of flush-mount trim, Set to .01 for no flush-mount ring (if height is less than .6 inches try using the opposite of the height, (i.e. height is 0.44 than make this -0.44) 
spacerTrimThickness = 0.25; 

// Height of flush-mount trim, Set to .01 for no flush-mount ring (if height is less than .6 inches try using the opposite of the height, (i.e. height is 0.44 than make this -0.44)
spacerTrimHeight = 0.25; 

/* [Speaker Screw Holes] */
//Speaker mount hole diameter, (same size as inner d_inner), (should be slightly larger than needed to ensure fit)
speakerHoleDiameter = d_inner;

//diagonally opposing holes this distance apart
speakerScrewHoleSpacing = 6.0;

numberOfSpeakerScrewHoles = 4; 

//.128 inch (3.25mm) seems good for #6 wood screw (screw in slowly / don't overtighten to avoid cracking) - chase with drill bit if needed
speakerScrewHoleDiameter = 0.128;

// Sets the angle from 0 to position holes, 45 is default
speakerScrewHoleAngle = 45;

/* [Spacer Ring Mounting Holes] */

//diagonally opposing holes this distance apart
mountScrewHoleSpacing = 6.0; 

numberOfMountScrewHoles = 4; 

//.2 inch (5.05mm) seems good for mount screws.  (use oem if possible), (screw in slowly / don't overtighten to avoid cracking) - chase with drill bit if needed
mountScrewHoleDiameter = 0.2;

/* [Spacer Ring Template] */
// Print 2D template to check fit


difference() {
    cylinder(d=d_outer+spacerTrimThickness-i_outer, h=h, $fn=256);
    
    translate([0,0,-1]) {
        cylinder(d=d_inner+i_inner, h=h+2, $fn=256);
        
    screwCutOuts(0, speakerScrewHoleSpacing, numberOfSpeakerScrewHoles, speakerScrewHoleDiameter, speakerScrewHoleAngle);
        
    mountscrewCutOuts(0, mountScrewHoleSpacing, numberOfMountScrewHoles, mountScrewHoleDiameter);
        
    spacerTrim(spacerTrimThickness, spacerTrimHeight);
        
    }
}

echo ((d_outer-d_inner-i_outer-i_inner)/2, units_entered);

module screwCutOuts(rotation, distance, numberOfHoles, holeDiameter, holeAngle)

{
	rotate ([rotation,0,0]) translate([0, 0, 1]) 
	{
		for (i = [0 : 360 / numberOfHoles : 360])
		{
			rotate([0,0,i + holeAngle])
				translate([0, distance / 2, h*.25])
					cylinder(r = holeDiameter / 2, h = h * 2, $fn=50);
		}
	}
}



module mountscrewCutOuts(rotation, distance, numberOfHoles, holeDiameter)

{
	rotate ([rotation,0,0]) translate([0, 0, -1.5]) 
	{
		for (i = [0 : 360 / numberOfHoles : 360])
		{
			rotate([0,0,i + 0])
				translate([0, distance / 2, 2])
					union () {
                        cylinder(r = holeDiameter / 2, h = h * 2, $fn=50);
                translate([0,0,1])cylinder(h=h*.26, r=holeDiameter / 2 + .1, $fn=50);
            }
		}
	}
}

// Trim for ring flush-mounting.  Code from https://www.thingiverse.com/apps/customizer/run?thing_id=1483876
module spacerTrim(spacerTrimThickness, spacerTrimHeight) 

{
	difference() {
		
        translate([0, 0, h+h-spacerTrimHeight])
        cylinder(h=h + spacerTrimHeight, d=d_outer, $fn=256);
        cylinder(h=h * 4, d=d_inner, center=true);
	
        }
}
