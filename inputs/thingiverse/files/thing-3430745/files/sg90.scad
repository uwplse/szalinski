$fn = 100;

difference()
{
    // main board
    cube([80,30,2], center=true);

    // chassis screw holes
    translate([-30,30/4,-5]) cylinder(d=3.5, h=10);
    translate([-30,-30/4,-5]) cylinder(d=3.5, h=10);

    // servo hole
    #translate([20,0,18.5]) rotate([180,0,0]) sg90();

    // servo screw holes
    translate([-32.5/2+2+20,0,-5]) cylinder(d=2, h=10);
    translate([32.5/2-2+20,0,-5]) cylinder(d=2, h=10);
}

module sg90()
{
    translate([0,0,22.8/2]) cube([22.8,12.6,22.7], center=true); // main box

    translate([0,0,22.8-1])
    {
        hull()
        {
            translate([-1,0,0]) cylinder(d=5, h=4+1); // semi-circle
            translate([1,0,0]) cylinder(d=5, h=4+1);
        }

        translate([5,0,0]) cylinder(d=12.6, h=4+1); // large cylinder
    }

    translate([5,0,22.5-1+4])
    {
        difference()
        {
            cylinder(d=4.6, h=3.2+1); // small cylinder
            translate([0,0,1]) cylinder(d=1.7, h=4); // hole
        }
    }

    difference()
    {
        translate([0,0,16]) cube([32.5,12.6,2.5], center=true); // screw tabs

        translate([-32.5/2+2,0,16-2])
        {
            cylinder(d=2, h=2.5+1); // screw hole
            translate([-2,0,2]) cube([4,1.3,1.3+2], center=true);
        }

        translate([32.5/2-2,0,16-2])
        {
            cylinder(d=2, h=2.5+1); // screw hole
            translate([2,0,2]) cube([4,1.3,1.3+2], center=true);
        }
    }
}