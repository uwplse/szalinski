// Inner Width of Structure
ginnerWidth = 12;

// Outer Width of Structure
gouterWidth = 18;

// Width Gap (either side)
gwidthGap = 0.5;

// Cross over length
gcrossOver = 9;

//Display Male Bar
Display_Male_Bar = true; // [true,false]

//Display Female Bar
Display_Female_Bar = true; // [true,false]

// Bar Connect Male Structure
if(Display_Male_Bar) maleBar(100, ginnerWidth, gouterWidth, gcrossOver);

// Bar Connect Female Structure
if(Display_Female_Bar) translate([-20,0,0]) femaleBar(100, ginnerWidth, gouterWidth, gwidthGap, gcrossOver);


module maleCrossBar(length, innerWidth, outerWidth, crossOver)
{

	translate([0,length/2+(outerWidth/2),0]) maleBar(length, innerWidth, outerWidth, crossOver);
	rotate([0,0,90]) translate([0,length/2-(outerWidth/2),0]) maleBar(length, innerWidth, outerWidth, crossOver);
}


module maleBar(length, innerWidth, outerWidth, crossOver)
{
	screwHoleLength = outerWidth + 2;
	screwHoleWidth = 1.5;

	rotate([90,0,0]) translate([0,0,crossOver])
	difference()
	{
		union()
		{
			translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-crossOver]) cube([innerWidth,innerWidth,length]);
			cube([outerWidth,outerWidth,length - (crossOver*2)]);
		}

		translate([outerWidth/2,outerWidth+1,-crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,-crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([outerWidth/2,outerWidth+1,length-crossOver-(crossOver/2)]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,length-crossOver-(crossOver/2)]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);
	}
}

module femaleBar(length, innerWidth, outerWidth, widthGap, crossOver)
{
	screwHoleLength = outerWidth + 2;
	innerWidth = innerWidth+widthGap;
	screwHoleWidth = 1.5;

	rotate([90,0,0])
	difference()
	{
		cube([outerWidth,outerWidth,length]);

		translate([(outerWidth-innerWidth-widthGap)/2,(outerWidth-innerWidth-widthGap)/2,-1]) cube([innerWidth+widthGap,innerWidth+widthGap,crossOver+2]);

		translate([(outerWidth-innerWidth-widthGap)/2,(outerWidth-innerWidth-widthGap)/2,length-(crossOver)-1]) cube([innerWidth+widthGap,innerWidth+widthGap,crossOver+2]);

		translate([outerWidth/2,outerWidth+1,crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([outerWidth/2,outerWidth+1,length-(crossOver/2)]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,length-(crossOver/2)]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

	}
}

module hmaleBar(length, innerWidth, outerWidth, crossOver)
{
	screwHoleLength = outerWidth + 2;
	screwHoleWidth = 1.5;

	rotate([90,0,0]) translate([0,0,crossOver])
	difference()
	{
		union()
		{
			translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-crossOver]) cube([innerWidth,innerWidth,length]);
			cube([outerWidth,outerWidth,length - (crossOver)]);
		}

		translate([outerWidth/2,outerWidth+1,-crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,-crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);
	}
}

module hfemaleBar(length, innerWidth, outerWidth, widthGap, crossOver)
{
	screwHoleLength = outerWidth + 2;
	innerWidth = innerWidth+widthGap;
	screwHoleWidth = 1.5;


	rotate([90,0,0])
	difference()
	{
		cube([outerWidth,outerWidth,length]);

		translate([(outerWidth-innerWidth)/2,(outerWidth-innerWidth)/2,-1]) cube([innerWidth,innerWidth,crossOver+2]);

		translate([outerWidth/2,outerWidth+1,crossOver/2]) rotate([90,0,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

		translate([-1,outerWidth/2,crossOver/2]) rotate([0,90,0]) cylinder(screwHoleLength,screwHoleWidth,screwHoleWidth,$fn=100);

	}
}