/* 
 * Parametric Encoder Wheel 
 *
 * by Rafael Estevam, November 2015
 * http://www.RafaelEstevam.Net
 * 
 * Licenced under Creative Commons Public Domain
*/

ExternalRadius = 10;
WallTickness = 1;
InnerRadius = 5;
TeethCount = 5;
WheelHeight = 2;
CenterHoleRadius = 1.75;
CenterHoleExagonal = "No"; // [No,Yes]
CenterSupportRadius = 4;
CenterSupportHeight = 2;
CenterSupportHoleRadius = 3;
CenterSupportHoleExagonal = "Yes"; // [No,Yes]

/* [HIDDEN] */
$fn=50;

difference(){
    union(){
        Wheel(ExternalRadius,WallTickness,
              InnerRadius,TeethCount,WheelHeight);
        cylinder(h=CenterSupportHeight,
                 r=CenterSupportRadius);
    }
    translate([0,0,WheelHeight/2])
        cylinder(h=(WheelHeight+CenterSupportHeight)*2,
                 r=CenterSupportHoleRadius,
                 $fn=CenterSupportHoleExagonal == "No" ? 50:6);
    translate([0,0,-WheelHeight+0.01])
        cylinder(h=WheelHeight*2,
                 r=CenterHoleRadius,
                 $fn=CenterHoleExagonal == "No" ? 50:6);
}


module Wheel(ExtRadius,Wall,InnerRadius,TeehCount,Height){
    cylinder(r=InnerRadius,h=Height,center=true);
    difference(){
        cylinder(r=ExtRadius,h=Height,center=true);
        for(a = [0:2:TeehCount*2]){
            stepAngle = 360.0 / (TeehCount*2);
            3DArc(Height+1,a*stepAngle,
                  (a+1)*stepAngle,
                  ExtRadius-Wall);
            
        }
    }
}
module 3DArc(Height,StartAngle,EndAngle,Radius){
    linear_extrude(height=Height,center=true)
    2DArc(StartAngle,EndAngle,Radius);
}
module 2DArc(StartAngle,EndAngle,Radius){
    points = [ 
        for (a = [StartAngle : EndAngle]) 
            Radius * [ sin(a), cos(a) ] ];
    polygon(concat(points, [[0, 0]]));
}