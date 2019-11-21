// A front panel to hinge and mount a OnePlus One phone into the Note4 VR Headset

// Which part to make?
part = "both"; // [first:Panel Only,second:Clip Only,both:Panel and Clip]

// Measured Width of Phone
phoneHeight = 77; // measured width of OnePlus One (sideways)

// Measured Depth of Phone (7.1 for iPhone6+, 9.1 for Oneplus One)
phoneDepth = 7.1; // measured depth of phone

/* [Hidden] */
$fn=40;
panelHeight = 80; // really measured it as 79
panelThickness = 3; // thickness of plastic for the panel
hingeThickness = 4; // thickness of lower hooks
hookSeparation = 70; // distance between the two lower hooks
hookWidth = 12; // width of the bottom hooks. Measured as 10.
hookDepth = 18; // distance from flat face to inner hook
foamFudge = 1; // fudge factor due to adding foam, clip radius being oversized, etc
tabWidth = 20; // width of upper tab
tabHeight = 8; // height to make the upper tab
clipThickness = 4; // how thick to make the clip
clipRadius = clipThickness * .5; // Same as clipThickness to make it round  clipThickness * .6; // radius for clips. They'll be slightly bigger than clipThickness
clipClearance = 55; // inner width for upper clip
clipDepthClearance = 17; // inner depth for upper clip
clipWidth = clipClearance + clipRadius; // adjusted for dimensioning
clipDepth = clipDepthClearance + clipRadius; // inner depth before taper for upper clip



if (part== "first") panel();
else if (part == "second") clip();
else if (part == "both") makeBoth();
else makeBoth();


module makeBoth()
{
	panel();
	
	translate ([(hookSeparation + hookWidth)/2 + hingeThickness + clipRadius, 0, 0]) 
	rotate([0,0,270])
	clip();
}

module panel()
{
	// create the panel itself
	union()
	{
		// first leg
		hull()
		{
			translate ([0,(panelHeight/2), panelThickness/2])
			rotate([0,90,0])
			cylinder(r=panelThickness/2, h=tabWidth, center=true);
			
			translate ([-hookSeparation/2, -(panelHeight/2 + panelThickness/2), panelThickness/2])
			rotate([0,90,0])
			cylinder(r=panelThickness/2, h=hookWidth + 2*hingeThickness, center=true);
		}
		
		// second leg
		hull()
		{
			translate ([0,(panelHeight/2), panelThickness/2])
			rotate([0,90,0])
			cylinder(r=panelThickness/2, h=tabWidth, center=true);
				
			translate ([hookSeparation/2, -(panelHeight/2 + panelThickness/2), panelThickness/2])
			rotate([0,90,0])
			cylinder(r=panelThickness/2, h=hookWidth + 2*hingeThickness, center=true);
		}
			
		// add tab
		difference()
		{
			hull()
			{
				translate ([-tabWidth/2, panelHeight/2 + tabHeight/2 - 1, panelThickness/2])
				rotate ([90,0,0])
				cylinder (r=panelThickness/2, h=tabHeight + 2, center=true);
		
				translate ([tabWidth/2, panelHeight/2 + tabHeight/2 - 1, panelThickness/2])
				rotate ([90,0,0])
				cylinder (r=panelThickness/2, h=tabHeight + 2, center=true);
			}
				
			// remove a notch for better clip grip
			translate ([0,(panelHeight + hingeThickness)/2, -clipRadius])
			rotate ([0,90,0])
			cylinder (r=clipRadius+.5,h=tabWidth * 2,center=true);
		}
			
		// add hooks
		translate ([-hookSeparation/2, -panelHeight/2, 0])
		hook();
		
		translate ([hookSeparation/2, -panelHeight/2, 0])
		hook();
			
		// add nubbins for onePlus self alignment (uncomment and adjust "phoneHeight" to make a mini platform to auto-align your phone)
		translate ([-(hookSeparation/2+hookWidth/2), -(panelHeight - (panelHeight - phoneHeight)/2) / 2, (panelThickness + phoneDepth + foamFudge) / 2])
		cube ([hookWidth/2, (panelHeight - phoneHeight)/2, phoneDepth], center=true);
		
		translate ([hookSeparation/2+hookWidth/2, -(panelHeight - (panelHeight - phoneHeight)/2) / 2, (panelThickness + phoneDepth + foamFudge) / 2])
		cube ([hookWidth/2, (panelHeight - phoneHeight)/2, phoneDepth], center=true);
		

	}
}	

module hook()
{
	// create the hooks
	difference()
	{
		hull()
		{
			translate ([0, -panelThickness/2, panelThickness/2])
			rotate([0,90,0])
			cylinder(r=panelThickness/2, h=hookWidth + 2*hingeThickness, center=true);
			
			translate([0, -hingeThickness/2, hingeThickness/2 + hookDepth + phoneDepth + foamFudge])
			rotate([0,90,0])
			cylinder(r=hingeThickness/2, h=hookWidth + 2*hingeThickness, center=true);

		}
		
		translate ([0, -hingeThickness/2, panelThickness/2 + hookDepth/2 + phoneDepth + foamFudge])
		cube ([hookWidth, 100, hookDepth], center=true);
	}
	
	// draw the cylinder back in
	translate([0, -hingeThickness/2, hingeThickness/2 + hookDepth + phoneDepth + foamFudge])
	rotate([0,90,0])
	cylinder(r=hingeThickness/2, h=hookWidth * 1.5, center=true);		

}

module clip()
{
	translate ([0,0,clipThickness/2])
	intersection()
	{
		union()
		{
			hull()
			{
				corner1();
				corner2();
			}
			hull()
			{
				corner1();
				corner3();
			}
			hull()
			{
				corner2();
				corner4();
			}
			hull()
			{
				corner3();
				corner5();
			}
			hull()
			{
				corner4();
				corner6();
			}
			hull()
			{
				corner5();
				corner6();
			}
		}

		cube([1000,1000,clipThickness],center=true); // narrowing the clip to create flats.
	}
}

module corner1() translate([-clipWidth/2,0,0]) sphere(r=clipRadius, $fn=20);
module corner2() translate([clipWidth/2,0,0]) sphere(r=clipRadius, $fn=20);
module corner3() translate([-clipWidth/2,clipDepth,0]) sphere(r=clipRadius, $fn=20);
module corner4() translate([clipWidth/2,clipDepth,0]) sphere(r=clipRadius, $fn=20);
module corner5() translate([-(tabWidth + clipThickness + 1)/2,clipDepth + phoneDepth + foamFudge + clipRadius + panelThickness,0]) sphere(r=clipRadius, $fn=20);
module corner6() translate([(tabWidth + clipThickness + 1)/2,clipDepth + phoneDepth + foamFudge + clipRadius + panelThickness,0]) sphere(r=clipRadius, $fn=20);
