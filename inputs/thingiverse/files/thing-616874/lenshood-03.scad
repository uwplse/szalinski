length=4;
InnerDiameter=4;
radius=InnerDiameter/2;
//If wallThickness is larger than brimThickness than there will not be a brim.
wallThickness=0.1;
brimThickness=0.2;
brimLength=0.75;
//These holes were put in to be tapped. This is the mounting mechanism. Set holeDiameter to 0.0 if you do not want them.
holeDiameter=.09375;
holeOffset=.2;
numberOfHoles=4;
//Set to 0 if you do not want holes at the top of the lens hood. These were put in as a plan B should the holes at the bottom strip.
topHoles=1;
//Resolution
res=50;

difference()
{
	union()
	{
	cylinder(r=radius+wallThickness,h=length,$fn=res);
	cylinder(r=radius+brimThickness,h=brimLength,$fn=res);
	translate([0,0,length-brimLength])cylinder(r=radius+brimThickness,h=brimLength,$fn=res);
	translate([0,0,length-brimLength-brimThickness])
	cylinder(r=radius,r2=radius+brimThickness,h=brimThickness,$fn=res);
	translate([0,0,brimLength])
	cylinder(r=radius+brimThickness,r2=radius,h=brimThickness,$fn=res);
	}
	for(k=[0:topHoles])
	translate([0,0,k*(length-holeOffset*2)])
		{
		for(i=[1:numberOfHoles])
		rotate([0,0,i*360/numberOfHoles])
		translate([k*(radius+0.05),0,holeOffset])rotate([0,90,0])
		cylinder(h=radius+brimThickness+0.1,r=holeDiameter/2,$fn=res/3);
		}
	translate([0,0,-0.1])cylinder(r=radius,h=length+0.2,$fn=res);
}