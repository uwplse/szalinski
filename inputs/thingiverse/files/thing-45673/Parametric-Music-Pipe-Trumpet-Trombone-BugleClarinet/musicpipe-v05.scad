//Length of the music pipe (section) you want to make
BellLength=200;

//How many mm from the asymptote rim of the bell do you want to start you section? For a trumpet around 5 seems to be fair. You can also change this to BellLength+SectionOffset (e.g. 205, to get the next section of pipe.
SectionOffset=5;

// The shape of the music pipe is according to the folling formula: Radius=B/(x+offset)^a. Factor B mostly influences the size of the bell at the middle.
Factor_B=310;

Factor_x0=SectionOffset;

//Coefficient mostly influences the diameter at the small end of the pipe.
Coefficient_a=0.5;
PipeThickness=1;
ElementsPerMillimeter=0.2; // [0.01,0.02,0.05,0.1,0.2,0.5,1]
ConnectionSleeve="Yes"; //[Yes,No]

union(){
	difference()
	{
		bell(PipeThickness);
		bell(0);
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
	// Uniting a series of cylinders
	union()
	{
		// Number of cylinders
		for ( i = [0 : 1/ElementsPerMillimeter : BellLength-1/ElementsPerMillimeter] )
		{
		translate([0,0,i]) cylinder(h=1/ElementsPerMillimeter,r1=Factor_B/pow((i+Factor_x0),Coefficient_a)/2+PipeRadiusOffset,r2=Factor_B/pow((1/ElementsPerMillimeter+i+Factor_x0),Coefficient_a)/2+PipeRadiusOffset);
echo(i);
		}
	}
}