//Clip for plastic storage box
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"clip_lid_storage_box" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//7/10/2016 - Released

/* [Options] */
// preview[view:south east, tilt:top diagonal]
// Clip thickness.
Clip_thickness=4; // [1:10]
// Width of the clip.
Clip_width=10; // [5:50]
// Section A length.
Section_A=6; // [3:10]
// Section B length.
Section_B=6; // [2:10]
// Section B fillet radius.
Section_BR=2; // [0:5]
// Section C length.
Section_C=19; // [10:30]
// Section C fillet radius.
Section_CR=8; // [0:20]
// Section D length.
Section_D=17; // [5:20]
// Section E length.
Section_E=5; // [5:20]
// Section F length.
Section_F=5; // [5:20]
// Number of clip to generate
Clip_number=1; // [1:4]

/* [Hidden] */
N=Clip_number; 
W=Clip_width;
T=Clip_thickness;
aL=Section_A;
aW=W;
aT=T;
R1=Section_BR;
bL=T;
bW=W;
bT=Section_B;
cL=Section_C;
cW=W;
cT=T;
R2=Section_CR;
dL=T;
dW=W;
dT=Section_D;
eL=Section_E;
eW=W;
eT=T;
fL=T;
fW=W;
fT=Section_F;

$fn=40;
epsilon=0.1;
module ocylinder(r1,r2,h) {
    difference() {
        cylinder(r=r1,h=h,center=true);
        cylinder(r=r2,h=h+epsilon,center=true);
    }
}

module a() {
    hull() {
        translate([-cL/2-aL-T,0,0]) rotate([90,0,0]) cylinder(r=T/2,h=W,center=true);
        translate([-0.5-cL/2-T,0,0]) cube([1,cW,cT],center=true);
    }
}

module fillet(R) {
    difference() {
        rotate([90,0,0]) ocylinder(r1=R+T,r2=R,h=W);
        coL=R+T;
        coW=W;
        coT=coL*2;
        //translate([coL/2+epsilon,0,0]) cube([coL+epsilon,coW+epsilon,coT],center=true);
        //translate([0,0,-coL/2-epsilon]) cube([coT+epsilon,coW+epsilon,coL+epsilon],center=true);
        translate([coT/2,0,0]) cube([coT,coW+epsilon,coT],center=true);
        translate([0,0,-coT/2]) cube([coT,coW+epsilon,coT],center=true);
    }
}

module lid_clip() {
    hull() {
        a();
        translate([-R2/2,0,0]) cube([cL-R2,cW,cT],center=true);
    }
    translate([R1-cL/2,0,-R1-T/2]) fillet(R=R1);
    translate([R1-cL/2-R1*2-T,0,-R1-T/2]) mirror([1,0,0]) fillet(R=R1);
    translate([-bL/2-cL/2,0,-bT/2-cT/2]) cube([bL,cW,bT],center=true);
    translate([-R2+cL/2,0,-R2-T/2]) mirror([1,0,0]) fillet(R=R2);
    translate([cL/2+dL/2,0,-dT/2-cT/2-R2/2]) cube([dL,dW,dT-R2],center=true);
    hull() {
        translate([cL/2,0,-dT-T/2]) rotate([0,180,0]) fillet(R=0);
        translate([-eL/2+cL/2,0,-eT-dT]) cube([eL,eW,eT],center=true);
        translate([cL/2-eL,0,-dT-T/2]) rotate([0,-90,0]) fillet(R=0);
    }
    translate([-fL/2+cL/2-eL,0,fT/2-dT-T/2]) cube([fL,fW,fT],center=true);
}

module c1() {
    rotate([-90,0,0]) translate([cL/2+bL+aL/2,0,aT/2+bT+T]) lid_clip();
}


c1();
if (N>1) { rotate([0,0,90]) c1(); }
if (N>2) { rotate([0,0,180]) c1(); }
if (N>3) { rotate([0,0,270]) c1(); }

//translate([-T,0,-cL/2-bL-aL-T*2]) rotate([0,90,0]) lid_clip();
