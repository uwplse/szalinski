
difference()
{
    cylinder(d=31,h=31,$fn=60);
    translate([0,0,(31-22.4)/2])
    cylinder(d=22.4,h=31,$fn=60);
};