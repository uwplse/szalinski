// - Screw Diameter (mm) (default=3)
screwsize = 3; //[3,4,5]
// - Counter Bore Diameter (mm) (default = 6)
cbsize = 6; //[6,8,9]
// Rubber Rod Diameter (mm) (default = 12.70)
rubberdia = 12.70; //[6:25.4]
// Base Diameter (mm) (default = 25.4)
basedia = 25.4; //[25.4:40]
module mainbodyextrusion(){
    rotate_extrude($fn=200) polygon( points=[[0,0],[0,38.75],[13.21,38.75],[basedia,5.80],[basedia,0]] );
}
 
module mountingscrewholes (){
    translate([0,19.05,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2); 
    translate([-16.50,-9.530,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2);
    translate([16.50,-9.530,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2);
}
module mountingscrewcb (){
    translate([0,19.05,8]) cylinder(h=50,r1=cbsize/2,r2=cbsize/2); 
    translate([-16.50,-9.530,8]) cylinder(h=50,r1=cbsize/2,r2=cbsize/2);
    translate([16.50,-9.530,8]) cylinder(h=50,r1=cbsize/2,r2=cbsize/2);
}
module rubbercb () {
    translate([0,0,13.5]) cylinder(h=35,r1=rubberdia/2,r2=rubberdia/2);
}
module horizontalbolt (){
     translate([0,25,27.71])rotate([90,90,0])cylinder(h=50,r1=screwsize/2,r2=screwsize/2);
}
difference (){
    mainbodyextrusion ();
    mountingscrewholes();
    mountingscrewcb();
    rubbercb();
    horizontalbolt();
}