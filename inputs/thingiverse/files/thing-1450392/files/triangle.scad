depth = 2; //[1:10]
size = 30; //[10:100]
thickness = 5; //[1:10]
lean = -30; //[-180:180]
div = 7; //[1.5:10]

formGenerator(depth, size, thickness, lean, div);

//base 2D triangle
module triangle2D(dia = 20, thickness = 2) {
    translate([0,dia/2,0])
    rotate([0,0,90])
    difference() {
        circle(dia,$fn=3);
        circle(dia-thickness,$fn=3);
    }
}

//base 3D triangle
module triangle3D(depth = 2, size = 20, thickness = 2) {
    linear_extrude(height = depth , center = true, convexity = 10, twist = 0)
    triangle2D(size, thickness);
}

module formGenerator(d, s, t, l, div=2) {
    depth = d;
    size = s;
    thickness = t;
    lean = l;

    for (a=[1:3]) {
        rotate([0,0,(360/3) * a])
        translate([0,size/div,0])
        rotate([lean,0,0])
        rotate([90,0,0])
        triangle3D(depth, size, thickness);
    }
}

module forms() {

    translate([80,0,0])
    color("green")
    formGenerator(2,30,5,45);

    translate([0,80,0])
    color("lime")
    formGenerator(2,30,5,20);

    translate([80,80,0])
    color("red")
    formGenerator(2,30,5,20, 5);

    translate([-80,0,0])
    color("pink")
    formGenerator(2,30,5,-30,7);
}

