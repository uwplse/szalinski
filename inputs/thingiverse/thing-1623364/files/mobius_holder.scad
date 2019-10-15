$fa = 0.5; // default minimum facet angle is now 0.5
$fs = 0.5; // default minimum facet size is now 0.5 

tilt = 25;

back_width = 42;
front_width = 33;
length = 46.5;
min_height = 4;

offset = 4;

screw_outer = 7;
//screw_outer=12;
screw_inner = 2.9;

strap_length = 15;
strap_width = 2.5;

a = (back_width-front_width)/2;
c = sqrt(pow(length,2) + pow(a,2));
alpha = asin(a/c);

difference() {
    cube([back_width, length, length]);
    
    translate([-back_width/2,0,min_height])
        rotate([tilt, 0, 0])
        cube([2*back_width, 2*length, 2*length]);
    rotate([0,0,-alpha])
        translate([-2*back_width,0,-5])
        cube([2*back_width, 2*length, 2*length]);
    translate([back_width,0,-5])
        rotate([0,0,alpha])
        cube([2*back_width, 2*length, 2*length]);

    translate([-screw_outer+offset+screw_outer/2,-screw_outer+offset+screw_outer/2,length/2+min_height])
        cube([2*screw_outer,2*screw_outer,length],center=true);
    translate([back_width+screw_outer-offset-screw_outer/2,-screw_outer+offset+screw_outer/2,length/2+min_height])
        cube([2*screw_outer,2*screw_outer,length],center=true);
    translate([a-screw_outer+offset+screw_outer/2,length+screw_outer-offset-screw_outer/2,length/2+min_height])
        cube([2*screw_outer,2*screw_outer,length],center=true);
    translate([a+screw_outer+front_width-offset-screw_outer/2,length+screw_outer-offset-screw_outer/2,length/2+min_height])
        cube([2*screw_outer,2*screw_outer,length],center=true);
    
    translate([offset,offset,0])   
        cylinder(h=2*length, r=screw_inner/2, center=true);
    translate([back_width-offset,offset,0])
        cylinder(h=2*length, r=screw_inner/2, center=true);
    translate([a+offset,length-offset,0])
        cylinder(h=2*length, r=screw_inner/2, center=true);
    translate([a+front_width-offset,length-offset,0])
        cylinder(h=2*length, r=screw_inner/2, center=true);
        
    translate([back_width/2+2,length/2+5,10])
        rotate([tilt,0,0])
        cube([back_width+5,strap_length,strap_width], center=true);
}
