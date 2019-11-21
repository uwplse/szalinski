// Diameter of pipe [mm] *default of 16 fits 1/2"
innerDiameter=16;

// Outer diameter of tool [mm]
outerDiameter=36;

// Thickness of tool [mm]
thickness=10;

difference() {
	cylinder(h=thickness,r=outerDiameter/2);
	translate([0,0,-0.5])
	cylinder(h=thickness+1,r=innerDiameter/2);
	translate([-outerDiameter,-((innerDiameter-1)/2),-0.5])
	cube([outerDiameter,innerDiameter-1,thickness+1]);
}
