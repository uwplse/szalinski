DowelDiameter = 7.8;
DrillDiameter = 2.4;
FitBuffer = 0.5;
OverallHeight = 20;
rad1 = (DowelDiameter/2)+FitBuffer;
rad2 = (DrillDiameter/2)+FitBuffer;
$fn=50;
difference(){
    union(){
        cylinder(OverallHeight,DowelDiameter,DowelDiameter,true);
        cube([OverallHeight,OverallHeight/1.5,OverallHeight],true);
    }
    union(){
        cylinder(OverallHeight/1.99,rad1,rad1);
        translate([0,0,-(OverallHeight/2)])
            cylinder(OverallHeight/1.99,rad2,rad2);   
    }
}
