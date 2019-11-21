//radius of the opening
r = 30;  //[10:100]

$fn=200;

octa_cord = [
    [+1, 0, 0], [-1, 0, 0],     // - x axis
    [0, +1, 0],	[0, -1, 0],     // - y axis
    [0, 0, +1],	[0, 0, -1]];    // - z axis    
octafaces = [
    [4,2,0],[4,0,3],[4,3,1],[4,1,2],
    [5,0,2],[5,3,0],[5,1,3],[5,2,1]];

difference(){
    union(){
        minkowski(){
            scale(3)polyhedron(octa_cord,octafaces);
            translate([3,-6,3])cube([12,12,12]);    
        }
        translate([r+18,0,0])difference(){
            union(){
                cylinder(4.5,r+5,r+5);
                translate([0,0,4.5])cylinder(4.5,r+5,r);
            }
            translate([0,0,-0.5])cylinder(11,r,r);
        }
    }
    translate([-0.5,0,9])rotate([0,90,0])cylinder(19,5,5);
}