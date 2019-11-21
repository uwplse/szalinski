/* 
*  Copyright (c)..: 2018 janpetersen.com
*
*  Creation Date..:08/24/2018
*  Description....: Temperature Tower
*
*  Rev 1: Intitial Release
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  If used commercially attribution is required (janpetersen.com)
*
*
*   Thingiverse Customizer documentation:
*   http://customizer.makerbot.com/docs
*
*
*/

/* ----- customizer view ----- */
//preview[view:south east, tilt:side]

/* ----- parameters ----- */

// Degrees to change between each step
tempStep = 5;
// Minimum temperature for the tower
minTemp = 195; // [190:1:260]
// Maximum temperature for the tower
maxTemp = 230; // [190:1:260]
// Hight of the base
baseHeight = 2; // [0.4:0.2:3]

/* [Hidden] */
$fn=60; // recomended value for smooth circle is 60
sectionHeight=10;

/* ----- execute ----- */

mainModule();

/* ----- modules ----- */

module mainModule() {
    z = baseHeight;
    secCount = floor((maxTemp - minTemp) / tempStep);
    
    translate([-15, -15, 0]) {
        base();
        for(i=[0:1:secCount]) {
            translate([0, 0, z+i*sectionHeight]) {
                difference() {
                    raiserBlock(maxTemp);
                    //emboss text
                    translate([10, 9, 5])
                        rotate([90, 0, 180])
                            linear_extrude(height = 1.2)
                                text(text=str(maxTemp-i*tempStep), font="Arial:style=Narrow Bold", size=7, valign="center", halign="center");
                }
                backPoles();
                bridges();
                spike();
            }
        }
    }
}


module base() {
    difference() {
        cube(size=[30, 30, baseHeight], center=false);
        translate([6, 10, -0.1])
            cube(size=[17.5, 20.5, baseHeight+0.2], center=false);
    }
}

module backPoles() {
    translate([1, 22.5, 0])
        cube(size=[5, 5, sectionHeight], center=false);
    translate([26, 25, 0])
        cylinder(d=5, h=sectionHeight);
}

module bridges() {
    translate([2.5, 5+2.5, sectionHeight])
        rotate(a=[-90, 0, 0])
            cube(size=[2, 1, 20], center=false);
    translate([2, 24, 0])
        rotate(a=[90, 0, 90])
            cube(size=[2, 1, 25], center=false);
}

module spike() {
    translate([15, 25, 1])
        cylinder(r1=1, r2=0, h=sectionHeight-3);
}

module raiserBlock(temp) {

    // left section of tower block
    translate([2.5, 2.5, 0])
        difference() {
            intersection() {
                cube(size=[12.5, sectionHeight/2, sectionHeight], center=false);
                translate([0, sectionHeight/2, 0])
                    rotate(a=[0, 90, 0])
                        cylinder(h=12.5, r=sectionHeight/2);
            }
        }
    
    //triangle
    translate([2.5, 2.5, sectionHeight])
        rotate(a=[0, 90, 0])
            linear_extrude(12.5)
                polygon(points=[[0, 0],[sectionHeight/2,sectionHeight/2],[0, sectionHeight/2]]);

    //backBlock
    translate([2.5, sectionHeight-2.5, 0])
        cube(size=[12.5, 2.5, sectionHeight], center=false);
    
    // Right section of tower block
    intersection() {
        difference() {
            translate([15, 2.5, 0])
                cube(size=[12.5, sectionHeight-2.5, sectionHeight], center=false);
            translate([30-2, 1, -2])
                rotate(a=[-90,0,0])
                    cylinder(h=sectionHeight, r=sectionHeight);
        }
        union() {
            translate([sectionHeight*2-5, 2.5, 0])
                cube(size=[2.5, sectionHeight-2.5, sectionHeight], center=false);
            translate([sectionHeight*2-2.5, sectionHeight+2.5, 0])
                cylinder(h=13, r=sectionHeight);
        }
    }

}
// End Modules