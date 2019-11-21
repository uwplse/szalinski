/////////////////////////////////////////////////////////////////////////
///
///  CellCaps - storage caps for single cell cylindrical batteries,
///             such as e.g. AA, AAA, C, D, 18650
///
/////////////////////////////////////////////////////////////////////////
///
///  2013-08-21 Heinz Spiess
///
///  released under Creative Commons - Attribution - Share Alike licence
/////////////////////////////////////////////////////////////////////////
/* Cells */
// Number of cells in the Y direction.
M = 1;  //[0,1,2,3,4] 
// Number of cells in the X direction. 
N = 2; // [0,1,2,3,4] 


/////////////////////////////////////////////////////////////////////////
// Space between instances
Space = 5;

// Parameters (w. values for AA cell)
//D = 14.5; // diameter
//H = 8;    // height
//W = 2.5;  // wall thickness
//S = 1;    // extra slack between cells
//F = 1.13; // width of friction winglets
//DI = 0.5; // diameter increment
//G = 20;   // radius of "grip" cavities
//GD = 1.8; // "grip" depth (0=no grip)


//N:  Number of cells in x-direction
//M:  Number of cells in y-direction
//PX:  Offset position in x-direction (no. of instances), usually 0
//PY:  Offset position in y-direction (no. of instances), usually 0










///  AA Cell
module AA_Caps(N=4, M=1, PX=0, PY=0){
    CellCaps(N, M, PX, PY, D=14.5, H=8, W=2.5, S=1, F=1.13, DI=0.5, G=20, GD=1.8);
}

///  AAA Cell
module AAA_Caps(N=4, M=1, PX=0, PY=0){
    CellCaps(N, M, PX, PY, D=10.5, H=7, W=2.3, S=1.2, F=1.13, DI=0.5, G=18, GD=1.1);
}

///  C Cell
module C_Caps(N=4, M=1, PX=0, PY=0){
    CellCaps(N, M, PX, PY, D=26.2, H=7, W=2.8, S=1.2, F=1.8, DI=0.5, G=36, GD=2.8);
}

///  D Cell
module D_Caps(N=4, M=1, PX=0, PY=0){
    CellCaps(N, M, PX, PY, D=34.2, H=7, W=2.8, S=1.2, F=1.8, DI=0.5, G=50, GD=3.5);
}

///  18650 LiIon/LiPo Cell
module 18650_Caps(N=4, M=1, PX=0, PY=0){
    CellCaps(N, M, PX, PY, D=18.5, H=9, W=2.8, S=1, F=1.5, DI=0.5, G=28, GD=2.2);
}


module CellCaps(N,M,PX,PY,D,H,W,S,F,DI,G,GD){

// position cell caps for multiple instances
translate([PX*(N*(D+S)+2*W+Space),PY*(M*(D+S)+2*W+Space),0]){

  // friction winglets
  for(m=[0:1:M])translate([0,(m-0.5)*(D+S),0])for(n=[0:1:N]){
    translate([(n-0.5)*(D+S),0,0])for(x=[-1,+1])for(y=[-1,+1])
    rotate(a=(1+x+2*y)*45){
       if(((n>0 && n<N) &&(m>0 && m<M))
         ||(n==0 && m>0 && m<M && x==-1 && y==-1)
         ||(n==N && m>0 && m<M && x==-1 && y==1)
         ||(m==0 && n>0 && n<N && x==1 && y==-1)
         ||(m==M && n>0 && n<N && x==1 && y==1)
           ){
       hull(){
         translate([-0.9*F,D/6-0.1,W])cube([F,0.1,H/2]);
         translate([-F,D/6-0.1,W+H/2])cube([F+0.2,0.28*D,0.1]);
         translate([-0.7*F,D/6-0.1,W+H/2])cube([F-0.2,0.32*D,0.1]);
       }
       hull(){
         translate([-0.7*F,D/6-0.1,W+H/2])cube([F-0.2,0.32*D,0.1]);
         translate([-F,D/6-0.1,W+H/2])cube([F+0.2,0.28*D,0.1]);
         translate([-0*F,D/6-0.1,W+H-0.75])cube([F,0.28*D,0.1]);
         translate([0.2*F,D/6-0.1,W+H-0.1])cube([0.4*F,0.32*D,0.1]);
       }
       }
    }
  }

  // main body
  difference(){
    // outer hull
    hull(){
      for(m=[0:1:M-1])for(n=[0:1:N-1]){
        // lower edge
        translate([n*(D+S),m*(D+S),0])cylinder(r=D/2+2*W/3,h=0.1);
	// main part
        translate([n*(D+S),m*(D+S),W/2])cylinder(r=D/2+W,h=H);
	// upper edge
        translate([n*(D+S),m*(D+S),W+H-0.1])cylinder(r=D/2+W/2,h=0.1);
      }
    }

    for(m=[0:1:M-1])for(n=[0:1:N-1]){
      // main cavity
      translate([n*(D+S),m*(D+S),W])cylinder(r1=D/2+DI/2,r2=D/2,h=2*H/3+0.1);
      translate([n*(D+S),m*(D+S),W+2*H/3])cylinder(r2=D/2+DI,r1=D/2,h=H/3+0.1);
      // cavity  for plus pole
      translate([n*(D+S),m*(D+S),W/2])cylinder(r=D/4,h=H+1);
    }

    // outer "grip" cavities in x-direction
    if(N>1)for(n=[0:1:N-2]){
      for(y=[-1,1]){
        translate([(n+0.5)*(D+S),y*(((y>0)?(M-1)*(D+S):0)+D/2+G/2+W-GD),-0.1])cylinder(r1=G/2+W/3,r2=G/2,h=W/2+0.2);
        translate([(n+0.5)*(D+S),y*(((y>0)?(M-1)*(D+S):0)+D/2+G/2+W-GD),W/2])cylinder(r=G/2,h=H+0.5*W);
        translate([(n+0.5)*(D+S),y*(((y>0)?(M-1)*(D+S):0)+D/2+G/2+W-GD),H+W/2-0.1])cylinder(r1=G/2,r2=G/2+W/3,h=W/2+0.2);
      }
    }

    // outer "grip" cavities in y-direction
    if(M>1)for(m=[0:1:M-2]){
      for(x=[-1,1]){
        translate([x*(((x>0)?(N-1)*(D+S):0)+D/2+G/2+W-GD),(m+0.5)*(D+S),-0.1])cylinder(r1=G/2+W/3,r2=G/2,h=W/2+0.2);
        translate([x*(((x>0)?(N-1)*(D+S):0)+D/2+G/2+W-GD),(m+0.5)*(D+S),W/2])cylinder(r=G/2,h=H+0.5*W);
        translate([x*(((x>0)?(N-1)*(D+S):0)+D/2+G/2+W-GD),(m+0.5)*(D+S),H+W/2-0.1])cylinder(r1=G/2,r2=G/2+W/3,h=W/2+0.2);
      }
    }

    // connect inner cavities in x-direction
    for(m=[0:1:M-1])translate([0,-D/3+m*(D+S),W+0.5])cube([(N-1)*(D+S),2*D/3,H+1]);

    // connect inner cavities in y-direction
    for(n=[0:1:N-1])translate([-D/3+n*(D+S),0,W+0.5])cube([2*D/3,(M-1)*(D+S),H+1]);
  }
  /*
  for(m=[0:1:M-1])translate([0,m*(D+S),0])for(n=[0:1:N-2]){
    translate([n*(D+S),0,0])for(A=[0,1])
    rotate(a=A*180){
       hull(){
         translate([-A*(D+S)+D/2-0.9*F,-D/3-0.1,W])cube([F,0.1,H/2]);
         translate([-A*(D+S)+D/2-0.9*F,-D/3-0.1,W+H/2])cube([F+0.2,0.25*D,0.1]);
       }
       hull(){
         translate([-A*(D+S)+D/2-0.9*F,-D/3-0.1,W+H/2])cube([F+0.2,0.25*D,0.1]);
         translate([-A*(D+S)+D/2-0*F,-D/3-0.1,W+H-0.1])cube([F,0.25*D,0.1]);
       }
    }
  }
  */
}
}

for(x=[0:1:0]) for(y=[0:1:0]) {
//AAA_Caps(N=2,M=1,PX=x,PY=y);
//AAA_Caps(N=3,M=1,PX=x,PY=y);
//AAA_Caps(N=4,M=1,PX=x,PY=y);
//AAA_Caps(N=2,M=2,PX=x,PY=y);
//AAA_Caps(N=4,M=6,PX=x,PY=y);

//AA_Caps(N=2,M=1,PX=x,PY=y);
//AA_Caps(N=3,M=1,PX=x,PY=y);
//AA_Caps(N=4,M=1,PX=x,PY=y);
AA_Caps(N,M,PX=x,PY=y);
//AA_Caps(N=6,M=4,PX=x,PY=y);

//C_Caps(N=2,M=1,PX=x,PY=y); // not yet tested!
//C_Caps(N=3,M=1,PX=x,PY=y); // not yet tested!
//C_Caps(N=4,M=1,PX=x,PY=y); // not yet tested!

//D_Caps(N=2,M=1,PX=x,PY=y); // not yet tested!
//D_Caps(N=3,M=1,PX=x,PY=y); // not yet tested!
//D_Caps(N=4,M=1,PX=x,PY=y); // not yet tested!

//18650_Caps(N=2,M=1,PX=x,PY=y);
//18650_Caps(N=3,M=1,PX=x,PY=y);
//18650_Caps(N=4,M=1,PX=x,PY=y);
//18650_Caps(N=2,M=2,PX=x,PY=y);
}
