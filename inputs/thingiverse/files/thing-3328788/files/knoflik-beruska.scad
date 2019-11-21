$fn=50;

height=9;
width=18;
length=17;



module ocko()
{
    difference()
    {
        cylinder(d=4,h=2);
        cylinder(d=2.5,h=2);
    }
    translate([1.5,-3,0]) cube([0.6,6,2]);
}


module beruska_spodek()
{
    difference()
    {
        union()
        {
            translate([1.3,-1.8,3.3]) sphere(d=1.2);
            translate([-1.3,-1.8,3.3]) sphere(d=1.2);

            translate([0,0,0]) sphere(d=8);
            translate([0,6,0]) cylinder(d=15,h=1);

            translate([7,3,0]) sphere(d=2.50);
            translate([8,6,0]) sphere(d=2.50);
            translate([7,9,0]) sphere(d=2.50);
            translate([-7,3,0]) sphere(d=2.50);
            translate([-8,6,0]) sphere(d=2.50);
            translate([-7,9,0]) sphere(d=2.50);
        }
        union()
        {
            translate([-3.2,3.2,0.3]) cube([6.4,2.4,1]);
            translate([-2.2,3.2,0.0]) cube([4.4,2.4,1]);
            translate([0,0,-10]) cylinder(d=55,h=10);
            translate([0,0,1])
            {
                difference()
                {
                    translate([0,6,0]) resize([15.4,15.4,10]) sphere(d=15);
                    translate([0,0,-15]) cylinder(d=55,h=15);
                }
            }
        }
    }
}

module beruska_vrch()
{
    difference()
    {
        union()
        {
            translate([0,6,0]) resize([15,15,10]) sphere(d=15);
        }
        union()
        {
            translate([0,5,6.4]) sphere(d=4);
            translate([4.0,1,4.5]) sphere(d=4);
            translate([6.8,6,4.0]) sphere(d=4);
            translate([4.1,11,4.4]) sphere(d=4);
            translate([-4.0,1,4.5]) sphere(d=4);
            translate([-6.8,6,4.0]) sphere(d=4);
            translate([-4.1,11,4.4]) sphere(d=4);

            translate([-3.2,3.2,0.0]) cube([6.4,2.4,1]);
            translate([0,0,-15]) cylinder(d=55,h=15);
        }
    }
}


resize([length,width,height])
{
    translate([0,5.4,-1.1]) rotate([0,-90,90]) ocko();
    translate([0,0,0]) rotate([0,0,0]) beruska_spodek();
    translate([0,0,1]) rotate([0,0,0]) beruska_vrch();
}