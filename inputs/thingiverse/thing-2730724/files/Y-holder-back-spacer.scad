/*
 * Customizable spacer rear Y motor Holder to Nema 17 motor for Tatara steel frame V100 - https://www.thingiverse.com/thing:2730724
 * by TataraTeam - https://www.thingiverse.com/TataraTeam/about
 * created 2017-12-25
 * version v0.01
 *
 * Changelog
 * --------------
 * v0.01:
 *      - First version
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - NonCommercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

//preview[view:north, tilt:top]

// Y rear bracket to NEMA 17 motor distance in mm
ytrb=2.3;
// 3D Printed part Wall thickness in mm
wt = 2; //[2:0.4:4]
// Material frame thickness in mm )
mt=3;
// Clearance in mm
clearance=0.2; 
/* [Hidden] */
ybmh=6;

difference() {
cube(size = [wt+mt+clearance+wt, ytrb+ybmh, 20], center = false);
translate([wt, ytrb ,0])
     cube(size = [mt+clearance, ybmh, 20], center = false);
}