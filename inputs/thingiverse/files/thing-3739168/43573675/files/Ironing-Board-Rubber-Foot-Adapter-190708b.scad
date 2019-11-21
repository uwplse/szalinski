
difference()
{
    minkowski()
    {
        cylinder(d=22.4,h=22.4,$fn=60);
        sphere(d=(31-22.4),$fn=60);
    };
    translate([0,0,(31-22.4)/2])
    cylinder(d=22.4,h=31,$fn=60);
};