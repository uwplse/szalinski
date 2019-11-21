// parametric lens holder for Note4 VR OpenDive Headset (and others)

// Single- or Dual- lens model?
part = "single"; // [single:Single Lens,dual:Dual Lens]

// Inter-Pupillary Distance
IPD = 65; // Inter-Pupillary Distance. How far apart the center of the two lenses will be
// Diameter of lens #1 (single and dual)
lensSize1 = 40.5; // diameter of one of the lenses you are using
// Diameter of lens #2 (single and dual)
lensSize2 = 40.5; // diameter of the second lens you are using
// Diameter of lens #3 (dual only)
lensSize3 = 40.5; // diameter of the third lens you are using
// Diameter of lens #4 (dual only)
lensSize4 = 40.5; // diameter of the fourth lens you are using
// Gap between dual lenses (dual only)
lensGap = 11; // gap between first and second lens (center-to-center)
// Width of the VR visor being used.
visorWidth = 149; // outer width of the visor.  this is how wide the lens clip will be
// Width of slots within the VR visor
slotWidth = 10; // how wide the slots for the lens clip are
// Thickness of single lenses
lensThickness = 2; // how thick the edges of the lenses are
// Thickness of secondary lenses
lensThickness2 = 2; // how thick the edges of the secondary lenses are

/* [Hidden] */
$fn=40;
lensLip = 1; // how big the rim of plastic holding the lens in will be
mountStart = (IPD+(lensSize1 + lensSize2)/2)/2 + 4; // an intermediate value
mountMid = (visorWidth/2-mountStart)/2 + mountStart;

lensThicknessAvg = (lensThickness + lensThickness2) / 2; // just to simplify dual
        
lensClip(part);

module lensClip(part)
{
	difference ()
	{
		union()
		{
            // lens outers
            if (part == "single")
            {
                hull()
                {
                    translate([-(IPD/2+1),0,lensThickness/2 + 2])	cylinder(r=lensSize1/2 + 2, h=lensThickness + 4, center=true);
                    translate([-mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
                }

                hull()
                {
                    translate([(IPD/2+1),0,lensThickness/2 + 2])	cylinder(r=lensSize2/2 + 2, h=lensThickness +4, center=true);
                    translate([mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
                }
            }
            else
            {
                hull()
                {
                    translate([-(IPD/2+1),0,(lensThicknessAvg/2 + 2) + lensGap/2])	cylinder(r=lensSize1/2 + 2, h=(lensThicknessAvg + 4) + lensGap, center=true);
                    translate([-mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
                }

                hull()
                {
                    translate([(IPD/2+1),0,(lensThicknessAvg/2 + 2) + lensGap/2])	cylinder(r=lensSize2/2 + 2, h=(lensThicknessAvg + 4) + lensGap, center=true);
                    translate([mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
                }
            }
            
            
            translate([-mountMid, 0, 5]) cube([visorWidth/2 - mountStart, slotWidth, 10], center=true);
			translate([mountMid, 0, 5]) cube([visorWidth/2 - mountStart, slotWidth, 10], center=true);
			
			// crosspiece (lighter for single than for dual)
            if (part == "single") 
            {
                hull()
                {
                    translate([0, 5, 12]) rotate([90,0,0]) cylinder(r=2,h=6,center=true);
                    translate([-12, 4, 3]) rotate([90,0,0]) cylinder(r=3,h=8,center=true);
                }
                hull()
                {
                    translate([0, 5, 12]) rotate([90,0,0]) cylinder(r=2,h=6,center=true);
                    translate([12, 4, 3]) rotate([90,0,0]) cylinder(r=3,h=8,center=true);
                }
            }
            else
            {
                hull()
                {
                    translate([0, 5, 12]) rotate([90,0,0]) cylinder(r=3,h=6,center=true);
                    translate([-12.5, 4, 4]) rotate([90,0,0]) cylinder(r=4,h=8,center=true);
                }
                hull()
                {
                    translate([0, 5, 12]) rotate([90,0,0]) cylinder(r=3,h=6,center=true);
                    translate([12.5, 4, 4]) rotate([90,0,0]) cylinder(r=4,h=8,center=true);
                }
            }
			translate([-(IPD/4 + 6),4,3]) cube([IPD/2-12,8,6], center=true);
			translate([(IPD/4 + 6),4,3]) cube([IPD/2-12,8,6], center=true);
		}
	
	// slot mount cutouts
	translate ([-mountMid, 0, 5])
	{
		cube([visorWidth/2 - mountStart + 1, 2, 11],center=true);
		rotate([0,90,0]) cylinder(r=2, h=visorWidth/2 - mountStart + 1, center=true, $fn=10);
	}

	translate ([mountMid, 0, 5])
	{
		cube([visorWidth/2 - mountStart + 1, 2, 11],center=true);
		rotate([0,90,0]) cylinder(r=2, h=visorWidth/2 - mountStart + 1, center=true, $fn=10);
	}
	// lens cutouts
	translate ([-IPD/2,0,lensThickness/2 + 2]) lensCutOut(lensSize1,lensThickness);
	translate ([IPD/2,0,lensThickness/2 + 2]) lensCutOut(lensSize2,lensThickness);
    
    // secondary lens cutouts
    if (part == "dual")
    {
        translate ([-IPD/2,0,(lensThickness/2 + 2) + lensGap]) lensCutOut(lensSize3,lensThickness2);
        translate ([IPD/2,0,(lensThickness/2 + 2) + lensGap]) lensCutOut(lensSize4,lensThickness2);
    }
	
	// lens gap
	translate([0,-50,3]) cube([IPD,100,50], center=true);

	}
}

module lensCutOut(lensSize,lensThickness)
{
	union()
	{
		cylinder(r=lensSize/2 - lensLip, h=100, center=true);
		
		// creating a bevel
		hull()
		{
			cylinder(r=lensSize/2, h=lensThickness, center=true);
			cylinder(r=lensSize/2-lensLip, h=lensThickness + lensLip, center=true);
		}
	}
}