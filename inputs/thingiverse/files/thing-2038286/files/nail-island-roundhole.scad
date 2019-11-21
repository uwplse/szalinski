$fn = 200;
holesize = 26;
baseheight = 25;
wall = 3;

rotate([0,180,0])
{
    difference()
    {
        linear_extrude(height=baseheight, center=true, scale=[1,2]) circle(r=holesize-wall);
        translate([0,0,-wall]) cylinder(d=holesize, h=baseheight+wall, center=true);
    }
}
