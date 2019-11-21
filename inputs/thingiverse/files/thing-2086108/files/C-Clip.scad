//Outer radius of the peg the clip will attach to
pegRadius = 1.75;
//Clearance between the peg and the inner radius of the clip
clearance = .15;
//Outer radius of the clip.  If it's less than or equal to your peg radius, your clip isn't going to hold much.
outerRadius = 4;
//Thickness of the clip.
thickness = 1.5;
//Bevel angle from vertical of the clip and peg notch.  The steeper the angle, the more holding power and thinner notch in your peg, but the harder it is to print the peg without support.  Supports are bad.
bevelAngle = 37.5;
//Thickness of the clip before it starts beveling.  This can be 0 for a sharp-edged clip, or greater than the thickness for a clip with no bevel at all.
bevelStart = .5;
//This is how much the "wings" overlap the solid portion of the peg.  Too much and your clip may not be flexible enough to open and go into place.  Less than clearance and the clip can just fall off.  You only need enough wraparound to keep the clip from coming off during normal useage and still be removable by hand (or tool).
wrapAround = .4;
//This chamfers the outside edge, easing the top and bottom corners and making removal from the bed easier.
chamferAngle = 37.5;
chamferHeight = .5;

offset = ((thickness-bevelStart) / tan((90-bevelAngle)));

innerRadius = (pegRadius - offset) + clearance;
iR2 = innerRadius + offset;
//1.56321 - .1;

chamferWidth = (chamferHeight) / tan(90-chamferAngle);

//Number of sides to make it "round".  I like very round, so I use 100, but less round renders faster.
$fn=100;

//jump = 10*ceil(outerRadius * 3 / 10);

difference() {
	cylinder(
		h=thickness,
		r=outerRadius
	);
	cylinder(
		h=thickness,
		r=innerRadius
	);
	translate([0, 0, bevelStart]){
		cylinder(
			h=thickness - bevelStart,
			r1=innerRadius,
			r2=iR2
		);
	};
	translate([0, outerRadius/2, thickness/2]) {
		cube(
			size=[(innerRadius-wrapAround)*2,outerRadius,thickness],
			center=true
		);
	};
	polyhedron(
		points=[
			[-(innerRadius-wrapAround), 0, bevelStart],
			[-(innerRadius-wrapAround + offset), 0, thickness],
			[(innerRadius-wrapAround)+offset, 0, thickness],
			[innerRadius-wrapAround, 0, bevelStart],
			[-(innerRadius-wrapAround), outerRadius, bevelStart],
			[-(innerRadius-wrapAround + offset), outerRadius, thickness],
			[(innerRadius-wrapAround)+offset, outerRadius, thickness],
			[innerRadius-wrapAround, outerRadius, bevelStart]
		],
		faces=[
			[0,1,2,3],
			[7,6,5,4],
			[1,5,6,2],
			[3,7,4,0],
			[0,4,5,1],
			[2,6,7,3]
		]
	);
	difference() {
		cylinder(
			h=chamferHeight,
			r=outerRadius*2
		);
		cylinder(
			h=chamferHeight,
			r1=outerRadius - chamferWidth,
			r2=outerRadius
		);
	};
	translate([0,0,thickness-chamferHeight]) {
		difference() {
			cylinder(
				h=chamferHeight,
				r=outerRadius*2
			);
			cylinder(
				h=chamferHeight,
				r1=outerRadius,
				r2=outerRadius - chamferWidth
			);
		}
	};
}
