// Outer radius of the ball part
ball_radius=5;

// Wall thickness of the ball part
wall_thickness=1.5;

// Width of the slots along the ball part
slot_width=1;

// Gap spacing between the ball and socket
socket_gap=.2;

// Fraction of the socket radius to be enclosed
socket_fraction_enclosed=0.25;

socket_radius = ball_radius + socket_gap;

segment_resolution = ball_radius / 10;

translate ([-2*ball_radius,0,((1/sqrt(2))+2)*ball_radius])
union()
{
    difference()
    {
        sphere(r=ball_radius, $fs=segment_resolution);

        translate([0,0,ball_radius*(2-(1/sqrt(2)))])
            cube([3*ball_radius, 3*ball_radius, ball_radius],center=true);
    
        sphere(r=ball_radius-wall_thickness, $fs=segment_resolution);
    
        translate([0,0,ball_radius*(1-(1/sqrt(2)))])
            cube([2*ball_radius, slot_width, 2*ball_radius],center=true);
    
        translate([0,0,ball_radius*(1-(1/sqrt(2)))])
            cube([slot_width, 2*ball_radius, 2*ball_radius],center=true);
    
    }
    translate([0,0,((-1/sqrt(2))-1)*ball_radius])
            cylinder(r=ball_radius/sqrt(2),h=2*ball_radius,center=true, $fs=segment_resolution);
}

translate ([3*ball_radius,0,0])
difference()
{
    translate([0,0,2*ball_radius])
        cube([4*ball_radius, 4*ball_radius, 4*ball_radius],center=true);
    
    translate([0,0,socket_fraction_enclosed*(ball_radius+socket_gap)])
        union()
        {
            sphere(r=socket_radius, $fs=segment_resolution);
            translate([0,0,socket_radius/sqrt(2)])
                cylinder(h=socket_radius/sqrt(2),r1=socket_radius/sqrt(2),r2=0,center=false, $fs=segment_resolution);
        }
}
