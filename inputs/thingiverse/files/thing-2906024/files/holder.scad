$fn=50;

// number of caps
numberOfCaps=6;

// in mm
spaceBetweenCaps=3; //[1:10]

// in mm
basePlateThickness=2; //[1:10]

// in mm
basePlateSideMargins=5; //[1:10]

// in mm
basePlateTopMargin=5; //[1:20]

// in mm
basePlateBottomMargin=15; //[1:50]

// in mm (Leave at 15 for expo)
capOuterDiameter=15; //[1:30]

// in mm (Leave at 9 for expo)
capInnerDiameter=9; //[1:15]

// in mm (Leave at 26.8 for expo)
capHeight=26.8;

// height at which the slope occurs (Leave at 22.3 for expo)
startSlopeHeight=22.3;



module markerCap()
{
	difference()
	{
		difference()
		{
			cylinder(d=capOuterDiameter, h=capHeight);
			cylinder(d=capInnerDiameter, h=capHeight+1); //+1 so it renders pretty
		}

		union(){
			translate([0,0,startSlopeHeight]) cylinder(h=capHeight-startSlopeHeight, d1=capInnerDiameter, d2=capOuterDiameter);
			translate([0,0,capHeight]) cylinder(h=1, d=capOuterDiameter);
		}
	}
}	

module setOfMarkerCaps()
{
	for(i = [0:numberOfCaps-1]){
		translate([i*(capOuterDiameter+spaceBetweenCaps),0,0]) markerCap();
	}
}

module basePlate()
{
	basePlateWidth = (numberOfCaps)*(capOuterDiameter+spaceBetweenCaps) - spaceBetweenCaps + (basePlateSideMargins*2);
	basePlateLength = capOuterDiameter + basePlateTopMargin + basePlateBottomMargin;
	cube([basePlateWidth, basePlateLength, basePlateThickness]);
}
module main(){
	basePlate();
	translate([(capOuterDiameter/2)+basePlateSideMargins,(capOuterDiameter/2)+basePlateBottomMargin,0]) setOfMarkerCaps();
}

main();
