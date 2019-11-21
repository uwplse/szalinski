/*CREATED BY PASZIN*/

//Thickness of all elements
thickness = 5; // [1:15]

//Length of vertical arm
len1 = 50; // [10:100]
//Length of horizontal arm
len2 = 50; // [10:100]
//Width of angle section
width = 30; // [5;100]

//Diameter of a hole centered at the end of the arms (You can use it for srews)
hole_diameter = 4;
hole_diameter_top = hole_diameter + hole_diameter*0.7;

$fn=50*1;

module one_side(cx, cy, cz, hd, invert=1) {
    difference() {
        cube([cx, cy, cz]);
        translate([cx-hd*2, width/2, -1])  cylinder(d=hd, h=cz+2);
        translate([cx-hd*2, width/2, cz-2])  cylinder(d1=hd, d2=hole_diameter_top, h=2);
    }
    
    
}


module angle_profile() {
        

    mirror([1,0,0]) rotate([0,-90,0]) one_side(len1, width, thickness, hole_diameter, -1);
   one_side(len2, width, thickness, hole_diameter);
    hull() {
        mirror([1,0,0]) rotate([0,-90,0])  translate([len1-hole_diameter*5, 0, 0])  cube([thickness, width, 1]);
        translate([len2-hole_diameter*5, 0, 0])  cube([thickness, width, 1]);
        
        
        }
    
    
    
    }


angle_profile();
    
    