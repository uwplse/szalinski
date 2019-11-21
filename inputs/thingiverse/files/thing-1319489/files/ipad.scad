$fn=100*1;
// Base width (millimeter)
H = 16.3;  //  [4:0.1:100]
// Base length (millimeter)
L = 60; // [30:0.1:90]
// Device thickness (millimeter)
T = 8;  //  [8:0.1:12]
// Device inclination (degree)
A = 103.9;  //  [91:0.1:130]
// Dock thickness (millimeter)
D = 4;  //  [2:0.1:8]
// Thickness at depression (millimeter)
DD = 0.2;  //  [0:0.1:2]
// Text
Text = "Thingiverse"; 
// Text Depth (millimeter)
TH = 0.2; // [0:0.1:1]
// Text Size
TS = 8; // [3:0.1:10]
// Text Position X (millimeter)
TX = -3; // [-10:0.1:10]
// Text Position Y (millimeter)
TY = -11; // [-11:0.1:11]
// Add ring for keychain? 
K = 1; // [1:yes, 0:no]
// Backing X (millimeter)
X = 20;  // [0:0.1:30]
// Backing Y (millimeter)
Y = 0;  // [0:0.1:30]

module wall(x1,y1,x2,y2,z,t)
{
    dx=x2-x1;
    dy=y2-y1;
    l = sqrt(dx*dx+dy*dy);
    translate([x1,y1,0])cylinder(h=z,r=t/2);
    translate([x2,y2,0])cylinder(h=z,r=t/2);
    translate([x1+dx/2,y1+dy/2,z/2])rotate(atan2(dy,dx),[0,0,1])cube([l,t,z],center=true);
}

difference()
{
    union()
    {
    wall(30-L,D/2,max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,H,D); // base1
    wall(max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,24-2*T/2.5,D/2,H,D); // base2
    wall(24-2*T/2.5,D/2,30,D/2,H,D); // base0
    wall(24-2*T/2.5+23*cos(A),D/2+23*sin(A),max(24-X-2*T/2.5+Y/tan(A),30-L),Y+D/2,H,D); // back    
    wall(30,D/2,6.2*cos(110)+30,6.2*sin(110),H,D); // foot

    if ((Y==0) && (K==1)) {   
        difference(){     
            translate([-L/2,D+2,0])cylinder(h=3,r=4);
            translate([-L/2,D+2,-1])cylinder(h=6,r=2);
            }
        }// keychain
    }

    translate([0,DD,-1])wall(26.6-T/2.5,T/2+0.5,26.6-T/2.5+47*cos(A),T/2+0.5+47*sin(A),H+2,T); // base depression
    
    if ((Y==0)) {

    translate([-1.3*L/4+TY,TH,H/2+TX])rotate(0,[0,1,0])rotate(90,[1,0,0])linear_extrude(2*TH)
        text(Text, font="Arial:style=Bold", size = TS); // text

    }

}