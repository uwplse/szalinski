// http://www.wolframalpha.com/input/?i=Fermat+spiral

a = 10;
b = 100;

incrementBy = 10;
height = 18;
wallThickness = 20;

for(t=[0:incrementBy:1000])
hull(){
translate([a*sqrt(t)*cos(t),a*sqrt(t)*sin(t),0])
cylinder(r=wallThickness/2,h=height);
translate([a*sqrt(t+incrementBy)*cos(t+incrementBy),a*sqrt(t+incrementBy)*sin(t+incrementBy),0])
cylinder(r=wallThickness/2,h=height);
}
