//Bibo Gromets
//GrometType=2 BackRight(YZStepper) BiboRightBackGromet.stl
//   9x20x8.5, Rounding=2,GrommetThick=1,Offx=2,Offy=2,FlangeThick=1,FlangeShoulder=2,Detent=1.5

//GrometType=1 FrontLeft(Empty) BiboLeftFrontGromet.stl
//   9x21x8.5, Rounding=2,GrommetThick=1,Offx=2,Offy=2,FlangeThick=2,FlangeShoulder=2,Detent=1.5

//GrometType=3 BackLeft(X EndStop) BiboLeftBackGromet.stl
//   9x13x8.5, Rounding=2,GrommetThick=1,Offx=0,Offy=2,FlangeThick=1,FlangeShoulder=2,Detent=1.5

//5 BackMiddle(Empty) BiboMiddleBackGromet.stl
//   9x28x8.5, Rounding=2,GrommetThick=1,Offx=2,Offy=0,FlangeThick=1,FlangeShoulder=2,Detent=1.5
//4 BedHeaterWires BiboBedHeaterGromet.stl
//   5x64x4.5, Rounding=2,GrommetThick=1,Offx=0,Offy=0,FlangeThick=1,FlangeShoulder=2,Detent=1.5
//GrometType 1-FrontLeft,2-BackRight,3-BackLeft,4-BedHeatNotComplete,5-BackMiddle
GrometType=1; 
//GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent

if (GrometType==5) { 
    Version="BackMiddle";
    //HoleSizeX
    HoleX=9;
    //HoleSizeY
    HoleY=28;
    //Plate thickness
    HoleZ=9.5;
    //Round it up a bit so it will fit better
    HoleRounding=2;
    HoleRounding2=HoleRounding*2;
    GrommetThickness=1 ;
    GrommetThickness2=GrommetThickness*2 ;
    //TopFlange
    TopFlangeXOff=2;
    TopFlangeYOff=0;
    TopFlangeThick=1;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.75;
    Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent);
};

if (GrometType==4) { 
    Version= (GrometType==4) ? "BedHeaterWires":"";
    //Version="BedHeaterWires";
    //HoleSizeX
    HoleX=5;
    //HoleSizeY
    HoleY=64;
    //Plate thickness
    HoleZ=4.5;
    //Round it up a bit so it will fit better
    //if (HoleX<6) HoleRounding=1; 
    //if (HoleX<6) HoleRounding=2;
    HoleRounding = (HoleX<6) ? 1 : 2;
    //xx = (x > (y-z)) ? x : y-z;
    //c= a>b ? b-w : (a<b ? a-w : a-w);

    GrommetThickness=1 ;
    //TopFlange
    TopFlangeXOff=0;
    TopFlangeYOff=0;
    TopFlangeThick=1;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.75;
    Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent);
};

if (GrometType==3) { 
    Version="BackLeft";
    //HoleSizeX
    HoleX=8.5;
    //HoleSizeY
    HoleY=13;
    //Plate thickness
    HoleZ=9.5;
    //Round it up a bit so it will fit better
    HoleRounding=2;
    HoleRounding2=HoleRounding*2;
    GrommetThickness=1 ;
    GrommetThickness2=GrommetThickness*2 ;
    //TopFlange
    TopFlangeXOff=2;
    TopFlangeYOff=0;
    TopFlangeThick=1;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.75;
    Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent);
};
if (GrometType==2) { 
    Version="BackRight";
    //HoleSizeX
    HoleX=9;
    //HoleSizeY
    HoleY=20;
    //Plate thickness
    HoleZ=9.5;
    //Round it up a bit so it will fit better
    HoleRounding=2;
    HoleRounding2=HoleRounding*2;
    GrommetThickness=1 ;
    GrommetThickness2=GrommetThickness*2 ;
    //TopFlange
    TopFlangeXOff=2;
    TopFlangeYOff=1;
    TopFlangeThick=1;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.75;
    Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent);
};

if (GrometType==1) {
    Version="FrontLeft";
    //HoleSizeX
    HoleX=9;
    //HoleSizeY
    HoleY=21;
    //Plate thickness
    HoleZ=8.5;
    //Round it up a bit so it will fit better
    HoleRounding=2;
    HoleRounding2=HoleRounding*2;
    GrommetThickness=1 ;
    GrommetThickness2=GrommetThickness*2 ;
    //TopFlange
    TopFlangeXOff=2;
    TopFlangeYOff=2;
    TopFlangeThick=2;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.25;
    Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent);
};


// 8x20x6.5
module Gromet(GrometType,Version,HoleX,HoleY,HoleZ,HoleRounding,GrommetThickness,TopFlangeXOff,TopFlangeYOff,TopFlangeThick,TopFlangeShoulder,Detent) {
//Adjustments
    HoleRounding2=HoleRounding*2;
    GrommetThickness2=GrommetThickness*2 ;
    echo ("HoleZ",HoleZ);
    aHoleZ=HoleZ-.75;

rotate([0,180,0]) { 
difference(){  //cut slice

    difference() {
union() {
    union() {
    union() {
        //topflange
        translate([TopFlangeXOff,TopFlangeYOff,HoleZ/2]) {
        RoundSquare((HoleX+(TopFlangeShoulder*2)),(HoleY+(TopFlangeShoulder*2)),TopFlangeThick,HoleRounding);
        }
        //build outer pipe
        RoundSquare(HoleX,HoleY,aHoleZ,HoleRounding);
    } 
         translate([-((HoleX/2)+GrommetThickness-Detent),0,(-HoleZ/2)+Detent]) {
       sphere(r=Detent);
        }
    }
        translate([(HoleX/2)+GrommetThickness-Detent,0,(-HoleZ/2)+Detent]) {
       sphere(r=Detent);
        }
    }
    translate([0,0,0]) {
    //build inner pipe
    RoundSquare(HoleX-GrommetThickness2,HoleY-GrommetThickness2,aHoleZ+2,HoleRounding);
    }
    };
    //slice to put wire in
    translate([0,4,0]) {
        cube([.2,HoleY,HoleZ*1.2],true);
    }
}
}
}  //Grommet end of moduile

//rotate(a=[0,90,0]) {
module RoundSquare(X,Y,Z,R) {
minkowski()
    {
    cube([X-(R*2),Y-(R*2),Z],true) ;
        cylinder(r=R,h=.001,center=true);
    }
}
//}
module BedHeaterWires(GrometType){
   //if (GrometType==4) { 
    Version= (GrometType==4) ? "BedHeaterWires":"";
    //Version="BedHeaterWires";
    //HoleSizeX
    HoleX=5;
    //HoleSizeY
    HoleY=64;
    //Plate thickness
    HoleZ=4.5;
    //Round it up a bit so it will fit better
    //if (HoleX<6) HoleRounding=1; 
    //if (HoleX<6) HoleRounding=2;
    HoleRounding = (HoleX<6) ? 1 : 2;
    //xx = (x > (y-z)) ? x : y-z;
    //c= a>b ? b-w : (a<b ? a-w : a-w);
    HoleRounding2=HoleRounding*2;
    GrommetThickness=1 ;
    GrommetThickness2=GrommetThickness*2 ;
    //TopFlange
    TopFlangeXOff=0;
    TopFlangeYOff=0;
    TopFlangeThick=1;
    TopFlangeShoulder=2;
    //DetentSize
    Detent=1.75;
    }