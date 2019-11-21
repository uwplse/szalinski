/*
Name: OpenSCAD model of a x-axis strain relief bracket
Suits x-axis idlers with offset between leadscrew and straight rod
eg HIC Prusa or MaxMicron Prusa i3 clones 
see Thing: http://www.thingiverse.com/thing:712896

bracket clips over idler end piece and pushes back onto the x-axis rods.

v1.1, Adjustable length for upper and lower arms
v1.2, Mods for customizer support

Author: R Sutherland 

License: CC BY-NC-SA 3.0
License URL: https://creativecommons.org/licenses/by-nc-sa/3.0/
*/

use <MCAD/motors.scad>
use <MCAD/boxes.scad>
use <MCAD/nuts_and_bolts.scad>

$fn=16*1;    

//Upper arm inside length (mm)
Upper_Depth=47.5; //
//Lower arm inside length (mm)
Lower_Depth=47.5; //
//Bracket inside height (mm)
Inside_Height=61.0;  //
//Bracket width (mm)
Width=15.0; // [5:20]
//Bracket thickness (mm)
Thickness=5.0;   //[3.0,4.0,5.0,6.0,7.0]

//metric nut/screw size (Msize)
Nut_Size=3;    //[3,4]
//x-axis straight rod diameter (mm)
Rod_Diameter=8.0;  //[6.0,8.0,10.0]

//Overhang at the end that holds the bracket on (mm)
Lip_Depth=3.4;   //


_dpth=47.5*1; // mm normal inside arm length, don't change,  *1 to stop customizer
_tol=0.2*1;  // mm, tolerance for holes
_delta_upper=_dpth-Upper_Depth;
_delta_lower= _dpth-Lower_Depth;

translate([0,Inside_Height+Thickness+Thickness,0.0])  rotate([90,0,0])  xrelief();

module xrelief (){
    
    difference(){
            
        union(){
//lower arm
            color("red") translate([_delta_upper,0.0,0.0]) cube([Thickness,Width,Thickness+Lip_Depth]);
            color("green") translate([_delta_upper,0.0,0.0]) cube([Thickness+_dpth+Thickness-_delta_upper,Width,Thickness]);

// upper arm
            color("red") translate([_delta_lower,0.0,Thickness+Inside_Height-Lip_Depth]) cube([Thickness,Width,Thickness+Lip_Depth]);
            color("green") translate([_delta_lower,0.0,Thickness+Inside_Height]) cube([Thickness+_dpth+Thickness-_delta_lower,Width,Thickness]);

// riser
            color("blue")  translate([Thickness+_dpth,0.0,0.0]) cube([Thickness,Width,Thickness+Inside_Height+Thickness]);
            translate([_dpth+Thickness,Width/2,18+12+Thickness]) cube([2.0,8.0-1,24.0-1],center=true);
            translate([_dpth+Thickness-1,Width/2,Inside_Height+Thickness-7.5])  rotate([0,90,0]) cylinder(r=3.5,h=3.0);
            translate([_dpth+Thickness-1.0,Width/2,Thickness+9.0]) rotate([0,90,0]) cylinder(r=3.5,h=3.0);
        }

      #  translate([_dpth,Width/2,Inside_Height+Thickness-7.5]) rotate([0,90,0]) boltHole(Nut_Size,length=Thickness*3.0,tolerance=_tol);
      #  translate([_dpth+Thickness-1.0,Width/2,Inside_Height+Thickness-7.5]) rotate([0,90,0]) nutHole(Nut_Size,tolerance=0.1);
      #  translate([_dpth,Width/2,Thickness+9.0]) rotate([0,90,0]) boltHole(Nut_Size,length=Thickness*3,tolerance=_tol);
      #  translate([_dpth+Thickness-1.0,Width/2,Thickness+9.0]) rotate([0,90,0]) nutHole(Nut_Size,tolerance=0.1);

    }

}
