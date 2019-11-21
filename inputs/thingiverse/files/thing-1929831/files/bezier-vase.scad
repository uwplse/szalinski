/* [Basic] */

bottom_radius = 25;
curve_width = 12;
thickness = 2;
inner_vase = "YES"; // [YES, NO]

/* [Point0] */

px0 = 0;   // [-300:300]
py0 = 0;   // [-300:300]

/* [Point1] */

px1 = 40;  // [-300:300]
py1 = 60;  // [-300:300]

/* [Point2] */

px2 = -50;  // [-300:300]
py2 = 90;  // [-300:300]

/* [Point3] */

px3 = 0;   // [-300:300]
py3 = 200; // [-300:300]

/* [Advanced] */

fn = 40;
t_step = 0.05;

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

function bezier_coordinate(t, n0, n1, n2, n3) = n0 * pow((1 - t), 3) + 3 * n1 * t * pow((1 - t), 2) + 3 * n2 * pow(t, 2) * (1 - t) + n3 * pow(t, 3);

function bezier_point(t, p0, p1, p2, p3) = 
    [
        bezier_coordinate(t, p0[0], p1[0], p2[0], p3[0]),
        bezier_coordinate(t, p0[1], p1[1], p2[1], p3[1]),
        bezier_coordinate(t, p0[2], p1[2], p2[2], p3[2])
    ];
    

function bezier_curve(t_step, p0, p1, p2, p3) = [for(t = [0: t_step: 1 + t_step]) bezier_point(t, p0, p1, p2, p3)];

module bezier_vase(bottom_radius, curve_width, thickness, inner_vase, p0, p1, p2, p3, fn, t_step) {
    $fn = fn;

    points = bezier_curve(t_step, p0, p1, p2, p3);
    
    // bezier_curve as a wall
    a_step = 360/fn;
    x_offset = bottom_radius + curve_width / 2;
            
    for(a = [0: a_step : 360 - a_step]) {
        rotate([90, 0, a]) 
            translate([x_offset, 0, 0]) 
                linear_extrude(thickness, center = true) 
                    polyline(points, curve_width);
    }        
    
    // bottom
    half_curve_width = curve_width / 2;
    bottom_scale = (bottom_radius + half_curve_width) / bottom_radius;

    translate([0, 0, -half_curve_width]) 
        linear_extrude(half_curve_width, scale = bottom_scale) 
            circle(bottom_radius);

    if(inner_vase == "YES") {
        rotate_extrude() 
            translate([bottom_radius, 0, 0]) 
                polyline(points, thickness);
    }
}

bezier_vase(
    bottom_radius, 
    curve_width, 
    thickness, 
    inner_vase, 
    [px0, py0, 0], 
    [px1, py1, 0], 
    [px2, py2, 0], 
    [px3, py3, 0], 
    fn, 
    t_step
);


