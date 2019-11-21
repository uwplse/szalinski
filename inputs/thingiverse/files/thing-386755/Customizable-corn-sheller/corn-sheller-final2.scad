//Open-source parametric hand corn sheller

// height of corn sheller
h=55;

// radius of top of corn sheller
rt=35; //[50:130]

rb=0.85*rt; //radius of bottom of corn sheller

//number of digits
d=6;

// digit radius
r=1.5;

// extra length of digit
l=1;

// thickness of sheller
t=3;

module sheller(){
union (){
for (z = [0:d]) // d iterations, z = 0 to d
{
    rotate([0,0, z*360/d])translate([rb,0,h*.1])finger();
}
difference(){
cylinder(h = h, r1 =rt, r2 =rb, center = true, $fn=100);
translate([0,0,0])cylinder(h = h+1, r1 =rt-t, r2 =rb-t, center = true, $fn=100);
}
}
}
module finger(){
rotate([0,(rb/rt)*-10,0])
hull(){
cylinder(h = h*.9, r1 =2*r, r2 =2*r, center = true, $fn=100);
translate([l-(rt-rb),0,0])cylinder(h = h*.9, r1 =r, r2 =r, center = true, $fn=100);
}
}

rotate([180,0,0])
difference(){
sheller();
translate([0,0,h/2])cylinder(h=10, r=rt+10);
}