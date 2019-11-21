include <tomasf.scad>

innerDiameterBottom = 70;
innerDiameterTop = 90;
innerHeight = 65;
wallThickness = 5;
bottomThickness = 5;

dimpleDepth = 1;
dimpleDiameter = 5;
// Set to 0 to disable dimples
dimpleColumns = 9;
dimpleRows = 3;


outerDiameterBottom = innerDiameterBottom + wallThickness*2;
outerDiameterTop = innerDiameterTop + wallThickness*2;
outerHeight = innerHeight + bottomThickness;
wallAngle = atan(outerHeight / ((outerDiameterTop-outerDiameterBottom) / 2));


difference() {
	cylinder(d1=outerDiameterBottom, d2=outerDiameterTop, h=outerHeight);
	translate([0, 0, bottomThickness]) {
		cylinder(d1=innerDiameterBottom, d2=innerDiameterTop, h=innerHeight+0.1);
	}
	
	dimpleStepAngle = 360 / dimpleColumns;
	dimpleStepHeight = outerHeight / (dimpleRows+1);
	
	if (dimpleColumns > 0 && dimpleRows > 0) {
		for (r = [1:dimpleRows]) {
			h = dimpleStepHeight * r;
			fraction = h / outerHeight;
			d = outerDiameterBottom + fraction * (outerDiameterTop-outerDiameterBottom);
			
			for (c = [1:dimpleColumns])
				rotate([0, 0, dimpleStepAngle*c])
					translate([d/2, 0, h])
						rotate([0, 180-wallAngle, 0])
							cylinder(d=dimpleDiameter, h=dimpleDepth*2, center=true);
		}
	}
}