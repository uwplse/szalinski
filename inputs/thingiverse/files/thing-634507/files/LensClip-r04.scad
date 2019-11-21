// parametric lens holder for Note4 VR OpenDive Headset (and others)

IPD = 65; // Inter-Pupillary Distance. How far apart the center of the two lenses will be.
lensSize1 = 40.5; // diameter of one of the lenses you are using
lensSize2 = 40.5; // diameter of the other lens you are using
visorWidth = 149; // outer width of the visor.  this is how wide the lens clip will be
slotWidth = 10; // how wide the slots for the lens clip are
lensThickness = 2; // thickness of the edge of the lens

/* [Hidden] */
$fn=40;
lensLip = 1; // how big the rim of plastic holding the lens in will be
mountStart = (IPD+(lensSize1 + lensSize2)/2)/2 + 4; // an intermediate value
mountMid = (visorWidth/2-mountStart)/2 + mountStart;

lensClip();

module lensClip()
{
	difference ()
	{
		union()
		{
			hull()
			{
				translate([-(IPD/2+1),0,lensThickness/2 + 2])	cylinder(r=lensSize1/2 + 2, h=lensThickness +4, center=true);
				translate([-mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
			}
			translate([-mountMid, 0, 5]) cube([visorWidth/2 - mountStart, slotWidth, 10], center=true);

			hull()
			{
				translate([(IPD/2+1),0,lensThickness/2 + 2])	cylinder(r=lensSize2/2 + 2, h=lensThickness +4, center=true);
				translate([mountStart, 0, 5]) cube([.01, slotWidth, 10], center=true);
			}
			translate([mountMid, 0, 5]) cube([visorWidth/2 - mountStart, slotWidth, 10], center=true);
			
			// crosspiece
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
	translate ([-IPD/2,0,lensThickness/2 + 2]) lensCutOut(lensSize1);
	translate ([IPD/2,0,lensThickness/2 + 2]) lensCutOut(lensSize2);
	
	// lens gap
	translate([0,-50,3]) cube([IPD,100,50], center=true);

	}
}

module lensCutOut(lensSize)
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