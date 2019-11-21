//Checker base diameter
a = 26;
//Checker base thickness
b = 1;
//Bottom radius
r1 = 5;
//Top radius
r7 = 1;//[0.5:0.5:5.0]


fn=100; // [6.0:2.0:100.0]




r5 = r1*(sqrt(2)-1);

difference(){
union(){
    translate([0,0,b]) rotate_extrude(convexity = 10, $fn = fn)

    difference(){
        translate([0.5*a-r1, 0, 0]) circle(r = r1, $fn = fn);
        translate([-2*r1,-r1,0]) square([2*r1,2*r1],center=false);
        translate([0.5*a-r1-r1,-2*r1,0]) square([2*r1,2*r1],center=false);
    }

    translate([0,0,b+(r1+2*r5+r7)/sqrt(2)])
        rotate_extrude(convexity = 10, $fn = fn)
            translate([a/2-(r5+r7)/sqrt(2), 0, 0])
                circle(r = r7, $fn = fn);

    cylinder(h = b, d=a, $fn = fn);

    translate([0,0,0])
        rotate_extrude(convexity = 10, $fn = fn)
            square([a/2-r5/sqrt(2),b+(r1+2*r5+2*r7)/sqrt(2)], $fn = fn);
}


translate([0,0,b+(r1+r5)/sqrt(2)])
        rotate_extrude(convexity = 10, $fn = fn)
            translate([a/2, 0, 0])
                circle(r = r5, $fn = fn);

translate([0,0,b+r1+a/2]) sphere(r=a/2*sqrt(2)-r5-2*r7,$fn = fn);
}