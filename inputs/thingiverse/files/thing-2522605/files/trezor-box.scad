
t = 0.1; //helper

tol_cap = 0.4; // cap tolerance - for easy opening
cap_depth = 5;

inner_width = 44;
inner_height = 73.5;
inner_depth = 10;

wall_thickness = 0.9;

translate([inner_width+wall_thickness*2+5, 0,0]) cap();
bottom();
//cube([inner_width, inner_height, inner_depth]);
module cap() {   
    difference() {
        cube([inner_width+4*wall_thickness+tol_cap, inner_height+4*wall_thickness+tol_cap, cap_depth+wall_thickness]);
        translate([wall_thickness,wall_thickness,wall_thickness]) cube([inner_width+2*wall_thickness+tol_cap, inner_height+2*wall_thickness+tol_cap, cap_depth+t]);
    }
}

module bottom() {

    difference() {
        cube([inner_width+2*wall_thickness, inner_height+2*wall_thickness, inner_depth+wall_thickness]);
        
        translate([wall_thickness, wall_thickness, wall_thickness]) cube([inner_width, inner_height, inner_depth+t]);
    }
}