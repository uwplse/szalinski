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
        
    screwPosX = 0;
    screwPosY = 0;
        
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
        
    screwPosX = 0;
    screwPosY = 0;
        
    screwPosX = (screwPosition <= 0.5) ? screwPosition * outerX : outerX/2;
    screwPosY = (screwPosition <= 0.5) ? outerY/2 : (1 - screwPosition) * outerY;

    outerScrewRadius = screwRadius * 1.75 + 0.75;
    
    a = (move) ? outerX+10 : 0;
    b = (move) ? 0 : outerZ+coverWidth*2;
    c = (move) ? 0 : 180;
    
    translate([a, 0, b]) rotate([0, c, 0])
        {
        linear_extrude(height=coverWidth)
            difference()
                {
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
            Points = [[outerX/2-wallWidth, outerY/2-wallWidth],[-outerX/2+wallWidth, outerY/2-wallWidth],[-outerX/2+wallWidth, -outerY/2+wallWidth],[outerX/2-wallWidth, -outerY/2+wallWidth], [outerX/2-wallWidth-connectionWidth, outerY/2-wallWidth-connectionWidth],[-outerX/2+wallWidth+connectionWidth, outerY/2-wallWidth-connectionWidth],[-outerX/2+wallWidth+connectionWidth, -outerY/2+wallWidth+connectionWidth],[outerX/2-wallWidth-connectionWidth, -outerY/2+wallWidth+connectionWidth]];
            paths = [[0, 1, 2, 3], [4, 5, 6, 7]];
            linear_extrude(height=connectionDepth)    
                difference()
                    {
                    polygon(Points, paths);
                        
                    translate([ screwPosX+offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([ screwPosX+offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
            translate([-screwPosX-offset,  screwPosY+offset, 0])
                circle(r=outerScrewRadius, $fn=50);    
            translate([-screwPosX-offset, -screwPosY-offset, 0])
                circle(r=outerScrewRadius, $fn=50);
                        
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
    
if ((part == 1) || (part == 3))
    Case();                         // Create body

if ((part == 2) || (part == 3))
    Cover();                        // Create Cover    
 