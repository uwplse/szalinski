/* [BASE] */

CONE_HEIGHT = 50;
BASE_RADIUS = 25;
TOTAL_ROWS = 5; // Number of circles around the cone

/* [STICKS] */

STICK_RADIUS = 1.9;
STICK_HEIGHT = 5;
STICK_SEPARATION = 6; // mm

tree();

module tree()
{
  union()
  {
  difference()
    {
     coneOuter();
     union()
     {
       coneInner1();
       sticks();
     }
    }
   coneInner2();
   base();
   }
}

module coneOuter()
{
 translate([0,0,CONE_HEIGHT/2])
   cylinder(h = CONE_HEIGHT, r1 = BASE_RADIUS, r2 = 0, center = true);
    
}

module base()
{
    difference()
    {
        coneOuter();
        translate([0,0,CONE_HEIGHT+2])
         cube(CONE_HEIGHT*2, center=true);
    }
    
    
}

module coneInner1()
{
 translate([0,0,(CONE_HEIGHT-STICK_HEIGHT-1)/2])
   cylinder(h = CONE_HEIGHT-STICK_HEIGHT, r1 = BASE_RADIUS-STICK_HEIGHT, r2 = 0, center = true);
    
}
module coneInner2()
{
 translate([0,0,(CONE_HEIGHT-(STICK_HEIGHT+5))/2])
   cylinder(h = CONE_HEIGHT-(STICK_HEIGHT+5), r1 = BASE_RADIUS-(STICK_HEIGHT+5), r2 = 0, center = true);
    
}
module stick(angle)
{
   rotate([0,angle,0])
   translate([0,0,CONE_HEIGHT])
     cylinder(r=STICK_RADIUS, h=CONE_HEIGHT*2, center=true, $fn=20);    
}

module sticks()
{
    distancePerCircle = CONE_HEIGHT/(TOTAL_ROWS+1.5);
    anglesPerRow = (60-10)/TOTAL_ROWS;
    union()
    {
       for (currentRow = [1:TOTAL_ROWS])
       {
           circleRadius = getRowRadius(currentRow);  
           baseAngle = currentRow*anglesPerRow; 
           echo(baseAngle);        
           numberSticks = floor(circleRadius*2*PI/STICK_SEPARATION);
           for (currentStick = [1:numberSticks])
           {
             flatAngle = 360*(currentStick/numberSticks); 
             stickAngle = baseAngle + anglesPerRow*(currentStick/numberSticks); 
             upHeight = CONE_HEIGHT-(currentRow*distancePerCircle)-
               (distancePerCircle*currentStick/numberSticks)-
               distancePerCircle;
             prevRadius = getRowRadius(currentRow-1);             
             distance = prevRadius + (circleRadius-prevRadius)*currentStick/numberSticks;
             x = cos(flatAngle)*distance;
             y = sin(flatAngle)*distance;
             translate([x,y,upHeight])    
               rotate([0,0,flatAngle])              
                stick(stickAngle);  
           }    
       }  
    }    
}
function degrees(x) = ((180*x)/PI);
function getRowRadius(x) = (BASE_RADIUS-(STICK_HEIGHT+5))*x/(TOTAL_ROWS);

    

