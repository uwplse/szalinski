include <constants.scad>;

rotate([0, -90, -45]) {
    difference(){
     stand();
    cube1();
    }
}
module cube1(){
    translate([0, gap_y*3/2, 0])
        cube([width*2/3, base_length*2/3, thickness_part]);
}
    
module stand() {
   
     cube([width, base_length, thickness_part]);
     

     finger();
     translate([0, gap_y, 0]) finger();
}

module finger() {
     rotate([finger_angle, 0, 0]) cube([width, finger_length, thickness_part]);
}
