innerDiameter=8;
outerDiameter=14;
play=0.5;
length=50;
hingeWidth=16;
hingeThickness=3;
boreDiameter=5;

translate([0,-outerDiameter,0]){
rotate(-90,[0,1,0]){
difference(){
union(){
translate([0,-hingeThickness/2,-hingeWidth]){
cube([length/2,hingeThickness,hingeWidth+outerDiameter/2]);
}
translate([0,0,outerDiameter/2]){
rotate(90,[0,1,0]){
union(){
    cylinder(h=length-(outerDiameter-innerDiameter)/2, d=innerDiameter);
    cylinder(h=length/2, d=outerDiameter);
}
}
}
}
translate([boreDiameter,hingeThickness/2+1,-hingeWidth/2]){
rotate(90,[1,0,0]){
cylinder(hingeThickness+2,d=boreDiameter);
translate([length/2-2*boreDiameter,0,0]){
    cylinder(hingeThickness+2,d=boreDiameter);
}
}
}
}
}
}


translate([0,outerDiameter,length/2]){
rotate(90,[0,1,0]){
difference(){
union(){
translate([0,-hingeThickness/2,-hingeWidth]){
cube([length/2,hingeThickness,hingeWidth+(outerDiameter-innerDiameter)/2]);
}
translate([0,0,outerDiameter/2]){
rotate(90,[0,1,0]){
difference(){
cylinder(h=length/2,d=outerDiameter);
cylinder(h=length/2-(outerDiameter-innerDiameter)/2, d=innerDiameter+play);
}
}
}
}
translate([boreDiameter,hingeThickness/2+1,-hingeWidth/2]){
rotate(90,[1,0,0]){
cylinder(hingeThickness+2,d=boreDiameter);
translate([length/2-2*boreDiameter,0,0]){
    cylinder(hingeThickness+2,d=boreDiameter);
}
}
}
}
}
}