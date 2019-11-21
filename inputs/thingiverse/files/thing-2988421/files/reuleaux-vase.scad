top_diameter = 60;

bottom_diameter = 80;

vase_height = 200;

wall_thickness = 2;

//rotation from bottom to top
total_twist = 360;

/* [Hidden] */

$fa=1;
$fs=1;

top_scale = top_diameter/bottom_diameter;

module reuleaux_triangle(triangle_d) {
    intersection() {
        translate([0,triangle_d/2,0]) circle(r=triangle_d);
        translate([triangle_d*sqrt(3)/4,-triangle_d/4,0]) circle(r=triangle_d);
        translate([-triangle_d*sqrt(3)/4,-triangle_d/4,0]) circle(r=triangle_d);
    }
}

module vase() {
    difference() {
        linear_extrude(height=vase_height,twist=total_twist,scale=top_scale)
        reuleaux_triangle(bottom_diameter);
        
        linear_extrude(height=vase_height,twist=total_twist,scale=(top_scale*bottom_diameter - 2*wall_thickness)/(bottom_diameter - 2*wall_thickness))
        reuleaux_triangle(bottom_diameter-wall_thickness*2);
    }
    
    
    linear_extrude(height=wall_thickness,twist=total_twist*(wall_thickness/vase_height),scale=((top_diameter-bottom_diameter)/vase_height*wall_thickness+bottom_diameter)/bottom_diameter) {
        reuleaux_triangle(bottom_diameter);
    }
}

vase();