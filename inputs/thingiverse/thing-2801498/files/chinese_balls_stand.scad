/*[Parameters]*/
//in mm
ball_diameter = 50; //[30:100]
//in mm
corner_radius = 5; //[1:10]
//between balls in mm
margin = 5; //[0:30]

/*[Hidden]*/
$fn = 50;
size_x = 2 * ball_diameter + 2 * corner_radius;
size_y = ball_diameter + margin;

difference() {

    hull()
    for (i = [-1:2:1])
    {
        for (j = [-1:2:1])
        {
           translate([i * size_x / 2, j * size_y / 2, 10]) sphere(r=corner_radius);
           translate([i * size_x / 2, j * size_y / 2, 0]) cylinder(r=corner_radius, h = 1);
        }
    }
    
    for (i = [-1:2:1])
    translate([i * (ball_diameter + margin) / 2, 0, ball_diameter / 2 + margin]) sphere(d=ball_diameter, $fn = 50);

}
