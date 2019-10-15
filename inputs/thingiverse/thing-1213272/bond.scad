length = 50; // min/max:[5:100]

union(){
difference(){
    cylinder(5,8,8);
    translate([0,0,-1]) cylinder(7,6,6);
}
translate([6,-5,0]) cube([length,10,5]);
difference(){
    translate([length+12,0,0]) cylinder(5,8,8);
    translate([length+12,0,-1]) cylinder(7,6,6);
}
}