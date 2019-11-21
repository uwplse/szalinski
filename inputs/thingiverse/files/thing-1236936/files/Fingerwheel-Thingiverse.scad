Render_Quality = 100; // [100:Fine, 60:Middle, 30:Coarse]

$fn =Render_Quality; // number of fragments


Outer_Diameter = 40;  // [10:1:100]
Total_Height = 15;  // [10:1:60]

Drain_Bottom_Diameter_1 = 28; // [5:1:90]
Drain_Bottom_Diameter_2 = 20; // [5:1:90]
Height_Drain_Bottom = 4; // [0:1:58]

Height_Shoulder = 5; // [0:1:58]
Shoulder_Diameter_1 = 20; // [10:1:100]
Shoulder_Diameter_2 = 30; // [10:1:100]

Through_Hole =8.5; // [0:0.1:25]

Hex_Width = 13; // [0:0.1:38]
Hex_Depth = 6; // [0:0.1:35]

Grip_Radius = 15; // [5:1:100]
Grip_Depth = 1.5; // [0:0.1:30]
Number_of_Grips = 10; // [4:1:40]

Height_Chamfer_30_Degree = 1.5; // [0.5:0.1:15]


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
    Drain_Bottom();
    Through_Hole();
    Shoulder_Top();
    Hex();
    Grip_Notches();
    Chamfer_30_Degree();
    translate([0,0,Total_Height-Height_Shoulder]){
        mirror([0,0,1]) Chamfer_30_Degree();    
    }    
    }
}