
// Outside radius to fit cage
outside_radius =  15.8;
// Inside radius to fit the plug
inside_radius = 14.1;
// Cup size
cupsize = 10.0;

/* [Hidden] */
heit = 13.0;
heit1 = 10.0;
heit2 = 3.0;
heit3 = 5.0;
$fn = 60;

module try3()
{
    translate([0,0,0])
    difference()
    {
        cylinder(r=inside_radius/2+.4,h=3);
        cylinder(r=inside_radius/2,h=3);
    }
    translate([0,0,3])
    difference()
    {
        cylinder(r1=inside_radius/2+.4,r2=outside_radius/2+.2,h=2);
        cylinder(r1=inside_radius/2,r2=outside_radius/2-.2,h=2);
    }
    translate([0,0,5])
    difference()
    {
        cylinder(r1=outside_radius/2+.2,r2=outside_radius/2-.2,h=5);
        cylinder(r1=outside_radius/2-.2,r2=outside_radius/2-.6,h=5);
    }
    
    translate([0,0,heit1])
        difference()
        {
            cylinder(r1=outside_radius/2-.2,r2=cupsize/2+.4,h=heit2);
            cylinder(r1=outside_radius/2-.6,r2=cupsize/2,h=heit2);
        }
    translate([0,0,heit1+heit2])
    difference()
    {
        cylinder(r1=cupsize/2+.4,r2=cupsize/2+.6,h=heit3);
        cylinder(r1=cupsize/2,r2=cupsize/2+.2,h=heit3);
    }
    difference()
    {
        hull()
        {
            cylinder(r=22/2,h=1);
            translate([29/2-2.5,0,0])
                cylinder(r=2.5,h=1);
            translate([-29/2+2.5,0,0])
                cylinder(r=2.5,h=1);
        }
        cylinder(r=inside_radius/2+.4,1);
    }

}


try3();
