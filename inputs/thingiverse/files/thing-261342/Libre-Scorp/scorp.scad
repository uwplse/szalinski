//libre scorp

// radius of handle
r=10;

// length of handles
z=90;

// blade radius
l=50;

// thickness of top of blade
t=4;

// heigth of blade
h=30;

//seperator
s=10;

n=100;

module blade(){
difference(){
cylinder(h = h, r1 = l,r2 = l, center = true, $fn=n);
cylinder(h = h+1, r1 = l-t,r2 = l, center = true, $fn=n);
translate([0,-l/2,0])cube([2*l+1,l+1,h+1], center = true);
}
}

union(){
translate([0,r-2,h/2])blade();
translate([-l,0,z/2])cylinder(h = z, r1 = r,r2 = r, center = true, $fn=n);
translate([l,0,z/2])cylinder(h = z, r1 = r,r2 = r, center = true, $fn=n);
}
