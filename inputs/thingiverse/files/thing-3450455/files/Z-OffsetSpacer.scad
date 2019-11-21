/*    This file is licensed under the following license:
    https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
    https://creativecommons.org/licenses/by-nc-nd/3.0/
    (c) 2019 Andreas Rath (derandi3D on www.thingiverse.com)
*/
/*
	Z-Axis 

/* [Global] */
// Thickness of your glas-bed
GlassPlateThikness = 3; 
// Thikness of the magnetic bed (if you remove it)
MagneticPlateThikness = 0.95;	
// length of stock screw measured from top side of carrier to top of screw
FabScrewHeight = 7;		

// Diameter of the knob
KnobDiameter = 10;		

// Height of the nut (M4 default)
NutHeight = 3.2;	
// Diameter of the nut on the parallel sides
NutDiameter = 6.92;
// Diameter of the screw (M4 default)
ScrewDiameter = 4;		

// Hight of the raised small knob
TopKnobHeight = 1;		
// Extra hight for fine alignement with sandpaper
TopKnobExtraHeight = 0;	

// Tolerance for additional width of holes and the nut-slot
Tolerance = 0.2;		

/* [Storage Tab] */
// Print with storage tab
withTab = 1;		// [0: no tab, 1: width tab]	

TabHeight = 1; 			// Hight of the storage tab
TabLength = 10;			// Length of the storage tab


/* [Hidden] */
MinBuildPlateThikness = 1;

_KnobHeight = FabScrewHeight-MagneticPlateThikness + GlassPlateThikness;
_HoleHeight = FabScrewHeight + 0.5;

echo(_KnobHeight=_KnobHeight, MagneticPlateThikness=MagneticPlateThikness, GlassPlateThikness=GlassPlateThikness);

module Tab() {
	difference() {
		union() {
			cube([KnobDiameter, TabLength, 1], true);
			translate([0,TabLength/2,0])
			cylinder(h=TabHeight, r=KnobDiameter/2, center=true);
		}
		translate([0, TabLength/2, 0])
			cylinder($fn=50, h=TabHeight, r=ScrewDiameter/2+Tolerance, 1, center=true);
	}
}

union() {
	difference() {
		union() {
			// the body
			cylinder($fn=10, h=_KnobHeight - TopKnobHeight, r=KnobDiameter/2, center=false);
			if(withTab == 1) {
				translate([0, TabLength/2, TabHeight/2])
					Tab();
			}
		}
		// the screw-hole
		cylinder($fn=50, h=_HoleHeight, r = ScrewDiameter/2+Tolerance, center=false);
		// slot for nut
		translate([0, 0, FabScrewHeight-NutHeight]) 
		cube([KnobDiameter+1, NutDiameter, NutHeight +Tolerance], true);
	}
	
	translate([0,0,_KnobHeight-TopKnobHeight])
		cylinder($fn=50, h=TopKnobHeight+TopKnobExtraHeight, r=ScrewDiameter/2, center=false);
	

}