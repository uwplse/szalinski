/*
Fruit fly trap

George Miller
11-03-2017

This will be sized to fit onto a baby food jar.
*/




JarInnerDia=43.2;
JarThreadDia=48.6;
JarThreadHeight=5.2;
coneHeight=20;
holeDia=3;
wallthick=1;




/* Hidden */
JIR=JarInnerDia/2;
JTR=JarThreadDia/2;
HoleR=holeDia/2;
PartOR = JTR+wallthick;
PartH = JarThreadHeight+wallthick;
/* Part */

$fn=180;
rotate_extrude()
{
    //flat lid
    CleanRail(X1=JIR-(wallthick/2),Y1=(wallthick/2),X2=PartOR-(wallthick/2),Y2=(wallthick/2),Width=wallthick);
    
    //lid thread and rim
    //translate([JTR,0,0])
    //square([wallthick,PartH]);
    CleanRail(X1=PartOR-(wallthick/2),Y1=PartH-(wallthick/2),X2=PartOR-(wallthick/2),Y2=(wallthick/2),Width=wallthick);
    
    //funnel
    CleanRail(X1=JIR-(wallthick/2),Y1=(wallthick/2),X2=HoleR+(wallthick/2),Y2=coneHeight-(wallthick/2),Width=wallthick);
    
}    




//CleanRail();
module CleanRail(X1=0,Y1=0,X2=20,Y2=20,Width=2){
    //puts a rail between two points.
    Q1 = (X2>=X1)&&(Y2>=Y1)?atan((Y2-Y1)/(X2-X1)):0;
    Q2 = (X2<X1)&&(Y2>=Y1)?(180+atan((Y2-Y1)/(X2-X1))):0;
    Q3 = (X2<X1)&&(Y2<Y1)?(180+atan((Y2-Y1)/(X2-X1))):0;
    Q4 = (X2>=X1)&&(Y2<Y1)?(atan((Y2-Y1)/(X2-X1))):0;
    //angle = atan((Y2-Y1)/(X2-X1)) + Q1 + Q2 + Q3 + Q4;
    angle = Q1 + Q2 + Q3 + Q4;
    //rad = round(angle/90)==(angle/90)?0:(Width/2);
    rad = (Width/2);
    length = sqrt(pow((X2-X1),2)+pow((Y2-Y1),2));
    
    translate([X1,Y1,0])
    union(){
        rotate([0,0,angle])
        translate([0,0,0]){
            circle(rad,$fn=45);
            translate([0,-(Width/2),0])
            square([length,Width]);
            translate([length,0,0])
            circle(rad,$fn=45);
        }
    }
    
}