// - Number of segments
N = 9;

// - Outer diameter of body
D = 70;

// - inside height of body
H = 25;

// - wall thickness 
t = 1.2;

// - print quality
$fn=60;

/* [hidden] */
c = 0.8;
R = D/2;
NotchZ = max(H-10, H/2);
unitVol = (3.14159*pow(R-t,2) - (R-t)*t )*H /(1000*(N+1));
echo(unitVol, "cm^3");
echo(str("FileName: PillCase2 ",N," ",D," ",H," ",t));

//Body();
//Lid();
//PrintConfig(); 
FitConfig();

module Body() {
    //body polygon starting at origin and going CCW
    pBody = [
        [0,         0],         //origin
        [R,       0],           //Bottom outer edge
        [R,       NotchZ-t/2],  //Bottom of notch
        [R-t/2,   NotchZ],      //Center of notch
        [R,       NotchZ+t/2],  //Top of notch
        [R,       H],           //Top outer edge
        [R-t,     H],           //Top inner edge
        [R-t,     t],           //Bottom inner edge
        [0,         t]];        //I/S Center
    rotate_extrude() {
        polygon(pBody);
    }
    //walls
    for(a=[0:360/(N+1):360]) {
        rotate(a) translate([0, -t/2, 0]) {
            cube([R-t, t, H]);
        }
    } 
    //filled segment. N-NE
    intersection() {
        linear_extrude(H) 
        polygon([
            [0,0],
            [D,0],
            [D,D*10], 
            [R*cos(360/(N+1)), R*sin(360/(N+1))]]); 
        cylinder(d=D-t,H);
    }
    //locating notches
    rotate(0) translate([R-0.3*t,0,NotchZ]) scale([1,1,2]) {
        sphere(d=1.5*c);
    }
    rotate(360/(N+1)) translate([R-0.3*t,0,NotchZ]) scale([1,1,2]) {
        sphere(d=1.5*c);
    } 
  
    //labels going CW 
    textWd = min(3.14159*D/(N+1)*0.8, D/10);
    textHt = min(textWd*1.4, H/2-2);
    textTk = 0.7;
    for(n = [1:N]) {
        ang = -360/(N+1)*(n-0.5);
        rotate(ang)
        translate([R-textTk*1.5, 0, 0.5*NotchZ])
        rotate([90,0,90])
        linear_extrude(2*textTk)
        resize([textWd, textHt])
        text(str(n), halign="center",, valign="center", font="Arial");
    }
}


module Lid() {
    //lid polygon starting inside center and going CCW
    pLid = [ 
        [0,       H+c],             //inside center
        [R+c,     H+c],             //top inside ring
        [R+c,     NotchZ+t/2+c],    //top of notch
        [R-t/2,   NotchZ],          //point of notch
        [R+t+c,     NotchZ],          //back of notch
        [R+t+c,     H+c+t],           //top outer edge
        [0,       H+c+t]];          //top center
    
    difference() {
        //body
        rotate_extrude() {
            polygon(pLid);
        }
        //splits
        splitLen = min(R/2, 15, 0);
        for(a=[0:360/(N+1):360]) {
            rotate(a) translate([R-splitLen, -c/2]) {
                cube([R,c,H*2]);
            }
        }
        //opening
        difference() {
            //triangular wedge
            linear_extrude(H*2) 
            polygon([
                [0,0],
                [D,0],
                [D,D*10], 
                [R*2*cos(360/(N+1)), R*2*sin(360/(N+1))]]); 
            //central cylinder
            cylinder(d=R,H*2);
        }
    } 
}

module PrintConfig() {
    Body();
    rotate([180,0,0]) translate([D+t*2, 0, -H-t-c]) {
        Lid();
    }
}


module FitConfig() {    
    intersection() {
        union() {
            Body();
            Lid();
        }
        rotate(-45/2) cube(D);
    }
}