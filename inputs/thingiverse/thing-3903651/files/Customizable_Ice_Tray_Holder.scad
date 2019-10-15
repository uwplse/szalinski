//Holder Length
l=100;

//Holder Height
h=50;

//Holder Thickness
t=4;

//Holder Width
w=20;

//Rung Thickness
r=5;
difference()
{
cube([l,h,w]);	
translate([t,t,0]) cube([l-2*t, h-t, w]);
}
difference()
{
translate([-2*t-r,h-2*t-r,0]) cube([2*t+r, 2*t+r, w]);
translate([-t-r,h-2*t-r,0]) cube([r,r+t,w]);
}
difference()
{
translate([l,h-2*t-r,0]) cube([2*t+r, 2*t+r, w]);
translate([l+r,h-2*t-r,0]) cube([r,r+t,w]);
}