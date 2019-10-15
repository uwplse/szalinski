// all measurements are in millimeters (mm)

// tolerance added to every hole diameter (mm)
tol = 0.6;		

// wall thickness (mm)
wt 		= 1.0; 	

// pipe/can outer diameter (mm)
d1 = 85.5;		
d1t = d1 + tol;	

// pipe/can inner diameter (mm)
d2 = 77.5;
d2t = d2 - tol;		

// outer length (mm)
l1 = 6.0;	
	
// inner length (mm)		
l2 = 6.0; 

// make cap?
makeCap = "no"; // [yes,no]

// make holes?
makeHoles = "no"; // [yes,no]

// dividers height (zero -> no dividers)
dh = 49.1;

// holes diameter (mm)		
hd = 4.0; // [4:12]

// difference in holes and solids to prevent (visual) glitches (mm)
e = 0.02*1;		

// smoothness
$fn = 128;	

module outerSolid()
{
	cylinder(d=d1t+2*wt,h=l1);
}

module outerHole()
{
	translate([0,0,wt]) cylinder(d=d1t,h=l1+2*e);
}

module innerSolid()
{
	cylinder(d=d2t,h=l1);
}

module innerHole()
{
	translate([0,0,-e			]) cylinder(d=d2t-2*wt,h=l1+2*e);
}

module holes()
{
	pi = 3.14159*1;
	m = floor(0.7*d2t/(1.1*hd+3));
	s = 0.53*d2t/m;
	for(i=[0:m-1])
	{
		d2 = i*s;
		k = 1+floor(2*pi * d2 / (1.2*hd+2)); 
		s2 = 360/k;
		for(j=[0:k])
		{
			rotate([0,0,i*s2/2+j*s2]) 
				translate([d2,0,-e])
					cylinder(d=hd,h=wt+2*e,$fn=3+5*hd);
		}
	}
}

union()
{
	difference()
	{
		union()
		{
			innerSolid();
			difference()
			{
				outerSolid();
				outerHole();
			}
		}
		innerHole();
	}	
	if(makeCap=="yes") 
	{
		difference()
		{
			
			cylinder(d=d2t-2*wt+2*e,h=wt);
			if(makeHoles=="yes") holes();
		}
	}
	if(dh>0.01)
	{
		translate([0,0,dh/2])
		{
			cube([d2t,wt,dh],center=true);
			cube([wt,d2t,dh],center=true);
		}
	}
}