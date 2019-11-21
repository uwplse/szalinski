radius = 5;
fn = 5;
layers=35;
translate(v = [0, 0, -1])
linear_extrude( height = 1)
offset(r=radius, $fn=20)
circle(r=radius, $fn=fn);
vase(layers);

module vase(l) {
    for (i=[0:l]) { 
difference() {
    translate(v = [0, 0, i])
    rotate([0,0,i])
    linear_extrude( height = 1)
offset(r=radius, $fn=20)
circle(r=radius, $fn=fn);
    translate(v = [0, 0, i])
    rotate([0,0,i])
    linear_extrude( height = 1)
    offset(r=radius-.7, $fn=20)
circle(r=radius, $fn=fn);
}
}
}