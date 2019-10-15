$fn = 32;

radius = 1.5;
height = 40;

num = 1;

for (i=[0:num-1]) {
    
    translate([0, i*(radius * 3),0])
    rotate([0,90,0])
    cylinder(r=radius, h=height);
    
}