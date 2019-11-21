height=20;
outerDiameter=17;
innerDiameter=13;
shaderSize=50;
shaderRadius=20;
shaderThickness=2;


difference() {
    cylinder(d=outerDiameter, h=height);
    cylinder(d=innerDiameter, h=height);
} 
hull() {
    cylinder(d=shaderRadius, h=shaderThickness);
    translate([shaderSize, 0, 0]) cylinder(d=shaderRadius, h=shaderThickness);
    translate([0, shaderSize, 0]) cylinder(d=shaderRadius, h=shaderThickness);
    translate([shaderSize, shaderSize, 0]) cylinder(d=shaderRadius, h=shaderThickness);
}
