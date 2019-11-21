// Caliper (c) 2013 Wouter Robers

include <write/Write.scad>;



Length=170;
Width=15;
Thickness=2;
//Scale for calibration. You can use 1.01 for example to calibrate the scale. For Inches take 25.4. 
Scale=1;
//For Inches take 1;
UnitNumbersEvery=10;
//For Inches take 16
Subdivisions=10;
ScaleThickness=.7;
//How loose do the pieces need to fit together?
Clearance=1.2;
// This parameter compensates for filament width in some Printers (e.g. Makerbot Replicator).
Offset=0.15;


color([0.8,0.8,0.8]) {
difference() {
union() {
// Main body
cube([Length,Width,Thickness]);
rotate([45,0,0]) cube([Length,Thickness/sqrt(2),Thickness/sqrt(2)]);
translate([0,Width,0]) rotate([45,0,0]) cube([Length,Thickness/sqrt(2),Thickness/sqrt(2)]);

//Top Caliper
linear_extrude(height = Thickness) polygon([[0,0],[-Offset,0],[-Offset,-40],[-10,-30],[-20,0],[-20,Width],[-15+Offset,Width],[-15+Offset,Width+15],[-10,Width+5],[-10,Width],[0,Width]]);

}

// Main Body Scale
for(i=[0:Scale*UnitNumbersEvery/Subdivisions:Length-Scale*UnitNumbersEvery/Subdivisions]){translate([i+1,-1,Thickness-ScaleThickness]) cube([0.3,Width*StripeLenght(i/Scale),ScaleThickness*2]);}

// Main Body Scale Numbers
for(i=[0:Scale*UnitNumbersEvery:Length-Scale*UnitNumbersEvery]){
translate([i+2,Width/1.5,Thickness-ScaleThickness]) write(str(floor(i/Scale)),h=Width/4,t=ScaleThickness*2,font="write/Letters.dxf");
echo(i);
}
}




//Slider bottom part
translate([30,-30-Width,0]) linear_extrude(height = Thickness) polygon([[Offset,-Thickness],[Offset,-40],[10,-30],[20,-Thickness],[50,-Thickness],[50,Width+Thickness+Clearance],[-15-Offset,Width+Thickness+Clearance],[-15-Offset,Width+15],[-20,Width+10],[-20,-Thickness]]);







//Slider top part
difference(){
union(){
//Thumb grip
translate([75,-30-Thickness-Width]) cylinder(r=4,h=Thickness);



translate([30,-30-Width,Thickness]) linear_extrude(height = Thickness) polygon([[Offset,-Thickness],[Offset,-40],[10,-30],[20,-Thickness],[50,-Thickness],[50,Width+Thickness+Clearance],[0,Width+Thickness+Clearance]]);
}
// Scale Slider
translate([30+1,-30-Width,0]) for(i=[0:Subdivisions]){
translate([i*Scale*UnitNumbersEvery/Subdivisions*1.9,-StripeLenght(i)*4,Thickness*2-ScaleThickness]) cube([0.3,Width,ScaleThickness*2]);}

translate([30,-30-Width,Thickness]) {
translate([-1,0,0]) cube([60,Width+Clearance,Thickness*2]);
rotate([45,0,0]) cube([60,Thickness/sqrt(2),Thickness/sqrt(2)]);
translate([0,Width+Clearance,0]) rotate([45,0,0]) cube([60,Thickness/sqrt(2),Thickness/sqrt(2)]);
}
}
}

function StripeLenght(Value)=0.4+0.3*floor(1/(((Value)%10)+1))+0.25*floor(1/(((Value)%5)+1))+0.05*floor(1/(((Value)%2)+1));
