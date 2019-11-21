use <write.scad>

all();

ball_diameter   = 60;
wall            =  3;
side            =  6;
angle           = 60; // [30, 45, 60, 90]
your_logo       = "3D by Salvador";
text_size       =  3;
text_rotation   =140;
cylinder_elements = 50;

$fn=cylinder_elements;

module all()
{
    ball();
    hook();
    logo();
}

module logo()
{
    rotate([90,text_rotation,0]) writecylinder(your_logo,[0,0,0],ball_diameter/2,40,rotate=0,h=text_size,center=true);
}

module hook()
{
    translate([0,wall/2,ball_diameter/2+3])
    rotate([90,0,0])
    difference()
    {
        cylinder(d=10, h=wall);
        cylinder(d=6, h=wall);
    }        
}

module ball()
{
    for(alpha = [angle:angle:180])
    {
        rotate([90,0,alpha])
        {
            difference()
            {
                cylinder(d=ball_diameter, h=side, center=true);
                cylinder(d=ball_diameter-2*wall, h=side, center=true);
            }        
        }
    }
}