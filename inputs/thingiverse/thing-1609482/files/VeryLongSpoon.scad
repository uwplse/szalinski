width = 170; // [50:300]
height = 6;  // [4:20]
depth = 7;   // [4:20]
UseCubicTip = "yes"; // [yes,no]
/* HIDDEN */
$fn=50;
CubicTip= (UseCubicTip=="yes");

P1(false);
translate([width+depth,depth*4])rotate(a=[0,0,180]) P1(CubicTip);

module P1(Cubic){    
    cS1 = depth*2;
    cS2 = depth*1.5;
    cube([width,depth,height]);
    translate([-depth*2,0])cube([depth*2,depth,height/2-0.1]);
    translate([width+depth-depth/2+1,depth/2]) difference(){
        hull(){
            cylinder(d=depth*2,h=height);
            if(Cubic) {translate([depth,-cS1/2]) cube([cS1,cS1,height]);}
            else {translate([depth,0]) cylinder(d=depth*2,h=height);}
        }
        translate([0,0,height*2/3+0.1]) hull(){
            cylinder(d=depth*1.5,h=height/3);
            if(Cubic) {translate([depth,-cS2/2]) cube([cS2+1,cS2,height/3]);}
            else {translate([depth,0]) cylinder(d=depth*1.5,h=height/3);}
        }
    }
}