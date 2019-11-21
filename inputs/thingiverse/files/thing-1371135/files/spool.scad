// lib
function r2d(a) = 180 * a / PI;

// inner circumference
Circumference = 200; // [0.1:0.1:1000]

// distance between grooves
Pitch = 5; // [0.1:0.1:20]

// groove depth
Groove_Depth = 4; // [0.1:0.1:1000]

// height
Height = 100; // [0.1:0.1:1000]

// smoothness (facets)
Smoothness = 72;// [3:1:144]

// end cap vertical height from ends
End_Height = 7; // [0:0.1:500]

// end cap deph from the main radius
End_Depth = 3; // [0:0.1:500]

Wall_Thickness = 3; // [0.1:0.1:500]

// 
Axis_Diameter = 5;// [0:0.1:50]

// number of internal supports
Num_Supports = 2;//[0:1:100]

Support_Count = Num_Supports - 1;

Thread_Direction = 1; // [-1,1]

// calculated values
Adj_Circumference = Circumference + Groove_Depth;
Radius = Adj_Circumference / (PI * 2);
Hole_Radius = Radius - Wall_Thickness - Groove_Depth;
Segment_Angle = 90-atan2(Pitch, Adj_Circumference);
Segment_Length = (Adj_Circumference / Smoothness);
Turns = Height / Pitch;

// make threads
difference(){
    // main body
    union(){
        difference(){
            // rotate so main cylinder facets will be in-line with groove segments
            rotate([0,0,360/Smoothness/2]) cylinder(Height, Radius, Radius, $fn = Smoothness);
            // channel
            union(){
                for (i = [0:Turns * Smoothness]){
                    Segment(i);
                }
            }
        }
        // end caps
        if (End_Height > 0 && End_Depth > 0){
            cylinder(End_Height, Radius + End_Depth , Radius + End_Depth );
            translate([0,0,Height - End_Height]) cylinder(End_Height, Radius + End_Depth , Radius + End_Depth );
            }
        }
    
    // center hole
    translate([0,0,-1]){
        cylinder(Height + 2, Hole_Radius,Hole_Radius);
    }
    
    // cable_hole
    cable_hole_height = End_Height + Groove_Depth/2;
    segment_index = (cable_hole_height / Pitch) * Smoothness;
    segment_angle = (Thread_Direction * -segment_index * 360/Smoothness) + 90;
    translate([0,0,cable_hole_height]){
        rotate([90,0,segment_angle]){
            cylinder(Radius, Groove_Depth/2, Groove_Depth/2, $fn = 10);
        }
    }
}

// make inner structure
Support_Dist = (Height - Wall_Thickness) / Support_Count;
difference(){
    union(){
        for (i = [0:Support_Count]){
            translate([0,0,i * Support_Dist]) SupportStrap(i);
        }
    }

    translate([0,0,-1]) cylinder(Height + 2, Axis_Diameter / 2, Axis_Diameter / 2);
}


module Segment(index = 0){
    Turn_Index = index / Smoothness;
    rotate([0,0, Thread_Direction * -index * 360/Smoothness]){
        translate([0,0, Turn_Index * Pitch]){
            translate([Radius, 0, 0]){
                rotate([Thread_Direction * Segment_Angle,0, 0]){
                    translate([0,0,-0.5 * Segment_Length]){
                        resize([Groove_Depth, Groove_Depth,Segment_Length]) cylinder(Segment_Length, Groove_Depth, Groove_Depth, $fn = 10);
                    }
                }
            }
        }
    }
}

module SupportStrap(index = 0){
    translate([0,0,Wall_Thickness / 2]) cube([Hole_Radius*2, Axis_Diameter, Wall_Thickness], true);
    
    rotate([0,0,60]) translate([0,0,Wall_Thickness / 2]) cube([Hole_Radius*2, Axis_Diameter, Wall_Thickness], true);
    
    rotate([0,0,120]) translate([0,0,Wall_Thickness / 2]) cube([Hole_Radius*2, Axis_Diameter, Wall_Thickness], true);
    
}