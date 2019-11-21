difference() 
{
cube([100,12,1.3]);
    translate([20,6,0])
    cylinder(r=3/2, h=2.3,$fn=100);
    translate([80,6,0])
    cylinder(r=3/2, h=2.3,$fn=100);
}
cube([100,1,5.8]);
translate([0,11.5,0])
cube([100,1,5.8]);
translate([0,0.5,5])
cube([100,2,0.8]);
translate([0,10,5])
cube([100,1.5,0.8]);

