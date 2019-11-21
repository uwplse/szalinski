height = 34;
bottle_radius = 40;
arm_length = 50;

module point(x,y,z)
{
    translate([x,y,z])
    cylinder(r=0.1,h=0.1,center=true);
}

difference()
{
    hull()
    {
        point(0,-5,0);
        point(0,5,0);

        point(arm_length,-5,0);
        point(arm_length,5,0);

        point(arm_length,-5,height);
        point(arm_length,5,height);
    }
        
    /*
    translate([77,-5.5,5])
    cube([3,11,5]);

    translate([77,-5.5,40])
    cube([3,11,5]);
    */
    /*
    translate([20,5.5,2 + 2.5])
    rotate([90,0,0])
    rotate([0,0,90])
    cylinder(r=5,h=11,$fn=3);

    translate([40,5.5,2 + 6.5])
    rotate([90,0,0])
    rotate([0,0,90])
    cylinder(r=13,h=11,$fn=3);

    translate([79,5.5,2 + 13])
    rotate([90,0,0])
    rotate([0,0,90])
    cylinder(r=26,h=11,$fn=3);
    */
}
cylinder(r=10,h=4,$fn=28);

translate([arm_length + bottle_radius - 1,0,0])
intersection()
{
    difference()
    {
        cylinder(r=bottle_radius,h=height,$fn=48);
        
        cylinder(r=bottle_radius - bottle_radius/2,h=height,$fn=48);

        translate([0,0,2])
        cylinder(r=bottle_radius - 2,h=height + 0.2,$fn=48);
    }
    rotate([0,0,180 - 45])
    cube([180,180,80]);
}