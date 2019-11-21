echo("------------------------ BEGIN ------------------------");
// Colors: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#hull
// HELP:   http://www.openscad.org/cheatsheet/index.html
//////////////////////////////////////////////////////////////////////////////////////////////


TotalHeight = 130;

OverallThickness = 20;
BaseThickness = 7;
MicHolderThickness = 2;

MicHeight = 13.5;
MicDiameter = 8;

Precision = 100;

//////////////////////////////////////////////////////////////////////////////////////////////
MicFocalPoint = MicHeight;  // by setting this the same height as the mic can be inserted then the base of the mic will be equal to the base of the main cylinder
MicHolderDiameter = MicDiameter+(2*MicHolderThickness);
//////////////////////////////////////////////////////////////////////////////////////////////

difference()
{
	BowlHeight = TotalHeight - BaseThickness;
	BowlFocalPoint = MicFocalPoint - BaseThickness;
	
	difference()
	{
		union()
		{
			translate([0,0,MicFocalPoint-MicHeight])
			cylinder(h = MicHeight, r1 = (MicDiameter/2)+OverallThickness, r2 = (MicDiameter/2)+OverallThickness,  $fn=Precision);
		
			translate([0,0,BaseThickness])
			translate([0,0,-OverallThickness])
			paraboloid(y=BowlHeight,f=BowlFocalPoint,fc=0,detail=Precision);
		}
		
		translate([0,0,BaseThickness])
			paraboloid(y=BowlHeight,f=BowlFocalPoint,fc=0,detail=Precision);
	}	
	
	// CUTOUT FOR MIC
	color("green")
		translate([0,0,MicFocalPoint-MicHeight-9])
			cylinder(h = MicHeight+10, r1 = MicDiameter/2, r2 = MicDiameter/2,  $fn=Precision);
	
	translate([-100,-100,-50])
		cube([200,200,50]);
}

// FAKE MIC
//color("green")
//cylinder(h = MicHeight, r1 = MicDiameter/2, r2 = MicDiameter/2,  $fn=Precision);
		
//////////////////////////////////////////////////////////////////////////////////////////////
module ParabolicCylinder(PC_Height,PC_FocalPoint,PC_BowlThickness, PC_BaseThickness,PC_FocusSize,PC_Precision)
{
	BowlHeight = PC_Height - PC_BaseThickness;
	BowlFocalPoint = PC_FocalPoint - PC_BaseThickness;

	Diameter = 2*BowlFocalPoint*sqrt(BowlHeight/BowlFocalPoint);
	Width = Diameter + (PC_BowlThickness*2);

	difference()
	{
		cylinder(h = PC_Height-0.005, r1 = Width, r2 = Width,  $fn=Precision);
		
		translate([0,0,PC_BaseThickness])
			paraboloid (y=BowlHeight,f=BowlFocalPoint,fc=0,detail=Precision);
	}
	
	color("red")
		translate([0,0,PC_FocalPoint])
			sphere(d=PC_FocusSize, $fn=Precision);
}		
		
//////////////////////////////////////////////////////////////////////////////////////////////
module paraboloid (y=10, f=5, rfa=0, fc=1, detail=44)
{
	// y = height of paraboloid
	// f = focus distance 
	// fc : 1 = center paraboloid in focus point(x=0, y=f); 0 = center paraboloid on top (x=0, y=0)
	// rfa = radius of the focus area : 0 = point focus
	// detail = $fn of cone

	hi = (y+2*f)/sqrt(2);								// height and radius of the cone -> alpha = 45° -> sin(45°)=1/sqrt(2)
	x =2*f*sqrt(y/f);									// x  = half size of parabola
	
   translate([0,0,-f*fc])								// center on focus 
   {
		rotate_extrude(convexity = 10,$fn=detail )		    // extrude paraboild
		translate([rfa,0,0])								// translate for fokus area	 
		difference()
		{
			union()
			{						                         					// adding square for focal area
				projection(cut = true)													// reduce from 3D cone to 2D parabola
					translate([0,0,f*2])                                                // translate for cutting
						rotate([45,0,0])				          						// rotate cone 45° 
							translate([0,0,-hi/2])                                      // center cone on tip
								cylinder(h= hi, r1=hi, r2=0, center=true, $fn=detail);   	
				translate([-(rfa+x ),0]) 
					square ([rfa+x , y ]);											    // focal area square
			}
		
			translate([-(2*rfa+x ), -1/2])
				square ([rfa+x ,y +1] );                                                // cut of half at rotation center 
		}
	}
}

echo("------------------------- END -------------------------");