//Revision 1.0 released 1 SEPT 15
//by Siti



//Desired height of hanger
Height = 15;
//Desired Overall Dimension for hanger
OD = 16;
//Measured Overall Dimension of thread
Thread_OD = 3;

threadTol = 6*1;
//Measured diameter of nut (across corners)
Nut_OD = 6.7;
//Number of sides of nut
Nut_Sides = 6; //[4,6]
//Depth of nut
Nut_Depth = 3;
//Clearance around thread, no need to touch this unless you're having clearance issues.
Thread_Clearance = 1;
//Clearance around nut, no need to touch this unless you're having clearance issues.
Nut_Clearance =0.8;
NutCutoutD = Nut_OD+Nut_Clearance;
//angle of guide from vertical. Probably no need to touch this.
Angle = 30;

fudge = 0.01*1;
edge=1*1;

GrooveR = (edge+OD)/2-(tan(Angle)*(Height/2));

intersection()
{
difference()
{
    //things to add
    union()
    {
        //top cone
        translate([0,0,Height/4])cylinder( r2 = (OD+edge)/2, r1 = GrooveR, center=true, h = Height/2,$fn=64);
        //bottom cone
         rotate([0,180,0])translate([0,0,Height/4])cylinder( r2 = (OD+edge)/2, r1 = GrooveR, center=true, h = Height/2,$fn=64);
        
    };
    
    //things to subtract
    union()
    {
       translate([0,0,Height/2-Nut_Depth/2+fudge])cylinder(d=NutCutoutD, h = Nut_Depth,center=true, $fn=Nut_Sides); 
        
        cylinder(h = Height+fudge,d=Thread_OD+Thread_Clearance,center=true,$fn=64);
    };
    
}

cylinder(h=Height,d=OD,center=true,$fn=64);

}