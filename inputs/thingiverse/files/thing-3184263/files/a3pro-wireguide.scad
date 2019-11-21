/* [Main settings] */
//The height of wireguide measured center of screws to center of guide
arm_rise=50;

//Width of each arm of the guide, also controls the size of the 2 screw pads.
arm_width=10;

//Depth of the arms, 4 is original, 2 fits with my shorter screws. 
arm_depth=4;

/* [Other settings] */
//The offset from origin for each arm. (or 1/2 the distance between the 2 mounting screws.
arm_offset=34;

//depth of wireguide. Standard is 10
wireguide_depth=10;

/* [Hidden] */
$fn=100;


//shouldnt have to modify these:
wireguide_ID=arm_width;
wireguide_OD=wireguide_ID+5;
wireguide_lip_d=wireguide_ID+7;

difference()
{
    frame();
    
    union(){
        translate ([0,arm_rise,-5]) cylinder(20,5,5); 
        translate ([-arm_offset,0,-5]) cylinder(20,2.5,2.5); 
        translate ([arm_offset,0,-5]) cylinder(20,2.5,2.5); 
        rotate([0,0,90]) 
        translate([0,-2,-.5])
        cube([arm_rise,4,wireguide_depth+1]);
    }
}


module frame(){
    arm_hypo=sqrt(pow(arm_offset,2) + pow(arm_rise,2));
    
    arm_angle=acos(arm_offset/arm_hypo);
    
    echo(arm_offset);
    
    
    // right arm
    translate([arm_offset,0,0])
    rotate([0,0,180-arm_angle])
    translate([0,-arm_width/2,0])
       traphedron(arm_depth,arm_hypo,arm_width,wireguide_OD);  
    //cube([arm_hypo,10,arm_depth]);
    
    //left arm
    translate([-arm_offset,0,0])
    rotate([0,0,arm_angle])
    translate([0,-arm_width/2,0])
     traphedron(arm_depth,arm_hypo,arm_width,wireguide_OD);
       // cube([arm_hypo,10,arm_depth]);
    
    //right nub
    translate([arm_offset,0,0])
        cylinder(arm_depth,arm_width*1.1/2,arm_width*1.1/2);
        
    //left nub
    translate([-arm_offset,0,0])
        cylinder(arm_depth,arm_width*1.1/2,arm_width*1.1/2);
        
    wireguide();
}

module wireguide(){
    union(){
        translate ([0,arm_rise,0]) 
        {
           cylinder(wireguide_depth,wireguide_OD/2,wireguide_OD/2); 
            
           translate([0,0,wireguide_depth-1]) cylinder(1,wireguide_lip_d/2,wireguide_lip_d/2);  
            
           translate([0,0,-1]) cylinder(wireguide_depth,0,wireguide_lip_d/2);
        }        
    }
}

module traphedron(depth,length,width_1,width_2)
{
  linear_extrude(height=depth)
  polygon(points=[[0,0],
                  [0,width_1],
                  [length,(width_1/2)+(width_2/2)],
                  [length,(width_1/2)-(width_2/2)],
                  [0,0]]);
    
}

//%import("Cable_Support_for_Laser_Carriage.stl", convexity=3);