// number of trays
n=2; // [0, 1, 2, 3, 4, 5]
// length of tray (cm)
l=10; // [5:1:20]
// diameter of trays (cm)
d=5.0; // [3:0.5:10]
// thickness (mm)
t=2.0; // [0.5:0.5:10]

translate([0,15,0])
cube([5*d+t,t,l*10]);
translate([5*d+t,0,0])
cube([t,15+t,l*10]);

translate([0,15+(n*2+1)*(10*d+t),0])
cube([5*d+t,t,l*10]);
translate([5*d+t,15+(n*2+1)*(10*d+t),0])
cube([t,15+t,l*10]);

translate([0,(d*5)+15+t,0])
difference()
{
    cylinder(r=(d*5)+t,h=l*10,$fn=100);
    translate([0,0,-1])
    cylinder(r=d*5,h=(l*10)+2,$fn=100);
    translate([0,-d*10,-1])
    cube([d*20,d*20,l*20]);
}
for(i=[1:n])
{
   translate([0,(5*d)+t+15+((i*2)-1)*(d*10+t),0])
   difference()
    {
        cylinder(r=(d*5)+t,h=l*10,$fn=100);
        translate([0,0,-1])
        cylinder(r=d*5,h=(l*10)+2,$fn=100);
        translate([-d*20,-d*10,-1])
        cube([d*20,d*20,l*20]);
    } 
    translate([0,(5*d)+t+15+i*2*(d*10+t),0])
    difference()
    {
        cylinder(r=(d*5)+t,h=l*10,$fn=100);
        translate([0,0,-1])
        cylinder(r=d*5,h=(l*10)+2,$fn=100);
        translate([0,-d*10,-1])
        cube([d*20,d*20,l*20]);
    } 
}
