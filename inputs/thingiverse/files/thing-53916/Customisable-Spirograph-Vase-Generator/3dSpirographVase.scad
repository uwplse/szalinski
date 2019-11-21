// 3D Spirograph
// Paul Murrin - Jan 2013

// Hypotrochoid (roll around the inside) or epitrochoid (roll around the outside) 
isHypotrochoid = 1; // [1:Hypotrochoid, 0:Epitrochoid]
// (mm)
Radius_of_fixed_ring = 16;	
// (mm)
Radius_of_rotating_ring = 2;
// from center of rotating ring for the 'pen' (mm)
Distance = 8;
// Number of rotations around the fixed ring. 1 is OK if the ratio of fixed ring radius to rotating ring radius is integer, otherwise increase to complete the pattern. There is no advantage to increasing further.
turns = 1;
// (mm)
wallWidth = 0.8;
// Number of segments - large gives fine resolution, but very long render times.
// Note if the spirograph has a lot of lobes, detail will be lost with low settings.
Segments = 300;	// [100:coarse (100), 300:medium (300), 500:fine (500), 1000:very fine (1000) 
// Number of cycles of vertical twist
twistCycles = 0.4;
// Hight of vase (mm)
height = 50; // [1:200]
// Segment height (vertical). This controls the precision on twisted edges - too many layers also gives very long render times. Start with large layers and decide if you need to reduce it. 
layerHeight = 2; // [10:coarse (10mm), 5:medium (5mm), 2:fine (2mm)]
// Base thickness (mm) - can set zero if no base required.
baseThickness = 1; 

// Parameters controlling curve segment precision
$fa = 0.01+0;
$fs = 0.5+0; 


R1=Radius_of_fixed_ring;
R2=Radius_of_rotating_ring;
d=Distance;
N=Segments;
pi = 3.14159+0;
nEnd = turns*2*pi;
radToDeg = 360/(2*pi); 
nLayers = height/layerHeight;



function hypotrochoidX(r1,r2,a,d) = (r1-r2)*cos(a*radToDeg)+d*cos((r1-r2)*a*radToDeg/r2);
function hypotrochoidY(r1,r2,a,d) = (r1-r2)*sin(a*radToDeg)-d*sin((r1-r2)*a*radToDeg/r2);
function epitrochoidX(r1,r2,a,d) = (r1+r2)*cos(a*radToDeg)-d*cos((r1+r2)*a*radToDeg/r2);
function epitrochoidY(r1,r2,a,d) = (r1+r2)*sin(a*radToDeg)-d*sin((r1+r2)*a*radToDeg/r2);


module hypotrochoidSpirographSegment(theta1, theta2)
{
	assign(
		x1=hypotrochoidX(R1,R2,theta1,d),
		x2=hypotrochoidX(R1,R2,theta2,d),
		y1=hypotrochoidY(R1,R2,theta1,d),
		y2=hypotrochoidY(R1,R2,theta2,d)
		) 
	assign(				
		phi1 = atan2(y1,x1),
		phi2 = atan2(y2,x2)
	)
	{
		hull()
		{
			translate([x1,y1,0])
				circle(r=wallWidth/2, center=true);
			translate([x2,y2,0])
				circle(r=wallWidth/2, center=true);
		}		
	}
}


module epitrochoidSpirographSegment(theta1, theta2)
{
	assign(
		x1=epitrochoidX(R1,R2,theta1,d),
		x2=epitrochoidX(R1,R2,theta2,d),
		y1=epitrochoidY(R1,R2,theta1,d),
		y2=epitrochoidY(R1,R2,theta2,d)
		) 
	assign(				
		phi1 = atan2(y1,x1),
		phi2 = atan2(y2,x2)
	)
	{
		hull()
		{
			translate([x1,y1,0])
				circle(r=wallWidth/2, center=true);
			translate([x2,y2,0])
				circle(r=wallWidth/2, center=true);
		}		
	}
}


module hypotrochoidSpirograph()
{
	union() for (n=[0:N-1])
	{
		assign(a=n*nEnd/N, a2=(n+1)*nEnd/N)
		hypotrochoidSpirographSegment(a,a2);
	}
}


module epitrochoidSpirograph()
{
	union() for (n=[0:N-1])
	{
		assign(a=n*nEnd/N, a2=(n+1)*nEnd/N)
		epitrochoidSpirographSegment(a,a2);
	}
}


module spirographBase()
{
	hull() for (n=[0:N-1])
	{
		assign(a=n*nEnd/N, a2=(n+1)*nEnd/N)
		spirographSegment(a,a2);
	}
}


	
union() 
{
	if (isHypotrochoid==1)
	{
		linear_extrude(height=height,center=false,convexity=10,twist=twistCycles*2*pi*radToDeg, slices=nLayers)
			hypotrochoidSpirograph();
		cylinder(h=baseThickness, r1=R1-R2+d, r2=R1-R2+d);
	}
	else
	{
		linear_extrude(height=height,center=false,convexity=10,twist=twistCycles*2*pi*radToDeg, slices=nLayers)
			epitrochoidSpirograph();
		cylinder(h=baseThickness, r1=R1+R2+d, r2=R1+R2+d);
	}
}


