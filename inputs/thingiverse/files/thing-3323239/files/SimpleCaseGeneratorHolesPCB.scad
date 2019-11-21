// Published by BenOt on Thingiverse.com


/* [inner Dimensions] */
// (mm)
innerSizeX = 20;
// (mm)
innerSizeY = 30;
// (mm)
innerSizeZ = 15;

// (mm)
coverWidth = 2;
// (mm)
wallWidth = 2.5;                    
// Radius of the rounded edges (mm)
radius = 2;
// height of the border used to prevent the top from moving
connectionDepth = 1.5;
// width of the border used to prevent the top from moving
connectionWidth = 1.5;
// clearance between cover connection
clearance = 0.2;

/* [Screws] */
// (mm)
screwDiameter = 2;
// position of the screws. Value between 0 and 1. 0 means middle of the y-faces 1 means middle of the x-faces
screwPosition = 0.5; // [0:0.01:1]
// Move the screws farer out
offset = -2;

// Where should the Cover be placed
move = 1; // [0:On the Case (debuging), 1:Next to the case]

// What parts should be created? 
part = 3; // [1:Create only Case, 2:Create only Cover, 3: Create both]

/* [PCB] */
PCB_type = 1; // [0: No PCB, 1:Support in the edges, 2:Support on the sides]

// Dimensions of PCB in x direction (mm)
PCB_X = 15;

// Dimensions of PCB in y direction (mm)
PCB_Y = 25;

// Height of slots (mm)
PCB_height = 4;


// Height of the PCB (mm)
PCB_support_height = 1;

// Width of the support for the PCB (mm)
PCB_support_width = 5;


/* [Hole1] */
hole1_enable = 1; // [0: Off, 1: On]
// Shape of the hole
hole1_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole1_x = 5;
// Position Y of the hole (type m for middle)
hole1_y = 5;
// Face on witch the hole should appear
hole1_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole1_width = 5;
// (mm) only used in rectangular mode
hole1_height = 5;



/* [Hole2] */
hole2_enable = 1; // [0: Off, 1: On]
// Shape of the hole
hole2_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole2_x = 5;
// Position Y of the hole (type m for middle)
hole2_y = 5;
// Face on witch the hole should appear
hole2_face = "+y"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole2_width = 5;
// (mm) only used in rectangular mode
hole2_height = 5;



/* [Hole3] */
hole3_enable = 1; // [0: Off, 1: On]
// Shape of the hole
hole3_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole3_x = 5;
// Position Y of the hole (type m for middle)
hole3_y = 5;
// Face on witch the hole should appear
hole3_face = "+z"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole3_width = 5;
// (mm) only used in rectangular mode
hole3_height = 5;



/* [Hole4] */
hole4_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole4_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole4_x = 5;
// Position Y of the hole (type m for middle)
hole4_y = 5;
// Face on witch the hole should appear
hole4_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole4_width = 5;
// (mm) only used in rectangular mode
hole4_height = 5;



/* [Hole5] */
hole5_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole5_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole5_x = 5;
// Position Y of the hole (type m for middle)
hole5_y = 5;
// Face on witch the hole should appear
hole5_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole5_width = 5;
// (mm) only used in rectangular mode
hole5_height = 5;



/* [Hole6] */
hole6_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole6_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole6_x = 5;
// Position Y of the hole (type m for middle)
hole6_y = 5;
// Face on witch the hole should appear
hole6_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole6_width = 5;
// (mm) only used in rectangular mode
hole6_height = 5;



/* [Hole7] */
hole7_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole7_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole7_x = 5;
// Position Y of the hole (type m for middle)
hole7_y = 5;
// Face on witch the hole should appear
hole7_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole7_width = 5;
// (mm) only used in rectangular mode
hole7_height = 5;



/* [Hole8] */
hole8_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole8_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole8_x = 5;
// Position Y of the hole (type m for middle)
hole8_y = 5;
// Face on witch the hole should appear
hole8_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole8_width = 5;
// (mm) only used in rectangular mode
hole8_height = 5;



/* [Hole9] */
hole9_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole9_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole9_x = 5;
// Position Y of the hole (type m for middle)
hole9_y = 5;
// Face on witch the hole should appear
hole9_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole9_width = 5;
// (mm) only used in rectangular mode
hole9_height = 5;



/* [Hole10] */
hole10_enable = 0; // [0: Off, 1: On]
// Shape of the hole
hole10_shape = 1; // [1:Round, 2:Rectangular, 3:Square]
// Position X of the hole (type m for middle)
hole10_x = 5;
// Position Y of the hole (type m for middle)
hole10_y = 5;
// Face on witch the hole should appear
hole10_face = "+x"; // ["+x": positive X, "-x": negative X, "+y": positive Y, "-y": negative Y, "+z": Cover, "-z": Bottom]
// (mm)
hole10_width = 5;
// (mm) only used in rectangular mode
hole10_height = 5;



/* [Hidden] */
innerSize = [innerSizeX, innerSizeY, innerSizeZ];
screwRadius = screwDiameter / 2;

module Case()
    {
    innerX = innerSize[0];
    innerY = innerSize[1];
    innerZ = innerSize[2];              
        
        
    outerX = innerX + 2 * wallWidth;
    outerY = innerY + 2 * wallWidth;
    outerZ = innerZ + coverWidth;

        
    screwPosX = (screwPosition <= 0.5) ? screwPosition * outerX : outerX/2;
    screwPosY = (screwPosition <= 0.5) ? outerY/2 : (1 - screwPosition) * outerY;

    outerScrewRadius = screwRadius * 1.75 + 0.75;
        
        linear_extrude(height=coverWidth)
            union()
            {groundPlate([outerX, outerY, outerZ], radius, screwPosX, screwPosY, outerScrewRadius);
                translate([ screwPosX+offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([ screwPosX+offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([-screwPosX-offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);    
            translate([-screwPosX-offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            }
     
        translate([0, 0, coverWidth])
            linear_extrude(height=innerZ)
            difference ()
                {
            union ()
                {
            difference()
                {
                groundPlate([outerX, outerY, outerZ], radius, screwPosX, screwPosY, outerScrewRadius);      
     
                polygon([[-innerX/2, -innerY/2], [-innerX/2, innerY/2], [innerX/2, innerY/2], [innerX/2, -innerY/2]]);
                }
            translate([ screwPosX+offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([ screwPosX+offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([-screwPosX-offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);    
            translate([-screwPosX-offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
                }
            if (screwRadius != 0)
                {
                    
                translate([ screwPosX+offset,  screwPosY+offset, coverWidth])
                    circle(r=screwRadius, $fn=50);
                translate([ screwPosX+offset, -screwPosY-offset, coverWidth])
                    circle(r=screwRadius, $fn=50);
                translate([-screwPosX-offset,  screwPosY+offset, coverWidth])
                    circle(r=screwRadius, $fn=50);    
                translate([-screwPosX-offset, -screwPosY-offset, coverWidth])
                    circle(r=screwRadius, $fn=50);
                }
            }
        }


module Cover()
    {
    innerX = innerSize[0];
    innerY = innerSize[1];
    innerZ = innerSize[2];              
        
        
    outerX = innerX + 2 * wallWidth;
    outerY = innerY + 2 * wallWidth;
    outerZ = innerZ + coverWidth;

    screwPosX = (screwPosition <= 0.5) ? screwPosition * outerX : outerX/2;
    screwPosY = (screwPosition <= 0.5) ? outerY/2 : (1 - screwPosition) * outerY;

    outerScrewRadius = screwRadius * 1.75 + 0.75;
    
    a = (move) ? outerX+10 : 0;
    b = (move) ? 0 : outerZ+coverWidth;
    c = (move) ? 0 : 180;
    
    translate([a, 0, b]) rotate([0, c, 0])
        {
        linear_extrude(height=coverWidth)
            difference()
                {
                union()
                    {
                    groundPlate([outerX, outerY, outerZ], radius, screwPosX, screwPosY, outerScrewRadius);
                    translate([ screwPosX+offset,  screwPosY+offset, 0])
                        circle(r=outerScrewRadius, $fn=50);
                    translate([ screwPosX+offset, -screwPosY-offset, 0])
                        circle(r=outerScrewRadius, $fn=50);
                    translate([-screwPosX-offset,  screwPosY+offset, 0])
                        circle(r=outerScrewRadius, $fn=50);    
                    translate([-screwPosX-offset, -screwPosY-offset, 0])
                        circle(r=outerScrewRadius, $fn=50);
                    }

                if (screwRadius != 0)
                    {
                    translate([ screwPosX+offset,  screwPosY+offset, coverWidth])
                        circle(r=screwRadius, $fn=50);
                    translate([ screwPosX+offset, -screwPosY-offset, coverWidth])
                        circle(r=screwRadius, $fn=50);
                    translate([-screwPosX-offset,  screwPosY+offset, coverWidth])
                        circle(r=screwRadius, $fn=50);    
                    translate([-screwPosX-offset, -screwPosY-offset, coverWidth])
                        circle(r=screwRadius, $fn=50);
                    }
                }
             translate([0, 0, coverWidth])
                {
                outerSizeX = outerX-(wallWidth+clearance)*2;
                outerSizeY = outerY-(wallWidth+clearance)*2;
                    
                innerSizeX = outerX-(wallWidth+connectionWidth+clearance)*2;
                innerSizeY = outerY-(wallWidth+connectionWidth+clearance)*2;
                    
                linear_extrude(height=connectionDepth)    
                    difference()
                        {

                        square([outerSizeX, outerSizeY], center=true);
                        square([innerSizeX, innerSizeY], center=true);
                            
                        translate([ screwPosX+offset,  screwPosY+offset, 0])
                    circle(r=outerScrewRadius+clearance, $fn=50);
                translate([ screwPosX+offset, -screwPosY-offset, 0])
                    circle(r=outerScrewRadius+clearance, $fn=50);
                translate([-screwPosX-offset,  screwPosY+offset, 0])
                    circle(r=outerScrewRadius+clearance, $fn=50);    
                translate([-screwPosX-offset, -screwPosY-offset, 0])
                    circle(r=outerScrewRadius+clearance, $fn=50);
                        
                        }                
                }
        }    
    }


module groundPlate(size, radius, screwPosX, screwPosY, outerScrewRadius)
    {
    x = size[0];
	y = size[1];
	z = size[2];
	
    hull()
        {
        translate([(-x/2)+(radius), (-y/2)+(radius), 0])
            circle(r=radius, $fn = 50);
        
        translate([(x/2)-(radius), (-y/2)+(radius), 0])
            circle(r=radius, $fn = 50);
        
        translate([(-x/2)+(radius), (y/2)-(radius), 0])
            circle(r=radius, $fn = 50);
        
        translate([(x/2)-(radius), (y/2)-(radius), 0])
            circle(r=radius, $fn = 50);    
        }        
    }


module Bore(borePosition)
    {
    innerX = innerSize[0];
    innerY = innerSize[1];
    innerZ = innerSize[2];              
        
        
    outerX = innerX + 2 * wallWidth;
    outerY = innerY + 2 * wallWidth;
    outerZ = innerZ + coverWidth;
    
        
    screwPosX = (screwPosition <= 0.5) ? screwPosition * outerX : outerX/2;
    screwPosY = (screwPosition <= 0.5) ? outerY/2 : (1 - screwPosition) * outerY;

    outerScrewRadius = screwRadius * 1.75 + 0.75;
    
    boreWall = borePosition[0];    
    borePos = borePosition[1];
    boreHeight = borePosition[2];
    boreRadius = borePosition[3] / 2;
    
    
    type = (len(borePosition[3]) == 2) ? "b" : "c";
   
    rX = (len(borePosition[3]) == 2) ? borePosition[3][0] : 0;    
    rY = (len(borePosition[3]) == 2) ? borePosition[3][1] : 0;        

    if (type == "c")
        {
        if (boreWall == "+x")
            {        
            x = (borePos == "m") ? innerX/2 : ((borePos >= 0) ? innerX/2 : ((borePos < 0) ? innerX/2 : 0));
            y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + boreRadius + borePos : ((borePos < 0) ? innerY/2 - boreRadius + borePos : 0));      
            z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+boreRadius : ((boreHeight < 0) ? outerZ+boreHeight-boreRadius : 0));
                
                      
            translate([x, y, z])
                rotate([0, 90, 0])
                cylinder(wallWidth, r=boreRadius, $fn = 50);
            }
if (boreWall == "-x")
        {        
        x = (borePos == "m") ? -innerX/2 : ((borePos >= 0) ? -innerX/2 : ((borePos < 0) ? -innerX/2 : 0));
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + boreRadius + borePos : ((borePos < 0) ? innerY/2 - boreRadius + borePos : 0));      
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+boreRadius : ((boreHeight < 0) ? outerZ+boreHeight-boreRadius : 0));
            
            
                        
        translate([x, y, z])
            rotate([0, -90, 0])
            cylinder(wallWidth, r=boreRadius, $fn = 50);
        }
        
        
        
    if (boreWall == "+y")
        {        
        x = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerX/2 + boreRadius + borePos : ((borePos < 0) ? innerX/2 - boreRadius + borePos : 0));      
        y = (borePos == "m") ? innerY/2 : ((borePos >= 0) ? innerY/2 : ((borePos < 0) ? innerY/2 : 0));        
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+boreRadius : ((boreHeight < 0) ? outerZ+boreHeight-boreRadius : 0));
            
            
                        
        translate([x, y, z])
            rotate([-90, 0, 0])
            cylinder(wallWidth, r=boreRadius, $fn = 50);
        }
        
    
    if (boreWall == "-y")
        {        
        
        x = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerX/2 + boreRadius + borePos : ((borePos < 0) ? innerX/2 - boreRadius + borePos : 0));      
        y = (borePos == "m") ? -innerY/2 : ((borePos >= 0) ? -innerY/2 : ((borePos < 0) ? -innerY/2 : 0));
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+boreRadius : ((boreHeight < 0) ? outerZ+boreHeight-boreRadius : 0));
            
            
                        
        translate([x, y, z])
            rotate([90, 0, 0])
            cylinder(wallWidth, r=boreRadius, $fn = 50);
        }
    if ((boreWall == "-z") || (boreWall == "bottom") || (boreWall == "b"))
        {        
        x = (boreHeight == "m") ? 0 : ((boreHeight >= 0) ? -innerX/2 + boreRadius + boreHeight : ((boreHeight < 0) ? innerX/2 - boreRadius + boreHeight : 0));      
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + boreRadius + borePos : ((borePos < 0) ? innerY/2 - boreRadius + borePos : 0));        
        z = 0;                      
                        
        translate([x, y, z])
            cylinder(coverWidth, r=boreRadius, $fn = 50);
        } 

    if ((boreWall == "+z") || (boreWall == "top") || (boreWall == "t"))
        {        
        x = (boreHeight == "m") ? 0 : ((boreHeight >= 0) ? -innerX/2 + boreRadius + boreHeight : ((boreHeight < 0) ? innerX/2 - boreRadius + boreHeight : 0));      
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + boreRadius + borePos : ((borePos < 0) ? innerY/2 - boreRadius + borePos : 0));        
        z = 0;                      
        a = (move) ? outerX+10 : 0;
        b = (move) ? wallWidth : outerZ;
        c = (move) ? 180 : 0;
    
        translate([a, 0, b]) rotate([0, c, 0])                
            translate([x, y, z-1-connectionDepth/2])
                cylinder(coverWidth+2+connectionDepth, r=boreRadius, $fn = 50);
        }



            
        }
    if (type != "c")
        {
        if (boreWall == "+x")
            {        
            x = (borePos == "m") ? innerX/2 : ((borePos >= 0) ? innerX/2 : ((borePos < 0) ? innerX/2 : 0));
            y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + rY/2 + borePos : ((borePos < 0) ? innerY/2 - rY/2 + borePos : 0));      
            z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+rX/2 : ((boreHeight < 0) ? outerZ+boreHeight-rX/2 : 0));
                
                      
            translate([x, y, z])
                rotate([0, 90, 0])
                translate([0, 0, (wallWidth+outerScrewRadius+offset)/2])
                cube([rX, rY, wallWidth+outerScrewRadius+offset], center=true);
            }

if (boreWall == "-x")
        {        
        x = (borePos == "m") ? -innerX/2 : ((borePos >= 0) ? -innerX/2 : ((borePos < 0) ? -innerX/2 : 0));
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + rY/2 + borePos : ((borePos < 0) ? innerY/2 - rY/2 + borePos : 0));      
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+rX/2 : ((boreHeight < 0) ? outerZ+boreHeight-rX/2 : 0));
            
            
                        
        translate([x, y, z])
                rotate([0, -90, 0])
                translate([0, 0, (wallWidth+outerScrewRadius+offset)/2])
                cube([rX, rY, wallWidth+outerScrewRadius+offset], center=true);
        }
        
        
        
    if (boreWall == "+y")
        {        
        x = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerX/2 + rY/2 + borePos : ((borePos < 0) ? innerX/2 - rY/2 + borePos : 0));      
        y = (borePos == "m") ? innerY/2 : ((borePos >= 0) ? innerY/2 : ((borePos < 0) ? innerY/2 : 0));        
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+rX/2 : ((boreHeight < 0) ? outerZ+boreHeight-rX/2 : 0));
            
            
                        
        translate([x, y, z])
                rotate([-90, 90, 0])
                translate([0, 0, (wallWidth+outerScrewRadius+offset)/2])
                cube([rX, rY, wallWidth+outerScrewRadius+offset], center=true);
        }
        
    
    if (boreWall == "-y")
        {        
        
        x = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerX/2 + rY/2 + borePos : ((borePos < 0) ? innerX/2 - rY/2 + borePos : 0));      
        y = (borePos == "m") ? -innerY/2 : ((borePos >= 0) ? -innerY/2 : ((borePos < 0) ? -innerY/2 : 0));
        z = (boreHeight == "m") ? outerZ/2 : ((boreHeight >= 0) ? coverWidth + boreHeight+rX/2 : ((boreHeight < 0) ? outerZ+boreHeight-rX/2 : 0));
            
            
                        
        translate([x, y, z])
                rotate([90, 90, 0])
                translate([0, 0, (wallWidth+outerScrewRadius+offset)/2])
                cube([rX, rY, wallWidth+outerScrewRadius+offset], center=true);
        }
        
        
        
    if ((boreWall == "-z") || (boreWall == "bottom") || (boreWall == "b"))
        {        
        x = (boreHeight == "m") ? 0 : ((boreHeight >= 0) ? -innerX/2 + rX/2 + boreHeight : ((boreHeight < 0) ? innerX/2 - rY/2 + boreHeight : 0));      
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + rY/2 + borePos : ((borePos < 0) ? innerY/2 - rY/2 + borePos : 0));        
        z = 0;                      
                 
            
        translate([x, y, z])
                translate([0, 0, coverWidth/2])
                cube([rX, rY, coverWidth], center=true);
        } 

    if ((boreWall == "+z") || (boreWall == "top") || (boreWall == "t"))
        {        
        x = (boreHeight == "m") ? 0 : ((boreHeight >= 0) ? -innerX/2 + rX/2 + boreHeight : ((boreHeight < 0) ? innerX/2 - rX72 + boreHeight : 0));      
        y = (borePos == "m") ? 0 : ((borePos >= 0) ? -innerY/2 + rY/2 + borePos : ((borePos < 0) ? innerY/2 - rY/2 + borePos : 0));        
        z = 0;                      
        a = (move) ? outerX+10 : 0;
        b = (move) ? wallWidth : outerZ;
        c = (move) ? 180 : 0;
    
            
            translate([a, 0, b]) rotate([0, c, 0])                
            translate([x, y, z])
                translate([0, 0, coverWidth/2-1-connectionDepth/2])
                cube([rX, rY, coverWidth+2+connectionDepth], center=true);

                
        }
            
        }    
        
            
    }
    
module holes()
    {
    if (hole1_enable == 1)
        {
        //cube([1,2,3]);
        if (hole1_shape == 1)
            Bore([hole1_face, hole1_x, hole1_y, hole1_width]);
        if (hole1_shape == 2)
            Bore([hole1_face, hole1_x, hole1_y, [hole1_height, hole1_width]]);
        if (hole1_shape == 3)
            Bore([hole1_face, hole1_x, hole1_y, [hole1_width, hole1_width]]);
        }
        
        
    if (hole2_enable == 1)
        {
        //cube([1,2,3]);
        if (hole2_shape == 1)
            Bore([hole2_face, hole2_x, hole2_y, hole2_width]);
        if (hole2_shape == 2)
            Bore([hole2_face, hole2_x, hole2_y, [hole2_height, hole2_width]]);
        if (hole2_shape == 3)
            Bore([hole2_face, hole2_x, hole2_y, [hole2_width, hole2_width]]);
        }
        
        
    if (hole3_enable == 1)
        {
        //cube([1,2,3]);
        if (hole3_shape == 1)
            Bore([hole3_face, hole3_x, hole3_y, hole3_width]);
        if (hole3_shape == 2)
            Bore([hole3_face, hole3_x, hole3_y, [hole3_height, hole3_width]]);
        if (hole3_shape == 3)
            Bore([hole3_face, hole3_x, hole3_y, [hole3_width, hole3_width]]);
        }
        
        
    if (hole4_enable == 1)
        {
        //cube([1,2,3]);
        if (hole4_shape == 1)
            Bore([hole4_face, hole4_x, hole4_y, hole4_width]);
        if (hole4_shape == 2)
            Bore([hole4_face, hole4_x, hole4_y, [hole4_height, hole4_width]]);
        if (hole4_shape == 3)
            Bore([hole4_face, hole4_x, hole4_y, [hole4_width, hole4_width]]);
        }
        
        
    if (hole5_enable == 1)
        {
        //cube([1,2,3]);
        if (hole5_shape == 1)
            Bore([hole5_face, hole5_x, hole5_y, hole5_width]);
        if (hole5_shape == 2)
            Bore([hole5_face, hole5_x, hole5_y, [hole5_height, hole5_width]]);
        if (hole5_shape == 3)
            Bore([hole5_face, hole5_x, hole5_y, [hole5_width, hole5_width]]);
        }
        
        
    if (hole6_enable == 1)
        {
        //cube([1,2,3]);
        if (hole6_shape == 1)
            Bore([hole6_face, hole6_x, hole6_y, hole6_width]);
        if (hole6_shape == 2)
            Bore([hole6_face, hole6_x, hole6_y, [hole6_height, hole6_width]]);
        if (hole6_shape == 3)
            Bore([hole6_face, hole6_x, hole6_y, [hole6_width, hole6_width]]);
        }
        
        
    if (hole7_enable == 1)
        {
        //cube([1,2,3]);
        if (hole7_shape == 1)
            Bore([hole7_face, hole7_x, hole7_y, hole7_width]);
        if (hole7_shape == 2)
            Bore([hole7_face, hole7_x, hole7_y, [hole7_height, hole7_width]]);
        if (hole7_shape == 3)
            Bore([hole7_face, hole7_x, hole7_y, [hole7_width, hole7_width]]);
        }
        
        
    if (hole8_enable == 1)
        {
        //cube([1,2,3]);
        if (hole8_shape == 1)
            Bore([hole8_face, hole8_x, hole8_y, hole8_width]);
        if (hole8_shape == 2)
            Bore([hole8_face, hole8_x, hole8_y, [hole8_height, hole8_width]]);
        if (hole8_shape == 3)
            Bore([hole8_face, hole8_x, hole8_y, [hole8_width, hole8_width]]);
        }
        
        
    if (hole9_enable == 1)
        {
        //cube([1,2,3]);
        if (hole9_shape == 1)
            Bore([hole9_face, hole9_x, hole9_y, hole9_width]);
        if (hole9_shape == 2)
            Bore([hole9_face, hole9_x, hole9_y, [hole9_height, hole9_width]]);
        if (hole9_shape == 3)
            Bore([hole9_face, hole9_x, hole9_y, [hole9_width, hole9_width]]);
        }
        
    
    if (hole10_enable == 1)
        {
        //cube([1,2,3]);
        if (hole10_shape == 1)
            Bore([hole10_face, hole10_x, hole10_y, hole10_width]);
        if (hole10_shape == 2)
            Bore([hole10_face, hole10_x, hole10_y, [hole10_height, hole10_width]]);
        if (hole10_shape == 3)
            Bore([hole10_face, hole10_x, hole10_y, [hole10_width, hole10_width]]);
        }
    }

module PCB_holder()
    {
    if (PCB_type == 1)      // 4 holders in the corners
        {
        difference()
            {
            union()
                {
                translate([PCB_X/2-PCB_support_width/2,PCB_Y/2-PCB_support_width/2,coverWidth+PCB_support_height/2])cube([PCB_support_width, PCB_support_width, PCB_height]);
                translate([-PCB_X/2-PCB_support_width/2,PCB_Y/2-PCB_support_width/2,coverWidth+PCB_support_height/2])cube([PCB_support_width, PCB_support_width, PCB_height]);
                translate([-PCB_X/2-PCB_support_width/2,-PCB_Y/2-PCB_support_width/2,coverWidth+PCB_support_height/2])cube([PCB_support_width, PCB_support_width, PCB_height]);
                translate([PCB_X/2-PCB_support_width/2,-PCB_Y/2-PCB_support_width/2,coverWidth+PCB_support_height/2])cube([PCB_support_width, PCB_support_width, PCB_height]);
                }
            translate([0, 0, coverWidth+PCB_height])cube([PCB_X, PCB_Y, PCB_support_height], center = true);
            }
        }
    
    if (PCB_type == 2)      // 2 holders on the sides    
        {
        difference()
            {
            union()
                {
                translate([PCB_X/2-PCB_support_width/2,-PCB_Y/2,coverWidth])cube([PCB_support_width, PCB_Y, PCB_height]);
                translate([-PCB_X/2-PCB_support_width/2,-PCB_Y/2,coverWidth])cube([PCB_support_width, PCB_Y, PCB_height]);
                }
            translate([-PCB_X/2, -PCB_Y/2, coverWidth-PCB_support_height+PCB_height])cube([PCB_X, PCB_Y, PCB_support_height]);
            }
        }
    }
    
if ((part == 1) || (part == 3))
    {
    difference()
        {
        union()
            {
            Case();                         // Create body
            PCB_holder();
            }
        holes();
        }
    
    }
    

if ((part == 2) || (part == 3))
    difference()
        {
        Cover();                         // Create Cover 
        holes();
        }                           
