 
/* [total size] */
width=180; 
depth=180; 
height=60;
/* [windows] */
windowWidth=40; 
windowHeight=6; 
windowOffset=25;  
windowGap=20;

/* [Bunker support] */
supportWidth=15; 
supportDepth=10;

/* [Door] */
DoorHeight=40; 
DoorWidth=20; 

/* [Pillars] */
pillarDiameter=5;  
numberOfPillars=3; // [0:6]
look_inside_to_view_pillars=0;// [0:No, 1:Yes]
/* [Wall] */
wallthickness=3;
 
/* [Doors] */
use_cubes_for_doors=0; // [0:No, 1:Yes]
door_frame=1;
door_type=1; // [0:plain, 1:divided,2:bunker]
add_door_on_front=0; // [0:No, 1:Yes]
add_door_on_back=0; // [0:No, 1:Yes]
add_door_on_left=1; // [0:No, 1:Yes]
add_door_on_right=0; // [0:No, 1:Yes]
/* [slope] */
slope=10;
/* [Fan] */
numberOfFans=4; // [0:4]
Fan_diameter=25;  
Fan_height=3;  
Rotor_thickness=1;  
Rotor_Count=32;  
/* [Hollow] */
hollow=0; // [0:No, 1:Yes]

/* [Hidden] */
 
useCubes=(use_cubes_for_doors==1)?true:false;
hollowIndoor=(hollow==1)?true:false;
openTop= (look_inside_to_view_pillars==1)?true:false;
doorOnFront=(add_door_on_front==1)?true:false; 
doorOnBack=(add_door_on_back==1)?true:false;
doorOnLeft=(add_door_on_left==1)?true:false;
doorOnRight=(add_door_on_right==1)?true:false;
doorGap=20;
$fn=10; 
windowTotalWith=windowWidth+windowGap; 
module Bunker()
{
    color("LightBlue") 
    difference() {
        roundedRect([width,depth, height],slope);
        translate([wallthickness,wallthickness,wallthickness])
        
    if(hollowIndoor)
    {
        roundedRect([width-wallthickness*2,depth-wallthickness*2, height-wallthickness*2+(openTop?wallthickness+1:0)],slope);
    }
        makeSide(0,0,doorOnFront,width+wallthickness);
        makeSide(0,depth-wallthickness,doorOnBack,width); 
        makeSide(90,-wallthickness,doorOnLeft,depth);
        makeSide(90,-width,doorOnRight,depth );  
    }
    
       color("orange")  makeSupport(0,0,doorOnFront,width,false);
       color("orange")  makeSupport(0,depth,doorOnBack,width,true); 
       color("orange")  makeSupport(90,0,doorOnLeft,depth,true);
       color("orange")  makeSupport(90,-width,doorOnRight,depth,false);    
        color("red")  rotate([0,0,-45]) support(); 
        color("red") translate([width ,0,0])rotate([0,0,45])     support();
        color("red")  translate([width ,depth,0]) rotate([0,0,135])  support();
        color("red")  translate([0 ,depth,0])rotate([0,0,-135])  support();
        pillars();
 
    if(numberOfFans==1)
    {
        Fan(width/2,depth/2);
    }
    else if(numberOfFans==2)
    {
        Fan(width/4,depth/2);
        Fan(width/4+width/2,depth/2);
    }
    else if(numberOfFans==3)
    {
        Fan(width/2,depth/3*2);
        Fan(width/4,depth/3);
        Fan(width/4+width/2,depth/3);
    }
    else if(numberOfFans==4)
    { 
        Fan(width/4,depth/3*2);
        Fan(width/4+width/2,depth/3*2);
        Fan(width/4,depth/3);
        Fan(width/4+width/2,depth/3);
    } 
    
} 
module Fan(x,y)
{
$fn=30; 
    translate ([x,y,height])
    {
    difference() {
        cylinder(r1=Fan_diameter/3*2,r2=Fan_diameter/2,h=Fan_height);
    translate ([0,0,1])
        cylinder(d=Fan_diameter-2,h=Fan_height+1);
    }
    cylinder(r1=Fan_diameter/4,r2=0,h=Fan_height);
    translate ([0,0,0])
    { 
        for(r=[0:360/Rotor_Count:360])
        { 
            rotate([24,0,r])
            cube([Fan_diameter/2 ,Rotor_thickness, Fan_height/3*2 ]);
        }
    }
    }
}
module support()
{
supportHeight=height-slope; 
    translate ([-supportWidth/2,,0])
    translate ([0,-supportDepth-supportWidth,0])
    hull(){ 
    cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth*2,0])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth*2,supportHeight/5])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,0,supportHeight/5])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth,supportHeight/2])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth*2,supportHeight/2])cube([supportWidth,supportWidth,supportWidth]);
        
        
    }
    translate ([-supportWidth/2,,0])
    translate ([0,-supportDepth-supportWidth,0])
    hull(){ 
    translate([0,supportDepth,supportHeight/2])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth*2,supportHeight/2])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth,supportHeight-supportWidth ])cube([supportWidth,supportWidth,supportWidth]);
    translate([0,supportDepth+slope,height-supportWidth ])cube([supportWidth,supportWidth,supportWidth]);    
     translate([0,supportDepth+slope*2,height-supportWidth ])cube([supportWidth,supportWidth,supportWidth]);    
       
    }
 
}
module pillars( )
{
    if(hollowIndoor)
    {
    if(numberOfPillars==1)
    {
        pillar(width/2,depth/2);
    }
    else if(numberOfPillars==2)
    {
        pillar(width/4,depth/2);
        pillar(width/4+width/2,depth/2);
    }
    else if(numberOfPillars==3)
    {
        pillar(width/2,depth/3*2);
        pillar(width/4,depth/3);
        pillar(width/4+width/2,depth/3);
    }
    else if(numberOfPillars==4)
    { 
        pillar(width/4,depth/3*2);
        pillar(width/4+width/2,depth/3*2);
        pillar(width/4,depth/3);
        pillar(width/4+width/2,depth/3);
    }
    else if(numberOfPillars==5)
    { 
        pillar(width/2,depth/2);
        pillar(width/4,depth/4*3);
        pillar(width/4+width/2,depth/4*3);
        pillar(width/4,depth/4);
        pillar(width/4+width/2,depth/4);
    }
    else if(numberOfPillars==6)
    { 
        pillar(width/2,depth/4*3);
        pillar(width/2,depth/4);
        pillar(width/4,depth/4*3);
        pillar(width/4+width/2,depth/4*3);
        pillar(width/4,depth/4);
        pillar(width/4+width/2,depth/4);
    }
}
}  
module makeSide(rotation,off,door,length)
{
    doorOffset=door?DoorWidth+doorGap:0;
    offset=((length-doorOffset)%(windowTotalWith))/2; 
    if(door)
    {
        rotate([0,0,rotation])
        translate([doorGap,off,wallthickness])
        door( );
    }
    for(i=[windowGap/2+(offset+doorOffset):windowTotalWith:length-windowWidth])
    { 
        rotate([0,0,rotation])
        window(i,off); 
    } 
}
module makeSupport(rotation,off,door,length,mirr)
{    
    doorOffset=door?DoorWidth+doorGap:0;
     
    offset=((length-doorOffset)%(windowTotalWith))/2;  
    for(i=[windowGap/2+(offset+doorOffset) :windowTotalWith:length-windowTotalWith-windowGap ])
    {   
        rotate([0,0,rotation])
        translate([i+windowWidth+windowGap/2,off,0]) 
            scale([1,mirr?-1:1,1])
        support();
    } 
}
module window(xoffset,zoffset)
{
    
         translate([xoffset,zoffset,windowOffset])  
           cube([windowWidth,wallthickness, windowHeight]); 
}
module door()
{ 
    DCW=(DoorWidth-door_frame*3)/2;
    DCH=(DoorHeight-door_frame*3)/2;
    df=door_frame;
    if(!hollowIndoor&&door_type!=0)
    {
        if(door_type==1)
        { 
         roundCube([DoorWidth,wallthickness+0.001, DoorHeight]);
        
         translate([df,-df,df]) 
         roundCube([DCW,wallthickness+df*2, DCH]);
         translate([df*2+DCW,-df,df]) 
         roundCube([DCW,wallthickness+df*2, DCH]);
         translate([df,-df,wallthickness+DCH]) 
         roundCube([DCW,wallthickness+df*2, DCH]);
         translate([df*2+DCW,-df,DCH+df*2]) 
         roundCube([DCW,wallthickness+df*2, DCH]); 
        }
        if(door_type==2)
        { 
         roundCube([DoorWidth,wallthickness+0.001, DoorHeight]);
            section=DoorHeight/16;
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*16-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*15-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*15-df]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*14-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*14-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df, section*13-df ]) 
         cube([df,wallthickness+df*2, df]); 
            } 
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*13-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df,  section*12-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*12-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*11-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*11-df]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*10-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*10-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df, section*9-df ]) 
         cube([df,wallthickness+df*2, df]); 
            } 
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*9-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df,  section*8-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*8-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*7-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*7-df]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*6-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*6-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df, section*5-df ]) 
         cube([df,wallthickness+df*2, df]); 
            } 
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*5-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df,  section*4-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3-df/2,-df,  section*4-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*3-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*3-df]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3*2-df/2,-df,  section*2-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3*2-df/2,-df,  section*2-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df, section*1-df ]) 
         cube([df,wallthickness+df*2, df]); 
            }
            hull()
            {
         translate([DoorWidth/3-df/2,-df, section*1-df ]) 
         cube([df,wallthickness+df*2, df]); 
         translate([DoorWidth/3-df/2,-df, 0 ]) 
         cube([df,wallthickness+df*2, df]); 
            }
        }
        
    }
    else
    {
        
         translate([0,0,wallthickness]) 
        cube([DoorWidth,wallthickness, DoorHeight]);
    }
} 
module pillar(x,y)
{
 pillarHight=height-wallthickness*2;    
 translate([x-pillarDiameter,y-pillarDiameter,pillarHight-pillarHight/3+wallthickness]) 
 cylinder(h=pillarHight/3, r1=pillarDiameter, r2=pillarDiameter*2, center=false);
 translate([x-pillarDiameter,y-pillarDiameter,pillarHight/3+wallthickness]) 
 cylinder(h=pillarHight/3, r1=pillarDiameter, r2=pillarDiameter, center=false);
 translate([x-pillarDiameter,y-pillarDiameter,wallthickness]) 
 cylinder(h=pillarHight/3, r1=pillarDiameter*2, r2=pillarDiameter, center=false);
} 
module roundedRect(size, r)
{
    r=r==undef?5:r;
$fn=8; 
	w = size[0]-r;
	h = size[1]-r;
	z = size[2]-r-1;
	z2 = size[2]-1;
    translate([r/2,r/2,0])
    hull() {
cylinder(d=r);
translate([0,h,z])cylinder(d=r);
translate([w,0,z])cylinder(d=r);
translate([w,h,0])cylinder(d=r);
translate([w,h,z])cylinder(d=r);
translate([0,0,z])cylinder(d=r);
translate([w,0,0])cylinder(d=r);
translate([0,h,0])cylinder(d=r);
translate([w-r,h-r,z2])cylinder(d=r);
translate([r,r,z2])cylinder(d=r);
translate([r,h-r,z2])cylinder(d=r);
translate([w-r,r,z2])cylinder(d=r);
    }
}
module unicube(d)
{
    cube([d,d,d]);
}    
module roundCube(size, r)
{
    if(useCubes)
    {
        cube(size);
    }
    else
    {
         r=r==undef?5:r;
        $fn=8; 
            w = size[0]-r;
            z = size[1];
            h = size[2]-r;
            rotate([90,0,0])
            translate([r/2,r/2,-z])
            hull() {
        cylinder(d=r);
        translate([0,h,z-1])cylinder(d=r);
        translate([w,0,z-1])cylinder(d=r);
        translate([w,h,0])cylinder(d=r);
        translate([w,h,z-1])cylinder(d=r);
        translate([0,0,z-1])cylinder(d=r);
        translate([w,0,0])cylinder(d=r);
        translate([0,h,0])cylinder(d=r);
            }
    }
}
Bunker();