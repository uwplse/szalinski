 /**************************************************************************\
 * This is a customizable core for twisty puzzles. Adjust it at your needs. *
 * ======================================================================== *
 *  Copyright © 2016 Tourdetour                                             *
 *                                                                          *
 *  This program is free software: you can redistribute it and/or modify    *
 *  it under the terms of the GNU General Public License as published by    *
 *  the Free Software Foundation, either version 3 of the License, or       *
 *  (at your option) any later version.                                     *     
 *                                                                          *
 *  This program is distributed in the hope that it will be useful,         *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *  GNU General Public License for more details.                            *
 *                                                                          *
 *  You should have received a copy of the GNU General Public License       *
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.   *
 \**************************************************************************/
 

/* [Global] */

//Length of each 3 cylinders
length=19;
//Diameter of the 3 cylinders
cylinders_diameter=8.5;
//Diamter of the holes in the cylinders for the screws. The x and y holes are tightend with "xyshrink" in the "Adjustments" tab. 
holes_diameter=2.8;



/* [Adjustements] */

//Number of sides to the cylinders (more sides means a higher precision)
$fn=50; // [20:200]
//Lower the diameter of x and y because it's too loose as it overhangs (change it to 0 if you don't print it with the default rotation). This highly depends on your printer, lower this setting if the x and y holes are too tight and increase it if they are too loose). 
xyshrink=0.4;


/* [Rotation] */

//Rotation on x axis
xrotat=0; // [0:1:90]
//Rotation on y axis
yrotat=0; // [0:1:90]

/* [Hidden] */
// A safety setting to prevent surfaces with no thickness (do not change this).
margin=0.1;


/* Main */ 

//Rotate and create the core
rotate([xrotat,yrotat,0]) core();

//Create the core
module core()
{
difference() // The difference drills the holes in the core
{
    
//Create the three cylinders, each of them rotated 90 degrees
union()
{
cylinder(r=cylinders_diameter/2,h=length,center=true);
rotate([0,90,0]) cylinder(r=cylinders_diameter/2,h=length,center=true);
rotate([90,0,0]) cylinder(r=cylinders_diameter/2,h=length,center=true);
}

//Create the three holes
union()
{
cylinder(r=holes_diameter/2,h=length+margin,center=true);
rotate([90,0,0]) cylinder(r=holes_diameter/2-xyshrink/2,h=length+margin,center=true);
rotate([0,90,0]) cylinder(r=holes_diameter/2-xyshrink/2,h=length+margin,center=true);
}

}
}