// Part to render
part = "Diffuser"; // ["Base Grid", "Diffuser"]

/* [Part Configuration] */
// Number of pixels wide
numPixelsX = 32;
// Number of pixels high
numPixelsY = 16;
// Width of the divider between pixels
pixelDividerWidth = 0.7;
// Distance from the center of a pixel to the center of its neighbor
pixelSpacing = 6;
// Inset of pixels from the edge of the panel
edgePixelInset = 0.5;
// Diffuser thickness- adjust this to let more/less light through
diffuserThickness = 0.55;
// How far the diffuser will set into the frame
diffuserInset = 0.2;
// Tolerance value- adjust higher if the diffuser squares won't fit in the frame
diffuserMargin = 0.5;
// Width of outer bezel (set to 0 to disable)
bezelWidth = 1.5;
// Total depth of bezel
bezelDepth = 9.6;
// Total depth of grid
gridDepth = 6.6;
// Fillet radius for corners
roundRad = 1.0; // [0.0:0.1:10.0]

/* [Debug] */
showOriginalSTL = false;

/* [Hidden] */
pixelXY = pixelSpacing - pixelDividerWidth;
overallWidth = (pixelSpacing) * numPixelsX + edgePixelInset*2;
overallHeight = (pixelSpacing) * numPixelsY + edgePixelInset*2;
bezelTotalWidth = overallWidth+bezelWidth*2;
bezelTotalHeight = overallHeight+bezelWidth*2;

if (showOriginalSTL)
{
    difference()
    {
        origDiffuserThickness=0.60;
        #orig();
        //translate([-1, -1, origDiffuserThickness])
        //cube([220, 110, 10]);
    }
}

//oldBaseGrid();
//oldDiffuser();
if (part == "Base Grid")
{
    baseGrid();
}
else if (part == "Diffuser")
{
    color("white") diffuser(diffuserMargin);
}

module diffuser(pixelMargin)
{
    cubesOffsetXY = bezelWidth+edgePixelInset+pixelSpacing/2;
    
    bzW = bezelTotalWidth-roundRad*2;
    bzH = bezelTotalHeight-roundRad*2;
    diffBaseH = (diffuserThickness-diffuserInset) / (roundRad>0 ? 2 : 1);
    translate([roundRad, roundRad, 0])
    minkowski()
    {
        cube([bzW, bzH, diffBaseH]);
        cylinder(r=roundRad, h=diffBaseH, $fn=45);
    }
    
    translate([cubesOffsetXY, cubesOffsetXY, 0])
    for(x=[0:numPixelsX-1])
    {
        for(y=[0:numPixelsY-1])
        {
            translate([(pixelSpacing)*x, (pixelSpacing)*y, diffuserThickness/2])
            cube([pixelXY-pixelMargin, pixelXY-pixelMargin, diffuserThickness-0.01], center=true);
        }
    }
}

module baseGrid()
{
    calcGridDepth = gridDepth-diffuserThickness+diffuserInset;
    calcBezelDepth = bezelDepth-diffuserThickness+diffuserInset;
    gridWidth = pixelSpacing * numPixelsX;
    gridHeight = pixelSpacing * numPixelsY;
    
    spacerWidth = pixelSpacing - pixelXY;
    
    translate([bezelWidth, bezelWidth, diffuserThickness-diffuserInset])
    translate([edgePixelInset, edgePixelInset, 0])
    {
        translate([-edgePixelInset, -edgePixelInset, 0])
        cube([spacerWidth/2+edgePixelInset, overallHeight, calcGridDepth]);
        for (x=[1:numPixelsX-1])
        {
            translate([pixelSpacing*x, overallHeight/2-edgePixelInset, calcGridDepth/2])
            cube([spacerWidth, overallHeight, calcGridDepth], center=true);
        }
        translate([gridWidth-spacerWidth/2, -edgePixelInset, 0])
        cube([spacerWidth/2+edgePixelInset, overallHeight, calcGridDepth]);
        
        translate([-edgePixelInset, -edgePixelInset, 0])
        cube([overallWidth, spacerWidth/2+edgePixelInset, calcGridDepth]);
        for (y=[1:numPixelsY-1])
        {
            translate([overallWidth/2-edgePixelInset, pixelSpacing*y, calcGridDepth/2])
            cube([overallWidth, spacerWidth, calcGridDepth], center=true);
        }
        translate([-edgePixelInset, gridHeight-spacerWidth/2, 0])
        cube([overallWidth, spacerWidth/2+edgePixelInset, calcGridDepth]);
    }
    
    if (bezelWidth > 0)
    {
        bzd = calcBezelDepth / (roundRad>0 ? 2 : 1);
        bzw = bezelTotalWidth-roundRad*2;
        bzh = bezelTotalHeight-roundRad*2;
        translate([bezelTotalWidth/2, bezelTotalHeight/2, calcBezelDepth/2+diffuserThickness-diffuserInset])
        difference()
        {
            translate([0, 0, (roundRad>0 ? -bzd/2 : 0)])
            minkowski()
            {
                cube([bzw, bzh, bzd], center=true);
                cylinder(r=roundRad, h=bzd, $fn=45);
            }
            cube([overallWidth-0.01, overallHeight-0.01, calcBezelDepth+1], center=true);
        }
    }
}

module orig()
{
    translate([97.5, 50.5, -2.4])
    import("matrix_grid.stl");
}