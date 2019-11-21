// by Hank Cowdog
// 17 Jan 2018
// changes by ALittleSlow
// 18 Dec 2018
// * made pin length parametric
// * fixed parameter ranges to work better with customizer
//
// GNU General Public License, version 2
// http://www.gnu.org/licenses/gpl-2.0.html

// public-facing measurements are in Imperial (e.g. inches)
// Internally, mm are used

//pin thickness, inches
PinDiameterInches		= 0.25;   			//[0.0:0.05:0.75]

//Shelf Thickness,, in 1/16th inch increments
ShelfThicknessFracInches = 8;   //[1:1:16]

//pin length, inches
PinLength = 0.1875;
//
// No editing needed beyond this point
//

// pin is always 5mm
PinLengthMM = PinLength*25.4;

PinDiameterMM = PinDiameterInches*25.4;
PinRadiusMM = PinDiameterMM/2.0;

ShelfThicknessMM  = ShelfThicknessFracInches/16.0*25.4;

VertThicknessMM = 3.0*1;
HorBracketThicknessMM = 3.0*1;
HorBracketLengthMM = 15.0*1.0;
LengthBelowShelfMM = HorBracketLengthMM;

WedgeHeightMM = 15*1;
BarbThicknessMM=2*1;

Fudge =0.0000001*1;  //fudge factor to avoid 3D artifacts at edges when previewing

VertLengthMM = LengthBelowShelfMM + PinRadiusMM + ShelfThicknessMM + Fudge;

// Allow a small edge beyond the pin size, mostly for looks
PinOffsetMM = 1.0*1;

// at least 10mm high on print bed, even if very small pin
BracketHeightMM = max(PinDiameterMM + PinOffsetMM*2.0,10.0);

union() {
    
    //Draw the Vertical Support
    translate([-VertThicknessMM,-LengthBelowShelfMM,0])
    cube([VertThicknessMM,VertLengthMM,BracketHeightMM]);
    
    //Draw the Horizontal Support
    // using hull makes a nice transition from round bottom to flat top
    hull(){
    translate([Fudge-HorBracketLengthMM-VertThicknessMM,PinRadiusMM-HorBracketThicknessMM,0])
        cube([HorBracketLengthMM,HorBracketThicknessMM,BracketHeightMM]);
    
    translate([-HorBracketLengthMM-Fudge, -BracketHeightMM/2.0,BracketHeightMM/2.0])
        rotate([0,90,00]) cylinder(h=HorBracketLengthMM,r=PinRadiusMM,$fn=60);
    }
    
    // Draw the Pin
    translate([0, -Fudge,BracketHeightMM/2.0])
    rotate([0,90,00])cylinder(h=PinLengthMM,r=PinRadiusMM,$fn=60);
    
    
    // Draw the Wedge  - this sits above the shelf to hold it in place
    // using a wedge shape makes it easier to drop the shelf down onto
    // the bracket when installing
    translate([Fudge-VertThicknessMM-BarbThicknessMM,PinRadiusMM+ShelfThicknessMM,0]){
       // cube([WedgeThicknessMM,WedgeHeightMM,BracketHeightMM]);
       linear_extrude(height=BracketHeightMM)
       polygon(points=[
                     [0,0],
                     [BarbThicknessMM+VertThicknessMM,WedgeHeightMM],
                     [BarbThicknessMM+VertThicknessMM,0]
                     ]);        
    }
}
