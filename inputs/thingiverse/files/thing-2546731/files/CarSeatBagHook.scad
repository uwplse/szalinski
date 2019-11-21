//Aqee Li, 
//https://www.thingiverse.com/Aqee
//2017-9-21
//Original publish url:
//https://www.thingiverse.com/thing:2546731
//Lisence: CC-AN-SA

//A hook to hang bags at back of front seat in your car.
//Customize it as you need.

/*[Overall]*/
//Draft or Final. Use draft when trying for faster, and Final for output stl.
Draft=0; //[1:Draft, 0:Final]
//Rounded corner radius, only works in Final mode.
Rounded=1;

/*[Parameters]*/
Thickness=5;
Width=25;
//Arm Length(Horizontal Part), include bend
ArmLength=100;
//Arm Height(Vertical Part), include bend
ArmHeight=100;
//Radius of bend between Arm Horizontal and vertical parts.
ArmBend=15;
//Radius of bend between Hook and Arm vertical parts.
HookBend=10;
//Height of Hook, exclude bend
HookHeight=25;
//Diameter of the stick where you want to hang this hook
StickDiameter =10;
//For safety, the opening is slightly shrinked than the stick 
StickDiameterShrink=0.05;


minkowski() //rounded with sphere
{
    {
        difference() // devide stick hook hole form the arm
        {
            union() 
            {
                linear_extrude(Width){
                    //Arm Horizontal
                    translate([ArmBend, 0])
                    square([ArmLength-ArmBend, Thickness]);
                    
                    //Arm Vertical
                    translate([-Thickness, -ArmHeight])
                    square([Thickness, ArmHeight-ArmBend]);
                    
                    //Hook
                    translate([-HookBend*2-Thickness*2, -ArmHeight])
                    square([Thickness, HookHeight]);
                }
                
                //Arm Bend
                translate([ArmBend,-ArmBend, Width])
                rotate([0,0,-90])
                GetBend(ArmBend ,90 );

                //Hook Bend
                translate([-HookBend-Thickness,-ArmHeight, Width])
                GetBend(HookBend ,180 );
                
                //Round End
                translate([ArmLength,Thickness,Width/2])
                rotate([90,90,0])
                GetRoundEnd();
                translate([-HookBend*2-Thickness*2,-ArmHeight+HookHeight,Width/2])
                rotate([90,90,90])
                GetRoundEnd();
            }
            
            //Stick Hook
            {
            translate([ArmLength-Width/2,-Thickness*0.5, Width/2])
            rotate([-90,0,0])
            linear_extrude(Thickness*2)
                hull(){   
                circle(d=StickDiameter+Rounded);
                translate([-Width,-Width])
                circle(d= (StickDiameter+Rounded)*(1-StickDiameterShrink));
                }
            }
        }
    }
    if(Draft==0)
        sphere(Rounded, $fn=36);
}

module GetRoundEnd()
{
        linear_extrude(Thickness)
    difference(){
        circle(Width/2);
        translate([-Width/2,-Width])
        square(Width);
    }
}

module GetBend(radius, angle)
{
    rotate_extrude(angle=angle){
    translate([-radius-Thickness,-Width])
    square([Thickness, Width]);
    }
}



