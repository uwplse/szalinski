
difference()
{
    cube([16,12,40]);
    translate([1,0,1]) cube([0.5,1,38]);
    translate([14.5,0,1]) cube([0.5,1,38]);
    translate([1,0,1]) cube([14,1,0.5]);
    translate([1,0,39]) cube([14,1,0.5]);
    translate([5,0,30]) cube([6,1,0.5]);
    translate([5,0,31]) cube([6,1,0.5]);
    translate([5,0,32]) cube([6,1,0.5]);
}
translate([2,-1,18]) cube([1,1,4]);    