/** Adapter for vacuum hoses
 * Licence: CC:BY-SA
 */

/* [Parameters] */

// Inner diameter of large cylinder (mm)
LargeInnerDiameter = 35.1;
// Length of large cylinder (mm)
LargeLength=20;
// Inner diameter of small cylinder (mm)
SmallInnerDiameter = 30.6;
// Length of small cylinder (mm)
SmallLength=20;
// Thickness of walls (mm)
Thickness = 3;

// Resolution
$fn = 100;

/* large cylinder */
difference() {
	cylinder (d1=LargeInnerDiameter+0.5+2*Thickness, d2=LargeInnerDiameter-0.5+2*Thickness, h=LargeLength);
	cylinder (d=LargeInnerDiameter+0.5,              d2=LargeInnerDiameter-0.5,             h=LargeLength);
}

/* link between large & small cylinder
 * length is computed for a 50° angle from horizontal
 * so it's printable without support
 */
overhang = LargeInnerDiameter-0.5 - (SmallInnerDiameter+0.5);
MiddleLength = (tan(50) * overhang) > 3 ? (tan(50) * overhang) : 3;
echo ("MiddleLength", MiddleLength, "overhang", overhang);

translate ([0, 0, LargeLength])
	difference() {
		cylinder (d1=LargeInnerDiameter-0.5+2*Thickness, d2=SmallInnerDiameter-0.5+2*Thickness, h=MiddleLength);
		cylinder (d1=LargeInnerDiameter-0.5,             d2=SmallInnerDiameter-0.5,             h=MiddleLength);
	}

/* small cylinder */
translate ([0, 0, LargeLength+MiddleLength])
	difference() {
		cylinder (d1=SmallInnerDiameter-0.5+2*Thickness, d2=SmallInnerDiameter+0.5+2*Thickness, h=SmallLength);
		cylinder (d=SmallInnerDiameter-0.5,              d2=SmallInnerDiameter+0.5,             h=SmallLength);
	}
