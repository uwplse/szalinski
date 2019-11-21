// Cusomizeable Simple Comb
// TrevM 17/09/2015

/* [Global] */

// What quality?
$fn = 50;	// [20,30,40,50,60,70,80,90,100]

// Width (mm) of back?
backWide = 5;	// [2:20]

// Width (teeth) of ends?
endWide = 0.75;	// [0.25:0.25:10.00]

// Tooth (mm) Diameter?
toothDia = 1.5;	// [0.5:0.1:10.0]

// Gap (mm) between teeth?
toothGap = 1.5;	// [0.5:0.1:10.0]

// Tooth (mm) length?
toothLen = 20;	// [5:30]

// Number of teeth?
numTeeth = 39;	// [5:100]

/* [Hidden] */
backLen = (numTeeth-1)*(toothDia+toothGap);
endLen = endWide*toothDia;

comb();

//translate([-((numTeeth*(toothGap+toothDia))+toothGap)/2,backWide+toothDia+2,0])
//	rotate([0,90,0])	cylinder(r=1,h=115);	

module comb()
{
	translate([-((numTeeth*(toothGap+toothDia))+toothGap)/2,0,toothDia/2])
	{
		// do teeth
		for(x=[1:numTeeth])
			translate([(x-1)*(toothGap+toothDia),toothDia/2,0])
				tooth();
		// left thick tooth
		translate([-(endWide*toothDia),toothDia/2,0])
		{
			tooth();
			translate([0,-toothLen+toothDia,0])
			{
				rotate([0,90,0])
					cylinder(d=toothDia,h=endWide*toothDia);
				translate([0,0,-toothDia/2])
					cube([endWide*toothDia,toothLen-toothDia,toothDia]);
			}
		}
		// right thick tooth
		translate([backLen,toothDia/2,0])
		{
			translate([endLen,0,0])	tooth();
			translate([0,-toothLen+toothDia,0])
			{
				rotate([0,90,0])
					cylinder(d=toothDia,h=endWide*toothDia);
				translate([0,0,-toothDia/2])
					cube([endLen,toothLen-toothDia,toothDia]);
			}
		}
		// do back
		translate([-endLen,0,0])
		{
			// left end
			rotate([-90,0,0])	cylinder(d=toothDia,h=backWide);
			translate([0,backWide,0])
			{
				// left back corner
				sphere(d=toothDia);
				// back edge
				rotate([0,90,0])	cylinder(d=	toothDia,h=backLen+(endLen*2));
			}
			// front edge
			rotate([0,90,0])	cylinder(d=	toothDia,h=backLen+(endLen*2));
			translate([backLen+(endLen*2),0,0])
			{
				// right back corner
				translate([0,backWide,0])	sphere(d=toothDia);
				// right end
				rotate([-90,0,0])	cylinder(d=	toothDia,h=backWide);
			}
			// back fill
			translate([0,0,-toothDia/2])	
				cube([backLen+(endLen*2),backWide,toothDia]);
		}
	}
}

module tooth()
{
	rotate([90,0,0])
	{
		cylinder(d=toothDia,h=toothLen-toothDia);
		translate([0,0,toothLen-toothDia])
			cylinder(d1=toothDia,d2=0.5,h=toothDia/2);
	}
}

	
