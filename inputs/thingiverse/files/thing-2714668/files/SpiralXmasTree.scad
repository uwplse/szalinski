//X-mas tree thing
//Eric Lindholm

/* The spiral extrudes as a pentagonal shape. 
  This pentagonal shape decreases in width as it goes to the center,
   so that when stretched the spiral turns into a rough tree shape.
  Note: the fragment number for the spiral is roughly 180 
   (there are 180 segments per revolution)
  Although you can play with the settings all you like, it does take a while to compute.
 */

// Parameters
// The outer diameter is pretty self-explanatory.
outerdiameter=80;    // [5:1:400]
// The width is the width of the outer circle base; this also controls the width of the spiral.
width=1.6;           // [0.5:0.1:5]
// Controls height of part
thickness=1.6;       // [0.5:0.1:5]
// The diameter of the center pinhole, for putting the stake through.
pinholediameter=1;   // [0.5:0.1:8]
// Center / top point diameter
innerdiameter=12;     // [3:0.5:40]

// Preview[view:south east, tilt: top diagonal]

/* [hidden] */
SpiralTree();

// Other parameters
// The spiral count number
coilnumber=floor(0.25*(outerdiameter-innerdiameter)/width);        // [2:1:18]
$fn=60;
deltatheta=2;
// Math
outR=outerdiameter/2;
inR=innerdiameter/2;
pinR=pinholediameter/2;
outspiralR=outR-2*width;

echo(coilnumber);

// A spiral that has a center round disc and a disc around the outside
module SpiralTree() {
union() {
	//Create inner circle / top point
	difference() {
		cylinder(r=inR,h=thickness, center=true);
		cylinder(r1=pinR, r2=pinR/2,h=thickness*3, center=true);
	}
	// outer rings
	difference() {
		cylinder(r=outR, h=thickness, center=true);
		cylinder(r=outspiralR, h=thickness*2, center=true);
	}
	// The spiral
	translate([0,0,-thickness/2])
		spiral1(inR-width,outspiralR,coilnumber,width);
}
}

//Create a spiral object with a pentagonal cross-section
module spiral1(radius1, radius2, numbercoils, width) {
	// Math
	height=thickness-0.1;
	// This controls the thickness as the spiral goes inward.
	function t(rad)=width*(1/2+(rad-radius1)/(2*(radius2-radius1)));
	// This is the distance between each spiral arc (I think).
	poll=deltatheta*(radius2-radius1)/(numbercoils);
	deltar=poll/360;
	// This is the eventual angle at the end of the spiral.
	maxangle=numbercoils*360/deltatheta;
	// This function controls the length of each fragment.
	function L1(r,theta)=r*sin(theta)/cos(theta);
	// This controls the angle that each fragment is rotated. I don't remember where 1.7 comes from.
	function phi(leng)=1.7*asin((deltar/(deltatheta*leng)));

	// The spiral section is really just one element, that is repeated many many times.
	union() {
	for(i=[0:maxangle]) {
   		rotate(-i*deltatheta,[0,0,1])
			translate([radius1+i*deltar,0,0])
				rotate(phi(L1(radius1+i*deltar,deltatheta)),[0,0,1])
					rotate(90,[1,0,0])
						linear_extrude(height=(2-i/maxangle)*L1(radius1+i*deltar,deltatheta),center=false,twist=0,convexity=10)
							polygon(points=[[0,0],[2*t(radius1+i*deltar),0],[2*t(radius1+i*deltar),height/2],[t(radius1+i*deltar),height],[0,height/2]]);
	}
	}
}