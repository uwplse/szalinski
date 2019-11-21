burst_r1 = 30;
burst_r2 = 12;
burst_number = 5;
burst_height = 6;
two_sides = "NO";
hollow = "YES";
inside_scale = 0.9;

module star(burst_r1, burst_r2, burst_number, burst_height) {
    a = 180 / burst_number;

    p0 = [0, 0, 0];
    p1 = [burst_r2 * cos(a), burst_r2 * sin(a), 0];
    p2 = [burst_r1, 0, 0];
    p3 = [0, 0, burst_height];

    module half_burst() {
        polyhedron(points = [p0, p1, p2, p3], 
            faces = [
                [0, 2, 1],
                [0, 1, 3],
                [0, 3, 2], 
                [2, 1, 3]
            ]
        );
    }

    module burst() {
        hull() {
            half_burst();
            mirror([0, 1,0]) half_burst();
        }
    }

    union() {
        for(i = [0 : burst_number - 1]) {
            rotate(2 * a * i) burst();
        }
    }
}

if(hollow == "YES") {
    difference() {
        star(burst_r1, burst_r2, burst_number, burst_height);
        scale(inside_scale) star(burst_r1, burst_r2, burst_number, burst_height);
    }
    if(two_sides == "YES") {
       mirror([0, 0, 1]) difference() {
          star(burst_r1, burst_r2, burst_number, burst_height);
          scale(inside_scale) star(burst_r1, burst_r2, burst_number, burst_height);
      }
    } 
} else {
    star(burst_r1, burst_r2, burst_number, burst_height);
    if(two_sides == "YES") {
       mirror([0, 0, 1]) star(burst_r1, burst_r2, burst_number, burst_height);
    } 
}