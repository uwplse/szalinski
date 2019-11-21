// /********************************************************           
//  * Variable cicle for collision calibration             *   
//  *                                                      *   
//  * Author:  Adam, Kuczmik                               *   
//  *                                                      *   
//  * Purpose: For collision calibration of a delta 3d     *
//  * Printer (1 mm height)                                *   
//  *                                                      *   
//  * Usage:                                               *   
//  *      Run it in OpenSCAD version 2015.03-2            *   
//  ********************************************************/  
//
//
//
// Radius of the Ring [mm]
Radius= 96; 
 
 difference() {
    cylinder(h=1, r=Radius, center=false, $fn=200);
    cylinder(h=1, r=Radius-1, center=false, $fn=200);  
 }

 