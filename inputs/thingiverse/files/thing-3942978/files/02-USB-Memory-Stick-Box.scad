$fn=60;

boxLength=60;
boxWidth=60;
boxHeight=14.5;
lidLength=boxLength;
lidWidth=boxWidth;
lidHeight=14.5;
generateBox="Yes"; //[Yes, No]
generateLid="Yes"; //{Yes, No]

r=0.1*boxWidth;
bt=1.5; wt=2;
t=0.15;
lock=4.5;

if (generateBox == "Yes") showBox(boxLength,boxWidth,boxHeight,r);
if (generateLid == "Yes") showLid(lidLength,lidWidth,lidHeight,r);

module showBox(x,y,z,r){
    translate([-(x/2+5),0,0]){
        difference(){
            union(){
                roundBox(x,y,z-lock,4);
                translate([0,0,z-lock]) roundBox(x-(2*wt)-(2*t),y-(2*wt)-(2*t),2.5,2-t);
                translate([0,0,z-lock]) sphericalBox(x-(2*wt)-(2*t),y-(2*wt)-(2*t),4.5,2-t);
            } //union
            union(){
                for (i=[-16.5:16.5:16.5]){
                    for (j=[-20:10:20]){
                        translate([i,j,z-12.5]) roundBox(12.5,5,12.5,0.5);
                    } //for j
                } // for i   
            } //union
        } //difference
    } //translate
} //module showBox

module showLid(x,y,z,r){
    translate([x/2+5,0,0]){
        difference(){
            roundBox(x,y,z,4);
            union(){
                translate([0,0,1.5]) roundBox(x-(4*wt),y-(4*wt),z-1.5,0.5+t);
                translate([0,0,z-lock]) roundBox(x-(2*wt)+(2*t),y-(2*wt)+(2*t),z-lock,2+t);
            } //union
        } //difference
    } //translate
} //module showLid

module roundBox(x,y,z,r){
    hull(){
        translate([x/2-r,y/2-r,0]) cylinder(r=r,h=z);
        translate([-(x/2-r),(y/2-r),0]) cylinder(r=r,h=z);
        translate([-(x/2-r),-(y/2-r),0]) cylinder(r=r,h=z);
        translate([x/2-r,-(y/2-r),0]) cylinder(r=r,h=z);
    } //hull
} //module roundBox

module sphericalBox(x,y,z,r){
    hull(){
        translate([x/2-r,y/2-r,r]) sphere(r=r);
        translate([-(x/2-r),y/2-r,r]) sphere(r=r);
        translate([-(x/2-r),-(y/2-r),r]) sphere(r=r);
        translate([x/2-r,-(y/2-r),r]) sphere(r=r);
        translate([x/2-r,y/2-r,z-r]) sphere(r=r);
        translate([-(x/2-r),y/2-r,z-r]) sphere(r=r);
        translate([-(x/2-r),-(y/2-r),z-r]) sphere(r=r);
        translate([x/2-r,-(y/2-r),z-r]) sphere(r=r);
    } //hull
} //module sphericalBox

