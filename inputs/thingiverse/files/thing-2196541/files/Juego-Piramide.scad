l=30;
rb=l/sqrt(3);
ht=l*sqrt(2/3);
a=35.25;
htr=sqrt((l*l)*3/4);

translate([-l/2,0,0])
difference() {
cylinder(h=ht, r1=rb, r2=0, $fn=3);

rotate(-a, [0, 1, 0]) 
translate([rb-(htr/2),-l/2,-ht/2]) 
cube([l/2,l,l*1.3]);
}

translate([l/2,0,0])
difference() {
cylinder(h=ht, r1=rb, r2=0, $fn=3);

rotate(-a, [0, 1, 0]) 
translate([rb-(htr/2),-l/2,-ht/2]) 
cube([l/2,l,l*1.3]);
}
