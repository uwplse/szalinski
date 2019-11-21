
//Shot Glass Height
height=50;
//Lower Diameter
LD=20;
//Upper Diameter
UD=30;
//Resolution
resolution=200;
union(){
translate([0,0,-5])
cylinder(h=5,r1=LD-3,r2=LD,$fn=resolution);

difference()
{cylinder(h=height, r1=LD, r2=UD,$fn=resolution);

cylinder(h=height+2, r1=LD *.85, r2=UD *.9, $fn=resolution);
}
}

