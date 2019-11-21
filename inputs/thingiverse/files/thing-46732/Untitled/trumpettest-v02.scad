
// (c) 2013 Wouter Robers

SizeX=200;
SizeY=140;

PlatformSizeX=SizeX/2;
PlatformSizeY=SizeY/2;

NumberOfTurns=2.2;

HelixFactor=.15;


//How many mm from the asymptote rim of the bell do you want to start you section? For a trumpet around 5 seems to be fair. You can also change this to BellLength+SectionOffset (e.g. 205, to get the next section of pipe.
SectionOffset=105;

// The shape of the music pipe is according to the folling formula: Radius=B/(x+offset)^a. Factor B mostly influences the size of the bell at the middle.
Factor_B=310;

Factor_x0=SectionOffset;

//Coefficient mostly influences the diameter at the small end of the pipe.
Coefficient_a=0.5;
PipeThickness=0;
NumberOfElements=100;
ConnectionSleeve="No"; //[Yes,No]

union(){
	difference()
	{
		bell(PipeThickness);
		//bell(0);
	}
	if (ConnectionSleeve=="Yes")
	{
		difference()
		{
			translate([0,0,BellLength-1]) cylinder(h=5,r1=Factor_B/pow((BellLength+Factor_x0),Coefficient_a)/2+PipeThickness+.5,r2=Factor_B/pow((BellLength+Factor_x0),Coefficient_a)/2+2*PipeThickness+0.5);
			translate([0,0,BellLength-1]) cylinder(h=5+0.1,r=Factor_B/pow((BellLength+Factor_x0),Coefficient_a)/2+PipeThickness,r2=Factor_B/pow((BellLength+Factor_x0),Coefficient_a)/2+PipeThickness+0.5);
		}
	}
}
module bell(PipeRadiusOffset)
{
$fa=30;
	// Uniting a series of cylinders
	union()
	{
		// Number of cylinders
		for ( i = [0 : 360*NumberOfTurns/NumberOfElements : NumberOfTurns * 360] )
		{
		translate([PlatformSizeX*sin(i)*(1-sqrt(HelixFactor*i/360)),PlatformSizeY*cos(i)*(1-sqrt(HelixFactor*i/360)),i*0.02]) 
		sphere(Factor_B/pow((i/360*3.14*sqrt(2*(pow(PlatformSizeX,2)+pow(PlatformSizeY,2)))+Factor_x0),Coefficient_a)/2+PipeRadiusOffset);
echo(i/360*3.14*sqrt(2*(pow(PlatformSizeX,2)+pow(PlatformSizeY,2))));
		}
	}
}