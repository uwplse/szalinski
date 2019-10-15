//http://www.wolframalpha.com/input/?i=Archimedes%E2%80%99+spiral

spirals = 1;
a = 0.07;
incrementBy = 10;
height = 10;
wallThickness = 5;

for(i=[0:360/spirals:360])
rotate([0,0,i])
for(t=[0:incrementBy:1000])
hull(){

translate([a*t*cos(t),a*t*sin(t),0])
cylinder(r=wallThickness/2,h=height);

translate([a*(t+incrementBy)*cos(t+incrementBy),a*(t+incrementBy)*sin(t+incrementBy),0])
cylinder(r=wallThickness/2,h=height);
}
