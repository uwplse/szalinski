$fn = 200;
height = 2;
difference()
{
    union()
    {
        translate([0,0,0])
            resize([110,40,height])
                cylinder(d=60,h=height);
    }
    union()
    {
        translate([0,0,height/2]) 
            resize([96,37,height])
                cylinder(d=60,h=height);
    }
}
translate([-44,-14.5,height/2])
    resize([88,30,height])
        import("NUKI.stl");