Render_Quality = 100; // [100:Fine, 60:Middle, 30:Coarse]
$fn =Render_Quality; // number of fragments

Thread_Size = 6; // [0:M2, 1:M2.5, 2:M3, 3:M4, 4:M5, 5:M6, 6:M8, 7:M10, 8:M12, 9:M14, 10:M16, 11:M18, 12:M20]

Make_Drain_Bottom = 1; //[0:No, 1:Yes]
Make_Shoulder_Top = 1; //[0:No, 1:Yes]
/* [Hidden] */
Thread_Wrench_Width = [[2,4,1.6],[2.5,5,2],[3,5.5,2.4],[4,7,3.2],[5,8,4],[6,10,5],[8,13,6.5],[10,17,8],[12,19,10],[14,22,11],[16,24,13],[18,27,15],[20,30,16]];

//Debug
//echo (Thread_Wrench_Width[12]);
//echo (Thread_Wrench_Width[Thread_Size][0]);

Outer_Diameter = Thread_Wrench_Width[Thread_Size][0]*5;
Total_Height = Thread_Wrench_Width[Thread_Size][0]*1.875;

Drain_Bottom_Diameter_1 = Thread_Wrench_Width[Thread_Size][0]*3.5;
Drain_Bottom_Diameter_2 = Thread_Wrench_Width[Thread_Size][0]*2.5;
Height_Drain_Bottom = Thread_Wrench_Width[Thread_Size][0]*0.5;

Height_Shoulder = Thread_Wrench_Width[Thread_Size][0]*0.625;
Shoulder_Diameter_1 = Thread_Wrench_Width[Thread_Size][0]*2.5;
Shoulder_Diameter_2 = Thread_Wrench_Width[Thread_Size][0]*3.75;

Through_Hole =Thread_Wrench_Width[Thread_Size][0]*1.0625;

Hex_Width = Thread_Wrench_Width[Thread_Size][1];
Hex_Depth = Thread_Wrench_Width[Thread_Size][2]*0.923;

Grip_Radius = Thread_Wrench_Width[Thread_Size][0]*1.875;
Grip_Depth = Thread_Wrench_Width[Thread_Size][0]*0.188;
/* [Hidden] */
Number_of_Grips = 10;
Height_Chamfer_30_Degree = Thread_Wrench_Width[Thread_Size][0]*0.188;


module Outside_Measurements()
{
    cylinder(r=Outer_Diameter/2, h= Total_Height);
}
    
module Drain_Bottom()
{
    cylinder(r1=Drain_Bottom_Diameter_1/2, r2=Drain_Bottom_Diameter_2/2, h= Height_Drain_Bottom, center = true);
}
module Through_Hole()
{
    cylinder(r=Through_Hole/2, h= Total_Height);
} 
module Shoulder_Top()
{
    translate([0,0, Total_Height-Height_Shoulder]){
            difference(){
                cylinder(r=Outer_Diameter/2, h=Height_Shoulder);
                cylinder(r1=Shoulder_Diameter_2/2, r2=Shoulder_Diameter_1/2, h=   Height_Shoulder);
            } 
    } 
 }   
    
module Hex()
{ 
    translate([0,0, Total_Height-Hex_Depth]){
        linear_extrude(height = Hex_Depth){
        circle((Hex_Width/2)/sin(60),$fn=6);
        }
    }
}

module Grip_Notches(){
    for (a =[1:Number_of_Grips]){
        rotate(a = a*360/Number_of_Grips, v = [0,0,1]){
            translate([Outer_Diameter/2+Grip_Radius-Grip_Depth,0,0]){
                cylinder (r=Grip_Radius, h=Total_Height);
            }
        }
    }
}

module Chamfer_30_Degree(){
difference(){
                cylinder(r=Outer_Diameter/2, h=Height_Chamfer_30_Degree);
                cylinder(r1=Outer_Diameter/2-Height_Chamfer_30_Degree/tan(30), r2=Outer_Diameter/2, h=Height_Chamfer_30_Degree);
            } 
}
        
difference(){
    Outside_Measurements();
    union()
    {
    
    if (Make_Drain_Bottom==1) Drain_Bottom();
    Through_Hole();
    if (Make_Shoulder_Top==1) Shoulder_Top();
    Hex();
    Grip_Notches();
    Chamfer_30_Degree();
    if (Make_Shoulder_Top==1) translate([0,0,Total_Height-Height_Shoulder])
    {
        mirror([0,0,1]) Chamfer_30_Degree();    
    }
    if (Make_Shoulder_Top==0) translate([0,0,Total_Height])
    {
        mirror([0,0,1]) Chamfer_30_Degree();    
    }   
    }
}