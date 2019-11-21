//Roller Bearing
// (C) 2013 Wouter Robers 

OuterDiameter=60;
InnerDiameter=10;
InnerCorners=6;
NumberOfPlanets=7;
Thickness=10;
Tolerance=.15;

//Sun

difference(){
MakeWheel((OuterDiameter-InnerDiameter)*0.2+InnerDiameter-Tolerance*2,-Thickness,Thickness);
cylinder(r=InnerDiameter/2+Tolerance,h=Thickness,$fn=InnerCorners);
}


//Outer Ring

difference(){
cylinder(r=OuterDiameter/2-Tolerance,h=Thickness);
MakeWheel((OuterDiameter-InnerDiameter)*0.8+InnerDiameter+Tolerance*2,Thickness,Thickness);
}


// Planets

for(i=[1:NumberOfPlanets]){
rotate([0,0,i*360/NumberOfPlanets])
translate([((OuterDiameter-InnerDiameter)*0.5+InnerDiameter)/2,0,0]) MakeWheel((OuterDiameter-InnerDiameter)*0.3-Tolerance*2,Thickness,Thickness);
}




module MakeWheel(Diameter,Rim,Thickness)
{
$fn=60;
union(){
cylinder(r1=Diameter/2-Rim*0.1,r2=Diameter/2,h=Thickness*0.1);
translate([0,0,0.1*Thickness]) cylinder(r=Diameter/2,h=Thickness*0.8);
translate([0,0,0.9*Thickness]) cylinder(r2=Diameter/2-Rim*0.1,r1=Diameter/2,h=Thickness*0.1);
}
}



