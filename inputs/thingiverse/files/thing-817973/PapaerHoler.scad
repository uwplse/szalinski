//PaperHolder

//Width Of Slot
Width = 1;

//Depth Of Slot
Depth = 5;

polyhedron(
    points = [[0,0,0], [30,30,0], [15,15,10], [20,10,0], [10,20,0], ],
    faces = [[0,4,3], [1,3,4], [0,3,2], [0,2,4], [2,3,1], [2,1,4]]
);
translate([10,10,0]){
    difference(){
        cylinder(15,3,3);
        translate([0,0,15]){
            rotate([0,0,135]){
                cube([Width,6,Depth], center = true);
            }
        }
    }
}
translate([20,20,0]){
    difference(){
        cylinder(15,3,3);
        translate([0,0,15]){
            rotate([0,0,135]){
                cube([Width,6,Depth], center = true);
            }
        }
    }
}