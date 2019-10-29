// Design and code by Josh Werblin (https://www.thingiverse.com/jwerblin/designs)

// Magnet/Pin Capillary Holder for SBC X-Ray Crystallography Beam-line

//2017-08-17: First design --JW

//  Use your printing software to find out the last layer where the top is open and pause the print on that layer. Once paused, push the magnet into place and then continue print.

// This can be printed with or without the groove.

//  This can also be printed with an open bottom so you can push in the magnet from the bottom. If you want this, turn "Embedded" to false. If you do this, you may still want to stop the print and place the magnet in place as a way to hold up the plastic, as most printers can't print a flat cover over an empty cylinder hole. You may also want to make the MagnetShellRadiusTol a bit bigger to be able to slide in and out the magnet. With default settings it is pretty snug.


// PRO-TIPS:
// -Use your software to manually move the print head away from the print when it is paused so you do not melt the print.
// -Keep the magnet on the print-bed so it heats up and can be printed on more easily
// -My printer struggled to print onto the magnet, so be prepared to stick a poker of some sort (I used metal forceps) to squish down the hot plastic over the magnet for the first couple layers over it. This will likely mess up your groove, so you may want to set "Groove" to "false".

// VARIABLES:

// Size of nozzle
SizeOfNozzle = 0.4; // size of nozzle

// Things you may want to customize
Embedded = true;
Groove = true;
TotalFrameWidth = 52; // 52 mm
TotalFrameHeight = 78.2; // 78.2 mm
ColumnWidth = 3.5; // 3.5 mm
FrameThicknessInLayers = 3; // 3 layers
$fn = 36; // Minimum number of sides for all circles except arches


// Things you probably want to keep the same
MagnetShellRadius = 4.7; // 4.7 mm
MagnetShellRadiusTol = 0; // 0 mm
MagnetStemRadius = 1.75; // 1.75 mm
MagnetStemRadiusTol = 0.2; // 0.2 mm

MagnetTotalHeight = 7.4; // 7.4 mm
MagnetThickness = 3.5; // 3.5 mm
MagnetThicknessTol = 0.2; // 0.2 mm
MagnetStemHeight = MagnetTotalHeight - MagnetThickness; // 3.9 mm

PinOuterRadius = 5.9; // 5.9 mm
PinInnerRadius = 4.85; // 4.85 mm 
PinGrooveWidthTol = 0.35; // 0.35 mm
PinGrooveDepth = 1; // 1 mm
PinHolderWallHeight = 4; // 4 mm

MagnetHolderWall = 1; // 1 mm (the wall space around the magnet)
PinMagnetGapInLayers = 3; // 3 layers (# of layers that covers magnet. Groove is cut into this 



//////////////////////////////////////////
FrameThickness = FrameThicknessInLayers * SizeOfNozzle;
PinMagnetGap = PinMagnetGapInLayers * SizeOfNozzle;
PinHolderWallThick = (PinOuterRadius+MagnetHolderWall) - (PinOuterRadius+PinGrooveWidthTol);
//////////////////////////////////////////


if (Embedded == false){
        base(MagnetShellRadius+MagnetShellRadiusTol);
    }
    else{
        base(MagnetStemRadius+MagnetStemRadiusTol);
    }
    
arch();
mirror([0,1,0]) arch();
columns();


module base(Hole){
    difference(){
        hull(){
             cylinder( r = PinOuterRadius + MagnetHolderWall, h = MagnetTotalHeight + PinMagnetGap );
             translate([-FrameThickness/2,PinOuterRadius+MagnetHolderWall,0]){
                cube([FrameThickness, TotalFrameWidth/2-PinOuterRadius-MagnetHolderWall-ColumnWidth, MagnetTotalHeight + PinMagnetGap]);
             }
             mirror([0,1,0]){
                 translate([-FrameThickness/2,PinOuterRadius+MagnetHolderWall,0]){
                cube([FrameThickness, TotalFrameWidth/2-PinOuterRadius-MagnetHolderWall-ColumnWidth, MagnetTotalHeight + PinMagnetGap]);
                }
            }
        }
        
        cylinder( r = Hole, h = MagnetStemHeight);
        translate([0,0,MagnetStemHeight]){
            cylinder( r = MagnetShellRadius+MagnetShellRadiusTol, h = MagnetThickness + MagnetThicknessTol );
        }
        if (Groove==true){
            translate([0,0,MagnetTotalHeight+PinMagnetGap-PinGrooveDepth]){    
                difference(){
                    cylinder( r = PinOuterRadius+PinGrooveWidthTol, h = PinGrooveDepth );
                    cylinder( r = PinInnerRadius, h = PinGrooveDepth );
                }
            }
        }
    }
    
    translate([0,0,MagnetTotalHeight+PinMagnetGap]){
        difference(){
            cylinder( r = PinOuterRadius+PinGrooveWidthTol+PinHolderWallThick, h = PinHolderWallHeight );
        cylinder( r = PinOuterRadius+PinGrooveWidthTol, h = PinHolderWallHeight );
        }
    }
}

module columns(){
    translate([-FrameThickness/2, TotalFrameWidth/2-ColumnWidth,0]){
        cube([FrameThickness, ColumnWidth, TotalFrameHeight]);
    }
    mirror([0,1,0]){
        translate([-FrameThickness/2, TotalFrameWidth/2-ColumnWidth,0]){
        cube([FrameThickness, ColumnWidth, TotalFrameHeight]);
        }
    }
}

module arch(){
    translate([-FrameThickness/2,3*TotalFrameWidth/2,TotalFrameHeight-sqrt(pow(2*TotalFrameWidth,2)-pow(3/2*TotalFrameWidth,2))]){
        rotate([0,90,0]){
            difference(){
                cylinder( r = 2*TotalFrameWidth, h = FrameThickness, $fn=50 );
                cylinder( r = 2*TotalFrameWidth-ColumnWidth, h = FrameThickness, $fn=50 );
                translate([0, -2*TotalFrameWidth,0]){
                    cube([2*TotalFrameWidth, 4*TotalFrameWidth, FrameThickness]);
                }
                translate([-2*TotalFrameWidth,-3*TotalFrameWidth/2,0]){
                    cube([2*TotalFrameWidth, 4*TotalFrameWidth, FrameThickness]);
                }
            }
        }
    }
}
