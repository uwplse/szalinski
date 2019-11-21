p=1.5;//padding. Token wiggle room
t=3;//thickness of holder rims
base_thick=2;

$fn=256;
showTokens=false;


tokenHolder1();
translate([0,40,0])tokenHolder2();
translate([0,80,0])tokenHolder3();

module tokenHolder1() {
    base_width=110;
    base_depth=10;
    sp=2;
    color("green")translate([0,-base_depth/2,0])cube([base_width,base_depth,base_thick]);
    
    tokenHolderHealth5();
    translate([((25.4+p)/2)+p+sp+p+((21.5+p)/2),0,0])tokenHolderHealth();
    translate([((25.4+p)/2)+p+sp+p+(21.5+p)+p+sp+p+((21.5+p)/2),0,0])tokenHolderHealth();
    translate([((25.4+p)/2)+p+sp+p+(21.5+p)+p+sp+p+(21.5+p)+p+sp+p+((20+p)/2),0,0])tokenHolderHex();
    translate([((25.4+p)/2)+p+sp+p+(21.5+p)+p+sp+p+(21.5+p)+p+sp+p+(20+p)+p+sp+p+((20+p)/2),0,0])tokenHolderHex();
}

module tokenHolder2() {
    base_width=140;
    base_depth=20;
    spacing=[-1,-1,-1,-1,-1,-3];
    color("green")translate([0,-base_depth/2,0])cube([base_width,base_depth,base_thick]);
    
    rotate([0,0,180])tokenHolderTerminal();
    translate([((18+p)/2)+p+spacing[0]+p+((24.1+p)/2),0,0])tokenHolderCrate();
    translate([((18+p)/2)+p+spacing[0]+p+(24.1+p)+p+spacing[1]+p+((24.1+p)/2),0,0])tokenHolderCrate();
    translate([((18+p)/2)+p+spacing[0]+p+(24.1+p)+p+spacing[1]+p+(24.1+p)+p+spacing[2]+p+((25.5+p)/2),0,0])tokenHolderDisc();
    translate([((18+p)/2)+p+spacing[0]+p+(24.1+p)+p+spacing[1]+p+(24.1+p)+p+spacing[2]+p+(25.5+p)+p+spacing[3]+p+((25.5+p)/2),0,0])tokenHolderDisc();
    translate([((18+p)/2)+p+spacing[0]+p+(24.1+p)+p+spacing[1]+p+(24.1+p)+p+spacing[2]+p+(25.5+p)+p+spacing[3]+p+(25.5+p)+p+spacing[4]+p+((25.5+p)/2),0,0])tokenHolderDisc();
}

module tokenHolder3(){
    h=30;
    sp=-1;
    base_width=(19.2+t+p)*3+(3*sp);
    base_depth=10;
    color("green")translate([0,-base_depth/2,0])cube([base_width,base_depth,base_thick]);
    
    for(x=[0:3]){translate([(19.2+t+p)*x+(x*sp),0,0]){
    difference(){
        cylinder(d=19.2+p+t,h=h);
        translate([0,0,base_thick])tokenDiscSmall(height=h+1);
        rotate([0,0,45])translate([0,0,base_thick])cube([20,20,h+1]);
        rotate([0,0,225])translate([0,0,base_thick])cube([20,20,h+1]);
    }
    if (showTokens) {translate([0,0,2])rotate([0,0,45])tokenDiscSmall();}
    }}
}

module tokenHolderDiscQuad(){
    h=30;
    gaps=[225,315,225,315];
    for(x=[0:3]){rotate([0,0,x*90])translate([(19.2+t)/2,-(19.2+t)/2,0]){
    difference(){
        cylinder(d=19.2+p+t,h=h);
        translate([0,0,base_thick])tokenDiscSmall(height=h+1);
        rotate([0,0,gaps[x]])translate([0,0,base_thick])cube([20,20,h+1]);
    }
    if (showTokens) {translate([0,0,2])rotate([0,0,45])tokenDiscSmall();}
    }}
}

module tokenHolderDisc(){
    h=30;
    difference(){
        cylinder(d=25.5+p+t,h=h);
        translate([0,0,base_thick])tokenDisc(height=h+1);
        rotate([0,0,45])translate([0,0,base_thick])cube([20,20,h+1]);
        rotate([0,0,225])translate([0,0,base_thick])cube([20,20,h+1]);
    }
    
    if (showTokens) {translate([0,0,2])rotate([0,0,45])tokenDisc();}
}

module tokenHolderCrate(){
    h=30;
    difference(){
        cylinder(d=24.1+p+t,h=h);
        translate([0,0,base_thick])rotate([0,0,45])tokenCrate(height=h+1);
        rotate([0,0,45])translate([0,0,base_thick])cube([20,20,h+1]);
        rotate([0,0,225])translate([0,0,base_thick])cube([20,20,h+1]);
    }
    
    if (showTokens) {translate([0,0,2])rotate([0,0,45])tokenCrate();}
}

module tokenHolderTerminal(){
    h=30;
    difference(){
        cylinder(d=18+p+t,h=h);
        translate([0,0,base_thick])tokenTerminal(height=h+1);
    }
    if (showTokens) {translate([0,0,2])tokenTerminal();}
}

module tokenHolderHealth(){
    h=50;
    difference(){
        cylinder(d=14.8+p+t,h=h);
        translate([0,0,base_thick])tokenHealth(height=h+1);
    }
    if (showTokens) {translate([0,0,2])tokenHealth();}
}

module tokenHolderHealth5(){
    h=50;
    difference(){
        cylinder(d=17.5+p+t,h=h);
        translate([0,0,base_thick])tokenHealth5(height=h+1);
    }
    if (showTokens) {translate([0,0,2])tokenHealth5();}
}

module tokenHolderHex(){
    h=50;
    difference(){
        cylinder(d=20+p+t,h=h);
        translate([0,0,base_thick])tokenHex(height=h+1);
        rotate([0,0,45])translate([0,0,base_thick])cube([20,20,h+1]);
        rotate([0,0,225])translate([0,0,base_thick])cube([20,20,h+1]);
    }
    
    if (showTokens) {translate([0,0,2])tokenHex();}
}

module tokenHealth5(dia=17.5,height=2.45){
    tip_w=6+p;
    base_w=8.2+p;
    //le=5;//length from cylinder circumference
    points=4;
    width=25.4+p;
    le=(width-dia)/2+p;
    po=1.2;//PointOverlap
    color("red")union(){
        for (x=[1:points]){
            //point
            rotate([0,0,(360/points)*x])
            union(){
                translate([dia/2-po,-tip_w/2,0])cube([le+po,tip_w,height]);
                translate([dia/2+le,tip_w/2,0])rotate([0,-90,0])trangle(height,(base_w-tip_w)/2,le+po);
                translate([dia/2+le,-tip_w/2,height])rotate([0,90,180])trangle(height,(base_w-tip_w)/2,le+po);
            }
        }
        cylinder(d=dia+p,h=height);
    }
}

module tokenHealth(dia=14.8,height=2.45){
    tip_w=5.2+p;
    base_w=6.6+p;
    //le=5;//length from cylinder circumference
    points=4;
    width=21.5+p;
    le=(width-dia)/2+p;
    po=1.0;//PointOverlap
    color("red")union(){
        for (x=[1:points]){
            //point
            rotate([0,0,(360/points)*x])
            union(){
                translate([dia/2-po,-tip_w/2,0])cube([le+po,tip_w,height]);
                translate([dia/2+le,tip_w/2,0])rotate([0,-90,0])trangle(height,(base_w-tip_w)/2,le+po);
                translate([dia/2+le,-tip_w/2,height])rotate([0,90,180])trangle(height,(base_w-tip_w)/2,le+po);
            }
        }
        cylinder(d=dia+p,h=height);
    }
}

module tokenTerminal(dia=14,height=2.45){
    tip_w=8.8+p;
    base_w=12.5+p;
    //le=5;//length from cylinder circumference
    points=3;
    width=24.6+p;
    le=(width-dia)/2+p;
    po=3.6;//PointOverlap
    color("grey")union(){
        for (x=[1:points]){
            //point
            rotate([0,0,(360/points)*x])
            union(){
                translate([dia/2-po,-tip_w/2,0])cube([le+po,tip_w,height]);
                translate([dia/2+le,tip_w/2,0])rotate([0,-90,0])trangle(height,(base_w-tip_w)/2,le+po);
                translate([dia/2+le,-tip_w/2,0])rotate([0,-90,0])trangle(height,-(base_w-tip_w)/2,le+po);
            }
        }
        cylinder(d=dia+p,h=height);
    }
}

module tokenDisc(dia=25.5,height=2.45,fn=256){
    color("green")cylinder(d=dia+p,h=height,$fn=fn);    
}

module tokenDiscBig(height){
    tokenDisc(dia=25.5,height=height);
}
module tokenDiscSmall(height){
    tokenDisc(dia=19.2,height=height);
}
module tokenHex(height){
    color("blue")tokenDisc(dia=20,height=height,fn=6);
}
module tokenOct(height){
    color("purple")tokenDisc(dia=20,height=height,fn=8);
}

module tokenCrate(height=2.45){
    width=19;
    color("grey")translate([-width/2,-width/2,0])cube([width,width,height]);
}

module trangle(x,y,z){
	polyhedron(
		points = [[0,0,0], [0,0,z], [x,0,z], [x,0,0],[0,y,z], [x,y,z]],
		faces = [[0,1,2],[0,2,3],[1,0,4],[3,2,5],[1,4,5],[2,1,5],[5,0,3],[5,4,0]]
	);
}