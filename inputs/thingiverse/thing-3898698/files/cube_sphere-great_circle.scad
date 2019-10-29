diameter = 45;

translate([diameter/2,diameter/2,diameter/2]) sphere(d=diameter,$fn=50);
translate([diameter+5,0,0]) base();

module base()
{
    difference()
    {
        cube([diameter+10,diameter+10,diameter/2+2]);
        translate([diameter/2 + 5,diameter/2+5,diameter/2+2]) sphere(d=diameter+2,$fn=50);
    }
}