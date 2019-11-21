// all measurements are in millimeters (mm)

// tolerance added to every hole diameter (mm)
tol = 0.0;		

// wall thickness (mm)
wt 		= 1.2; 	

// bigger hole diameter (mm)
d1 = 42.0;		
d1t = d1 + tol;	

// smaller hole diameter (mm)
d2 = 34.9;
d2t = d2 + tol;		

// bigger diameter part length (mm)
l1 = 18.0;	
	
// transition part length (mm)		
l2 = 15.0; 

// smaller diameter part length (mm)
l3 = 30.0;				

// difference in holes and solids to prevent (visual) glitches (mm)
e = 0.02*1;		

// smoothness
$fn = 256;	

module solid()
{
	cylinder(d=d1t+2*wt,h=l1);
	translate([0,0,l1			]) cylinder(d1=d1t+2*wt,d2=d2t+2*wt	,h=l2);
	translate([0,0,l1+l2		]) cylinder(d=d2t+2*wt					,h=l3);
}

module hole()
{
	translate([0,0,-e			]) cylinder(d=d1t,h=l1+2*e);
	translate([0,0,l1			]) cylinder(d1=d1t,d2=d2t,h=l2+e);
	translate([0,0,l1+l2		]) cylinder(d=d2t,h=l3+e);
}

difference()
{
	solid();
	hole();
}