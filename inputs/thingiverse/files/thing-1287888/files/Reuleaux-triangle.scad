// Michael Barlow
// All measurements are in mm

object = 3; // [1:Reuleaux Triangle,2:Reuleaux Tetrahedron, 3:Reuleaux Solid of Revolution]
width = 40;
resolution = 200;
triangle_height = 2;
triangle_side_thickness = 4;

$fn = resolution;
radius = width;

if (object == 1){
    difference(){
        Reuleaux_triangle(radius);
        Reuleaux_triangle(radius - (triangle_side_thickness*2));
    }
} else if (object == 2) {
    Reuleaux_tetrahedron(radius);
} else {
    Solid_of_constant_width(radius);
}

module Reuleaux_triangle (rad = 100){
    linear_extrude(height=triangle_height)
        translate([0,-rad/2/sqrt(3),0]){
            intersection() {
                translate([rad/2,0,0]) {
                    circle(r = rad);
                }
                translate([-rad/2,0,0]) {
                    circle(r = rad);
                }
                translate([0,rad/2*sqrt(3),0]) {
                    circle(r = rad);
                }
        }
    }
}

module Solid_of_constant_width (rad = 100){
    rotate_extrude() 
        difference(){
            translate([0,-rad/2/sqrt(3),0]){
                intersection() {
                    translate([rad/2,0,0]) {
                        circle(r = rad);
                    }
                    translate([-rad/2,0,0]) {
                        circle(r = rad);
                    }
                    translate([0,rad/2*sqrt(3),0]) {
                        circle(r = rad);
                    }
                }
            }
            translate([0,-radius,0]) {
                square(size = [2*radius, 2*radius]);
            }
        }
}

module Reuleaux_tetrahedron(rad = 100){
    translate([0,-rad/2/sqrt(3),-rad/2/sqrt(3)]){
        intersection() {
            translate([0,(rad/2)*sqrt(3),0]) {
                sphere(r=rad);
            }
            translate([0,(rad/2)/sqrt(3),(rad/2)*sqrt(3)]) {
                sphere(r=rad);
            }
            translate([-(rad/2),0,0]) {
                sphere(r=rad);
            }
            translate([rad/2,0,0]) {
                sphere(r=rad);
            }
        }
    }
}