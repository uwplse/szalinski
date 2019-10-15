// Quick XY calibration

// You need to measure the distance between either inside of small rectangle to inside of big rectangle or outside of small rectangle to outside of big rectangle.
// Let the thing on print surface when you measure it. 
// published here https://www.thingiverse.com/thing:3655905
   
// Edit the part between the scissors 
// ------8<------------------------

//Calibration on X direction, the larger the better accuracy
XSize = 100;
//Calibration on Y direction, the larger the better accuracy
YSize = 100;
//Line width, the same as in slicer.
LWidth = 0.44;
//Line multiplier, the same as wall line count in slicer.
LMul = 4; 

// ------8<------------------------

difference() {
cube([10+XSize+LWidth*LMul,10+YSize+LWidth*LMul,0.2],false);
translate([LWidth*LMul,LWidth*LMul,0])    
cube([10+XSize-LWidth*LMul,10+YSize-LWidth*LMul,0.2],false);
}    
difference() 
{
    cube([10+LWidth*LMul,10+LWidth*LMul,0.2],false);
    translate([LWidth*LMul,LWidth*LMul,0])    
    cube([10-LWidth*LMul,10-LWidth*LMul,0.2],false);
}    
