/*
** Custamizable SSD Relais box
**
** Created by Wolfgang Thomas
**
*/

// view the Relais
viewRelais = 0;

///
// SSD Relay BOX
//
// SSD Releay size 58x43x28
//
// Size X of SSD Relais (mm)
SSDX = 43;

// Size Y of SSD Relais (mm)
SSDY = 58;

// Size Z of SSD Relais (mm)
SSDZ = 28;

// offset of SSD Relay from center in Y direction (mm)
SSDYShift = -5;

// Thickness of the top (mm)
topThickness    = 3; 

// Thickness of the walls (mm)
wallThickness    = 1.5;

// Thickness of the bottom (mm)
bottomThickness     = 3;

// Cut area into the top
boxBottomCutSize = topThickness  / 3;

//  Distance from Relais to the wall in X direction (mm)
wallDistX   = 2;    // Distance from Wall

//  Distance from Relais to the wall in Y direction (mm)
wallDistY   = 15;

// Distance to the top (mm)
topDistZ   = 0;

// Cable entry offset from bottom (mm)
cableHoldZ = 10;


/* [hidden] */

boxX    = SSDX + 2* wallThickness + wallDistX * 2;
boxY    = SSDY + 2* wallThickness + wallDistY * 2;
boxZ    = SSDZ +    topThickness  + topDistZ   +topThickness/2 ;

screwHoldBlockDiameter = 9;
screwMoutingDiameter = 2.8;
screwWholeDiameter = 3.2;

mountScrewDiameter = 4;

printView = 1;

// main
difference()
{
    boxTop();
    boxBottom(addSize = 0.2);
}

if( printView )
{
    rotate([180,0,0])
    translate([boxX+5,0,-boxZ  ])
    {
        boxBottom();
        if( viewRelais ) 
            SSDReleay();
    }
    
    translate([-47,0,0])
    drawPowerCableHold();    
}
else 
{
   color([0.7,0.7,0.0,0.7])
   boxBottom();
}


module boxTop()
{   
    difference()
    {
        union()
        {            
           translate([0,0,topThickness/2])
           cube([boxX,boxY,topThickness],center=true);                  
       }
       if(1)
        union()
        {
           for( xMul = [1,-1] )
           for( yMul = [1,-1] )
            translate([ (boxX/2-screwHoldBlockDiameter/2) * xMul,
                        (boxY/2-screwHoldBlockDiameter/2) * yMul, 
                        +bottomThickness-(topThickness - boxBottomCutSize-0.1)])
                translate([0,0,0])
                cylinder(d=screwWholeDiameter,h= topThickness*2,$fn=18,center=true);
       }
    }  
}


module drawPowerCableHold()
{
    cableHoldY = 10;
    cableHoldZ = 7;
    
    translate([0,0,cableHoldZ/2])
    difference()
    {
        cube([30,cableHoldY,cableHoldZ],center=true);
    
        for( xMul = [1,-1] )
        translate([xMul*10,0,0.01])
            cylinder(d=screwWholeDiameter,h=cableHoldY,center=true,$fn=32);
        
        for( yMul = [1,-1] )
        translate([0, yMul *4,4])
        rotate([90,0,0])                
        cylinder(d=7.2,h=wallThickness*2+4,center=true,$fn=32);
        
        translate([0,0,4+1.3])
        rotate([90,0,0])                
        cylinder(d=7,h=wallThickness*2+3,center=true,$fn=32);
    }
    
}


module SSDReleay(addSize = 0.0)
{
    translate([0,SSDYShift,+boxZ-SSDZ/2])
    cube([SSDX+addSize,SSDY+addSize,SSDZ+addSize],center=true);
}

module boxBottom(addSize = 0.0)
{
    difference()
    {
        union()
        {
                // bottom
                if( 1 )
                {
                    translate([0,0,boxZ - bottomThickness/2])
                    cube([boxX,boxY,bottomThickness],center=true);
                }
                
                // 
                // Walls
                //
                if( 1 )
                {
                    for( yMul = [1,-1] )
                    translate([ 0,
                                (boxY/2 - wallThickness/2)*yMul,
                                boxZ/2 + topThickness/2 -boxBottomCutSize/2])
                    cube([boxX+addSize,wallThickness+addSize,boxZ - topThickness + boxBottomCutSize],center = true);

                    for( xMul = [1,-1] )
                    translate([
                                (boxX/2 - wallThickness/2)*xMul,
                                0,
                                boxZ/2 + topThickness/2 -boxBottomCutSize/2])
                    cube([
                        wallThickness+addSize,
                        boxY + addSize,
                        boxZ - topThickness + boxBottomCutSize],center = true);
               
                }
             
                // 
                // connection areas for the top including screw holes
                //
                if( 1 )
                {
                  translate([0,0,(boxZ+bottomThickness-1)/2])
                   for( xMul = [1,-1] )
                   for( yMul = [1,-1] )
                    translate([ (boxX/2-screwHoldBlockDiameter/2) * xMul,
                                (boxY/2-screwHoldBlockDiameter/2) * yMul, 
                                0])
                    difference()
                    {
                        cylinder(d=screwHoldBlockDiameter,h=boxZ-bottomThickness-1,$fn=36,center=true);
                        translate([0,0,-0.1])
                        cylinder(d=screwMoutingDiameter,h= boxZ-bottomThickness,$fn=18,center=true);
                    }
                }
                
                //
                // mounting areas
                //
                if( 1 )
                { 
                    holdArea = mountScrewDiameter * 2.5;
                    for( xMul = [0] )
                    difference()
                    {
                        hull()
                        {
                            for( yMul = [1,-1] )
                                translate([xMul * 10,(boxY/2+holdArea/2)*yMul,boxZ - bottomThickness/2])
                                    cylinder(d=holdArea,h=bottomThickness,center=true,$fn=32);
                        }
                        union()
                        {
                            wholeCut = mountScrewDiameter + 0.2;
                             for( yMul = [1,-1] )
                                translate([xMul * 10,(boxY/2+holdArea/2)*yMul,boxZ - bottomThickness/2])
                                    cylinder(d=wholeCut,h=bottomThickness+2,center=true,$fn=32);
                       }
                    }
                }
                
                // cable hold
                if( 1 )
                {
                    cableHoldY = 11;
                    
                    translate([0,+boxY/2- cableHoldY/2-wallThickness,boxZ   - cableHoldZ/2])
                    difference()
                    {
                        cube([35,cableHoldY,cableHoldZ],center=true);

                        for( xMul = [1,-1] )
                        translate([xMul*10,0,-bottomThickness])
                        //-bottomThickness+2])
                            cylinder(d=screwMoutingDiameter,h=cableHoldZ,center=true,$fn=32);
                    }
               }
               
             }
            union()
            {
                // SSDReleay
                SSDReleay(addSize=1);
                
                // cut for power cable and screw hold for cable hold
                for( yMul = [1,-1] )
                translate([0,boxY/2-6- yMul *4,boxZ-cableHoldZ-2])
                rotate([90,0,0])                
                cylinder(d=7.2,h=wallThickness*2+4,center=true,$fn=32);
                
                translate([0,boxY/2-+5,boxZ-cableHoldZ-2-1.3])
                rotate([90,0,0])                
                cylinder(d=7,h=wallThickness*2+3,center=true,$fn=32);
                
                // cut for control cable
                 translate([0,-boxY/2,boxZ-cableHoldZ-2])
                rotate([90,0,0])                
                cylinder(d=3,h=wallThickness*2+4,center=true,$fn=32);

                // top enforcement
              {
               for( yMul = [1,-1] )
                for( xMul = [1,-1] )
                    translate([(boxX/2-screwHoldBlockDiameter/2)*xMul,(boxY/2- screwHoldBlockDiameter/2)* yMul,topThickness/2])
                    cube([screwHoldBlockDiameter+2,screwHoldBlockDiameter+2,topThickness],center=true);
               }              
           }
     }  
}
