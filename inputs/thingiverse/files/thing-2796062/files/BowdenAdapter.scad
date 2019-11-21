// Tevo Extruder Boden Adapter

Rund=14.00;
Dick=3.50;
Innen=10.50 ;
Hoch=6.1;
Front=2.00;
CubeBreit=22.45;
CubeHoch=14.00;
CubeTief=5.00;
BPush=4.9;
BPush2=2.50;
PushHoch=10.00;
DVorn=5.00;
DVorn2=2.50;
HVorn=14.00;
module Adapter () {
difference () {
union () {
cylinder (Dick,d=Rund,Center=true,$fn=60);
   translate ([-Rund/2,-Rund/2,0]) cube ([Rund,Rund/2,Dick]);
translate ([0,0,Dick]) cylinder (Hoch,d=Innen,Center=true,$fn=60);
translate ([0,0,Dick+Hoch]) cylinder (Front,d=Rund,Center=true,$fn=60);
$fn=50;
minkowski()
{
translate ([-CubeBreit/2,-Rund/2+1,Dick+Hoch+Front+0.5]) cube ([CubeBreit,CubeHoch,CubeTief]);
   //cylinder(r=2,h=CubeTief/2); 
    cylinder (1, center=true);
}
}
cylinder (h=HVorn,d1=DVorn,d2=DVorn2,$fn=50);
translate ([0,0,HVorn]) cylinder (h=PushHoch+5,d1=BPush,d2=BPush2,$fn=50);
translate ([-CubeBreit/2+2,-Rund/2,Dick+Hoch+Front]) cube ([CubeBreit-4,3,2]);

}
translate ([-CubeBreit/2+5,-Rund/2,Dick+Hoch+Front]) cube ([12.5,3,2]);
}
rotate ([90,0,0]) Adapter ();
//Adapter ();