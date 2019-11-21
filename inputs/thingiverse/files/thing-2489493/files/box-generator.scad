inside_height  = 150; // inside height of the box
inside_width   = 95;  // inside width of the box
inside_length  = 41;  // inside length of the box
wall_thickness = 2.5; // wall_thickness thickness

pattern_radius   = 3.5;  // size of the pattern element
pattern_min_dist = 4.5; // minimal distance between pattern

//choose sides with pattern
pattern_on_front  = 1; 
pattern_on_back   = 0;
pattern_on_bottom = 1;
pattern_on_sideA  = 1;
pattern_on_sideB  = 1;

//choose a pattern
do_pattern_circle    = 0;
do_pattern_rectangle = 0;
do_pattern_cross     = 0;
do_pattern_hexagone  = 1;
do_pattern_starA     = 0;
do_pattern_starB     = 0;



module element(h,r)
{
    if (do_pattern_circle)
        cylinder(h, r, r);

    if (do_pattern_rectangle)
        cube([r*2,r*2,h*2],center=true);

    if (do_pattern_cross)
        polygon(r, h, 5);

    if (do_pattern_hexagone)
        polygon(r, h, 6);

    if (do_pattern_starA)
        polygon(r, h, 8);

    if (do_pattern_starB)
        polygon(r, h, 9);

}









difference()
{
    difference()
    {
    translate([-wall_thickness, -wall_thickness, -wall_thickness])
        cube([inside_length + wall_thickness*2, inside_width + wall_thickness*2, inside_height + wall_thickness*2]);


    color("red")
        cube([inside_length, inside_width, inside_height+10]);
    }
    
    if (pattern_on_bottom)
        translate([0, 0, -wall_thickness/2])
            grid(inside_width, inside_length); // bottom pattern
    if (pattern_on_sideA)
        rotate([90, 0, 0])
            translate([0, 0, wall_thickness/2])
            grid(inside_height, inside_length); // side A pattern
    if (pattern_on_sideB)
        rotate([90, 0, 0]) 
            translate([0, 0, -inside_width-wall_thickness/2])
            grid(inside_height, inside_length); // side B pattern
    if (pattern_on_front)
        rotate([0, -90, 0])
            translate([0, 0, wall_thickness/2])
            grid(inside_width, inside_height); // front pattern
    if (pattern_on_back)
        rotate([0, -90, 0])
            translate([0, 0, -inside_length-wall_thickness/2])
            grid(inside_width, inside_height); // back pattern
}



module grid(inside_width, inside_length)
{
    a = (inside_width - wall_thickness*2) / (pattern_radius*2 + pattern_min_dist);
    steps_y = round(a-.5);
    ea = a - steps_y;
    step_y = ((inside_width-wall_thickness*2+(ea*pattern_radius*2 + pattern_min_dist)) / steps_y);
//    echo("y->", a, steps_y, ea);
    
    
    b = (inside_length - wall_thickness*2) / (pattern_radius*2 + pattern_min_dist);
    steps_x = round(b-.5);
    eb = b - steps_x;
    step_x = ((inside_length-wall_thickness*2+(eb*pattern_radius*2 + pattern_min_dist)) / steps_x);
//    echo("x->", b, steps_x, eb);
    
//    color("yellow")
//        translate([wall_thickness, inside_width-wall_thickness, 0])
//        cube([pattern_radius*2, ea, wall_thickness+1]);
    
    for (x = [0:steps_x-1])
    {
        for (y = [0:steps_y-1])
        {
            x0 = x*step_x + pattern_radius + wall_thickness;
            y0 = y*step_y + pattern_radius + wall_thickness;
            
            if (x0 < 100000)
            {
                color("blue")
                    translate([x0, y0, -wall_thickness])
                    element(wall_thickness*2, pattern_radius);
//                
//                color("red")
//                    translate([x0-pattern_radius, y0+pattern_radius, -wall_thickness])
//                    cube([pattern_radius*2, pattern_min_dist, wall_thickness*2]);
//                
//                d = pattern_min_dist;
//                color("red")
//                    translate([x0+pattern_radius, y0-pattern_radius, -wall_thickness+1])
//                    cube([d, pattern_radius*2, wall_thickness*2]);
                
                x1 = (.5+x)*step_x + pattern_radius + wall_thickness;
                y1 = (.5+y)*step_y + pattern_radius + wall_thickness;
                
                if (y < steps_y && 
                    x1 < (inside_length-wall_thickness*2+pattern_radius) && 
                    y1 < (inside_width-wall_thickness*2+pattern_radius))
                {
                    color("darkblue")
                        translate([x1, y1, -wall_thickness])
                        element(wall_thickness*2, pattern_radius);
                }
            }
        }
    }
}

module polygon(cle,h,d)
{
	angle = 360/d;
	cote = cle *2 * 1/tan(angle);
    
	union()
	{
		rotate([0,0,0])
			cube([cle*2,cote,h*2],center=true);
		rotate([0,0,angle])
			cube([cle*2,cote,h*2],center=true);
		rotate([0,0,2*angle])
			cube([cle*2,cote,h*2],center=true);
	}
}