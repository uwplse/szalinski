module osa()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cylinder(d1=9,d2=15,h=3);
            translate([0,0,3]) cylinder(d=15,h=4);
            translate([0,0,7]) cylinder(d2=9,d1=15,h=3);
        }
        union()
        {
            translate([0,0,0]) cylinder(d=7,h=10,$fn=6);
            for(i=[0:40:360])
            {
                rotate([0,0,-i+15]) translate([6,0,0]) cube([6,6,10]);
            }
        }
    }
    
}

module telo()
{
    difference()
    {
        hull()
        {
            union()
            {
                translate([30,0,0]) cylinder(d1=5,d2=7,h=2);
                translate([30,0,2]) cylinder(d=7,h=6);
                translate([30,0,8]) cylinder(d2=5,d1=7,h=2);
             }
            union()
            {
                translate([0,0,0]) cylinder(d1=18,d2=19,h=2);
                translate([0,0,2]) cylinder(d=19,h=6);
                translate([0,0,8]) cylinder(d2=18,d1=19,h=2);
             }
        }
        union()
        {
            translate([0,0,0]) cylinder(d1=10,d2=16,h=3);
            translate([0,0,3]) cylinder(d=16,h=4);
            translate([0,0,7]) cylinder(d2=10,d1=16,h=3);
            translate([0,-3,2]) cube([50,6,6]);
            translate([30,0,2]) cylinder(d=7.6,h=6);
            translate([30,0,0]) cylinder(d=3,h=10);
            translate([9,-1,0]) rotate([0,0,30]) cylinder(d=4,h=10,$fn=3);
            translate([8,0,0]) cube([2,2,10]);
            
        }
    }
    
}    

module spunt()
{
    difference()
    {
        translate([20,20,0]) cylinder(d=7.6,h=5.4);
        translate([20,20,0]) cylinder(d=3,h=5.4);
    }
}

module jezdec()
{
    difference()
    {
        translate([0,20,0]) cube([15,5,5]);
        union()
        {
            translate([0,20,0]) rotate([0,0,60]) cube([6,6,5]);
            translate([10,22.5,2.5]) rotate([0,90,0]) cylinder(d=4.5,h=10);
        }
    }
}

$fn=30;
osa();
spunt();
jezdec();
telo();


