$fn=60;
module sideproj() {
linear_extrude (height=38) 
polygon([[0,0],[52,0],[52,4],[0,4/*1:0,0,0,0*/] ,[-0.9,3.42] ,[-1.78,2.87] ,[-2.73,2.3] ,[-3.67,1.76] ,[-4.64,1.24] ,[-5.6,0.77] ,[-6.59,0.34] ,[-7.6,0.04],[-8,0/*1:2,0,-2,0*/] ,[-9.01,0.18] ,[-10.02,0.57] ,[-10.98,1.06] ,[-11.9,1.59] ,[-12.79,2.15] ,[-13.65,2.74],[-14,3],[-16,0/*1:0,0,0,0*/] ,[-15.1,-0.58] ,[-14.22,-1.13] ,[-13.27,-1.7] ,[-12.33,-2.24] ,[-11.36,-2.76] ,[-10.4,-3.23] ,[-9.41,-3.66] ,[-8.4,-3.96],[-8,-4/*1:-2,0,2,0*/] ,[-6.95,-3.79] ,[-6.01,-3.42] ,[-5.07,-2.98] ,[-4.1,-2.48] ,[-3.15,-1.94] ,[-2.24,-1.41] ,[-1.35,-0.86] ,[-0.47,-0.31]]);
}
module lid(height)
{
    translate([2.2,2.2,0]){
    cylinder (r=2.2, h=height, $fn=60);
    translate([0,-2.2,0])
        cube ([13.5,4.4,height]);
    translate([13.5,0,0])
        cylinder (r=2.2, h=height, $fn=60);
    }
}


module base() {
translate([0,0,4])
rotate([180,0,90])
intersection() {
translate([0,25.8,4])
rotate([90,180,90])
scale([0.5,0.5,0.5])
    sideproj();
    union() {
cube([19,6.1,10]);
translate([2,6,0])
{
cube([15,20,10]);
translate([7.5,20,0])
    cylinder(r=7.5,h=10);
}
}
}
}

translate ([1,1,-3.5])
{
    difference(){
    cube([4,17,3.6]);
    translate([2,8.5,-.1])    
        cylinder(r=0.8, h=4.2);
}
}

difference() {
base();
    translate([26-(4.4+13.5),(19-4.4)/2,-.05])
    lid(2.1);
}
//%lid(2);