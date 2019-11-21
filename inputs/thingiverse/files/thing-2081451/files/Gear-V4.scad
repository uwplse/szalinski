/*[Gear]*/

//Teeth Number
Z=20;//[10:100]

//Module(mm)
M=2;

//Pressure Angle(deg)
PA=20;//[14.5,20,25]

//space(%)
sp=3;//[0:0.1:3]

//Face Width(mm)
FW=10;//

/*[Bore]*/

//Bore Diameter(mm)-Inscribed Circle
BD=10;//

//Bore Polygon(200 for Circle)
BP=6;//[4,6,8,200]


/*[hidden]*/

//Reference Diameter
D=M*Z;

L0=D/2*pow(sin(PA),2);
Y=(2.5/Z-pow(sin(PA),2))*(D/2);
L=L0+Y;

//Base Diameter
baseD=D*cos(PA);

//Root Diameter
Df=D-2*L;

//Addendum Diameter
Dt=D+2*M;

//Rack Dedendum
hf=1.25*M;
ha=1.25*M;

c=0.25;
pi=3.14159265358979323846;

//pitch
p=M*pi;

poly=Z;

echo("Reference Diameter",D);
echo("Base Diameter",baseD);
echo("Root Diameter",Df);
echo("Addum Diameter",Dt);
echo("Rack dedendum",hf);

Ph=p/2*tan(90-PA);

ehf=Ph/2-hf;

tDf=Df/2-ehf-((sp/2)/100*p*tan(90-PA));
echo((sp/2)/100*p*tan(90-PA));
echo("Ph",Ph);
echo("ehf",ehf);
echo("tDf",tDf);
echo (tDf+Ph);
echo (p);

ang1=D*pi/360;

function Slope(x1,x2,y1,y2) = (y1-y2)/(x1-x2);
function LX(Y,mg)=mg[1]+Y/mg[0]-mg[2]/mg[0];
function LY(X,mg)=X*mg[0]-mg[1]*mg[0]+mg[2];
function LXY(X,Y,mg)
=[mg[1]+Y/mg[0]-mg[2]/mg[0],X*mg[0]-mg[1]*mg[0]+mg[2]];

function AXY(Xb,Yb,ang)
=[
    abs(pow(pow(Xb,2)+pow(Yb,2),1/2)
    *cos(atan(Yb/Xb)+ang)),
    
    abs(pow(pow(Xb,2)+pow(Yb,2),1/2)
    *sin(atan(Yb/Xb)+ang))
    ];
Sl=[
    [Slope(0,0-p/2,tDf+Ph,tDf),0,tDf+Ph],
    [Slope(0,p/2,tDf+Ph,tDf),0,tDf+Ph],
    [Slope(0-p,0-p/2,tDf+Ph,tDf),0-p,tDf+Ph],
    [Slope(p,p/2,tDf+Ph,tDf),p,tDf+Ph],
    ];
module TeethPorfile_2(){
    gh=PA+5;
    Step=1;
    for(O=[0-gh:Step:gh]){
        polygon([
        AXY(LX(Df/2,Sl[0])+ang1*O,Df/2,1*O),
        AXY(LX(Df/2+2*hf,Sl[0])+ang1*O,Df/2+2*hf,1*O),
        AXY(LX(Df/2,Sl[2])+ang1*O,Df/2,1*O),
        AXY(LX(Df/2,Sl[0])+ang1*(O+Step),Df/2,1*(O+Step)),
        AXY(LX(Df/2+2*hf,Sl[0])+ang1*(O+Step),Df/2+2*hf,1*(O+Step)),
        AXY(LX(Df/2,Sl[2])+ang1*(O+Step),Df/2,1*(O+Step))
        ],[[0,3,1,4,2,5]]);
    }
    
}
module Teeth2() {
polygon([
        [0,0],
        [LX(Df/2,Sl[2]),Df/2],
        [LX(Df/2,Sl[0]),Df/2],
        [LX(Df/2+2*hf,Sl[0]),Df/2+2*hf],
        [LX(Df/2+2*hf,Sl[1]),Df/2+2*hf],
        [LX(Df/2,Sl[1]),Df/2],
        [LX(Df/2,Sl[3]),Df/2],
        [0,0]
]);
}

bw= D*0.05>3?D*0.05:3;
fc=0.5;
module Base(){
    difference(){
        rotate_extrude(convexity = 10,$fn=500)
        polygon([
            [0,0],
            [0,FW/2+1],
            [BD/2+(bw-fc),FW/2+1],
            [BD/2+bw,FW/2+fc],
            [BD/2+bw,FW/4],
            [Df/2-bw,FW/4],
            [Df/2-bw,FW/2-fc],
            [Df/2-(bw-fc),FW/2],
            [D/2,FW/2],
            [D/2+M,FW/2-FW*0.1],
            [D/2+M,0],
        ]);
        rotate_extrude(convexity = 10,$fn=BP)
        polygon([
            [0,-1],
            [0,FW],
            [BD/2+fc,FW],
            [BD/2+fc,FW/2+(fc*2)],
            [BD/2,FW/2+fc],
            [BD/2,0-(fc*2)]
        ]);
    }
}
module MR(){
    gh=PA+2;
    for(O=[0-gh:1:gh]){
    rotate([0,0,1*O]){
          translate([ang1*O,0,0])
            children(0);}
    }
}

module RE(){
    for(k=[0:1:Z-1]){
            rotate([0,0,(360/Z)*k]){
                children(0);
                }}
   }
   

color("red")
//projection(cut = true)
intersection() {
    linear_extrude(height = FW*1.5,center = true,twist = 0)
    union(){
            RE()        
            difference(){
                Teeth2();
                color("red")
                TeethPorfile_2();
                mirror()
                TeethPorfile_2();
            }
        circle(d=Df);
    }
    
        union(){
            Base();
            mirror([0,0,1])
            Base();
        }
}