//Overall Thickness
thickness = 3; //[0.1:0.1:30]

//Outer Rectangle - Width
hull_x = 18.5; //[0.5:0.1:300]
//Outer Rectangle - Length
hull_y = 56; //[0.5:0.1:300]

//Inner Rectangle (Cut) - Width
in_x = 12; //[0.5:0.1:299]
//Inner Rectangle (Cut) - Length
in_y = 24; //[0.5:0.1:299]

//Screw Diameter
screw_dia = 4.5; //[0.5:0.1:100]
//Overall Seperation
screw_seperation = 41.5; //[0.5:0.1:280]

//Final Representation
outer_hull();


module outer_hull(){
    difference(){
        cube([hull_x, hull_y, thickness], center = true);
        cube([in_x, in_y, thickness + 1], center = true);
        placed_screws();
    }
}


module placed_screws(){
    translate([0,screw_seperation/2, 0]){
        screw_holes();
    }
    translate([0,-screw_seperation/2, 0]){
        screw_holes();
    }
}

module screw_holes(){
    cylinder(h = thickness + 1, d = screw_dia, center = true, $fn = 50);
}