//wall/bench hook for file set

//how many tools
slots = 6; //[1:20]
//diameter of the shafts, in mm
tool_diam = 3; //[2:16]

//secret vars
$fn = 50 * 1;
trad = tool_diam / 2;
sw = trad * 1.2;
//6.3 is a magic number, it's 2 screw holes wide
//...assuming you use size 6 wood screws
min_wid = 6.3 + tool_diam * 2;
cen = (min_wid / 2);

module wallplate(){
    difference(){
        cube([4, min_wid, 20]);
    }
}
module hanger(){
    difference(){
        cube ([tool_diam * 5, min_wid, 4]);
        translate ([tool_diam * 2, cen, -0.5]) slot();
    }
}
module slot(){
    union(){
        cylinder(h = 5, r1 = tool_diam, r2 = sw);
        translate ([0, -(trad), 0]) cube([50, tool_diam, 50]);
    }
}
module single(){
    rotate ([0, 350, 0]) hanger();
    translate ([-3, 0, 0]) wallplate();
}
rotate ([0, 270, 0]) for(i=[0:slots-1]){
    translate ([0, i * min_wid, 0]){
        //single();
        if (i == 0){
            difference(){
                single();
                translate ([-3.5, cen, 12]) rotate ([0, 90, 0]) cylinder(h = 5, r1 = 1.5, r2 = 3.15);
            }
        } else if (i == slots - 1){
            difference(){
                single();
                translate ([-3.5, cen, 12]) rotate ([0, 90, 0]) cylinder(h = 5, r1 = 1.5, r2 = 3.15);
            }
        } else {
            single();
        }
    }
}