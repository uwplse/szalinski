
Pin_Distance=42;
shim=0;

dis=Pin_Distance;
len=dis+8;

translate([0,0,shim])
difference()
{
    union()
    {
        translate([-len/2,-3,-shim]) cube([len,6,4+shim]);
        for(rot=[0:180:180]) rotate([0,0,rot])
        {
            translate([-len/2,-3,4]) cube([16,6,5]);
            translate([-dis/2,-3+3*rot/90,5]) rotate([90,0,0])
                color([0,0,1]) cylinder(center=true,h=1.2,d=6,$fn=30);
            translate([-14,0,-shim])
                cylinder(h=9+shim,d=6,$fn=30);
        }
    }
    for(rot=[0:180:180]) rotate([0,0,rot])
    {
         translate([-14,0,-0.1-shim]) cylinder(h=8.1+shim,d=2.7,$fn=30);
         translate([-dis/2,-3+3*rot/90,5]) rotate([90,0,0])
                color([0,0,1]) cylinder(center=true,h=11,d=3,$fn=30);
    }
}
