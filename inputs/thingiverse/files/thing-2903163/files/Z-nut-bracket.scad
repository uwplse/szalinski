//translate([-35,30, 0])
//import ("Z_Nut_Braket_1.1.stl");

//Length of the part on the extrustion. For T10: 69
length = 59;

//Size of the extrusion
extrusion = 20;     // [15, 20, 30]

//Screw size of the extrusion
screw_hole = 5.2;   // [3.2:M3, 4.2:M4, 5.2:M5]

//Thickness of the walls everywhere
wall_thickness = 5;

//Distance from the extrsuion to the center of the nut
distance_to_nut = 27;

//Width of the part holding the nut. For T10: 45
nut_holding_part_width = 35;

//Length of the part holding the nut. For T10: 40
nut_holding_part_length = 36;

//The middle diameter of the nut For T8 it's 10.2, but 11 gives it some play. For T10: 17
nut_middle_diameter = 11;

//The position of the screws from the center of the nut. For T10 : 24
nut_screw_position_diameter = 16;

//The diameter of the screw holes on the nut. For T10: 3.5 still
nut_screw_diameter = 3.5;

/* [Hidden] */
$fn = 30;

difference() {
    cube([length, extrusion, wall_thickness]);
    
    translate([(extrusion / 2) - (screw_hole/2), extrusion / 2, 0])
        hull() {
        cylinder(d = screw_hole, h = wall_thickness);
            
        translate([-(extrusion / 2) - (screw_hole/2), 0, 0])
        cylinder(d = screw_hole, h = wall_thickness);
        }
    
    translate([length - (extrusion / 2) + (screw_hole/2), extrusion / 2, 0])
        hull() {
        cylinder(d = screw_hole, h = wall_thickness);
            
        translate([(extrusion / 2) + (screw_hole/2), 0, 0])
        cylinder(d = screw_hole, h = wall_thickness);
    }
}

//Going up
translate([0, extrusion, 0]) {
    difference() {
        cube([length, wall_thickness, extrusion + 1]);
        translate([5.9, 0, extrusion / 2 + wall_thickness]) {
            hull() {
                rotate([0,90,90])
                cylinder(d = screw_hole, h = wall_thickness);
                
                translate([0,0,length])
                rotate([0,90,90])
                cylinder(d = screw_hole, h = wall_thickness);
            }
        }
        
        translate([length - 5.9, 0, extrusion / 2 + wall_thickness]) {
            hull() {
                rotate([0,90,90])
                cylinder(d = screw_hole, h = wall_thickness);
                
                translate([0,0,length])
                rotate([0,90,90])
                cylinder(d = screw_hole, h = wall_thickness);
            }
        }
    }
}

translate([(length - nut_holding_part_width)/2, extrusion + wall_thickness, 0]) {
    //Actual nut part
    difference() {
        cube([nut_holding_part_width, nut_holding_part_length, wall_thickness]);
        
        translate([nut_holding_part_width/2, distance_to_nut - wall_thickness, 0]) {
            
            //Oval that has a radius of 3.5 and 5.5
            translate([-nut_screw_position_diameter / 2, 0, 0]) {
                hull() {
                    translate([0,-1,0])
                    cylinder(d = nut_screw_diameter, h = wall_thickness);
                    translate([0,1,0])
                    cylinder(d = nut_screw_diameter, h = wall_thickness);
                }
            }

            translate([nut_screw_position_diameter / 2, 0, 0]) {
                hull() {
                    translate([0,-1,0])
                    cylinder(d = nut_screw_diameter, h = wall_thickness);
                    translate([0,1,0])
                    cylinder(d = nut_screw_diameter, h = wall_thickness);
                }
            }

            hull() {
                translate([0, -1, 0])
                cylinder(d = nut_middle_diameter, h = wall_thickness);
                translate([0,1,0])
                cylinder(d = nut_middle_diameter, h = wall_thickness);
            }
            
            hull() {
                translate([0, -nut_screw_position_diameter / 2 - 1, 0])
                cylinder(d = nut_screw_diameter, h = wall_thickness);
                translate([0, nut_screw_position_diameter / 2 + 1, 0])
                cylinder(d = nut_screw_diameter, h = wall_thickness);
            }
        }
    }
    
    translate([0,0,wall_thickness])
    prism(wall_thickness, nut_holding_part_length, extrusion - wall_thickness);
    
    translate([nut_holding_part_width - wall_thickness,0,wall_thickness])
    prism(wall_thickness, nut_holding_part_length, extrusion - wall_thickness);
}


module prism(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,0,h], [l,0,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );

   }
