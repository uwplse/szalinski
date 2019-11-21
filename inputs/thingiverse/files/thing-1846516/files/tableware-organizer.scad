smallest_length = 30;
height1 = 60;
height2 = 120;
thickness = 1;

function fibonacci(nth) = 
    nth == 0 || nth == 1 ? nth : (
        fibonacci(nth - 1) + fibonacci(nth - 2)
    );

module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 




module tableware_organizer(smallest_length, height1, height2, height2, thickness) {

    module golden_rectangle(from, to, thickness) {
        if(from <= to) {
            f1 = fibonacci(from) * smallest_length;
            f2 = fibonacci(from + 1) * smallest_length;

            points = [[0, 0], [f1, 0], [f1, f1], [0, f1], [0, 0]];
            
            if(f1 < 3 * smallest_length) {
                linear_extrude(height1) polyline(points, thickness);
            } else {
                linear_extrude(height2) 
                polyline(points, thickness);
            }
            
            linear_extrude(thickness) square([f1, f1]);
            
            offset = f2 - f1;

            translate([0, -offset, 0]) rotate(90)
                golden_rectangle(from + 1, to, thickness);
        }
    }

    p1 = smallest_length * 3 / 4;
    p2 = smallest_length / 4;
    
    
    difference() {
        golden_rectangle(1, 4, thickness);
        
        translate([smallest_length * 2.5, 0, height2 / 2]) 
            rotate([90, 90, 0]) 
                linear_extrude(smallest_length * 8, center = true) 
                    polyline([[-p1, -p1], [p1, p1]], thickness * 2);
                    
        translate([smallest_length * 2.5, 0, height2 / 3]) 
            rotate([90, 90, 0]) 
                linear_extrude(smallest_length * 8, center = true) 
                    polyline([[-p1, -p1], [p1, p1]], thickness * 2);

        translate([smallest_length * 2.5, 0, height2 / 1.5]) 
            rotate([90, 90, 0]) 
                linear_extrude(smallest_length * 8, center = true) 
                    polyline([[-p1, -p1], [p1, p1]], thickness * 2);
                    
        translate([smallest_length / 2, 0, height1 / 3]) rotate([90, 90, 0]) linear_extrude(smallest_length * 8, center = true) polyline([[-p2, -p2], [p2, p2]], thickness * 2);
        
        translate([smallest_length / 2, 0, height1 / 1.5]) rotate([90, 90, 0]) linear_extrude(smallest_length * 8, center = true) polyline([[-p2, -p2], [p2, p2]], thickness * 2);
        
        translate([-smallest_length / 2, 0, height1 / 3]) rotate([90, 90, 0]) linear_extrude(smallest_length * 8, center = true) polyline([[-p2, -p2], [p2, p2]], thickness * 2);
        
        translate([-smallest_length / 2, 0, height1 / 1.5]) rotate([90, 90, 0]) linear_extrude(smallest_length * 8, center = true) polyline([[-p2, -p2], [p2, p2]], thickness * 2);
    }
}

tableware_organizer(smallest_length, height1, height2, height2, thickness);