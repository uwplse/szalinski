//base radius
r=70;

//base height
b=4;

//height
h=150;

//thickness
t=70;

// translate height
y=80;

difference(){
hull(){
cylinder(h = b, r=r, center=true, $fn=100); //bottom
translate([0,0,y])rotate([90,0,0])cylinder(h = t+2, r=r-0.5, center=true, $fn=100); //top
}
rotate([0,0,90])translate([0,0,h/2+b/2])cube(size = [t,2*t,h], center = true);
cylinder(h=b+1, r=r/2, center=true, $fn=100); //cut out bottom
}