$fn=50;
half_pipe_dia=21;
half_pipe_wall=3;
pipe_height = 170;

difference()
{
    union()
    {
        translate([0,pipe_height - half_pipe_dia*0.5,0])
            cylinder(d=half_pipe_dia + half_pipe_wall *2, h=15);
        hull()
        {
            translate([-16.5,3,0])
                cylinder(d=0.001,h=3);
            translate([16.5,3,0])
                cylinder(d=0.001,h=3);
            translate([half_pipe_dia * 0.5 ,pipe_height - half_pipe_dia*0.5,0])
                cylinder(d=0.001,h=3);
            translate([half_pipe_dia * -0.5 ,pipe_height - half_pipe_dia*0.5,0])
                cylinder(d=0.001,h=3);
        }
    }
    translate([0,pipe_height - half_pipe_dia*0.5,-0.001])
        cylinder(d=half_pipe_dia, h=15.002);
    translate([(half_pipe_dia + half_pipe_wall *2 ) * -0.5 - 0.001,pipe_height - half_pipe_dia*0.5 +2 ,-0.001])
        cube([half_pipe_dia + half_pipe_wall * 2+ 0.002,(half_pipe_dia + half_pipe_wall * 2) * +0.5 + 0.001,15.002]);
}

difference()
{
    translate([-16.5,0,0])
        cube([33,3,43]);
    translate([-11.5,-0.001,8])
        rotate([-90,0,0])
            cylinder(d=4,h=3.002);
    translate([11.5,-0.001,8])
        rotate([-90,0,0])
            cylinder(d=4,h=3.002);
    translate([-11.5,-0.001,38])
        rotate([-90,0,0])
            cylinder(d=4,h=3.002);
    translate([11.5,-0.001,38])
        rotate([-90,0,0])
            cylinder(d=4,h=3.002);
}

hull()
{
    translate([-1.5,0,0])
        rotate([0,90,0])
            cylinder(d=0.001,h=3);
    translate([-1.5,0,40])
        rotate([0,90,0])
            cylinder(d=0.001,h=3);
    translate([-1.5,pipe_height-half_pipe_dia-half_pipe_wall,15])
        rotate([0,90,0])
            cylinder(d=0.001,h=3);
    translate([-1.5,pipe_height-half_pipe_dia-half_pipe_wall,3])
        rotate([0,90,0])
            cylinder(d=0.001,h=3);
}