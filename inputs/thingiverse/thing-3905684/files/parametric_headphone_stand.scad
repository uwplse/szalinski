//Parametric Headphone Stand

//Footprint width in mm
w=80;

//Footprint depth in mm
d=100;

//Thickness of stand in mm, minimum of 7mm
t=10;

//Height of stand in mm
h=200;

union(){

difference(){
    translate([0,d/2-t*2,h/2-t])rotate([10,0,0])cube([w,t,h],center=true);
    translate([0,t,-t])cube([w*2,2*d,t],center=true);
    translate([0,-d/4+t/2,h-t])cube([w*2,2*d,t],center=true);
}
difference(){
    translate([0,0,h-t*2])cube([w,d,t],center=true);
    translate([0,d/2+t/2,h/2-t])rotate([10,0,0])cube([2*w,4*t,h*2],center=true);
}
difference(){
    cube([w,d,t],center=true);
    translate([0,d/2+t/2,h/2-t])rotate([10,0,0])cube([2*w,4*t,h*2],center=true);
}
}