$fn = 200;
holesize = 26; // small are 25 square by 28 high, large are 31x35mm
baseheight = 25;
wall = 3;

/* round version
difference()
{
    cylinder(h = baseheight, r1 = 40, r2 = 25, center = true);
    translate([0,0,3]) cube(size=holesize, center = true);
}
*/

rotate([0,180,0])
{
    difference()
    {
        linear_extrude(height=baseheight, center=true, scale=[1,2]) circle(r=holesize-wall);
        translate([0,0,-wall]) cube(size=holesize, center=true);
    }
}
