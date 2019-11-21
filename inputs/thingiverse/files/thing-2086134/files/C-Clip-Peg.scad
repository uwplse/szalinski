//Outer radius of the peg the clip will attach to
pegRadius = 1.75;
//Thickness of the clip.
clipThickness = 1.5;
//Bevel angle from vertical of the clip and peg notch.  The steeper the angle, the more holding power and thinner notch in your peg, but the harder it is to print the peg without support.  Supports are bad.
bevelAngle = 37.5;
//Thickness of the clip before it starts beveling.  This can be 0 for a sharp-edged clip, or greater than the thickness for a clip with no bevel at all.
bevelStart = .5;

offset = ((clipThickness-bevelStart) / tan((90-bevelAngle)));

//1.56321 - .1;


//Number of sides to make it "round".  I like very round, so I use 100, but less round renders faster.
$fn=100;

//jump = 10*ceil(outerRadius * 3 / 10);

difference() {
	cylinder(
		h=clipThickness*3,
		r=pegRadius
	);
	translate([0, 0, clipThickness]) {
		difference() {
			cylinder(
				h=clipThickness,
				r=pegRadius
			);
			cylinder(
				h=bevelStart,
				r=pegRadius-offset
			);
			translate([0, 0, bevelStart]) {
				cylinder(
					h=clipThickness - bevelStart,
					r1=pegRadius - offset,
					r2=pegRadius
				);
			}
		}
	}
}
