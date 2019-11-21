$fn=30;

ht=47;

difference()
{
    union()
    {
        cylinder(h=ht-14/2,d=14);
    
        translate([0,0,ht-14/2])
        rotate([90,0,0])
        cylinder(h=15,d=15,center=true);
    };

    translate([0,0,ht-14/2])
    rotate([90,0,0])
    cylinder(h=16,d=13,center=true);
    
    translate([0,0,ht])
    rotate([0,45,0])
    cube([16,16,16], center=true);
    
    translate([0,0,-0.01])
    cylinder(h=ht-3*14/2,d=10);
    
    translate([0,0,ht-3*14/2])
    sphere(d=10, center=true);
};
