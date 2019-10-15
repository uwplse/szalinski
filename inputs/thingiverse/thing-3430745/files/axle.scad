$fn = 100;

/*
axle length: 9.2
axle size: 4.65x6.9
axle hole: d=1.75
servo hole: d=4.6 (actually 5), h=3.2
*/

axle(100);

module axle(axle_len)
{
    rotate([0,90,0])
    {
        translate([-0.8,0,0]) cube([5,7,axle_len/3], center=true);

        intersection()
        {
            cube([3.4,5.4,axle_len], center=true);
            cylinder(h=axle_len, d=5.4, center=true);
        }
    }
}
