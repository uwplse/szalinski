// linear bearing V2... Glyn Cowles Apr 2019
// External diameter
exDiam=15;
// Internal diameter
inDiam=8;
// Length
length=24;
// Shell thickness
th=2; 
// diam of inner spline circle
d1=1;
// diam of outer spline circle
d2=2;
// number splines
n=20; 
// resolution 
$fn=50;


    //d=(exDiam)/2;
    tube(exDiam-th*2,exDiam,length);
    for (r=[0:360/n:360]) {
        #rotate([0,0,r]) translate([d1/2+inDiam/2,0,0]) wedge();
        }
//color("black") cylinder(d=inDiam,h=length);
//-----------------------------------------------------------
module tube(di,do,h) {
difference() {
cylinder(h=h,d=do);
cylinder(h=h,d=di);
}
}
//-----------------------------------------------------------
module wedge(){
x=(exDiam-inDiam)/2-d1/2-d2/2;  
linear_extrude(length)    
hull() {
    circle(d=d1);
    translate([x,0]) circle(d=d2);
}
    
}
//-----------------------------------------------------------
