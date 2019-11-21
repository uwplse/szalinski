//Remixed brackets customizable in Customizer

//Corner bracket, 3 way or 4 way connection?
sides = 4; //[2, 3, 4]

//How thick should the walls of the brackets be?
thickness = 1;

//How thick is the material being used on the open side or pass-through side? 
open_gap_input = 13;

//Calculate combined width of gap and wall.
open_gap = open_gap_input + thickness;

//How thick is the material being used on the closed side?
closed_gap_input = 6.85;

//calculating combined width of gap and single wall
closed_gap = closed_gap_input + thickness;

//How long should the grip be on the open side?
grip_length_open = 30;

//How wide should the grip be on the closed side?
grip_length_closed = 31;

// How tall do you want the bracket to be?
bracket_h_input = 30;

//Reverse the L?
Reverse = "No"; //[Yes, No]

//translate ([14,14,0]){
//    color("Lavender"){
//        import("a-elbow-custom.stl");
//    }
//}

//Side wall module
module SideWall(a) {
    if (a ==2){
        rcube (thickness, open_gap+thickness, grip_length_open);
        translate([0, open_gap, grip_length_open-closed_gap-thickness]){
            rcube (thickness,grip_length_closed, closed_gap+thickness);
         }
     } else if(a ==3){
        rcube (thickness, open_gap+thickness, grip_length_open*2-closed_gap);
        translate([0, open_gap, grip_length_open-closed_gap-thickness]){
            rcube (thickness,grip_length_closed, closed_gap+thickness);
         } 
     } else if(a ==4){
         rcube (thickness, open_gap+thickness, grip_length_open*2-closed_gap);
        translate([0, -grip_length_closed, grip_length_open-closed_gap-thickness]){
            #rcube (thickness,grip_length_closed*2+open_gap, closed_gap+thickness);
         }
     } 
         
}
 
// rounded rectangle module
module rcube(x,y,z){
        minkowski(){
            cube ([x-0.5, y-0.5, z-0.5]);
            translate ([0.25, 0.25, 0.25]) sphere (0.25);
        }
}

//Tapered rectangle module using rectangles
module tcube(x, y, z) {
        hull(){
        if (Reverse == "Yes"){
            translate([bracket_h_input-thickness, 0, 0]) cube([1, y, z]); 
            translate ([0, y-0.5, 0]) cube([1, y-0.5, z]);
        } else {
            translate([0,0,0]) cube([1, y, z]);
            translate ([bracket_h_input-thickness, 0, 0]) cube ([1, y-0.5, z]);
        }
    }
}

//tapered rectangle module using cylinder/cones
module tcc(x, y, z) {
    hull(){
        rotate ([0, 90, 0]) cylinder(r1 = 0.25, r2 = thickness, h = x); 
            translate ([0, 0, z]) rotate ([0, 90, 0]) cylinder(r1 = 0.25, r2 = thickness, h = x);
    }
}

$fn = 50; //resolution or number of parts



//check which side side wall should be
if (Reverse == "Yes"){
    translate ([bracket_h_input-thickness, 0, 0]){
        SideWall(sides);
    }
} else {
    SideWall(sides);
    }

//Check for corner, three way or 4 way
if (sides == 4) {
    tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    translate([0,0, grip_length_open]) tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    
    translate([0, open_gap, 0]) {
        tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    }
    translate([0, open_gap, grip_length_open]) {
        tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    }
    translate([0, -grip_length_closed, grip_length_open-closed_gap-thickness]){
        rcube (bracket_h_input,grip_length_closed, thickness);
    }
    translate([0, -grip_length_closed, grip_length_open - thickness ]){
        rcube (bracket_h_input, grip_length_closed, thickness);
    }
    echo("4 sides");
} else if(sides == 3){
    tcube(bracket_h_input, thickness, grip_length_open*2-closed_gap);
    translate([0, open_gap, 0]) {
        tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    }
    translate([0, open_gap, grip_length_open]) {
        tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
    }  
} else if(sides == 2){
    tcube(bracket_h_input, thickness, grip_length_open);
    translate([0, open_gap, 0]) {
    tcube (bracket_h_input, thickness, grip_length_open-closed_gap);
} 
    echo("two sides selected");
}


translate([0, open_gap, grip_length_open-closed_gap-thickness]){
    rcube (bracket_h_input,grip_length_closed, thickness);
}

translate([0, open_gap, grip_length_open - thickness ]){
    rcube (bracket_h_input, grip_length_closed, thickness);
}

