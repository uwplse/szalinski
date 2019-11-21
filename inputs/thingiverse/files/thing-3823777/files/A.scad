difference(){

union(){
    cube ([9,12,12]);
    translate([9,0,0]) rotate([0,0,90]) cube ([9,12,12]);
}

union(){
    translate ([3,6,2.5]) cube ([3,15,15]);
    translate ([4.5,0,0]) rotate([0,0,90]) translate ([3,1.5,2.5]) cube ([3,15,15]);
}
}
