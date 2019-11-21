/* [Ring] */
// Smaller Ring (mm)
MinSize = 16; // [12:25]
// Bigger Ring (mm)
MaxSize = 19; // [14:30]
// Lower radius difference. Enlarge the lower part of each piece
LowerRadiusDifference = 0.25; //[0:0.1:0.5]
// Ring Height (mm)
Height = 6;  // [4:15]
/* [Base] */
// Base Diameter, ZERO to Squared Base (mm)
BaseDiameter=30;
// Squared Base Size (mm)
BaseSize=22;

/* [Hidden] */
$fn=100;


for(i=[MinSize:1:MaxSize])
{
    translate([0,0,-(i-MinSize)*Height])
    {
        difference()
        {
            radius = i/2.0;
            rm = radius;
            rM = radius + LowerRadiusDifference;
            cylinder(r1=rM,r2=rm,h=Height,center=true);
            translate([i/2.0,0,0])
                cube([2,Height*2,Height],center=true);
        
            translate([(i/2.0)-2,-Height/1.6,-Height/2.4])
                rotate([90,0,90])
                    linear_extrude(height=2)
                        text(str(i),Height*0.8);
        }
    }
}
// Base
if(BaseDiameter > 0){
    translate([0,0,-0.5-(MaxSize-MinSize+0.5)*Height])
        cylinder(r=BaseDiameter/2.0,h=1,center=true);
}
else
{
    translate([0,0,-0.5-(MaxSize-MinSize+0.5)*Height])
        cube([BaseSize,BaseSize,1],center=true);        
}