part = "allParts"; // [wallSocket: wall-mounted socket, cameraMount: camera mounting ball, allParts: everything]

// distance from wall to socket
wallSpacing = 60; 

// diameter of screw holes for wall mounting
wallHole = 4;

// size for the screw on the socket
mountHole = 3.5; 

// size for the nut on the socket
mountNut = 6.5; 

// how thick the general mount should be
thickness = 5; 

// Diameter of Ball
ballSize = 20;

// Oversize for Socket
ballSlop = .2;

/* [Hidden] */
$fn=40;
include<MCAD/shapes.scad>
cameraHole = 6.6; // diameter of hole for camera and slider
cameraNut = 11.3; // size of nut for 1/4-20
ringGap = 3;
filletSize = 10; // radius of fillets on wall plate
bracketHeight = 50; // height of wall bracket
bracketWidth = 80; // width of wall bracket

if (part == "wallSocket")
{
    wallSocket();
}
else if (part == "cameraMount")
{
    cameraMount();
}
else 
{    
    wallSocket();
    translate ([0,ballSize,0]) cameraMount();
}

module wallSocket()
{
    difference()
    {
        union()
        {
            //plate against wall
            hull()
            {
                translate([-(bracketHeight/7 - filletSize),-(bracketHeight - filletSize),thickness/2]) cylinder(r=filletSize,h=thickness,center=true);
                translate([(bracketHeight/7 - filletSize),-(bracketHeight - filletSize),thickness/2]) cylinder(r=filletSize,h=thickness,center=true);
                translate([-(bracketWidth/2 - filletSize),-filletSize,thickness/2]) cylinder(r=filletSize,h=thickness,center=true);
                translate([(bracketWidth/2 - filletSize),-filletSize,thickness/2]) cylinder(r=filletSize,h=thickness,center=true);
            }
            
            // neck to ball
            hull()
            {
                translate([0,-bracketHeight/2,thickness/2]) cube([thickness,bracketHeight,thickness],center=true);
                translate([0,-thickness/2,wallSpacing]) sphere(d=thickness,$fn=10);
            }

            // ridge to ball
            hull()
            {
                translate([0,-thickness/2,thickness/2]) cube([bracketWidth*2/3,thickness,thickness],center=true);
                translate([0,-thickness/2,wallSpacing]) sphere(d=thickness,$fn=10);
            }
           
            // socket mount
            translate([0,-ballSize*.25,wallSpacing])
            union()
            {
                rotate([0,-50,270])
                difference()
                {   
                    // ring for mount
                    hull()
                    {
                        sphere(d=ballSize+thickness+ballSlop);
                        //cylinder(d=ballSize+thickness+ballSlop, h=2*thickness, center=true);
                        translate([(ballSize/2 + ballSlop + mountHole), 0, 0]) rotate([90,0,0]) cylinder(d=mountHole+thickness, h=ringGap + 2*thickness, center=true);
                    }
                    // remove top
                    translate([0,0,(ballSize/2+thickness*.75)]) cube([100,100,ballSize], center=true);
                    
                    // notch for tightening
                    translate([ballSize,0,0]) cube([2*ballSize, ringGap, ballSize], center=true);
                    // holes for mounting
                    translate([(ballSize/2 + ballSlop + mountHole), 0, 0]) rotate([90,0,0]) cylinder(d=mountHole, h=100, center=true);
                    // nut hole
                    translate([(ballSize/2 + ballSlop + mountHole), ringGap/2+thickness, 0]) rotate([90,90,0]) nutHole(mountHole,mountNut);
                    // surface for screw
                    translate([(ballSize/2 + ballSlop + mountHole), -(ringGap/2+thickness*1.5), 0]) rotate([90,0,0]) cylinder(d=mountHole+thickness,h=thickness,center=true);
                    // slight bevel of upper lip
                    translate([0,0,ballSize*.55]) sphere(d=ballSize+thickness+ballSlop);
                }
            }            
        }
        
        // remove ball for socket
        translate([0,-ballSize*.25,wallSpacing]) sphere(d=ballSize + ballSlop, $fn=30);
        
        // add mount holes
        translate([-(bracketWidth/2-filletSize),-filletSize,thickness]) rotate([180,0,0]) counterSunk(wallHole);
        translate([(bracketWidth/2-filletSize),-filletSize,thickness]) rotate([180,0,0]) counterSunk(wallHole); 
    }
}

module cameraMount()
{
    difference()
    {
        union()
        {
            // ball
            translate([0,0,ballSize*.35]) sphere (d=ballSize, $fn=40);
            cylinder (d=cameraHole+thickness,h=ballSize);
        }
        // remove nut hole
        translate([0,0,ballSize*.35]) nutHole(cameraHole,cameraNut);
        // make a flat bottom
        translate([0,0,-ballSize/2]) cube([ballSize,ballSize,ballSize], center=true);
    }
}


module nutHole(holeSize = mountHole,nutSize = mountNut)
{
    translate([0,0,-10])
	hexagon(nutSize,22);
	translate([0,0,1.3]) // deliberately creating solid material for printing
	cylinder(d=holeSize, h=100);
}

module counterSunk(holeSize = mountHole)
{
    hull()
    {
        translate([0,0,-1]) cylinder(d=holeSize*2,h=2,center=true);
        translate([0,0,holeSize/2]) cylinder(d=holeSize,h=.1,center=true);
    }     
    cylinder(d=holeSize,h=10);
}