include <MCAD/shapes.scad>
pencilRadius = 4.1;
wallThickness = 3;
pencilWall = pencilRadius + wallThickness;
height = 38;
length = 35;

difference() {
union() {
cylinder(height,pencilWall,pencilWall,true);
translate([-3.75,-length/2,0])
cube([wallThickness,length,height],true);
translate([3.75,-length/2,0])
cube([wallThickness,length,height],true);
}

//#cylinder(height+2,pencilRadius,pencilRadius,true);
#hexagon(pencilRadius*2, height+2);



}
translate([3.75,-(length+(wallThickness*0.5)),0])
cylinder(height,wallThickness,wallThickness,true);
translate([-3.75,-(length+(wallThickness*0.5)),0])
cylinder(height,wallThickness,wallThickness,true);


