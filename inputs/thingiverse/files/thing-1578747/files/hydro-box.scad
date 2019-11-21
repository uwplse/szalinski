//Set the number of boxes vertically
i=2; // [1:50]
//Set the number of boxes horizontally
j=2; // [1:50]
//Set the inner box size (in mm)
a=41;
//Set the wall thickness (in mm)
b=1;
//Set the bottom thickness (in mm, not higher than the total height!)
c=1;
//Set the total height of the holder (in mm)
h=40;

for (i =[1:i],j=[1:j]) kostka(a,b,c,h,i,j);

module kostka (a,b,c,h,i,j) {
translate([(i-1)*(a+b),(j-1)*(a+b),0]) union(){
translate([b,b,0]) difference() {
cube([a,a,c],false);
translate([a/2,a*(1-sqrt(2))/2,0]) rotate([0,0,45]) cube([a,a,c],false);
}
difference() {
cube([a+2*b,a+2*b,h],false);
translate([b,b,0]) cube([a,a,2*h],false);
}
}
}