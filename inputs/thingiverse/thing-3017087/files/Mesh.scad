$fn = 10;

/* [Parameters] */
//The angle of the lines of the mesh from the vertical
angle = 50; // [1:89]
//Thickness of line segments
radius = 3;
//Length of line segments
length = 30;
//Number of Borromean rings along the y-axis
rows = 3;
//Number of Borromean rings along the x-axis
columns = 4;

triple(length, radius, angle, rows, columns);

module triple(length, radius, angle, rows, columns) {
    for(i = [0:2]) {
        translate([(((length*sin(90-angle)))*i),0,0]) {
            xLayout(length, radius, angle, rows, columns);
        }
    }
}

module xLayout(length, radius, angle, rows, columns) {
    for(i = [0:columns-1]) {
        translate([(((cos(60)*length*sin(90-angle))+(length*sin(90-angle)))*i),(sin(60)*length*sin(90-angle))*(i%2),0]) {
            yLayout(length, radius, angle, rows);
        }
    }
}

module yLayout(length, radius, angle, rows) {
    for(i = [0:rows-1]) {
        translate([0,((sin(60)*length*sin(90-angle))*i)*2,0]) {
            tri(length, radius, angle);
        }
    }
}

module tri(length, radius, angle) {
    for(i = [0:2]) {
        rotate([0,angle,i*120]) {
            tube(length, radius);
        }
    }
}

module tube(length, radius) {
    sphere(radius);
    rotate([0,90,0]) {
        cylinder(length, radius, radius);
    }
    translate([length,0,0]) {
        sphere(radius);
    }
}

/*
CORE FORMULAS:

X DISTANCE:
((cos(60)*length*sin(90-angle))+(length*sin(90-angle)))

Y DISTANCE:
(sin(60)*length*sin(90-angle))


*/