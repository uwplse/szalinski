/**
 * CO2 Laser Tube support - replacement mounts to suit Chinese laser mounts
 * that consist of a semicircular steel block with a central screw mount
 * that connects to an adjustable height widget
 *
 * Copyright © 2016 Alastair D'Silva
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details:
 * https://www.gnu.org/licenses/gpl.html
 *  
 */

tubeDiameter = 80;
grace = 3.5; // Allow for padding around the tube
supportWidth = 10; // How much material to use around the tube
supportThickness = 15; // How much material to use along the tube axis
mountingScrewShaftDiameter = 5; 
mountingScrewHeadRecess = 4.5; // depth of screw head, plus some fudge factor
mountingScrewHeadDiameter = 8; // diameter of screw head, plus some fudge factor

jointPilotDiameter = 2.1; // diameter of the pilot holes, this should be drilled & tapped for your chosen screw
jointScrewShaftDiameter = 3; // diameter of the joining screws
jointScrewHeadDiameter = 8; // diameter of the joining screw head recess
jointScrewHeadOffset = 5; // Thickness of the support material under the joint screw head, should be enough for a 45 degree countersink

top = false; // true if you want the top piece

tolerance = 0.01;
segments = 1000;

cutoutRadius = tubeDiameter / 2 + grace;
blockHeight = supportWidth + cutoutRadius;
blockWidth = 2 * (cutoutRadius + supportWidth);

wedgeWidth = 2 * (supportWidth + cutoutRadius - ((supportWidth + cutoutRadius) / sqrt(2)));
wedgePoints = [
    [tolerance / -2, tolerance / -2, tolerance / -2],
    [wedgeWidth, tolerance / -2, tolerance / -2],
    [tolerance / -2, tolerance / -2, wedgeWidth],
    [tolerance / -2, supportThickness + tolerance / 2, tolerance / -2],
    [wedgeWidth, supportThickness + tolerance / 2, tolerance / -2],
    [tolerance / -2, supportThickness + tolerance / 2, wedgeWidth],    
];

wedgeFaces = [
    [0,2,1],
    [0,1,4,3],
    [1,2,5,4],
    [0,3,5,2],
    [3,4,5]
];

difference() {
    cube([blockWidth, supportThickness, blockHeight]);  
    translate([blockWidth / 2, supportThickness + tolerance / 2, cutoutRadius + supportWidth])
        rotate([90, 0, 0])
            cylinder(h = supportThickness + tolerance, r = cutoutRadius, $fn = 100);
    polyhedron(wedgePoints, wedgeFaces);
    translate([blockWidth, 0, 0])
        mirror([1, 0, 0])
            polyhedron(wedgePoints, wedgeFaces);
    if (top) {
        translate([supportWidth / 2, supportThickness / 2, tolerance / -2])
            cylinder(h = blockHeight + tolerance, r = jointScrewShaftDiameter / 2, $fn = 100);        
        translate([supportWidth / 2, supportThickness / 2, -1 * jointScrewHeadOffset])
            union() {
                cylinder(h = blockHeight + tolerance, r = jointScrewHeadDiameter / 2, $fn = 100);
                translate([0, 0, blockHeight])
                    cylinder(h = jointScrewHeadDiameter / 2, r1 = jointScrewHeadDiameter / 2, r2 = 0, $fn = 100);
            };

        translate([blockWidth - supportWidth / 2, supportThickness / 2, tolerance / -2])
            cylinder(h = blockHeight + tolerance, r = jointScrewShaftDiameter / 2, $fn = 100);        
        translate([blockWidth - supportWidth / 2, supportThickness / 2, -1 * jointScrewHeadOffset])
            union() {
                cylinder(h = blockHeight + tolerance, r = jointScrewHeadDiameter / 2, $fn = 100);
                translate([0, 0, blockHeight])
                    cylinder(h = jointScrewHeadDiameter / 2, r1 = jointScrewHeadDiameter / 2, r2 = 0, $fn = 100);
            };            
    } else {
        // Mounting Screw
        translate([blockWidth / 2, supportThickness / 2, tolerance / -2])
            cylinder(h = blockHeight + tolerance, r = mountingScrewShaftDiameter / 2, $fn = 100);    
        translate([blockWidth / 2, supportThickness / 2, supportWidth - mountingScrewHeadRecess])
            cylinder(h = blockHeight, r = mountingScrewHeadDiameter / 2, $fn = 1000);

        // Pilot holes
        translate([supportWidth / 2, supportThickness / 2, tolerance / -2])
            cylinder(h = blockHeight + tolerance, r = jointPilotDiameter / 2, $fn = 100);        
        translate([blockWidth - supportWidth / 2, supportThickness / 2, tolerance / -2])
            cylinder(h = blockHeight + tolerance, r = jointPilotDiameter / 2, $fn = 100);        
    }
}