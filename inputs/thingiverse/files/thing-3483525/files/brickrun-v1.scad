//
// BrickRun V1.0 - Marbles on Bricks
//
// CC-BY-SA 2019 Sebastian Ritterbusch
//

/* [Output] */

// Number of straight bricks
straightBricks=3; // [20]

// Number of turning bricks
bentBricks=4; // [20]

// Nunmber of bricks going down
downBricks=5; // [20]

// Length of bricks in pins
pinCount=3; // [2:1:6] 

// Diameter of marbles in mm
ballSize=16; // [5:30]

// Pipe radius enlargement in percent
radiusEnlargePercent=20; // [100]

/* [Print Settings] */

// Enable inside brim for tight fit
brim=true;

// Spacing of bricks in mm
brickSpacing=10; // [50]

// Rendering quality
$fn=100;

// Safety gap in mm
gap=0.2;


/* [Brick model] */

// https://de.wikipedia.org/wiki/Lego#/media/File:Lego_dimensions.svg

// Length of a 2-pin brick in mm
brickSize2=15.8;

// Wall size in mm
brickWallSize=1.2;

// Height of a brick in mm
brickHeight=9.6;

// Diameter of brick pin in mm
brickPinDiameter=4.8;

// Distance between two brick pins in mm
brickPinDistance=3.2;

// Brick pin height in mm
brickPinHeight=1.7;


bentStart=straightBricks;
downStart=straightBricks+bentBricks;

ballDiameter=ballSize*(1+radiusEnlargePercent/100);

brickDistanceX=brickSpacing+brickSize2*pinCount/2;
brickDistanceY=brickSpacing+brickSize2;

count=straightBricks+downBricks+bentBricks;
lines=floor(sqrt(count)/(pinCount/2*brickSize2+brickSpacing)*(brickSize2+brickSpacing)+0.999);


tubeCenterHeight=max(brickHeight,ballDiameter/2+brickPinHeight+brickWallSize+gap);

if(straightBricks>0)
for(i=[0:straightBricks-1])
{
    translate([(i%lines)*brickDistanceX,floor(i/lines)*brickDistanceY,0/*i*brickHeight*/])
    union()
    {
        difference()
        {    
            difference()
            {
                cube([brickSize2*pinCount/2,brickSize2,brickHeight],false);
                       
                difference()
                {
                    translate([brickWallSize-gap,brickWallSize-gap,0])
                    cube([brickSize2*pinCount/2-brickWallSize*2+gap*2,brickSize2-brickWallSize*2+gap*2,brickHeight-brickWallSize],false);
                    translate([0,brickSize2/2,tubeCenterHeight])
            rotate([0,90,0])
            cylinder(h=brickSize2*pinCount/2,d=ballDiameter+brickWallSize,center=false);
                }
            }

            translate([0,brickSize2/2,tubeCenterHeight])
            rotate([0,90,0])
            cylinder(h=brickSize2*pinCount/2,d=ballDiameter,center=false);
            
            translate([brickWallSize,brickPinDistance/2-gap,0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
            
            translate([brickWallSize,brickSize2-brickPinDistance/2+gap-(brickPinDiameter+gap*2),0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
        }

        translate([0,brickSize2/2-(brickPinDistance-gap*2)/2,0])
        cube([brickSize2*pinCount/2,brickPinDistance-gap*2,tubeCenterHeight-ballDiameter/2],center=false);
        
        if(brim)
        {
            translate([0,brickWallSize-gap*2,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([0,brickSize2-brickWallSize,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([brickWallSize-gap*2,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
            translate([brickSize2*pinCount/2-brickWallSize,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
        }
    }
}

alpha=atan(brickHeight/(brickSize2*pinCount/2));

if(downBricks>0)
for(i=[downStart:downStart+downBricks-1])
{
    translate([(i%lines)*brickDistanceX,floor(i/lines)*brickDistanceY,0/*i*brickHeight*/])

    union()
    {
        difference()
        {    
            difference()
            {
                difference()
                {
                    cube([brickSize2*pinCount/2,brickSize2,brickHeight*2],false);
                    translate([0,0,brickHeight])
                    rotate([0,-alpha,0])
                    cube([brickSize2*pinCount/2*sqrt(2),brickSize2,brickHeight],false);
                }       
                difference()
                {
                    difference()
                    {
                        translate([brickWallSize-gap,brickWallSize-gap,0])
                        cube([brickSize2*pinCount/2-brickWallSize*2+gap*2,brickSize2-brickWallSize*2+gap*2,brickHeight*2-brickWallSize],false);
                        translate([0,0,brickHeight-brickWallSize])
                        rotate([0,-alpha,0])
                        cube([brickSize2*pinCount/2*sqrt(2),brickSize2,brickHeight],false);
                    }
                
                    translate([-brickSize2*pinCount/2/2,brickSize2/2,tubeCenterHeight-brickHeight/2])
                    rotate([0,90-alpha,0])
                    scale([cos(alpha),1,1])
                    cylinder(h=brickSize2*pinCount/2*2,d=ballDiameter+brickWallSize,center=false);
                }
            }

            translate([-brickSize2*pinCount/2/2,brickSize2/2,tubeCenterHeight-brickHeight/2])
            rotate([0,90-alpha,0])
            scale([cos(alpha),1,1])
            cylinder(h=brickSize2*pinCount/2*2,d=ballDiameter,center=false);
            
            translate([brickWallSize,brickPinDistance/2-gap,0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
            
            translate([brickWallSize,brickSize2-brickPinDistance/2+gap-(brickPinDiameter+gap*2),0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
        }
     
        x=brickSize2*pinCount/2;
        y=brickPinDistance-gap*2;
        z1=tubeCenterHeight-ballDiameter/2;
        z2=z1+brickHeight;
        
        translate([0,brickSize2/2-(brickPinDistance-gap*2)/2,0])
        
        polyhedron(points=[[0,0,0],[x,0,0],[x,y,0],[0,y,0],
                           [0,0,z1],[x,0,z2],[x,y,z2],[0,y,z1]],
                   faces=[[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]]);
        
        if(brim)
        {
            translate([0,brickWallSize-gap*2,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([0,brickSize2-brickWallSize,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([brickWallSize-gap*2,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
            translate([brickSize2*pinCount/2-brickWallSize,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
        }
    }
}


if(bentBricks>0)
for(i=[bentStart:bentStart+bentBricks-1])
{
    translate([(i%lines)*brickDistanceX,floor(i/lines)*brickDistanceY+(i%2)*brickSize2,0])
    mirror(v=[0,(i%2),0])
    union()
    {
        difference()
        {    
            difference()
            {
                cube([brickSize2*pinCount/2,brickSize2,brickHeight],false);
                       
                difference()
                {
                    translate([brickWallSize-gap,brickWallSize-gap,0])
                    cube([brickSize2*pinCount/2-brickWallSize*2+gap*2,brickSize2-brickWallSize*2+gap*2,brickHeight-brickWallSize],false);
                    
                    translate([brickSize2*(pinCount-2)/2,0,tubeCenterHeight])
                    rotate_extrude(angle=90,convexity=10)
                    difference()
                    {
                        translate([brickSize2/2,0,0])
                        circle(r=ballDiameter/2+brickWallSize/2);
                        translate([-50,-25,0])
                        square([50,50],false);
                    }
                    
                    translate([0,brickSize2/2,tubeCenterHeight])
                    rotate([0,90,0])
                    cylinder(h=brickSize2*(pinCount-2)/2,d=ballDiameter+brickWallSize,center=false);
                    
                    
                 }
            }

            translate([brickSize2*(pinCount-2)/2,0,tubeCenterHeight])
            rotate_extrude(angle=90,convexity=10)
                    difference()
                    {
                        translate([brickSize2/2,0,0])
                        circle(r=(ballDiameter)/2);
                        translate([-50,-25,0])
                        square([50,50],false);
                    }
            
            translate([0,brickSize2/2,tubeCenterHeight])
            rotate([0,90,0])
            cylinder(h=brickSize2*(pinCount-2)/2,d=ballDiameter,center=false);
                    
            translate([brickWallSize,brickPinDistance/2-gap,0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
            
            translate([brickWallSize,brickSize2-brickPinDistance/2+gap-(brickPinDiameter+gap*2),0])
            cube([brickSize2*pinCount/2-2*brickWallSize,brickPinDiameter+gap*2,brickPinHeight+gap],center=false);
        }

        translate([brickSize2*(pinCount-2)/2,brickSize2/2-(brickPinDistance-gap*2)/2,0])
        cube([brickSize2/2+(brickPinDistance-gap*2)/2,brickPinDistance-gap*2,tubeCenterHeight-ballDiameter/2],center=false);
        translate([brickSize2/2-(brickPinDistance-gap*2)/2+brickSize2*(pinCount-2)/2,0,0])
        cube([brickPinDistance-gap*2,brickSize2/2,tubeCenterHeight-ballDiameter/2],center=false);
        
        
        translate([0,brickSize2/2-(brickPinDistance-gap*2)/2,0])
        cube([brickSize2*(pinCount-2)/2,brickPinDistance-gap*2,tubeCenterHeight-ballDiameter/2],center=false);
        
        if(brim)
        {
            translate([0,brickWallSize-gap*2,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([0,brickSize2-brickWallSize,0])
            cube([brickSize2*pinCount/2,gap*2,gap*2],center=false);
            translate([brickWallSize-gap*2,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
            translate([brickSize2*pinCount/2-brickWallSize,0,0])
            cube([gap*2,brickSize2,gap*2],center=false);
        }
               
    }
}



/*
translate([brickWallSize-gap,brickWallSize-gap,0])
cube([brickSize2-brickWallSize*2+gap*2,brickSize2-brickWallSize*2+gap*2,brickPinHeight+gap],false);
*/