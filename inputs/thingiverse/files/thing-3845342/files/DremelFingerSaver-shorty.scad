$fn=72;

//The hole needs to be bigger that the end part of the attachment you will be using as it has to be mounted after tightening the tool. Maximum hole diameter is 16mm. I would make a couple of these, one for small bits about 4mm, one 16mm that allow sanding drums to go through.If you want to see the inside shape, enable Section parameter.
//The thread fits perfectly on my Practyl rotary tool that should match Dremel original one as all Dremel attachments works with it. Depending on your printing tolerances, you may need to adjust ThreadDiameter parameters by a few 10th of millimeters.
//The shaded part is a model of the end of the dremel mounted with an adjustable collet.
//Part 2 is a little fan to blow air out of the tool shaft hole.


ThreadDiameter=19;
ExitHoleDiameter=16;
GripGrooves=0;
FingerCuts=1;
Section=0;
SectionRotation=-50;
Version=1; //Version 0 have parametric holem version 1 and 2 has fixed hole diameters, respectively of 17.5 and 4mm
ShowDremel=0;


difference()
{
	union()
	{
		difference()
		{
			union()
			{
					cylinder(d=26,h=10,center=true);
			}
			
			translate([0,0,-5.01])
				linear_extrude(twist=-360*4,height=10.02)
					translate([0.75,0,0])
						circle(d=ThreadDiameter);
			
			for(a=[0:45:359])
				rotate([0,0,a])
					translate([0,-10,-22])
						rotate([0,45,45])
							translate([0,0,25])
								cylinder(d=3,h=30,center=true);

		}

		translate([0,0,-10])
			difference()
			{
				union()
				{
					if(Version==0 || Version==1)
						translate([0,0,31])
							scale([1,1,4])
								sphere(d=32);
					
					if(Version==2)
						translate([0,0,31])
							scale([1,1,4])
								sphere(d=30);
				}
			
			translate([0,0,65])
				cube([100,100,100],center=true);
			
			if(Version==0 || Version==1)
				translate([0,0,55])
					scale([1,1,6])
						sphere(d=27.5);
			
			if(Version==2)
				translate([0,0,55])
					scale([1,1,6])
						sphere(d=27.25);
			
			if(Version==0)
				cylinder(d=ExitHoleDiameter,h=100,center=true);
			
			if(Version==1)
				cylinder(d=20,h=100,center=true);
		
			if(GripGrooves==1 && Version==0)
			{	
				translate([0,0,0])
					rotate_extrude()
						translate([15,0,0])
							circle(d=3);
				translate([0,0,-5])
					rotate_extrude()
						translate([14.15,0,0])
							circle(d=3);
				translate([0,0,-10])
					rotate_extrude()
						translate([13.1,0,0])
							circle(d=3);
				translate([0,0,-15])
					rotate_extrude()
						translate([12,0,0])
							circle(d=3);
			}
			
			if(GripGrooves==1 && Version==1)
			{	
				translate([0,0,0])
					rotate_extrude()
						translate([15,0,0])
							circle(d=3);
				translate([0,0,-5])
					rotate_extrude()
						translate([14.15,0,0])
							circle(d=3);
				translate([0,0,-10])
					rotate_extrude()
						translate([13.1,0,0])
							circle(d=3);
			}
		
			for(a=[0:45:359])
				rotate([0,0,a])
					translate([0,-10,-12])
						rotate([0,45,45])
							translate([0,0,25])
								cylinder(d=3,h=30,center=true);
			
			if(Version==1)
				translate([0,0,-43])
					cylinder(d=100,h=50,center=true);

		}

		difference()
		{
			union()
			{
				if(Version==0)
					translate([0,0,-34])
						cylinder(d=23,h=10,center=true);
				
				if(Version==1)
					translate([0,0,-26])
						cylinder(d=26,h=10,center=true);
				
				if(Version==2)
					translate([0,0,-26])
						cylinder(d=0,h=10,center=true);
				
			}
			
			translate([0,0,45])
				scale([1,1,6])
					sphere(d=27.5);
			
			if(Version==0)
				translate([0,0,-31.9])
					rotate_extrude()
						translate([14,0,0])
							circle(d=10);
			
			if(Version==1)
				translate([0,0,-23.9])
					rotate_extrude()
						translate([16,0,0])
							circle(d=10);			
		}
	}
	
	if(FingerCuts==1 && Version==0)
	{
		translate([-1,-6,-9])
			rotate([0,50,0])
				rotate_extrude(angle=90)
					translate([29,0,0])
						circle(d=17.5);
		
		rotate([0,0,-70])
			translate([-1,6,-9])
				rotate([0,50,0])
					rotate_extrude(angle=-90)
						translate([29,0,0])
							circle(d=17.5);
		
		rotate([0,0,90])
			translate([-6,-8,-25.3])
				rotate([0,15,0])
					rotate_extrude(angle=90)
						translate([26,0,0])
							circle(d=15);
		
	}
	
	if(FingerCuts==1 && Version==1)
	{
		translate([1,-6.25,0])
			rotate([0,50,0])
				rotate_extrude(angle=85)
					translate([30,0,0])
						circle(d=17.5);
		
		rotate([0,0,-70])
			translate([1,6.25,0])
				rotate([0,50,0])
					rotate_extrude(angle=-85)
						translate([30,0,0])
							circle(d=17.5);
		
		rotate([0,0,90])
			translate([-6,-7,-17])
				rotate([0,15,0])
					rotate_extrude(angle=90)
						translate([30.5,0,0])
							circle(d=20);
	}
	
	if(FingerCuts==1 && Version==2)
	{
		translate([0,-5.5,-2])
			rotate([0,50,0])
				rotate_extrude(angle=85)
					translate([27,0,0])
						circle(d=15);
		
		rotate([0,0,-70])
			translate([0,5.5,-2])
				rotate([0,50,0])
					rotate_extrude(angle=-85)
						translate([27,0,0])
							circle(d=15);
		
		rotate([0,0,90])
			translate([-6,-7,-17])
				rotate([0,15,0])
					rotate_extrude(angle=90)
						translate([28.5,0,0])
							circle(d=20);
	}
	
	if(Version==0)
		cylinder(d=ExitHoleDiameter,h=100,center=true);
			
	if(Version==1)
		cylinder(d=17.5,h=100,center=true);
	
	if(Version==2)
		cylinder(d=4,h=100,center=true);
			
	if(Section==1)
		rotate([0,0,SectionRotation])
			translate([0,-50,0])
				cube([100,100,100],center=true);
}




//Dremel final part

if(ShowDremel==1)
	%color("Gray")
union()
	{
		
		translate([0,0,-5.01])
			linear_extrude(twist=-360*4,height=10.02)
				translate([0.75,0,0])
					circle(d=19);
		
		translate([0,0,-10.5])
			cylinder(d=8,h=11,center=true);
		
		translate([0,0,-10])
			cylinder(d=9.5,h=4.5,center=true);
		translate([0,0,-12.7])
			cylinder(d=11.5,h=1,center=true);
		translate([0,0,-18.7])
			cylinder(d=13,h=11,center=true);
		translate([0,0,-27.2])
			cylinder(d1=8,d2=13,h=6,center=true);
		
		translate([0,0,30])
			cylinder(d1=24,d2=50,h=50,center=true);
		translate([0,0,80])
			cylinder(d=50,h=50,center=true);
	}
