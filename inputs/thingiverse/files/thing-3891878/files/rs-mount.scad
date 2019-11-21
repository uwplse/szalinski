//version 1.1

/* [Clamp Ring] */
// Height of the clamp 
Size = 15; //[0:0.1:30]

Ring_Inner_Diameter = 28.5; //[1:0.1:100]
Ring_Wall_Thickness = 3; //[1:0.1:10]

/* [Lock] */
Lock_Gap = 3; //[1:0.1:5]
Lock_Wall_Thickness = 8; // [1:0.1:30]
Lock_Hole_Diameter = 8; //[2:0.1:30]

/* [Mounting plate] */
Plate_Thickness = 5; //[1:0.1:10]
Plate_Angle = 22.5; //[0:0.1:45]
Mounting_Hole_Spacing = 45; // [20: 0.1: 100]
Mounting_Hole_Diameter = 4; // [2:0.1:10]
Support_Inset = 0.5; //[0:0.01:1]

$fn = $preview ? 32 : 128;

module bracket(
	size = 15,
	ring=28.5, 
	ringwall = 3, 
	lockgap = 3, 
	lockwall = 8, 
	lockhole = 8,
	platewall = 5, 
	plateangle = 0, 
	mountspacing = 45, 
	mounthole = 4,
	suppinset = 0 
)
{
	Z = size;
	WR = ringwall;
	W1 = lockwall;
	W2 = platewall;
	ANGLE = plateangle;
	
	G = lockgap;
	A = W1 + G / 2;
	B = (mountspacing - Z) / 2;
	L = mountspacing + Z;
	C = mountspacing / 2;
	R = ring / 2;
	M = R + WR + Z;
	RB1 = lockhole / 2;
	RB2 = mounthole / 2;
	
	BDI = B*suppinset;
	ADI = max(0, (A/2)-(B-BDI));
	
	difference() {
		linear_extrude(Z) {
			difference() {
				union() {
					circle(r = R+WR);
					polygon([
						[-A,+0],[-A,+M], 
						[+A,+M],[+A,+0],
						[+A/2,+0],[+B,-M],
						[BDI,-M],[ADI, 0], [-ADI, 0], [-BDI, -M],
						[-B,-M],[-A/2,+0]
					]);
				}
				union() {
					circle(r=R);
					translate([-G/2,R/2])
					square([G, M]);
				}
			}
		}
		union() {
			translate([0,R+WR+Z/2, Z/2])
			rotate([0,90,0]) 
			cylinder(A*2+2, r=RB1, center=true);
		
			translate([-L/2, -M])
			rotate([-ANGLE,0,0])
			translate([0,-L, 0])
			cube([L, L, L]);
		}
	}
	translate([-L/2, -M])
	difference()
	{
		intersection() {
			rotate([-ANGLE,0,0])
			cube([L, W2, Z*2]);
			cube([L, Z, Z]);		
		}
		
		for (c=[-C,C])
		translate([L/2-c, tan(ANGLE)*Z/2, Z/2])
		rotate([-ANGLE+90,0,0])
		cylinder(L, r=RB2, center=true);
	}
}

bracket(
	size = Size,
	ring = Ring_Inner_Diameter, 
	ringwall = Ring_Wall_Thickness, 
	lockgap = Lock_Gap, 
	lockwall = Lock_Wall_Thickness, 
	lockhole = Lock_Hole_Diameter,
	platewall = Plate_Thickness, 
	plateangle = Plate_Angle, 
	mountspacing = Mounting_Hole_Spacing, 
	mounthole = Mounting_Hole_Diameter,
	suppinset = Support_Inset 
);