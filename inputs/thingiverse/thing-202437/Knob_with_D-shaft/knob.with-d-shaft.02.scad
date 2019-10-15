//design and code by bioprint (http://www.thingiverse.com/bioprint)
//This code generates a knob with a D-shaft (customizable)
// 2013-12-07:	first design



// Top diameter
TopDiameter=18;
// Top height
TopHeight = 16; // [16]
// Shaft length
ShaftLength=18;
// Shaft outer diameter
ShaftOuterDiameter=10;
// Shaft inner diameter
ShaftInnerDiameter=7;
// Shaft pin width
ShaftPinWidth=2;
// XOffset
XOffset =1;



cylinder (h = TopHeight, r=TopDiameter/2, center = true, $fn=100);


difference() {
    			translate([0, 0, TopHeight])
    				cylinder (h = ShaftLength, r=ShaftOuterDiameter/2, center = true, $fn=100);
			translate([0, 0, TopHeight])
				cylinder (h = ShaftLength, r=ShaftInnerDiameter/2, center = true, $fn=100);
}

// add pins
PinHolderY=ShaftInnerDiameter/2-ShaftPinWidth/2;
PinholderX=sqrt(ShaftInnerDiameter*ShaftInnerDiameter/4-PinHolderY*PinHolderY)-XOffset;

translate([PinholderX/2+XOffset, PinHolderY/2+ShaftPinWidth/2, TopHeight]) 
	cube(size = [PinholderX,PinHolderY,ShaftLength], center = true);

translate([PinholderX/2+XOffset, 0-PinHolderY/2-ShaftPinWidth/2, TopHeight]) 
	cube(size = [PinholderX,PinHolderY,ShaftLength], center = true);

