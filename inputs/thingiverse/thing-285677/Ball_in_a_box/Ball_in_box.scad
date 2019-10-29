// Radius of the ball
radius = 12;



cube([radius*2+radius/2,radius*2+radius/2,radius/2], center=true);
translate([-radius,-radius,radius*2]) cube([radius/2,radius/2,radius*4], center=true);
translate([-radius, radius,radius*2]) cube([radius/2,radius/2,radius*4], center=true);
translate([ radius,-radius,radius*2]) cube([radius/2,radius/2,radius*4], center=true);
translate([ radius, radius,radius*2]) cube([radius/2,radius/2,radius*4], center=true);
translate([0,0,radius*4]) cube([radius*2+radius/2,radius*2+radius/2,radius/2], center=true);
$fn=50;
translate([0,0,radius+radius/4+.2]) sphere(r=radius, center=true);