thickness=5;
cut=thickness+20;
r_axis=4.3;
r_motorshaft=3.5;
r_motorbolt=3.3/2;
bolt_distance = 31;
r_boltplates=1.6;
difference()
{
cube([91.5,42.3,thickness],center=true);
cylinder(h=cut,r=r_axis, center=true, $fn=50);
translate([30,0,0])cylinder(h=cut,r=r_axis, center=true, $fn=50);
translate([-30,0,0])cylinder(h=cut,r=r_axis, center=true, $fn=50);
//bolts between plates    
translate([91.5/2-5,42.3/2-5,0]) cylinder(h=cut,r=r_boltplates, center=true, $fn=20);
translate([91.5/2-5,-42.3/2+5,0]) cylinder(h=cut,r=r_boltplates, center=true, $fn=20);
}


translate([80,0,0]){difference(){
translate([-5,0,0]) cube([52.3,42.3,thickness],center=true);
//bolts between plates    
translate([-52.3/2-5+5,42.3/2-5,0]) cylinder(h=cut,r=r_boltplates, center=true, $fn=20);
translate([-52.3/2-5+5,-42.3/2+5,0]) cylinder(h=cut,r=r_boltplates, center=true, $fn=20);
    
translate([-52.3/2-5,0,0]) cylinder(h=cut,r=8, center=true, $fn=50);    
cylinder(h=cut,r=r_motorshaft, center=true, $fn=50);    
translate([0,0,-thickness/2]) cylinder(h=2,r=11.5, center=true, $fn=50);    
translate([bolt_distance/2,bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=50); 
translate([-bolt_distance/2,bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=50); 
translate([bolt_distance/2,-bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=50); 
translate([-bolt_distance/2,-bolt_distance/2,0]) cylinder(h=cut,r=r_motorbolt, center=true, $fn=50);     
}
    }

