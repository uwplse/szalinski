inner_radius = 7.5;
outer_radius = 60;
wall_width = 1.2;
height = 25;
dividers = 4;

$fn = 120;

module box(inner_radius, outer_radius, height, wall_width, dividers){
    difference(){
        intersection(){
            union(){
                difference()
                {
                    cylinder(h=height, r=outer_radius);
                    cylinder(h=height, r=inner_radius);
                    translate([0,0,wall_width]){
                        cylinder(h=(height - wall_width), r = outer_radius - wall_width);
                    }
                }
                cylinder(h=height, r=inner_radius + wall_width);
                for (d = [1 : dividers]){
                    rotate(d * 360 / dividers, [0, 0, 1]){
                        translate([-wall_width / 2,inner_radius,0]){
                            cube(size=[wall_width, outer_radius-inner_radius, height], center=false);
                        }
                    }
                }
            }
            cylinder(h=height, r=outer_radius);
            
        }
        cylinder(h=height, r=inner_radius);
    }
}

box (inner_radius, outer_radius, height, wall_width, dividers);