$fn=50;

platen_thick = 3.5;
y_length = 35;
y_thickness = 6.5;
x_length = 40;
x_thickness = 13;
washer_diameter = 7.5;
screw_diameter = 3.5;
screw_radius_distance_from_glass_y = 7.6;
screw_radius_distance_from_glass_x = 1.5;
corner_round_diameter = 8;
screw_suppport_thickness = 1;

module xPartSmoothCylinder() {
translate([y_thickness,x_thickness]){
scale([(x_length-y_thickness)/x_thickness, 1, 1])
cylinder(platen_thick, x_thickness, x_thickness);
}
}


module yPartSmoothCylinder() {
    translate([y_thickness, x_thickness]){
        scale([1, (y_length-x_thickness)/y_thickness, 1])
            cylinder(platen_thick, y_thickness, y_thickness);
}
}


module xPart() {
    intersection(){
        xPartSmoothCylinder();
        translate([y_thickness, 0])
    cube([x_length-y_thickness,x_thickness,platen_thick]); 
          }   
}

module yPart() {
    intersection(){
        yPartSmoothCylinder();
        translate ([0, x_thickness])
    cube([y_thickness,y_length-x_thickness,platen_thick]);
    }
}

module union_block() {
    cube([y_thickness, x_thickness, platen_thick]);
}


module ScrewHole() {
  cylinder(platen_thick, d1=screw_diameter, d2=screw_diameter, center=false);  
}

module WasherHole() {
    translate([0,0,screw_suppport_thickness])
  cylinder(platen_thick, d1=washer_diameter, d2=washer_diameter, center=false);  
}


module RoundedCorner(){
translate([0, 0])
difference(){
cube([corner_round_diameter, corner_round_diameter, 2 * platen_thick]);
    translate([corner_round_diameter, corner_round_diameter]){
cylinder(2*platen_thick, corner_round_diameter, corner_round_diameter, center=false);
}}}

module MakeBracketRight(){
difference(){
    union(){
        xPart();
        yPart();
        union_block();
    };
    translate([y_thickness+screw_radius_distance_from_glass_x,x_thickness-screw_radius_distance_from_glass_y]){ScrewHole();
    }
    translate([y_thickness+screw_radius_distance_from_glass_x,x_thickness-screw_radius_distance_from_glass_y]){WasherHole();
    }
    RoundedCorner();
}
}



module MakeBracketRightSet() {
//MakeBracketRight();
translate([x_length+y_thickness+2,y_length])
rotate(a= 180, v=[0,0,1])
MakeBracketRight();
}


module MakeBracketLeftSet(){
    translate([x_length+y_thickness+2, x_thickness +2 ])
    mirror()
    MakeBracketRightSet();
}

MakeBracketRightSet();
MakeBracketLeftSet();

//translate([2*x_length+5, 0, 0])
//mirror()
//MakeBracket();


