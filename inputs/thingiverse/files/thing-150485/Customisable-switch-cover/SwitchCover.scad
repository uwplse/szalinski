// Switch cover
// Paul Murrin - Sept 2013

// (mm)
HeightOfSocket = 87;
// (mm) 
DepthOfSocket = 11.5;
// (mm)
HeightToBottomOfSwitch = 48;
// (mm)
WidthOfSwitch = 10;
// (mm)
DepthOfSwitch = 5;
// The clip helps to grip the switch plate. If not possible, use blue tack.
IncludeClips = true;

/* [Hidden] */

Thickness = 1;			// Thickness of cover
WidthExtraMargin = 0.5;	// Additional tolerance on width of cover.
Taper = 1.2;				// Amount which switch cover tapers (helps make it printable without massive overhang)
ClipLength = Thickness + 1.2;	// Length of clip that helps hold it on 
ClipThickness = 0.5;
WidthAtBase = WidthOfSwitch + 2*WidthExtraMargin + 2*Taper;
HeightOfCover=DepthOfSwitch+7;	// Height of the inside of the cover
LengthOfCover=40;	// Length of the inside of the cover
HeightToStartOfCover = HeightToBottomOfSwitch - 5 - Thickness;
FilletRadius = 2;
$fa=5;



rotate([0,90,0])
	union()
	{
		// Main body and cutout
		difference()
		{
			cube([WidthAtBase, HeightOfSocket+2*Thickness, DepthOfSocket + Thickness]);
			translate([0,Thickness,0])
				cube([WidthAtBase, HeightOfSocket, DepthOfSocket]);
			// Cutout for coverplate
			translate([0,Thickness + HeightToStartOfCover,DepthOfSocket])
				cube([WidthAtBase, LengthOfCover+2*Thickness, Thickness]);
		}
	
		// Clips to grip coverplate
		if (IncludeClips)
		{
			translate([0,0,-ClipThickness])
				cube([WidthAtBase, ClipLength, ClipThickness]);
			translate([0,HeightOfSocket+2*Thickness-ClipLength,-ClipThickness])
				cube([WidthAtBase, ClipLength, ClipThickness]);
		}
	
		
		// Cover bulge
		translate([0,HeightToStartOfCover+Thickness,DepthOfSocket])
		{
			difference()
			{
				union()
				{
					intersection()
					{
						translate([0,LengthOfCover/2+Thickness,(HeightOfCover+Thickness)-100])
							rotate([0,90,0])
								cylinder(r=100, h=WidthAtBase);
						cube([WidthAtBase,LengthOfCover+2*Thickness,HeightOfCover+Thickness]);
					}
					// Fillet at top
					translate([0,LengthOfCover+2*Thickness,Thickness])
						difference()
						{	
							cube([WidthAtBase,FilletRadius,FilletRadius]);
							translate([-0.01,FilletRadius,FilletRadius])	
								rotate([0,90,0])
									cylinder(r=FilletRadius, h=WidthAtBase+0.02, $fn=60);
						}
					// Fillet at bottom
					translate([0,-FilletRadius,Thickness])
						difference()
						{	
							cube([WidthAtBase,FilletRadius,FilletRadius]);
							#translate([-0.01,0,FilletRadius])	
								rotate([0,90,0])
									cylinder(r=FilletRadius, h=WidthAtBase+0.02, $fn=60);
						}
	
				}
				// Taper the cover
/*				translate([WidthAtBase,-FilletRadius, 0])
					rotate([0,-atan2(Taper, HeightOfCover+Thickness),0])
						cube([Taper,LengthOfCover+2*Thickness+2*FilletRadius,HeightOfCover+Thickness+10]);
				translate([-Taper,-FilletRadius, 0])
					rotate([0,atan2(Taper, HeightOfCover+Thickness),0])
						cube([Taper,LengthOfCover+2*Thickness+2*FilletRadius,HeightOfCover+Thickness+10]);
*/		
				// Cutout inside of cover
				difference()
				{
					intersection()
					{
						translate([Thickness,(LengthOfCover/2)+Thickness,HeightOfCover-100])
							rotate([0,90,0])
								cylinder(r=100, h=WidthAtBase);
						translate([Thickness,Thickness, 0])
							cube([WidthAtBase-2*Thickness,LengthOfCover,HeightOfCover]);
					}
					// Taper the cover
					translate([WidthAtBase-Thickness,Thickness, 0])
						rotate([0,-atan2(Taper, HeightOfCover+Thickness),0])
							cube([Taper,LengthOfCover,HeightOfCover+10]);
					translate([Thickness-Taper,Thickness, 0])
						rotate([0,atan2(Taper, HeightOfCover+Thickness),0])
							cube([Taper,LengthOfCover,HeightOfCover+10]);
				}
		
			}
		}
	
	}

