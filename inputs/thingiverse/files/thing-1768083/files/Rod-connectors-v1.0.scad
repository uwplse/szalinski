/* 
   Parametric ROD CONNECTOR - Ball joint to carbon fiber rod
   v1.0
*/

/*********************************************************************/
/*********************************************************************
Copyright (C) 2016  Alejandro Véliz Fernández

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/
/********************************************************************/

/* Configuration params */
// Rod diameter
Rodiam = 6.2;
// Rod length (rod length that goes into the part)
Rodlen = 12.5;
// End Rod diameter
EndRodiam = 6.45;
// End Rod length (end rod length that goes into the part)
EndRodlen = 9;
// Print tolerance
tolerance = 0.4;
// Wall thickness
walls = 3;
// Solid separator length
solidlen = 1.5;
/* [Hidden] */
$fn=50;


/* Connector code */
union(){
    // Rod part
    difference(){
        cylinder(r=(Rodiam+tolerance+walls)/2, h=Rodlen+solidlen);
        translate([0,0,-2])cylinder(r=(Rodiam+tolerance)/2, h=Rodlen+2);
    }
    // End Rod
    translate([0,0,Rodlen+solidlen]){
        difference(){
            cylinder(r=(Rodiam+tolerance+walls)/2, h=EndRodlen);
            cylinder(r=(EndRodiam+tolerance)/2, h=EndRodlen+2);
        }
    }
}