// SPIRAL SETTINGS
// Number of complete rotations of the spiral
NSpiral=1.2;
// Stretch factor for Spiral
Stretch_Factor=1;
Stretch=Stretch_Factor*.065;
// Radius of Spiral at widest point
Amplitude=5;
// Spiral Cost Thickness
SpiralThick=3;
// Length of Pendent
DropLength=37;
// Smoothness of spiral
$fn=8;
// TEXT SETTINGS
// Text for Pendent
Name="LOVE";
// Text Starting Height
TStart=3;
// Text Spacing
TSpace=6;
// Font
TFont="Arial Black";
// Font Height
FHeight=6;
Pi=3.14159265358979323846264338327950288419716939937510582*1;
//Size=2*Pi*NSpiral;
Size=360*NSpiral;
FirstQ=90*1;
LastQ=NSpiral*360-FirstQ;
Steps=Size/100;

module Spiral(Start,Stop){
    a=Amplitude;
    for (t=[Start:Steps:Stop]){
        x=a*sin(t);
        y=a*cos(t);
        z=t*Stretch;
        Thick=SpiralThick;
        translate([x,y,z])sphere(d=Thick);
    }
}

module SpiralStart(Start,Stop){
    for (t=[Start:Steps:Stop]){
        a=Amplitude-(pow(t-Stop,2)/pow(Stop,2))*Amplitude;
        x=a*sin(t);
        y=a*cos(t);
        z=(t*Stretch)*(t/Stop);
        Thick=SpiralThick;
        translate([x,y,z])sphere(d=Thick);
    }
}

module SpiralEnd(Start,Stop){
    for (t=[Start:Steps:Stop]){
        a=Amplitude-(pow(t-Start,2)/pow(FirstQ,2))*Amplitude;
        x=a*sin(t);
        y=a*cos(t);
        z=(t*Stretch)+Amplitude*((t-Start)/Steps)/((Stop-Start)/Steps);
        Thick=SpiralThick*(1-(((t-Start)/Steps)/((Stop-Start)/Steps)/1.5));
        //echo((t-Start)/Steps);
        //echo((Stop-Start)/Steps);
        //echo(((t-Start)/Steps)/((Stop-Start)/Steps));
        translate([x,y,z])sphere(d=Thick);
    }
}

module FullSpiral(){
    SpiralStart(0,FirstQ);
    Spiral(FirstQ,LastQ);
    SpiralEnd(LastQ,Size);

    rotate([0,0,180])SpiralStart(0,FirstQ);
    rotate([0,0,180])Spiral(FirstQ,LastQ);
    rotate([0,0,180])SpiralEnd(LastQ,Size);
    
    cylinder(d=SpiralThick/2,h=DropLength,$fn=40);
    translate([0,0,DropLength])sphere(d=SpiralThick);
}

module ShowName(){
    for (i=[1:len(Name)]){
        translate([0,-i*TSpace,-FHeight*.4])linear_extrude(height=FHeight*.8)text(Name[i-1],font=TFont,size=FHeight,halign="center");
    }
}

module Clip(){
    cylinder(d=SpiralThick/2,h=SpiralThick,$fn=40);
    translate([0,0,SpiralThick*1.75])rotate([90,0,0])rotate_extrude(angle=360,convexity=2,$fn=30)translate([SpiralThick*.75,0,0])circle(d=SpiralThick/2,$fn=20);
}

rotate([0,180,0])translate([0,0,TStart])rotate([-90,0,0])ShowName();
rotate([0,180,0])FullSpiral();
Clip();