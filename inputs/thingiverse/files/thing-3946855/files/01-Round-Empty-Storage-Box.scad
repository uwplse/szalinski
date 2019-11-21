$fn=60;

boxLength=50;
boxWidth=50;
boxHeight=20;
lidLength=boxLength;
lidWidth=boxWidth;
lidHeight=0.5*boxHeight;
x=boxLength;
y=boxWidth;
z=boxHeight;

r=0.1*boxWidth;
bt=1.5; wt=3;
lock=0.1*boxWidth;
t=0.15;

showBox(boxLength,boxWidth,boxHeight,r);
showLid(lidLength,lidWidth,lidHeight,r);

module showBox(x,y,z,r){
    translate([-(x/2+5),0,0]){
        difference(){
            union(){
                roundBox(x,y,z-lock,wt);
                translate([0,0,z-lock]) roundBox(x-wt-(2*t),y-wt-(2*t),2,(wt/2)-t);
                translate([0,0,z-lock]) sphericalBox(x-wt-(2*t),y-wt-(2*t),lock,(wt/2)-t);
            }
        translate([0,0,bt]) roundBox(x-(2*wt),y-(2*wt),z-bt,0.5);
        }
    }
}

module showLid(x,y,z,r){
    translate([x/2+5,0,0]){
        difference(){
            roundBox(x,y,z,wt);
            union(){
                translate([0,0,1.5]) roundBox(x-(2*wt),y-(2*wt),z-bt,0.5+t);
                translate([0,0,z-lock]) roundBox(x-3+(2*t),y-3+(2*t),z-lock,(wt/2)+t);
            }
        }
    }
}

module roundBox(x,y,z,r){
    hull(){
        translate([x/2-r,y/2-r,0]) cylinder(r=r,h=z);
        translate([-(x/2-r),(y/2-r),0]) cylinder(r=r,h=z);
        translate([-(x/2-r),-(y/2-r),0]) cylinder(r=r,h=z);
        translate([x/2-r,-(y/2-r),0]) cylinder(r=r,h=z);
    }
}

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
    }
}

