// clam gauge
// Insane measurements, i.e, inches
use <write/Write.scad> 
// preview[view:south, tilt:bottom]

measurementSystem=0; //[0:Insane (inches), 1:Metric (mm)]

//The legal shell diameter -- enter mm if using metric, inches if using insane (AKA imperial) measurements.
legalSizeDiameter=1.5;


//THIS MEASUREMENT IN MM ONLY!  You can also use this setting to adjust the hole diameter to account for printing artifacts -- increasing the number makes the hole larger, decreasing (even negative) makes the diameter smaller.  
nozzleDiameter=0.5;

/* Private */
sizeText=str(legalSizeDiameter);
module metricGauge()
{

	difference()
	{
		hull() 
		{
			translate([0,0,0]) cylinder(r=((legalSizeDiameter/2)+10), h=4);
			translate([(legalSizeDiameter*1.4),0,0]) cylinder(r=10, h=4);
		}

		union()
		{
			translate([0,0,-1]) cylinder(r=((legalSizeDiameter/2)+nozzleDiameter), h=6);
			translate([(legalSizeDiameter*1.4),0,-1]) cylinder(r=5, h=6);

			if (legalSizeDiameter<=80)
			{	
				color("red") translate([(legalSizeDiameter*0.95),0,4.1]) write(sizeText,t=2,h=(6*legalSizeDiameter/25),rotate=90,center=true);
				color("red") translate([((legalSizeDiameter*0.95)-(5*legalSizeDiameter/25)),0,4.1]) write("mm",t=2,h=(3*legalSizeDiameter/25),rotate=90,center=true);
			} else {
				color("red") translate([(legalSizeDiameter*0.95),0,4.1]) write(sizeText,t=2,h=20,rotate=90,center=true);
				color("red") translate([((legalSizeDiameter*0.95)-21),0,4.1]) write("mm",t=2,h=16,rotate=90,center=true);
			}
		}
	}
}

module insaneGauge()
{

	difference()
	{
		hull() 
		{
			translate([0,0,0]) cylinder(r=((legalSizeDiameter/2/0.039)+10), h=4);
			translate([(legalSizeDiameter/0.039*1.4),0,0]) cylinder(r=10, h=4);
		}

		union()
		{
			translate([0,0,-1]) cylinder(r=(legalSizeDiameter/2/0.039), h=6);
			translate([(legalSizeDiameter/0.039*1.4),0,-1]) cylinder(r=5, h=6);
			if (legalSizeDiameter<=3)
			{	
				color("red") translate([(legalSizeDiameter/0.039*0.95),0,4.1]) write(sizeText,t=2,h=(6.6*legalSizeDiameter),rotate=90,center=true);
				color("red") translate([((legalSizeDiameter/0.039*0.95)-(7*legalSizeDiameter)),0,4.1]) write("IN",t=2,h=(4*legalSizeDiameter),rotate=90,center=true);
			} else {
				color("red") translate([(legalSizeDiameter/0.039*0.95),0,4.1]) write(sizeText,t=2,h=20,rotate=90,center=true);
				color("red") translate([((legalSizeDiameter/0.039*0.95)-21),0,4.1]) write("IN",t=2,h=16,rotate=90,center=true);
			}
		}
	}
}

module finalAssembly()
{

	//translate and rotate to place words on printbed for nice printing.
	translate([0,0,4])
	{
		rotate([180,0,0])
		{
			if (measurementSystem==1)
			{
				metricGauge();
			} else {
				insaneGauge();
			}
		}
	}
}

finalAssembly();

