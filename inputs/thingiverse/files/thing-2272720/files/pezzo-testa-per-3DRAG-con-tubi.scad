r_axis=4.5;
r_vite=5.5/2;
r_syringe=5;
thickness=10;
cut=thickness+20;

union()
{
    translate([30,0,0])
    difference()
    {
        cylinder(h=45,r=r_axis+3.5,$fn=100);
        translate([0,0,-1])
    cylinder(h=57,r=r_axis,$fn=100);
    }
    translate([-30,0,0])
    difference()
    {
        cylinder(h=45,r=r_axis+3.5,$fn=100);
        translate([0,0,-1])
    cylinder(h=57,r=r_axis,$fn=100);
    }
  difference()
 {
cube([90,100,thickness],center=true);
cylinder(h=cut,r=r_axis, center=true, $fn=100);
     
     //fissaggi camicia
     translate([r_axis+12,-30,0])
     cylinder(h=cut,r=r_axis-1, center=true, $fn=100);
      translate([-r_axis-12,-30,0])
     cylinder(h=cut,r=r_axis-1, center=true, $fn=100);
     
     translate([0,-65,0])
     cube(40,40,cut,center=true);
    
translate([30,0,0])#cylinder(h=cut,r=r_axis, center=true, $fn=100);
translate([-30,0,0])cylinder(h=cut,r=r_axis, center=true, $fn=100);
    
translate([15,28+5,0])cylinder(h=cut,r=r_vite, center=true, $fn=100);
translate([-15,28+5,0])cylinder(h=cut,r=r_vite, center=true, $fn=100);    
//foro siringa
translate([0,-30,0])cylinder(h=cut,r=r_syringe, center=true, $fn=100); 
translate([0,52+30,0]) cube([130,60,cut],center=true);
  translate([45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
translate([-45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
 }
}
