// cockpit_height
wing_span = 40; // [10:base_width * 2]
cockpit_height = 10; // [3:10]
base_width = 30; // [15:50]
base_length = 90;

module back_wing(solid) {
    difference() {
        rotate([0,-5,0]) {
            translate([-8,0,0]) {
            color([0,1,0])
            linear_extrude(height=4) polygon([[-wing_span,0],[-5,10],[2,50]]);
            }
        }
        translate([-50,0,-50]) cube([50,50,50]);
    }
}

back_wing();
mirror([1,0,0]) {
    back_wing();
}

linear_extrude(5)
polygon([[-base_width,3],[0,base_length],[base_width,3],[0,15]]);

translate([0,35,5]) {
    color([1,0,0]) polyhedron(
    points=[ [0,20,0],[8,-10,0],[0,-18,0],[-8,-10,0], // the four points at base
           [0,0,cockpit_height]  ],                                 // the apex point 
    faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
    );
}