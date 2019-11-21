/*[All Gear Setting]*/
//Module(mm)
M=2;

//Pressure Angle(deg)
PA=20;//[14.5,20,25,32.14]

//space(%)
sp=3;//[0:0.1:3]

/*[Gear 1]*/
//Teeth Number
Z_1=15;//[10:100]
//Face Width(mm)
FW_1=10;//

/*[Gear 2]*/
//Teeth Number
Z_2=30;//[10:100]
//Face Width(mm)
FW_2=10;//


/*[Bore]*/
//Bore Diameter(mm)-Inscribed Circle
BD=10;//
//Bore Polygon(200 for Circle)
BP=6;//[4,6,8,200]

/*[hidden]*/

Z=[Z_1,Z_2];
FW=[FW_1,FW_2];

//pitch
pi=3.14159265358979323846;
p=M*pi;
poly=Z;
//Rack Dedendum
hf=1.25*M;
ha=1.25*M;
Ph=p/2*tan(90-PA);
ehf=Ph/2-hf;


//Reference Diameter
D=[M*Z[0],M*Z[1]];
L0=[D[0]/2*pow(sin(PA),2),D[1]/2*pow(sin(PA),2)];
Y=[
    (2.5/Z[0]-pow(sin(PA),2))*(D[0]/2),
    (2.5/Z[1]-pow(sin(PA),2))*(D[1]/2)
  ];
  
L=[L0[0]+Y[0],L0[1]+Y[1]];
//Base Diameter
baseD=[D[0]*cos(PA),D[1]*cos(PA)];
//Root Diameter
Df=[D[0]-2*L[0],D[1]-2*L[1]];
//Addendum Diameter
Dt=[D[0]+2*M,D[1]+2*M];
ang=[D[0]*pi/360,D[1]*pi/360];
tDf=[
    Df[0]/2-ehf-((sp/2)/100*p*tan(90-PA)),
    Df[1]/2-ehf-((sp/2)/100*p*tan(90-PA))];

module Teeth(g) {
    difference(){    
        union(){
            polygon([
            [0-p,tDf[g]+Ph],
            [0-p/2,tDf[g]],
            [0,tDf[g]+Ph],
            [p/2,tDf[g]],
            [p,tDf[g]+Ph]
            ]);

            polygon([
            [0-p,Df[g]/2+3*hf],
            [0-p,Df[g]/2+2*hf],
            [p,Df[g]/2+2*hf],
            [p,Df[g]/2+3*hf]
            ]);
        }
        polygon([
        [0-p,Df[g]/2],
        [p,Df[g]/2],
        [p,tDf[g]],
        [0-p,tDf[g]]
        ]);
    }
}
module outerT(g) {
    polygon([
            [0,0],
            [0-p/2,Df[g]/2+2*hf],
            [p/2,Df[g]/2+2*hf],
            [0,0]
    ]);
}
module MR(g){
    gh=PA+2;
            for(a=[0-gh:1:gh]){
                rotate([0,0,1*a]){
                    translate([ang[g]*a,0,0])
                    children(0); 
                }
            }
    }
module gTeeth(g){
    //linear_extrude(height = FW[g]*1.5,center = true,twist = 0)
    difference(){        
        outerT(g);
        MR(g) Teeth(g);
    }
}
module RE(g){
for(a=[0:1:Z[g]-1]){
            rotate([0,0,(360/Z[g])*a]){
            children(0);}}
}
module gT2(g){
    linear_extrude(height = FW[g]*1.5,center = false)
    union(){
        RE(g) gTeeth(g);
        circle(d=Df[g]);
    }
}
module Base(gB,gS){    
    fc=0.5;
    bfw=1;
    bw= 3;
    rotate_extrude(convexity = 10,$fn=500)
    polygon([
        [0,             FW[gS]+bfw],
        [BD/2+bw-fc,    FW[gS]+bfw],
        [BD/2+bw,       FW[gS]+bfw-fc],
        [BD/2+bw,       FW[gS]*3/4],
        [Df[gS]/2-bw,   FW[gS]*3/4],
        [Df[gS]/2-bw,   FW[gS]],
        [D[gS]/2,       FW[gS]],
        [D[gS]/2+M,     FW[gS]*0.9],
        [D[gS]/2+M,     0],//Top
        [D[gB]/2,       0],
        [D[gB]/2+M,     0-FW[gB]*0.1],
        [D[gB]/2+M,     0-FW[gB]*0.9],
        [D[gB]/2,       0-FW[gB]],
        [Df[gB]/2-bw,   0-FW[gB]],
        [Df[gB]/2-bw,   0-FW[gB]*3/4],
        [BD/2+bw,       0-FW[gB]*3/4],
        [BD/2+bw,       0-FW[gB]-bfw+fc],
        [BD/2+bw-fc,    0-FW[gB]-bfw],
        [0,             0-FW[gB]-bfw],
    ]);
}

gdS= D[1]>D[0]?0:1;
gdB= D[1]>D[0]?1:0;

difference(){
    intersection() {
        union(){
            mirror([0,0,1]) gT2(gdB);
            gT2(gdS);
        }
        Base(gdB,gdS);
    }
    FW2=[FW[0]+1,FW[1]+1];
    rotate_extrude(convexity = 10,$fn=BP)
    polygon([
            [0,0],
            [0,FW2[0]+1],
            [BD/2+0.5,FW2[0]+1],
            [BD/2+0.5,FW2[0]],
            [BD/2,FW2[0]-0.5],
            [BD/2,FW2[0]-0.5],
            [BD/2,0-FW2[1]+0.5],
            [BD/2+0.5,0-FW2[1]],
            [BD/2+0.5,0-FW2[1]-1],
            [0,0-FW2[1]-1]
            
            ]);
}
