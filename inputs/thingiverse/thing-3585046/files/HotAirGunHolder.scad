$fn=50;

diameter = 82;
handleThickness = 37;
height = 25;

mountingScrewDiameter = 5;

materialThickness = 5;

difference()
{
	cylinder(d=diameter + materialThickness*2, h=height);
	translate([0,0,-1])
		cylinder(d=diameter, h=height+2);	
	translate([-handleThickness/2,-diameter/2-materialThickness-1,materialThickness*2])
		cube([handleThickness, materialThickness*2+1, height-materialThickness+1]);
}

translate([-diameter/4,diameter/2,-height])
	difference()
	{
		cube([diameter/2, materialThickness, 3*height]);
		
		translate([diameter/8,materialThickness+1,height/2])
			rotate([90,0,0])
				cylinder(h=materialThickness+2, d=mountingScrewDiameter*1.2);
		
		translate([3*diameter/8,materialThickness+1,height/2])
			rotate([90,0,0])
				cylinder(h=materialThickness+2, d=mountingScrewDiameter*1.2);
		
		translate([diameter/8,materialThickness+1,5*height/2])
			rotate([90,0,0])
				cylinder(h=materialThickness+2, d=mountingScrewDiameter*1.2);
		
		translate([3*diameter/8,materialThickness+1,5*height/2])
			rotate([90,0,0])
				cylinder(h=materialThickness+2, d=mountingScrewDiameter*1.2);
	}