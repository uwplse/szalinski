// Velcro-like fastener
// (c) Wouter Robers

// Width of your fastener in mm
Width=10; 

// Length of your fastener in mm
Length=20;

// Notch Size. This makes determines the holding force. For me 140 was a bit loose and 150 was really tight. 
NotchSize=145; // [130:160]

Fastener();

module Fastener(){
NotchDiameter=NotchSize/100;
PlatformHeight=0.7;
NotchDistance=2;
NotchHeight=1.3;
NotchShape=0.9;
$fn=12;

cube([Width,Length,PlatformHeight]);

for(i=[1:NotchDistance:NotchDistance*floor(Width/NotchDistance)]){
for(j=[1:NotchDistance:NotchDistance*floor(Length/NotchDistance)]){
translate([i,j,PlatformHeight]) cylinder(r1=NotchShape*NotchDiameter/2,r2=NotchDiameter/2,h=NotchHeight);
translate([i,j,PlatformHeight+NotchHeight]) cylinder(r1=NotchDiameter/2,r2=0,h=NotchHeight*0.3);

}
}
}