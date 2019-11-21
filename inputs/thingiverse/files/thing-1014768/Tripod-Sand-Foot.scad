// Ball joint in SCAD by Erik de Bruijn
// Based on a design by Makerblock ( http://makerblock.com/2010/03/blender-help/ )
size=10; // size of the ball joint
joint_spacing =0.3; // some space between them?
joint_thickness = 2; // thickness of the arms
joint_arms = 5; // how many arms do you want?
arm_width = 5; // actually: how much is removed from the arms Larger values will remove more

// Pad Parameters
Pad_Radius = 30;
Pad_height = 7.5; // Height from center of ball to the bottom of the pad
Pad_Thickness = 2 ;
Rim = 2;
Rim_Height = Pad_Thickness + Rim; 

// Tripod Fitting Parameters

Cup_height = 19;
Cup_radius = 14 ;
Wall_thickness = 2;

//render settings
$fs=0.8; // def 1, 0.2 is high res
$fa=4;//def 12, 3 is very nice

//print();
demo(); // turn on animation, FPS 15, steps 200

module demo()
{
    base();
rotate([sin($t*720)*28,cos($t*360*4)*28,cos($t*360*2)*20]) Tripod_Fitting();// view at an angle
//    Tripod_Fitting();// view in-line

}
module print()
{
  translate([size*5+10,0,0]) base();
  rotate([0,180,0]) Tripod_Fitting();
}

module base()
{
    // Ball
    sphere(r=size);
	translate([0,0,-size]) cylinder(r1=8,r2=6,h=3);
    
    // Bottom Pad    
    difference() 
    {
        translate([0,0,-size-Pad_height]) cylinder(r=Pad_Radius,h=Rim_Height);
        translate([0,0,-size-Pad_height+Pad_Thickness]) cylinder (h = Rim_Height+2, r=Pad_Radius - Rim,  $fn=100);
    }
    translate([0,0,-size-Pad_height]) cylinder(r=8,h=Pad_height);
    

    
}



module Tripod_Fitting()
{
difference()
{
    // Socket
	sphere(r=size+joint_spacing+joint_thickness);
	sphere(r=size+joint_spacing);
	translate([0,0,-size-3]) cube([size+joint_spacing+joint_thickness+25,size+joint_spacing+joint_thickness+25,18],center=true);
	for(i=[0:joint_arms])
	{
		rotate([0,0,360/joint_arms*i]) translate([-arm_width/2,0, -size/2-4])
			cube([arm_width,size+joint_spacing+joint_thickness+20,size+6]);
	}
}
    // Top Collum  
	translate([0,0,size-2]) cylinder(r2=8,r1=8,h=5);// join socket to tripod cup
    difference() 
    {
        translate([0,0,size]) cylinder (h = Cup_height, r=Cup_radius, $fn=100);// outer diameter
        translate([0,0,size +3])cylinder (h = Cup_height + 1, r=Cup_radius - Wall_thickness , $fn=100);//inner diameter
    }
}