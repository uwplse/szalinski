/*
** Custamizable Arduino DUE + RAMPS-FD housing for TronXY X5S 
**
** Created by Wolfgang Thomas
**
*/


// view the box open ( also used to generate the STL )
printView = 1;              // [0,1]

// view the position of the Arduino
viewArduinoPosition = 0;     // [0,1]

// view the position of the RAMPS-FD
viewRAMPSFDPosition = 0;    // [0,1]

// outer Box size in mm
boxX = 150; // 140 will be working too 
boxY = 180;
boxZ = 55;

// size of the fan
fanSize = 60;
// distance of screws holding the fan
fanHoleDistance = 50;

// The height of the bottom in mm
bottomHeight    = 1.2;
// The height of the top in mm
topHeight       = 1.2;
// The wall size in (mm)
wallWidth       = 1.6;

// difference from bottom to top
tollerance = 0.2;   // 

// open top 
genTopHoles = 1;    // [0,1]
// holes on bottom
genBottomHoles = 1; // [0,1]

// hole for a 3mm screw (mm)
screwHoleDiameter = 3.2;
// hole to hold a 3mm screw (mm)
holdScrewDiameter = 2.8;

/* [Hidden] */

$fn=32;
// Size of the top screw holding construction (mm)
cornerCylinder  = 8;

// offset from box center.
ArduinoOffset = [-15,-40];

// Due and Mega 2560 Screw hole positions
dueHoles = [
		[  2.54, 15.24 ],
		[  17.78, 66.04 ],
		[  45.72, 66.04 ],
		[  50.8, 13.97 ],
		[  2.54, 90.17 ],
		[  50.8, 96.52 ]
		];


// Cube around box
if(0)
{
    translate([0,0,boxZ/2])
    {
        color(0.2,0.2,0.2,0.2)
        cube([boxX,boxY,boxZ],center = true);
    }
}


//
// main
// 
bottomBox();

if(printView)
{
    translate([boxX+10,0,boxZ])
    rotate([0,180,0])
    topBox();
}
else
{
    topBox();
}

module bottomBox(addDist = 0.0)
{
 
    // bottom
    difference()
    {
        union()
        {
            translate([0,0,bottomHeight/2])
            cube([boxX,boxY,bottomHeight],center=true);
        }
        union()
        {
            if( genBottomHoles )
            {
                borderDistance = 20;
                w = boxX/2 - borderDistance;
                h = boxY/2 - borderDistance;
                
                
                dx = 14;
                dy = 8;
                for(xPos=[-w:dx:w] )
                for(yPos=[-h:dy:h] )
                translate([xPos,yPos,bottomHeight/2])
                cylinder(d=6,h=bottomHeight/2+1,$fn=6,center=true);
                
          
                for(xPos=[-w:dx:w] )
                for(yPos=[-h:dy:h] )
                translate([xPos+dx/2,yPos+dy/2,bottomHeight/2])
                cylinder(d=6,h=bottomHeight/2+1,$fn=6,center=true);
            }
        }
    }
    
    
    // pins to hold the Arduino
    translate(ArduinoOffset)
    {
        for( holePos = dueHoles )
        {
            translate(holePos)
            {
                translate([0,0,bottomHeight/2])
                cylinder(d=15,h=bottomHeight,center=true);
                translate([0,0,bottomHeight+4/2])
                difference()
                {
                    cylinder(d1=7,d2=5.5,h=4.1,center=true);
                    if( addDist == 0 )
                    {
                        cylinder(d=holdScrewDiameter,h=4+1,center=true);
                    }
                }
            }
        }
        
        // view Arduino and RAMPS-FD
        translate([0,0,bottomHeight+4])
        difference()
        {
            union()
            { 
                ngWidth = 53.34;
                dueDepth = 101.6 + 1.1;

                if( viewArduinoPosition )
                    color([0.0,0.5,1.0,0.5])
                    cube([ngWidth,dueDepth,1]); 
                
                if( viewRAMPSFDPosition )
                    translate([-30,0,10])
                    color([0.0,0.5,1.0,0.5])
                    cube([ngWidth+40,dueDepth,1]); 

                
             }
             union()
             {
                if( viewArduinoPosition )
                    for( holePos = dueHoles )
                    {
                        translate(holePos)
                        {
                            translate([0,0,bottomHeight/2])
                            cylinder(d=3.1,h=bottomHeight+1,center=true);
                        }
                    }
            }
         }
             
 
    }   
   // Walls
   ch = boxZ - topHeight;
  
   difference()
   {
      union()
      { 
           w = wallWidth + addDist;
            
           csx = boxX / 3.7 + addDist;
           csy = boxY / 3.7 + addDist;
            
            
           translate([-(boxX/2-wallWidth/2),0,10/2])
           cube([w,boxY,10],center=true);
            
           translate([0,-(boxY/2-wallWidth/2),10/2])
           cube([boxX,w,10],center=true);
           
           translate([(boxX/2-wallWidth/2),0,10/2])
           cube([w,boxY,10],center=true);
            
           translate([0,(boxY/2-wallWidth/2),10/2])
           cube([boxX,w,10],center=true);
           
           // Corner + center
           for( yMul = [1,0,-1] ) 
           for( xMul = [1,0,-1] )
           {
               if( xMul || yMul )
               {
                   
                   if( yMul )
                        translate([(boxX/2-csx/2)*xMul,(boxY/2-wallWidth/2)*yMul,ch/2])
                        {
                            cube( [csx,w,ch ],center = true);
                            for(xMul = [1,-1])
                            translate([-(csx/2-wallWidth/2)*xMul,-5/2*yMul,0])
                            rotate([0,0,90])
                            cube([5+addDist,w+addDist,ch],center=true);
                        }
                   
              
                   if( xMul )
                        translate([(boxX/2-wallWidth/2)*xMul,(boxY/2-csy/2)*yMul,ch/2])
                        {
                            cube( [w,csy,ch ],center = true);
                            for(yMul = [1,-1])
                            translate([-5/2*xMul,-(csy/2-wallWidth/2)*yMul,0])
                            rotate([0,0,90])
                            cube([w+addDist,5+addDist,ch],center=true);
                       }
              
                    translate([(boxX/2-cornerCylinder/2)*xMul,(boxY/2-cornerCylinder/2)*yMul,ch/2])
                    difference()
                    {
                        cylinder(d=cornerCylinder+addDist,h=ch,center=true,$fn=32);
                        if( addDist == 0 )
                        {
                            translate([0,0,5])
                            cylinder(d=holdScrewDiameter,h=ch,center=true);
                        }
                    }
               }
               if( yMul )
               {
                    translate([(boxX/2-11)*xMul,(boxY/2-15)*yMul,ch/2])
                    {
                        if( addDist )
                        {
                             cylinder(d=10+addDist,h=ch,center=true);
                        }
                        else
                        {
                            
                            cylinder(d=6,h=ch,center=true);
                            hull()
                            {
                                cube([1,2+addDist,2],center=true);
                                
                                translate([0,0,ch/2-1])
                                cube([10,2+addDist,2],center=true);
                            }
                           translate([0,0,bottomHeight-ch/2])
                           cylinder(d1=15,d2=6,h=4);
                        }
                     }
               }
           } 
       }
       union()
       {
           // corner Cut
           for( yMul = [1,0,-1] ) 
           for( xMul = [1,0,-1] )
           {
               if( xMul || yMul )
               {
                    translate([(boxX/2-5)*xMul,(boxY/2-5)*yMul,boxZ -4/2])
                    cube([cornerCylinder+2.1-addDist,cornerCylinder+2.1-addDist,4],center = true);
               }
           }

       }
   }
   
   halterHoehe = 4;
   halterX  = 40;
   halterY  = 20;
   
   holePard = ch *2/5;
   // side box connection
   for(yMul=[1,-1])
   {
        hull()
        {
            
            translate([-boxX/2 + halterX/2, (boxY/2-1/2)*yMul, halterHoehe/2])
            cube([halterX,1,halterHoehe],center=true);
            
            
            translate([-boxX/2+2, (boxY/2-halterY/2+halterY)*yMul, halterHoehe/2])
            cube([2+0.1,halterY,halterHoehe],center=true);
        }
        
        difference()
        {
            union()
            {
                hull()
                {
                translate([-boxX/2 +halterHoehe/2, (boxY/2+halterY/2)*yMul, holePard/2])
                cube([halterHoehe,halterY,holePard],center=true);
                
                translate([-boxX/2 +halterHoehe/2, (boxY/2)*yMul, boxZ-topHeight-2])
                cube([halterHoehe,2,2],center=true);
                }
               
            }
            union()
            {
                 translate([-boxX/2 +halterHoehe/2, (boxY/2+halterY/2)*yMul, 15])
                 rotate([0,90,0])
                 cylinder(d=4.5,h=halterHoehe + 5 ,$fn=32,center=true);
            }
        }
    }
}

module topBox()
{
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {
                   translate([0,0,boxZ-topHeight/2])
                   cube([boxX,boxY,topHeight],center=true);
                    
                    if( fanSize > 0 )
                    {
                        translate([0,0,boxZ-topHeight-0.1])
                        cube([fanSize+10,fanSize+10,2],center=true);
                    }
                  
                   // Top enforcement
                   csh = 5;
                   csw = 10;
                   
                   for( xMul = [1,-1] )
                   {
                       translate([(boxX/2-csw/2)*xMul,0,boxZ-csh/2])
                       cube([csw,boxY-1,csh],center=true);
                   }
                   for( yMul = [1,-1] )
                   {
                       translate([0,(boxY/2-csw/2)*yMul,boxZ-csh/2])
                       cube([boxX-1,csw,csh],center=true);
                   }
                }
                union()
                {
                    bottomBox(addDist = tollerance);
                    
                   // corner
                   for( yMul = [1,0,-1] ) 
                   for( xMul = [1,0,-1] )
                   {
                       if( xMul || yMul )
                            translate([(boxX/2-cornerCylinder/2)*xMul,(boxY/2-cornerCylinder/2)*yMul,boxZ-topHeight/2])
                            cylinder(d=screwHoleDiameter,h=topHeight+10,center=true);
                    }
                    
                    if( genTopHoles )
                    {
                        borderDistance = 20;
                        
                        w = boxX/2 - borderDistance;
                        h = boxY/2 - borderDistance;                       
                        
                        dx = 14;
                        dy = 8;
                        for(xPos=[-w:dx:w] )
                        for(yPos=[-h:dy:h] )
                        translate([xPos,yPos,boxZ-topHeight/2])
                        cylinder(d=6,h=bottomHeight/2+1,$fn=6,center=true);
                        
                  
                        for(xPos=[-w:dx:w] )
                        for(yPos=[-h:dy:h] )
                        translate([xPos+dx/2,yPos+dy/2,boxZ-topHeight/2])
                        cylinder(d=6,h=bottomHeight/2+1,$fn=6,center=true);
                    }
                }
            }
           
            if( fanSize > 0 )
            {
                // fan enforcement
                translate([0,0,boxZ-(topHeight+1)/2])
                cube([fanSize+10,fanSize+10,topHeight+1],center=true);
            }
        }
        union()
        {
            if( fanSize > 0 )
            {    
                translate([0,0,boxZ-topHeight/2])
                {
                    cylinder(d=fanSize-4,h=topHeight+5,center=true);
                    
                    for( xMul = [1,-1] )
                    for( yMul = [1,-1] )
                    {
                        translate([xMul*fanHoleDistance/2,yMul*fanHoleDistance/2])
                        cylinder(d=4.1, h=topHeight+5, center=true );
                    }
                }
            }
        } 
    }
   

}