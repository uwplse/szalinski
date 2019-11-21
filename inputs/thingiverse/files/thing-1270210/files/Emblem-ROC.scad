
r=90;  // outer radius
r_Star=60;   // the radius of the star
r_Center=30;  // the radius of the center circle
r_Ring=35;  // the radius of the ring in center
h=7;  // height (thickness)
n=12;  // n-point star

module star(n=5,h=2,r1=20,r2=10) {
    union() {
        for (i=[0:n-1]) {
            polyhedron(
                points = [
                    [r1*cos(360*i/n), r1*sin(360*i/n), 0],
                    [r2*cos(360*(i+0.5)/n), r2*sin(360*(i+0.5)/n), 0],
                    [r2*cos(360*(i-0.5)/n), r2*sin(360*(i-0.5)/n), 0],
                    [r1*cos(360*i/n), r1*sin(360*i/n), h],
                    [r2*cos(360*(i+0.5)/n), r2*sin(360*(i+0.5)/n), h],
                    [r2*cos(360*(i-0.5)/n), r2*sin(360*(i-0.5)/n), h]
                ],
                faces = [ [0,1,2], [3,5,4],
                          [0,3,1], [3,4,1],
                          [1,4,2], [4,5,2],
                          [2,5,0], [5,3,0]
                ]
            );
        }
        cylinder(r=r2, h=h);
    }
}

module ring(h,r1,r2) {
    difference() {
        cylinder(r=r1,h=h);
        translate([0,0,-1]) {
            cylinder(r=r2,h=h+2);
        }
    }
}

union() {
    difference() {
        cylinder(r=r/2, h=h, $fn=360);
        translate([0,0,-1]) {
            star(n=n,h=h+2,r1=r_Star/2,r2=r_Center/2, $fn=360);
        }
    }
    ring(h,r_Ring/2,r_Center/2, $fn=360);
}


