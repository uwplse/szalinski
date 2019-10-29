//The height of the cover
height=100;




holeSize=6.25;


depth=3.5;

difference()
{
    union()
    {
        difference()
        {
            translate([0,7,0]) cylinder(r=10, h=height, center=true, $fn=50);
            translate([0,10,0]) cube([20,20,height+1], center=true);
        }
        translate([0,depth/2, 0]) cube([holeSize, 3.5, height], center=true);
    } 
    for (x=[-1,1])
    {
        translate([x*5.45,2.9,0]) rotate([0,0,x*10]) cube([5,5,height+1], center=true);
        translate([x*holeSize/2,0.4,0]) cylinder(r=1, h=height+1, center=true, $fn=16);
    }
}

