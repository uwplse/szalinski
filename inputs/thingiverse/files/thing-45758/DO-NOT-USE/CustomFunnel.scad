/*
 * CustomFunnel.scad:  A 3D printable parametric funnel
 * 
 * Written by Steven Morlock, smorloc@gmail.com
 *
 * This script is licensed under the Creative Commons Attribution - Share Alike license:
 *     http://creativecommons.org/licenses/by-sa/3.0/
 *
 */

//preview[view:south,tilt:top]

//CUSTOMIZER VARIABLES

// in millimeters
wall_thickness = 2.0;
// in millimeters
cone_height =  20; //[[1:200]]
// Funnel interior diameter in millimeters
cone_diameter =  50; //[[1:200]]
// in millmeters
neck_height = 40; //[[1:200]]
// Top of neck interior diameter in millimeters
neck_diameter = 10; //[[1:200]]
// Exit hole interiod diameter in millimeters
exit_diameter = 5; //[[1:50]]
// Handle diameter in millmeters
handle_diameter = 10; //[[1:50]]
// Hole in handle diameter in millmeters
handle_hole_diameter = 6; //[[1:50]]

//CUSTOMIZER VARIABLES END

WallThickness = wall_thickness;
NeckHeight = neck_height;
NeckDiameter = neck_diameter;
ConeHeight =  cone_height;
ConeDiameter =  cone_diameter;
ExitDiameter = exit_diameter;
HandleDiameter = handle_diameter;
HandleHoleDiameter = handle_hole_diameter;

makeFunnel();

module makeFunnel()
{
    // Funnel
    difference() {
        union() {
            // Outside of funnel
            funnel(
                    ConeHeight, 
                    ConeDiameter,
                    NeckHeight, 
                    NeckDiameter, 
                    ExitDiameter, 
                    WallThickness);
                    

            // Handle
            translate([ConeDiameter / 2 + WallThickness + HandleHoleDiameter / 2, 0, 0]) {
                difference() {
                    union() {
                        cylinder(WallThickness, r1 = HandleDiameter / 2, r2 = HandleDiameter / 2);
                        translate ([-HandleDiameter / 4, 0, WallThickness / 2]) {
                            cube([HandleHoleDiameter, HandleDiameter, WallThickness], center = true);
                        }
                    }
                    cylinder(WallThickness, r1 = HandleHoleDiameter / 2, r2 = HandleHoleDiameter/ 2);
                }
            }
        }
        
        // Interior of funnel
        funnel(
                ConeHeight, 
                ConeDiameter,
                NeckHeight, 
                NeckDiameter, 
                ExitDiameter, 
                0);
    }
}

module funnel(coneHeight, coneDiameter, neckHeight, neckDiameter, exitDiameter, wallThickness)
{
	union() {
        // Neck
		translate([0, 0, coneHeight]) {
			cylinder(
                    neckHeight, 
                    r1 = neckDiameter/2 + wallThickness, 
                    r2 = exitDiameter/2 + wallThickness);
		}
        // Cone
        cylinder(
                coneHeight, 
                r1 = coneDiameter/2 + wallThickness, 
                r2 = neckDiameter/2 + wallThickness);
	}
}
