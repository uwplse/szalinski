include <openscad-library/geometry.scad>;
include <openscad-library/fasteners.scad>;

/*
TODO:
Add Brake Cable Guide
Add "break" in throttle cable slot, to get cables in and out easily
Round slot
*/

$fa=12; //2
$fs=.1;

shroudRadius = 200;
shroudToMntHoles = 97;
mntHoleToBottomEdge = 9;
mntHoleSpacing = 85.5;
slotBottomY = 9;
mntW = mntHoleToBottomEdge + slotBottomY;
slotH = 15;
slotW = 100;
slotTopR = 1;
w1 = 180;
w2 = 165;
t=7;
t2=3.5;
arcS = arcSFromRL(r=shroudRadius,l=w1/2);
trapezoidTopY = shroudToMntHoles - arcS;
trapezoidH = trapezoidTopY + mntHoleToBottomEdge;
mntAreaH = slotBottomY + mntHoleToBottomEdge;
oaH = arcS+trapezoidH;
chamferH = oaH-slotBottomY-mntHoleToBottomEdge;
chamferT = t-t2;
chamferA = atan(chamferT/chamferH);
tilt = -2*chamferA;
plateBendAxis = [0,slotBottomY,-t];
breakW = .4;
slotBottomR = t - slotTopR;

difference(){
    bentPlate();
    #translate([-36, slotBottomY+slotH, 0]){
        trailTech();   
        translate([106.5/2,0,0])
        //translate([106.5/2-5,3,0])
            //rotate(a=[0,0,-7])
                drz400Indicators(clearance=.5);
    }
    #translate([w1/2-4,trapezoidTopY,0])
        ignSw(x=-1,y=-1);
    translate([-(slotW-slotH)/2,slotBottomY+slotH/2,-t])
        slotRnd();
    translate([-max(w1,w2)/2,slotBottomY,-2*t])
        rotate(a=[chamferA,0,0])
            cube([max(w1,w2),oaH,t]);
    jrotate(a=[-tilt,0,0],o=plateBendAxis){
        translate([mntHoleSpacing/2,0,-t])
            mntCushion();
        translate([-mntHoleSpacing/2,0,-t])
            mntCushion();
    }
    cube([breakW,mntW+t,mntW+t],center=true);
}

module bentPlate(){
    color("white"){
        dashArea();
        mntArea();
        bendFill();
    }
}

module dashArea(){
    difference(){
        plateBlank();
        translate([-max(w1,w2)/2,-mntHoleToBottomEdge,-max(t,t2)-1])
            cube([max(w1,w2),mntAreaH,max(t,t2)+2]);
    }
}

module mntArea(){
    jrotate(a=[-tilt,0,0],o=plateBendAxis)
        difference(){
            plateBlank();
            translate([-max(w1,w2)/2,slotBottomY,-max(t,t2)-1])
                cube([max(w1,w2),oaH,max(t,t2)+2]);
        }
}

module bendFill(){
    h=w1-(w1-w2)*((trapezoidTopY-slotBottomY)/trapezoidH);
    
    translate([h/2,slotBottomY,-t])
        rotate(a=[0,-90,0])
            linear_extrude(height=h)
                slice(a=tilt,r=t);
}

module plateBlank(){
    translate([0,0,-t])
        linear_extrude(height=t){
            difference(){
                radius(r=1){
                    translate([0,trapezoidTopY])
                        arc(w=w1,r=shroudRadius);
                    translate([0,-mntHoleToBottomEdge])
                        trapezoid(w1=w1,w2=w2,h=trapezoidH);
                }
            }
        } 
}

module slot(){
    translate([0,0,-t])
    linear_extrude(height=t)
        translate([-slotW/2, slotBottomY])
            radius(r=slotH/2-1)
                square([slotW, slotH]);
}

module slotRnd(){
    module profile(){
        difference(){
            polygon([
                [0,-1],
                [slotH/2+slotBottomR,0],
                [slotH/2,slotBottomR],
                [slotH/2,t-slotTopR],
                [slotH/2+slotTopR,t],
                [0,t+1]
            ]);
            translate([slotH/2+slotTopR,t-slotTopR])
                rotate(a=[0,0,90])
                    slice(a=90,r=slotTopR);
             translate([slotH/2+slotBottomR,slotBottomR])
                rotate(a=[0,0,180])
                    slice(a=90,r=slotBottomR);
       }
    }
    
    rotate(a=[90,0,90]){
        linear_extrude(height=slotW-slotH){
            profile();
            mirror([1,0,0])
                profile();
        }
        rotate(a=[-90,0,0])
            rotate_extrude(angle=180)
                profile();
        translate([0,0,slotW-slotH])
            rotate(a=[-90,0,0])
                rotate_extrude(angle=180)
                    profile();
    }
}

module trailTech(clearance=0){
    topR = 180;
    topS = 8;
    cornerR = 7;
    h = 60;
    h2 = 11;
    h1 = h - h2 - topS;
    w1 = 106.5;
    w2 = 97;
    w3 = 50;
    d = 21.5;
    cablesW = 25;
    cablesH = 24;
    cablesD = 20;
    holesY = 31.2;
    holesW = 40;

    color("gray"){
        //body
        translate([0, h2, 0])
            linear_extrude(height=d)
                radius(r=cornerR){
                    translate([0,h1])
                        arc(w=w1,s=topS);
                    trapezoid(w1=w1, w2=w2, h=h1);
                    trapezoid(w1=w3, w2=w2, h=-h2);
                }
        //cables
        translate([-cablesW/2,4.5,-cablesD])
            linear_extrude(height=cablesD)
                radius(r=1)
                    square([cablesW,cablesH]);
                
        //holes
        translate([holesW/2,holesY,0])
            screwM4x10CS();
        translate([-holesW/2,holesY,0])
            screwM4x10CS();
            }

}

module drz400Indicators(clearance=0){
    oaH=62.5;
    
    color("gray"){
        top();
        bottom();
        screwHoles();
    }
    
    module top(){
        w=25.5;
        h=oaH;
        d=21;
        r=4;
        linear_extrude(height=d)
            offset(delta=clearance)
                radius(r=r)
                    square([w,h]);
    }
    
    module bottom(){
        w=20.4;
        h=49.2;
        d=25;
        x=1.7;
        y=6.6;
        chamfer=6;
        rectW=w-chamfer;
        r=1;
        
        translate([x,y,-d])
            linear_extrude(height=d)
                radius(r=clearance)
                    radius(r=r){
                        square([rectW,h]);
                        translate([rectW,h/2,0])
                            trapezoid(w=chamfer,h1=h,h2=h-2*chamfer);
                    }              
    }
    
    module screwHoles(h=10){
        w=51.5;
        x=20.25;
        
        translate([x,oaH/2,0]){
            translate([0,w/2])
                screwWood4x10();
            translate([0,-w/2])
                screwWood4x10();
        }
    }
}

module ignSw(clearance=.5,x=0,y=0){
    r=14.8;
    keyH=1.6;
    keyW=5;
    bodyD=43;
    topR=17.35;
    topD=3;
    bootR=20;
    bootD=64;
    plateT=3;
    
    color("gray")
        translate([bootR+2*bootR*x,bootR+2*bootR*y,0]){
            //top plate
            linear_extrude(height=topD)
                offset(r=clearance){
                    circle(r=topR);
                }
            
            //body
            translate([0,0,-bodyD])
                linear_extrude(height=bodyD)
                    offset(r=clearance){
                        translate([-keyW/2,0])
                            square([keyW,keyH+r]);
                        circle(r=r);
                    }
                    
            //boot
            translate([0,0,-bootD-plateT])
                linear_extrude(height=bootD)
                    offset(r=clearance){
                        circle(r=bootR);
                    }
            
        }
}

module mntCushion(){
    od1=16;
    od2=11;
    notchH=3.5;
    
    rotate(a=[0,0,0]){
        translate([0,0,notchH])
            cylinder(d=od1,h=t);
        cylinder(d=od2,h=notchH);
        translate([0,0,-t])
            cylinder(d=od1,h=t);
    }
}
