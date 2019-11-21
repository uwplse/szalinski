
base_height=2;
column_height=4;
screw_hole_diameter=2.9;
bh=base_height;
ch=column_height;
shd=screw_hole_diameter;

difference()
{
    translate([3.25,3.25,0])
    {
        $fn=50;
        minkowski()
        {
            cube([30.5,30.5,bh/2]);
            cylinder(r=3,h=bh/2);
        }       
    }
    for(dx=[3.25:30.5:35])
        for(dy=[3.25:30.5:35])
        {
            translate([dx,dy,-0.1]) cylinder(h=bh+0.2,d=shd,$fn=30);
        }
}
 

for(dx=[3.25:30.5:35])
    for(dy=[3.25:30.5:35])
    {
        difference()
        {
            translate([dx,dy,bh]) cylinder(h=ch,d=6,$fn=30);
            translate([dx,dy,bh-0.1]) cylinder(h=ch+0.2,d=shd,$fn=30);
        }
    }