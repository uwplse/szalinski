//thickness of the shuriken (4mm works well)
shuriken_w = 4;
//Number of points
shuriken_points = 4;
//Shuriken diameter (without pins)
shuriken_dia = 50;
//Diameter of the middle hole
middle_hole_dia = 20;
tolerance = 0.2;
module shuriken()
{
    difference()
    {
        cylinder(r=shuriken_dia/2, h= shuriken_w, center=true);
        for(x=[0:shuriken_points -1])
        {
           
            rotate([0,90,360/shuriken_points*x])
             translate([0,0,shuriken_dia/2 - 9.5])
            cylinder(r=4+tolerance, h=2+tolerance*2, center=true, $fn=16);
            rotate([0,90,360/shuriken_points*x])
             translate([0,0,shuriken_dia/2 -5])
            cylinder(r1= 2.3+tolerance, r2=2.5+tolerance, h=10, center=true, $fn=16);
            rotate([0,0,360/shuriken_points * (x + 0.5)])
             translate([shuriken_dia*0.62,0,0])
            cylinder(r=shuriken_dia/shuriken_points + 5, h=10, center=true,$fn= 32);
            cylinder(r=middle_hole_dia/2,h=10,center=true,$fn= 32);
        }
    }
}
shuriken();