//Remixed customizable brackets

$fn = 50; //resolution or number of parts

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
Reverse = 1; //[-1:Yes, 1:No]

//Top wall

minkowski(){
        #cube([thickness, open_gap+thickness, grip_length_open]);
        #translate([0.25, 0.25, 0.25]) sphere (0.25);
    }
translate ([0, open_gap, grip_length_open-closed_gap-thickness]) minkowski(){
        #cube([thickness, grip_length_closed, closed_gap+thickness]);
        #translate([0.25, 0.25, 0.25]) sphere (0.25);
}
 
// rounded and tapered panel module
module rcube(x,y,z){
        //if reverse is true, change x to negative.
    xt = x*(Reverse);
    //if y is larger, create a new z which is 1/2 of original z for the tapered side.
    if (y>z) { 
        y2 = y;
        z2 = z/2;
        yt = y*0;
        zt = z/2;
        taper(x, y, z, xt, yt, zt, y2, z2);
    } else if (z>y) {      
        //if z is larger, create a new y which is 1/2 of the original y for the tapered side.
        y2 = y/2;
        z2 = z;
        yt = y/2;
        zt = z*0;
        taper(x, y, z, xt, yt, zt, y2, z2);
    }
}

module taper(x, y, z, xt, yt, zt, y2, z2){
    hull(){
        minkowski(){
            cube([1, y, z]);
            translate([0.25, 0.25, 0.25]) sphere (0.25);
        }
        translate ([xt,yt,zt]) cube([1, y2, z2]);
    }
}

rcube(bracket_h_input, thickness, grip_length_open);

translate([0, open_gap, 0]) {
    rcube (bracket_h_input, thickness, grip_length_open-closed_gap);
} 
translate([0, open_gap, grip_length_open-closed_gap-thickness]){
    rcube (bracket_h_input,grip_length_closed, thickness);
}

translate([0, open_gap, grip_length_open - thickness ]){
    rcube (bracket_h_input, grip_length_closed, thickness);
}

