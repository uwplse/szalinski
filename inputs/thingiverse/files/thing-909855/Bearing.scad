$fn=100;

//Diameter of bearing
Outer_Diameter=50;
//Diameter of inner hole
Hole_Diameter=20;
//Thickness of the bearing also the diameter of the balls
Thickness=10;
//Tolerance
Bearing_Tolerance=0.3; //[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]


Bearing([Hole_Diameter,Outer_Diameter,Thickness], Bearing_Tolerance);
//Bearing([20,60,15], .2);

function Circumference(Diameter)=PI*Diameter;
function CircumferenceFromBalls(numberofballs,balldiameter,tolerance) = numberofballs*(balldiameter+tolerance);

function Diameter(Circumference)=Circumference/PI;


module Bearing(Size, Tolerance) {
    Inner=Size[0];
    Outer=Size[1];
    Ball=Size[2];
    
    GapPercent=.5;//Amount of bearing exposed
    RadiusLimit=.8;//mm min amount of material to leaf in rails when tring to place balls
    BallTolerance=Tolerance/2;//Tolerance can be tighter because spheres only touch at a small point.
    
    CenCenter=((Outer/2-Inner/2)/2+Inner/2)*2; //Diameter if balls placed in center
    
    MaxCenter=(Outer/2-Ball/2-RadiusLimit)*2; //Diameter if balls placed as far out as possible
    MinCenter=(Inner/2+Ball/2+RadiusLimit)*2; //Diameter if balls placed as far in as possible
    
    if (MinCenter>MaxCenter)
        echo ("Error: Bearing will not print");
    
        C=Circumference(CenCenter);//Circumference at center
        NumberOfBearings=floor(C/(Ball+Tolerance/2)); //Number of ball that can fit at center
        
        CMin=CircumferenceFromBalls(NumberOfBearings,Ball,BallTolerance);
        CMax=CircumferenceFromBalls(NumberOfBearings+1,Ball,BallTolerance);
        
      MinCalcCenter=Diameter(CMin);//2*CMin/(2*PI);
      MaxCalcCenter=Diameter(CMax);//2*CMax/(2*PI);
        
      //Center = (MaxCalcCenter>MaxCenter) ? MaxCalcCenter : Center;  
        CUse=(C-CMin<CMax-C)?CMin:CMax;
        Bearings=(C-CMin<CMax-C)?NumberOfBearings:NumberOfBearings+1;
        echo("C:",C,"CMin:",CMin,"CMax:",CMax,"CUse:",CUse,"Bearings:",Bearings);
      //Center = (MinCalcCenter>MinCenter) ? MinCalcCenter : (MaxCalcCenter<MaxCenter) ? MaxCenter: CenCenter; 
            
    //Center=Diameter(CUse);
    Center=(Diameter(CUse)>MaxCenter)?MaxCalcCenter:(Diameter(CUse)<MinCenter)?MinCenter:Diameter(CUse);
    
    echo("MinCenter:",MinCenter,"CenCenter:",CenCenter,"MaxCenter:",MaxCenter,"Diameter(CUse)",Diameter(CUse),"Center:",Center);
    
    difference() {
    cylinder(d=Outer,h=Ball);
    translate([0,0,-1]) cylinder(d=Inner,h=Ball+2);
    
    //difference() {    
    //translate([-4,-8,.5])
    //rotate([90,0,0])
    //linear_extrude(height=Ball)
    //text(text=str(Tolerance),size=Ball-1);    
    //cylinder(d=Outer-.8,h=Ball);  
    //}
    
    difference() {
       translate([0,0,-1]) cylinder(d=Center+Ball*GapPercent,h=Ball+2);  
      translate([0,0,-2]) cylinder(d=Center-Ball*GapPercent,h=Ball+4);
    
    }
        
        translate([0,0,Ball/2])
            rotate_extrude() {
            translate([Center/2,0,0]) circle(d=Ball+Tolerance*2);
        }
           
        }
        Degrees=360/Bearings;
    for(i=[0:Bearings]) {
        
        rotate([0,0,Degrees*i]) translate([Center/2,0,Ball/2]) sphere(d=Ball);
        
    }
        
}





