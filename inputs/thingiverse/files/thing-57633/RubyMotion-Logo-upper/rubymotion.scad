//CUSTOMIZER VARIABLES

// edge length (width/height)
size = 80;

// for the "A" character
engrave_depth = .8;

//CUSTOMIZER VARIABLES END


height = size/10;
radius = size/10;
outer_size = size + 2*radius;
engrave_thickness = outer_size / 19.2;

l_a = outer_size/3.25;
l_b = outer_size/2.65;
l_c = outer_size/2.375;

a_a = 59.5 * 1;
a_b = 122 * 1;
a_c = 0 * 1;

difference() {
    color("lightgray") translate([radius,radius,-height]) difference() {
        // create a rounded cube
        translate([0,0,height]) {
            hull() {
                sphere(r=radius);
                translate([size,0,0]) sphere(r=radius);
                translate([size,size,0]) sphere(r=radius);
                translate([0,size,0]) sphere(r=radius);
            }
        }

        // cut away the lower half
        translate([-radius,-radius,0]) cube([size+radius*2,size+radius*2,height]);
    }

    color("gray") union() {
        // the three bars representing the "A"
        translate([outer_size*0.335,outer_size*0.37,height-engrave_depth])
            rotate([0,0,a_a])
                cube([l_a, engrave_thickness, engrave_depth]);

        translate([outer_size*0.71,outer_size*0.39,height-engrave_depth])
            rotate([0,0,a_b])
                cube([l_b, engrave_thickness, engrave_depth]);

        translate([(outer_size-l_c)/2,outer_size*0.49,height-engrave_depth])
            rotate([0,0,a_c])
                cube([l_c, engrave_thickness, engrave_depth]);


    }
}