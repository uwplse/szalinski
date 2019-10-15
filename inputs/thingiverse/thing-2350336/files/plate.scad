$fn=100;

w=25;   // size of square
thick=5;  // thickness
drillhole_r=2;  // radius of drill hole
drilloff=2;   // offset from edge of drill hole


difference()
{
cube([w,w,thick]);
translate([drilloff+drillhole_r,drilloff+drillhole_r,-1]) cylinder(h=thick+2,r=drillhole_r);
translate([w-(drilloff+drillhole_r),drilloff+drillhole_r,-1]) cylinder(h=thick+2,r=drillhole_r);
translate([drilloff+drillhole_r,w-(drilloff+drillhole_r),-1]) cylinder(h=thick+2,r=drillhole_r);
translate([w-(drilloff+drillhole_r),w-(drilloff+drillhole_r),-1]) cylinder(h=thick+2,r=drillhole_r);
}