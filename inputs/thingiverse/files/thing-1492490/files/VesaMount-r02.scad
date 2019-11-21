part = "allParts"; // [vesaMount: monitor attachment, socketSlider: sliding socket attachment, cameraMount: camera mounting ball, allParts: everything]

// separation in mm of vesa holes
vesaSize = 100; 

// how far the mount extends above the screws
mountHeight = 150; 

// size for the screw on the socket
mountHole = 3.5; 

// size for the nut on the socket
mountNut = 6.5; 

// length of slot for adjustable height of camera mount
sliderLength = 50; 

// how thick the general mount should be
thickness = 5; 

// Diameter of Ball
ballSize = 20;

// Oversize for Socket
ballSlop = .2;

/* [Hidden] */
$fn=40;
include<MCAD/shapes.scad>
vesaHole = 4.5; // holes for the vesa screws
sliderWidth = vesaHole + 2*thickness;
cameraHole = 6.6; // diameter of hole for camera and slider
cameraNut = 11.3; // size of nut for 1/4-20
ringGap = 3;

if (part == "vesaMount")
{
    translate ([0,0,thickness]) rotate ([0,180,0]) // flip it so countersink is on top
    vesaMount();
}
else if (part == "socketSlider")
{
    socketSlider();
}
else if (part == "cameraMount")
{
    cameraMount();
}
else 
{
    translate ([0,0,thickness]) rotate ([0,180,0]) // flip it so countersink is on top
    vesaMount();
    
    translate ([-2*sliderWidth,5*thickness,0]) socketSlider();
    translate ([2*sliderWidth,5*thickness,0]) cameraMount();
}

module vesaMount()
{
    translate ([0,0,thickness/2])
    difference()
    {
        union()
        {
            // horizontal cross-piece
            hull()
            {
                translate ([-vesaSize/2,0,0]) cylinder(d=vesaHole+thickness, h=thickness, center=true);
                translate ([vesaSize/2,0,0]) cylinder(d=vesaHole+thickness, h=thickness, center=true);
                translate ([0, thickness*2, 0]) cube([sliderWidth,.1,thickness], center=true);
            }
            
            // vertical slider piece
            hull()
            {
                translate ([0, thickness*2, 0]) cube([sliderWidth,.1,thickness], center=true);
                translate ([0, mountHeight, 0]) cylinder(d=sliderWidth,h=thickness, center=true);
            }
        }
        // vesa holes
        translate ([-vesaSize/2,0,-thickness/2]) counterSunk(vesaHole); // cylinder(d=vesaHole, h=thickness+.1, center=true);
        translate ([vesaSize/2,0,-thickness/2]) counterSunk(vesaHole); // cylinder(d=vesaHole, h=thickness+.1, center=true);
        
        // slider hole
        hull()
        {
            translate ([0,mountHeight,0]) cylinder(d=cameraHole, h=thickness+.1, center=true);
            translate ([0,mountHeight - sliderLength,0]) cylinder(d=cameraHole, h=thickness+.1,center=true);
        }
    }
}

module socketSlider()
{
    difference()
    {
        union()
        {
            translate([0,-thickness/2, sliderWidth*.75]) cube([sliderWidth + thickness + 1, thickness, sliderWidth*1.5], center=true);
            
            // slider tabs
            translate([-(sliderWidth/2+thickness/4+.5),0,sliderWidth*.75]) cube([thickness/2, thickness*2, sliderWidth*1.5], center=true);
            translate([(sliderWidth/2+thickness/4+.5),0,sliderWidth*.75]) cube([thickness/2, thickness*2, sliderWidth*1.5], center=true);
            
            // socket mount
            translate([0,-(thickness+ballSize/2),sliderWidth * 2])
            union()
            {
                rotate([25,0,0])
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
            
            // socket neck
            hull()
            {
                translate([0,-thickness/2, sliderWidth*.75]) cube([sliderWidth + thickness + 1, thickness, sliderWidth*1.5], center=true);
                translate([0,-(thickness+ballSize/2),sliderWidth*2 - ballSize*.25]) sphere(d=ballSize*.6,$fn=10);
            }
        }
        // remove ball for socket
        translate([0,-(thickness+ballSize/2),sliderWidth * 2]) sphere(d=ballSize + ballSlop, $fn=30);
        
        // nut hole for mounting
        translate ([0,-thickness,cameraNut/2+thickness]) rotate([-90,90,0]) nutHole(cameraHole,cameraNut);
        // make the hole go all the way through
        translate ([0,-thickness,cameraNut/2+thickness]) rotate([-90,90,0]) cylinder(d=cameraHole,h=thickness);
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
            cylinder (d=cameraHole+thickness,h=ballSize*.85);
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