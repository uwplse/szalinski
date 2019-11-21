stem_radius = 3.25;
stem_height = 20;
cavity_radius = 1.8;
cavity_height = 22;
base_radius = 7.5;
base_height = 2;
fillet_radius = 1.5;
fin_width = 1;
lowrez = 24;
highrez = 60;

$fn = highrez;

module fin () {
hull () {
translate ([stem_radius,0,base_height])
sphere (r=fin_width/2, $fn=lowrez);
translate ([base_radius-fin_width/2,0,base_height])
sphere (r=fin_width/2, $fn=lowrez);
translate ([stem_radius-fin_width,0,base_height+stem_height])
sphere (r=fin_width/2, $fn=lowrez);
}
}


difference () {

union () {

translate ([0,0,base_height])
difference () {

rotate_extrude () 
translate([stem_radius, 0, 0])
square (fillet_radius);

translate ([0,0,fillet_radius])
rotate_extrude () 
translate([stem_radius+fillet_radius, 0, 0])
circle(r = fillet_radius);
}
translate ([0,0,base_height])
cylinder (r=stem_radius, h=stem_height);

cylinder (r=base_radius, h=base_height);

translate ([0,0,base_height+stem_height])
sphere (r=stem_radius);

}

translate ([0,0,-.01])
cylinder (r=cavity_radius, h=cavity_height, $fn=lowrez);
translate ([0,0,cavity_height-.01])
cylinder (r1=cavity_radius, r2=.01,h=cavity_radius, $fn=lowrez);

}

fin ();
rotate ([0,0,120])
fin ();
rotate ([0,0,240])
fin ();

difference () {

rotate_extrude ()
translate ([base_radius,0,0])
circle (r=base_height);

translate ([0,0,-base_height/2])
cube ([base_radius*3, base_radius*3, base_height], center=true);
}