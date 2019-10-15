/* Customizable PCB or Hard Drive Carry Case
 * Author: Brhubbar - https://www.thingiverse.com/brhubbar/about
 * Date Created: 10/9/2019
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */
 
 
  // Parameters
  
/* [Left Dimensions (mm)] */
// Measure from base to bottom surface to be gripped. (L1+L2+L3 must sum to the same value as R1+R2+R3).
L1 = 7;

// Measure thickness of surface to be gripped.
L2 = 1  ;

// Measure from top of surface to be gripped to tallest component on PCBA.
L3 = 8;


/* [Right Dimensions (mm)] */
// Measure from base to bottom surface to be gripped.
R1 = 2;

// Measure thickness of surface to be gripped.
R2 = 6;

// Measure from top of surface to be gripped to tallest component on PCBA.
R3 = 8;


/* [Other Dimensions] */
// PCB Width [mm] (open face width).
width = 40;

// PCB Length [mm] (clamped dimension).
length = 70;

// shell_thickness Thickness [mm].
shell_thickness = 2;

// tolerance [mm].
tolerance = 0.2;

// preview[view:north east, tilt:top diagonal]

  // Build
  
CustomCase(L1, L2, L3, R1, R2, R3, width, length, shell_thickness, tolerance);
  // Modules
  
module CustomCase(L1, L2, L3, R1, R2, R3, width, length, shell_thickness, tolerance) {
  assert(R1 + R2 + R3 == L1 + L2 + L3, "Error: Sum of Left Dimensions must equal Sum of Right Dimensions");
  
  height = R1 + R2 + R3 + tolerance;
  
  translate([-width/2, height/2, 0])rotate([90, 0, 0]){
    difference(){
      Case_Body(width, length, height, shell_thickness, tolerance);
      PCB(L1, L2, R1, R2, width, length, height, shell_thickness, tolerance);
    }
  }
}

module PCB(L1, L2, R1, R2, width, length, height, shell_thickness, tolerance) { 
  // Build the right part of the PCB with a toleranceerance to ensure the difference completely removes the surface. No toleranceerance is applied to the thickness of the PCB (want a good friction fit).
  rightOrigin = [0-tolerance/2, shell_thickness, shell_thickness + R1];
  rightDim = [shell_thickness+tolerance, length, R2];
  translate(rightOrigin)cube(rightDim);
  
  // Build the bulk of the PCB with a toleranceerance on the total height (extra clearance).
  middleOrigin = [shell_thickness, shell_thickness, shell_thickness-tolerance/2];
  middleDim = [width - 2*shell_thickness, length, height];
  translate(middleOrigin)cube(middleDim);
  
  // Build the left part of the PCB with a tolerance on the width, but not the thickness/height (same as right side).
  leftOrigin = [width - shell_thickness - tolerance/2, shell_thickness, shell_thickness + L1];
  leftDim = [shell_thickness+tolerance, length, L2];
  translate(leftOrigin)cube(leftDim);
}

module Case_Body(width, length, height, shell, tolerance) {
  union(){
    caseOrigin = [0, 0, 0];
    caseDim = [width, length + shell - tolerance, height + 2*shell];
    translate(caseOrigin)cube(caseDim);
  }
}