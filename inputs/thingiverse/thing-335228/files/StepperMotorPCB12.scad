// by Les Hall
// started Fri Aug 15 2014
// 


size = [35, 35, 1];
holeSpacing = 20;
holeDiameter = 2;
pinSpacing = 0.1 * 25.4;
pinDiameter = pinSpacing/2;
chipOffset = [0, 2, 0];
connectorOffset = [0, -6, 0];
transistorOffset = [11, 3, 0];
bobbinOffset = [14, -4.5, 0];
merge = 0.1;
$fn = 32;


difference()
{
	union()
	{
		// main pcb plate
		cube(size, center=true);
	}

	// mounting holes in four corners
	for (t=[0:3])
	assign(theta=45+360*t/4, radius=holeSpacing/2*sqrt(2))
	rotate(theta, [0, 0, 1])
	translate([radius, 0, 0])
	cylinder(d=holeDiameter, h=size[2]+merge, 
		center=true);

	// chip
	for (x=[-1:2:1], y=[-1.5:1.5])
	assign(dx=x*1.5*pinSpacing, dy=y*pinSpacing, 
		dx2=x*2.5*pinSpacing)
	translate(chipOffset)
	{
		translate([dx, dy, 0])
		cylinder(d=pinDiameter, h=size[2]+merge, 
			center=true);	
		translate([dx2, dy, 0])
		cylinder(d=pinDiameter, h=size[2]+merge, 
			center=true);	
	}
	translate([-pinSpacing, 2.25*pinSpacing, size[2]/2])
	cylinder(d=pinDiameter/2, h=size[2]/2, 
		center=true);

	// motor connector (header)
	for (x=[-1:1], y=[-0.5:0.5])
	assign(dx=x*pinSpacing, dy=y*pinSpacing)
	translate(connectorOffset)
	translate([dx, dy, 0])
	cylinder(d=pinDiameter, h=size[2]+merge, 
		center=true);

	// transistors
	for (t=[0:3], x=[-0.5:0.5], y=[-1:1])
	assign(theta=360*t/4, dx=x*pinSpacing, dy=y*pinSpacing)
	rotate(theta, [0, 0, 1])
	translate(transistorOffset)
	translate([dx, dy, 0])
	cylinder(d=pinDiameter, h=size[2]+merge, 
		center=true);
	for (t=[0:3])
	assign(theta=360*t/4)
	rotate(theta, [0, 0, 1])
	translate(transistorOffset)
	translate([pinSpacing, pinSpacing, size[2]/2])
	cylinder(d=pinDiameter/2, h=size[2]/2, 
		center=true);

	// bobbin connectors (headers)
	for (t=[0:3], x=[-0.5:0.5], y=[-0.5:0.5])
	assign(theta=360*t/4, dx=x*pinSpacing, dy=y*pinSpacing)
	rotate(theta, [0, 0, 1])
	translate(bobbinOffset)
	translate([dx, dy, 0])
	cylinder(d=pinDiameter, h=size[2]+merge, 
		center=true);
}






