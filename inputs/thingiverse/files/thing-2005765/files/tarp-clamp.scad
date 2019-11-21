inner_radius = 12.5;
wall_thickness = 2.5;
open_angle = 80;//[25:170]
height = 30.0;

/* [Hidden] */
$fn = 200;

linear_extrude(height)
{
    difference()
    {
        union()
        {
            difference() 
            {
                pie_slice(inner_radius + wall_thickness, open_angle / 2, 360 - (open_angle / 2));
                circle(inner_radius);
            }
            translate([(inner_radius + wall_thickness) * cos(open_angle / 2), (inner_radius + wall_thickness) * sin(open_angle / 2),0]) circle(wall_thickness);
            translate([(inner_radius + wall_thickness) * cos(open_angle / 2), - (inner_radius + wall_thickness) * sin(open_angle / 2),0]) circle(wall_thickness);
        };
        translate([(inner_radius + wall_thickness) * cos(open_angle / 2), (inner_radius + wall_thickness) * sin(open_angle / 2),0]) circle(wall_thickness * 0.6);
        translate([(inner_radius + wall_thickness) * cos(open_angle / 2), - (inner_radius + wall_thickness) * sin(open_angle / 2),0]) circle(wall_thickness * 0.6);
    };
};

module pie_slice(r, start_angle, end_angle) {
    R = r * sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
        circle(r);
        polygon([
            [0,0],
            [R * cos(a0), R * sin(a0)],
            [R * cos(a1), R * sin(a1)],
            [R * cos(a2), R * sin(a2)],
            [R * cos(a3), R * sin(a3)],
            [R * cos(a4), R * sin(a4)],
            [0,0]
       ]);
    }
}
