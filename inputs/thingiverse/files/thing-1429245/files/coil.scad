module parametric_coil(r_corpus=3,r_border=6,h_border=2,h_corpus=12,h_grip=4, r_hole=1.5) {
$fn=20;
 height=h_border*2+h_corpus+h_grip;

 difference() {
  union() {
   cylinder(r=r_border,h=h_border);
   cylinder(r=r_corpus,h=height);
   translate([0,0,h_corpus+h_border]) cylinder(r=r_border, h=h_border);
  }
  translate([0,0,-1]) cylinder(r=r_hole,h=height+2);
  translate([r_corpus+1,0,-1]) cylinder(r=0.75,h=4);
 }
}

parametric_coil();