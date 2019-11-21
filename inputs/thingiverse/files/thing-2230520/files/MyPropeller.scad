Height = 10;
ShaftExtraHeight = 0;
MotorShaftDiameter = 2.5;
CenterShaftDiameter = 5;
Thickness = 2;
Size = 40;
TwistAngle = 60;
ShrinkRatio=0.5;
Blades = 3;

$fn=64;

difference(){
    PropellerBase();
    translate([0,0,-(Height+ShaftExtraHeight)/2])
        cylinder(d=MotorShaftDiameter,
                 h=Height+ShaftExtraHeight);
}

module PropellerBase(){
    blades = (Blades<2?2:(Blades>10?10:Blades));
    linear_extrude(Height,
                   twist=TwistAngle,
                   scale=ShrinkRatio,
                   slices=64){
        for(x=[2:blades+2]){
            rotate(a=[0,0,x*360/blades])
                translate([-Thickness/2,1.001])
                    square([Thickness,(Size/2)-1]);
        }
    }
    translate([0,0,Height]) 
        scale([1,1,2])sphere(d=CenterShaftDiameter);
    translate([0,0,-ShaftExtraHeight])
        cylinder(d=CenterShaftDiameter,
                 h=Height+ShaftExtraHeight);
}