r_axis=4.3;
r_syringe=5;
thickness=5;
cut=thickness+20;
difference()
{
cube([90,90,thickness],center=true);
cylinder(h=cut,r=r_axis, center=true, $fn=100);
    
translate([30,0,0])cylinder(h=cut,r=r_axis, center=true, $fn=100);
translate([-30,0,0])cylinder(h=cut,r=r_axis, center=true, $fn=100);
//foro siringa
translate([0,-30,0])cylinder(h=cut,r=r_syringe, center=true, $fn=100); 
translate([0,52,0]) cube([130,80,cut],center=true);
  translate([45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
translate([-45,-47.5,0]) rotate([0,0,45]) cube([40,40,cut],center=true);
}
