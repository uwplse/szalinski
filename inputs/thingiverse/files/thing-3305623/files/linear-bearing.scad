// linear bearing ... Glyn Cowles Dec 2018
// External diameter
exDiam=15;
// Internal diameter
inDiam=8;
// Length
length=24;
// Shell thickness
th=3; 
// size of inner spline gap
gap0=0.5;
// size of outer spline gap 
gap1=1.3;
// number splines
n=15; 
// angle of splines
angle=70; 
// resolution 
$fn=50;

//-----------------------------------------------------------
difference() {
    d=(exDiam)/2;
    tube(inDiam,exDiam,length);
    for (r=[0:360/n:360]) {
        rotate([0,0,r]) translate([d,0,0]) wedge();
        }
    }
tube(exDiam-th,exDiam,length);
//-----------------------------------------------------------
module tube(di,do,h) {
difference() {
cylinder(h=h,d=do);
cylinder(h=h,d=di);
}
}
//-----------------------------------------------------------
module wedge(){
    points=[[0,0],[(gap1-gap0)/2,exDiam/2],[gap1-(gap1-gap0)/2,exDiam/2],[gap1,0],[0,0]];
    linear_extrude(length) rotate([0,0,angle]) polygon(points);
}
//-----------------------------------------------------------
