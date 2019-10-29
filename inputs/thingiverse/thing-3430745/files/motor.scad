$fn = 50;

difference()
{
    cube([36.3,22.23,18.64], center=true);
    translate([-12.6,8.7,0]) cylinder(d=3,h=30, center=true);
    translate([-12.6,-8.7,0]) cylinder(d=3,h=30, center=true);
}