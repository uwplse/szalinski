/* [Overall] */

// (mm)
Thickness = 2.5;

// at narrowest point (mm)
Width = 15;

// from top of bar to bottom of rod (mm)
Length = 120;

//(degrees)
TwistAngle = 60; // [0:90]

PartToMake = "both";	// [both,left only,right only]

/* [Bar End] */

// (mm)
BarWidth = 15;

// (mm)
BarHeight = 15;

// for cable tie, 0 to omit (mm)
SlotWidth = 5;

// (mm)
SlotThickness = 2;

/* [Rod End] */

// (mm)
RodDiameter = 20;

/* Derived values */
TwistWidth = 1000 * 2;
EndLength = max(BarHeight * 1.5, RodDiameter * 1.5);
TwistLength = Length - 2 * EndLength;

module BarEnd() {
	rotate([0, -TwistAngle/2, 0]) {
		translate([-BarWidth-Thickness*1.5, Length/2 - BarHeight/3, -TwistWidth/2])
			cube([Thickness, BarHeight/3 + Thickness, TwistWidth]);
		translate([-BarWidth-Thickness*1.5, Length/2, -TwistWidth/2])
			cube([BarWidth + Thickness * 2, Thickness, TwistWidth]);
		difference() {
			translate([-Thickness/2, TwistLength/2, -TwistWidth/2])
				cube([Thickness, EndLength + Thickness, TwistWidth]);
			translate([-Thickness, (Length - SlotThickness) / 2 - BarHeight, -SlotWidth/2])
				cube([Thickness * 2, SlotThickness, SlotWidth]);
		}
	}
}

module RodEnd() {
	rotate([0, TwistAngle/2, 0]) {
		translate([-(Thickness + RodDiameter)/2, -(Length - RodDiameter)/2, 0])
			difference() {
				cylinder(h=TwistWidth, center=true, r=RodDiameter/2 + Thickness);
				cylinder(h=TwistWidth, center=true, r=RodDiameter/2);
				translate([-RodDiameter, 0, -TwistWidth])
					cube([RodDiameter*2, RodDiameter, TwistWidth*2]);
			}
		translate([-Thickness/2, -(Length - RodDiameter)/2, -TwistWidth/2])
			cube([Thickness, EndLength - RodDiameter/2, TwistWidth]);
	}
}

module TwistyPart() {
	rotate([90, 0, 0])
		linear_extrude(height=TwistLength + 0.01, center=true, twist=TwistAngle, slices=20, convexity=10)
			rotate([0, 0, TwistAngle/2])
				square([Thickness, (Width + Thickness) / cos(TwistAngle/2)], center=true);
}

module Complete() {
	translate([0, 0, Width/2]) {
		intersection() {
			cube([1000, 1000, Width], center=true);
			union() {
				BarEnd();
				RodEnd();
				TwistyPart();
			}
		}
	}
}

shift = PartToMake != "both" ? 0 : sin(TwistAngle/2) * Width/2 + Thickness * 3;
if (PartToMake != "right only")
	translate([-shift, 0, 0])
		Complete();
if (PartToMake != "left only")
	translate([shift, 0, 0])
		mirror([1, 0, 0])
			Complete();
