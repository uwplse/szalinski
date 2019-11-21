width=250;
height=200;
depth=15;
base_r=4;
top_r=8;
offset=25;


wall_height = depth * 1.2;
num_x = floor(width / offset);
num_y = floor(height / offset);

module post() {
    cylinder(h=depth/2, r1=base_r, r2=top_r);
    translate([0, 0, depth/2]) {
        cylinder(h=depth/2, r1=top_r, r2=base_r);
    }
}

translate([-width/2, -height/2, 0]) {
    for(x = [0 : 1 : num_x]) {
        for(y = [0 : 1 : num_y]) {
            translate([offset * x, offset * y, 0]) {
                post();
            }
        }
    }
    translate([0, 0, depth / 2]) {
        for(x = [1 : 1 : num_x - 1]) {
            translate([offset * x - base_r/2, 0, -base_r]) {
                cube(size = [base_r, height, base_r]);
            }
        }

        for(y = [1 : 1 : num_y - 1]) {
            translate([0, offset * y - base_r/2, -base_r]) {
                cube(size = [width, base_r, base_r]);
            }
        }
    }
}

translate([-width/2, -height/2, 0]) {
    translate([-top_r, -top_r, 0]) {
        cube(size = [width + top_r*2, top_r/2, wall_height]);
        cube(size = [top_r/2, height + top_r*2, wall_height]);
    }
}

translate([-width/2 - top_r, (num_y * offset)/2 + top_r/2, 0]) {
    cube(size = [(num_x * offset) + top_r*2, top_r/2, wall_height]);
}

translate([(num_x * offset)/2 + top_r/2, -height/2 - top_r, 0]) {
    cube(size = [top_r/2, (num_y * offset) + top_r*2, wall_height]);
}
