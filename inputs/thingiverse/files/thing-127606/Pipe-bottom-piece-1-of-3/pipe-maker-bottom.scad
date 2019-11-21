outerDiameter = 30;
innerDiameter = 25;
length = 100;
roundness = 250;
jointLength = 20;
jointGap = 0.5;
cutOutWidth = 2;


difference(){
union(){
difference(){
	cylinder(r=outerDiameter/2,h=length,$fn=roundness);
	cylinder(r=innerDiameter/2,h=length,$fn=roundness);
}

translate([0,0,length])
	difference(){
		cylinder(
			r=(outerDiameter/2 -((outerDiameter/2-innerDiameter/2)/2) - jointGap/2),
			h=jointLength,
			$fn=roundness
		);
		cylinder(r=innerDiameter/2,h=jointLength,$fn=roundness);
	}
}

translate([-outerDiameter/2,-cutOutWidth/2,length])
	cube(size=[outerDiameter,cutOutWidth,jointLength]);

translate([-cutOutWidth/2,-outerDiameter/2,length])
	cube(size=[cutOutWidth,outerDiameter,jointLength]);
}